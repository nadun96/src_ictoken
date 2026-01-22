import type { Principal } from '@dfinity/principal';
export type Text = string;
export interface _SERVICE {
  'balanceOf' : (arg_0: Principal) => Promise<bigint>,
  'getSymbol' : () => Promise<Text>,
  'payOut' : () => Promise<string>,
}
