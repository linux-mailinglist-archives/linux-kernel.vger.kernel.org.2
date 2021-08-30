Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558803FBD4C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 22:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbhH3UK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 16:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbhH3UKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 16:10:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EA7C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 13:09:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630354167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eYENvognaF1fc5M2JgWlXgHVHS70PbEWI4LZZj3Tvk0=;
        b=UnPeVFx9UBtAJ9y82lQ2BqmiCDARFk9Z/2048cG6vvGRwGApK2jvAlFLkntu+ZdngKtqqs
        ZhQO9PBGNFMC25JrFARDil71bxug7Kq7r18rcOMH7VGHXDCSLaPsk4ZsFtSJdUv+QdEK8v
        XicZqcq1X7A2TD1+D8w6tCqlfdbq40CPXfnXi8WFOWmkaqnx7RpI8Z2xn1eDNO6jDQCaAG
        RITjO2TwpnVcC6WHnNUyphmJawfBfAePXRKTuv+awyTd9nFlFCAxvo4kOJv7NTQtDdl/1W
        BnM+LcbDd7eNXYB3COqffXmmx53xAllBd0CGliAWSln7FdPLvfGV4pITFCyWRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630354167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eYENvognaF1fc5M2JgWlXgHVHS70PbEWI4LZZj3Tvk0=;
        b=YIpYsGUWiUO6id6+ENWuHfNhiddTZ8K/rTEgKyg5mVwB7zscumlA7ytTiZfBtza1E8LvlJ
        j9kiiQVvCYM+prAA==
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 01/10] x86/fpu/signal: Clarify exception handling in
 restore_fpregs_from_user()
In-Reply-To: <YS0ylo9nTHD9NiAp@zn.tnic>
References: <20210830154702.247681585@linutronix.de>
 <20210830162545.374070793@linutronix.de> <YS0ylo9nTHD9NiAp@zn.tnic>
Date:   Mon, 30 Aug 2021 22:09:27 +0200
Message-ID: <87zgsyg0eg.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30 2021 at 21:33, Borislav Petkov wrote:
> On Mon, Aug 30, 2021 at 06:27:22PM +0200, Thomas Gleixner wrote:
>> FPU restore from a signal frame can trigger various exceptions. The
>> exceptions are caught with an exception table entry. The handler of this
>> entry sets the error return value to the negated exception number.
>> 
>> Any other exception than #PF is fatal and recovery is not possible. This
>> relies on the fact that the #PF exception number is the same as EFAULT, but
>> that's not really obvious.
>> 
>> Check the error code for -X86_TRAP_PF instead of checking it for -EFAULT to
>> make it clear how that works.
>
> I guess you wanna fixup the comment over XSTATE_OP() too and perhaps
> mention ex_handler_fault() explicitly so that one can make her/his way
> around the code and pinpoint quickly where it sticks that exception
> number into rAX.

Something like the below?

Thanks,

        tglx
---
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -88,7 +88,11 @@ static inline void fpstate_init_soft(str
 #endif
 extern void save_fpregs_to_fpstate(struct fpu *fpu);
 
-/* Returns 0 or the negated trap number, which results in -EFAULT for #PF */
+/*
+ * Returns 0 on success or the negated trap number when the operation
+ * raises an exception (The exception fixup function ex_handler_fault()
+ * stores the trap number in EAX).
+ */
 #define user_insn(insn, output, input...)				\
 ({									\
 	int err;							\
@@ -199,7 +203,8 @@ static inline void fxsave(struct fxregs_
 
 /*
  * After this @err contains 0 on success or the negated trap number when
- * the operation raises an exception. For faults this results in -EFAULT.
+ * the operation raises an exception (The exception fixup function
+ * ex_handler_fault() stores the trap number in EAX).
  */
 #define XSTATE_OP(op, st, lmask, hmask, err)				\
 	asm volatile("1:" op "\n\t"					\
