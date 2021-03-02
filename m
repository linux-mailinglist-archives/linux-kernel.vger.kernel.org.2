Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E203A32A496
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442017AbhCBKxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:53:14 -0500
Received: from imap3.hz.codethink.co.uk ([176.9.8.87]:48974 "EHLO
        imap3.hz.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578024AbhCBKfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:35:08 -0500
Received: from cpc79921-stkp12-2-0-cust288.10-2.cable.virginm.net ([86.16.139.33] helo=[192.168.0.18])
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1lH1qB-0006FQ-M0; Tue, 02 Mar 2021 10:01:19 +0000
Subject: Re: [PATCH] riscv: Return -EFAULT if copy_to_user() failed in
 signal.c
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1614670097-28536-1-git-send-email-yangtiezhu@loongson.cn>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <aa84cddb-9c04-3bad-49de-2fb3056ec44a@codethink.co.uk>
Date:   Tue, 2 Mar 2021 10:01:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1614670097-28536-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2021 07:28, Tiezhu Yang wrote:
> copy_to_user() returns the amount left to copy, it should return -EFAULT
> if copy to user failed.

This looks technically correct, but the caller (only one)
will check for non-zero and will covert that to -EFAULT
in setup_rt_frame().

I expect if this change is done, it also needs to be done
for the callers too and there's a few others than assume
!=0 is an error.

I think it would be easier to define save_fp_state() to
return non-zero on error and note it does not return an
error code. It may be worth exiting the functio nif
the first __copy_to_user fails?

Note: setup_rt_frame -> setup_sigcontext -> save_fp_frame

> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   arch/riscv/kernel/signal.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> index 65942b3..2238fc5 100644
> --- a/arch/riscv/kernel/signal.c
> +++ b/arch/riscv/kernel/signal.c
> @@ -67,7 +67,7 @@ static long save_fp_state(struct pt_regs *regs,
>   	fstate_save(current, regs);
>   	err = __copy_to_user(state, &current->thread.fstate, sizeof(*state));
>   	if (unlikely(err))
> -		return err;
> +		return -EFAULT;
>   
>   	/* We support no other extension state at this time. */
>   	for (i = 0; i < ARRAY_SIZE(sc_fpregs->q.reserved); i++) {
> @@ -140,8 +140,12 @@ static long setup_sigcontext(struct rt_sigframe __user *frame,
>   {
>   	struct sigcontext __user *sc = &frame->uc.uc_mcontext;
>   	long err;
> +
>   	/* sc_regs is structured the same as the start of pt_regs */
>   	err = __copy_to_user(&sc->sc_regs, regs, sizeof(sc->sc_regs));
> +	if (unlikely(err))
> +		return -EFAULT;
> +
>   	/* Save the floating-point state. */
>   	if (has_fpu)
>   		err |= save_fp_state(regs, &sc->sc_fpregs);
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
