Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643B63A352B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 22:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhFJU41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 16:56:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35114 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhFJU4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 16:56:23 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623358465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lheG/WyLWN4DiKQNRJyzN2wdxM/g4ucOGltzrtvaQRU=;
        b=dwoNh4+nYuAK9yANrvjpHVtxu/fDB9wcnRWZsmBtswbArd/m8zgOJpmqKp4M+lwC/y3K1T
        jYAdh+0oC3wVo9hEp16igYoJYVvVp/82uZ6LmAnC5QxeB8R8TTUA83qrFGDT3vZ0qgGyja
        zkRvKaEguCcp651NSN8dD1NAEALtHMHMXjEy1OFTpKYttdomrTnUaMGscc7R8P1KJESMOe
        AGWeosxjrW3+A1fshiCs8UlFP1/BBmpKlvEsqYuXpZTUcoJIP/2/zakmY7xN2wtV7WVmGp
        wGLvoPJ65FaqgEQiyxoEqQzdIAB4y6lkgT1+qoEs1mUZo3piGCzmZCRiZerTWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623358465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lheG/WyLWN4DiKQNRJyzN2wdxM/g4ucOGltzrtvaQRU=;
        b=I5Nr+1RTEternKTd7Ss3HewOKcJa5fQ2OKgohH+Hyrg1LOZA1axfZ54uPMrvO9BwS44J8Q
        9GrX6bICZmwemIDA==
To:     Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Rik van Riel <riel@surriel.com>, Borislav Petkov <bp@suse.de>
Subject: Re: [patch V3 3/6] x86/process: Check PF_KTHREAD and not current->mm for kernel threads
In-Reply-To: <ca2d7f44-bbef-448a-bbd4-ff27cc6f0c9e@www.fastmail.com>
References: <20210608143617.565868844@linutronix.de> <20210608144345.912645927@linutronix.de> <ca2d7f44-bbef-448a-bbd4-ff27cc6f0c9e@www.fastmail.com>
Date:   Thu, 10 Jun 2021 22:54:24 +0200
Message-ID: <87fsxpxwxr.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10 2021 at 10:10, Andy Lutomirski wrote:

> On Tue, Jun 8, 2021, at 7:36 AM, Thomas Gleixner wrote:
>> switch_fpu_finish() checks current->mm as indicator for kernel threads.
>> That's wrong because kernel threads can temporarily use a mm of a user
>> process via kthread_use_mm().
>>=20
>> Check the task flags for PF_KTHREAD instead.
>>=20
>> Fixes: 0cecca9d03c9 ("x86/fpu: Eager switch PKRU state")
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Rik van Riel <riel@surriel.com>
>> Cc: stable@vger.kernel.org
>> ---
>>  arch/x86/include/asm/fpu/internal.h |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> --- a/arch/x86/include/asm/fpu/internal.h
>> +++ b/arch/x86/include/asm/fpu/internal.h
>> @@ -578,7 +578,7 @@ static inline void switch_fpu_finish(str
>>  	 * PKRU state is switched eagerly because it needs to be valid before =
we
>>  	 * return to userland e.g. for a copy_to_user() operation.
>>  	 */
>> -	if (current->mm) {
>> +	if (!(current->flags & PF_KTHREAD)) {
>>  		pk =3D get_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
>>  		if (pk)
>>  			pkru_val =3D pk->pkru;
>>=20
>>=20
> Why are we checking this at all?  I actually tend to agree with the
> ->mm check more than PF_anything. If we have a user address space,
> then PKRU matters. If we don=E2=80=99t, then it doesn=E2=80=99t.

Which PKRU matters? A kernel thread has always the default PKRU no
matter whether it uses a mm or not. It _cannot_ borrow the PKRU from the
mm owning process. There is no way, so let's not pretend there would be.

Thanks,

        tglx
