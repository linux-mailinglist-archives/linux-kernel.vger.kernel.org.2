Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084133FBDE6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 23:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbhH3VHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 17:07:50 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:44674 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbhH3VHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 17:07:49 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKoQB-00HOd6-C5; Mon, 30 Aug 2021 21:02:23 +0000
Date:   Mon, 30 Aug 2021 21:02:23 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 01/10] x86/fpu/signal: Clarify exception handling in
 restore_fpregs_from_user()
Message-ID: <YS1HXyQu2mvMzbL/@zeniv-ca.linux.org.uk>
References: <20210830154702.247681585@linutronix.de>
 <20210830162545.374070793@linutronix.de>
 <YS0ylo9nTHD9NiAp@zn.tnic>
 <87zgsyg0eg.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgsyg0eg.ffs@tglx>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 10:09:27PM +0200, Thomas Gleixner wrote:

> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -88,7 +88,11 @@ static inline void fpstate_init_soft(str
>  #endif
>  extern void save_fpregs_to_fpstate(struct fpu *fpu);
>  
> -/* Returns 0 or the negated trap number, which results in -EFAULT for #PF */
> +/*
> + * Returns 0 on success or the negated trap number when the operation
> + * raises an exception (The exception fixup function ex_handler_fault()
> + * stores the trap number in EAX).
> + */
>  #define user_insn(insn, output, input...)				\
>  ({									\
>  	int err;							\
> @@ -199,7 +203,8 @@ static inline void fxsave(struct fxregs_
>  
>  /*
>   * After this @err contains 0 on success or the negated trap number when
> - * the operation raises an exception. For faults this results in -EFAULT.
> + * the operation raises an exception (The exception fixup function
> + * ex_handler_fault() stores the trap number in EAX).
>   */
>  #define XSTATE_OP(op, st, lmask, hmask, err)				\
>  	asm volatile("1:" op "\n\t"					\

Incidentally, why do we bother with negation in those?  Why not have
user_insn(), XSTATE_OP() and kernel_insn_err() return 0 or trap number...
