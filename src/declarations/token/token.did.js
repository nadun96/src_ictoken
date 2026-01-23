export const idlFactory = ({ IDL }) => {
  const Text = IDL.Text;
  return IDL.Service({
    'balanceOf' : IDL.Func([IDL.Principal], [IDL.Nat], ['query']),
    'getSymbol' : IDL.Func([], [Text], ['query']),
    'payOut' : IDL.Func([], [IDL.Text], []),
    'transfer' : IDL.Func([IDL.Principal, IDL.Nat], [IDL.Text], []),
  });
};
export const init = ({ IDL }) => { return []; };
