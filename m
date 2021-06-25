Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E05E3B3BC0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 06:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhFYEvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 00:51:14 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40247 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhFYEvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 00:51:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GB4Jy5cWKz9sW8;
        Fri, 25 Jun 2021 14:48:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1624596531;
        bh=evdxRnSExFq6oxHHe+2dinIsiEOvUVA/6ZGnVd+6V34=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ToLl98U+R454WxT6SH5FhHsQjdJC68UzUIDPYrbmzPKLEpBbvQ7Kc2Rfwc2thm2jP
         i5Xu7V3A0X/o9FaOuCpqINXXmW3Qcqf+3qtZl+OJ3jUlFvuHLz/9dTXzeQK7or+xot
         HksDartu9Z1zhzjUnRo94tQTZBi52qc1b30P0+X1HSM6jRnW6vuFt1Z3NHy3F4sSxD
         LXPIKtIIVYonXiBfVqDv69rs5OhCyprkPS1QTyVXlnqEPdbQcXbPVJ9F5weY61YqF+
         o+PAJaERpPIaggpFofCuphLL73ZpWV77Lx82L+mUH2s753xp+PsSw9dp2nQR6I+DHK
         L6QCTeM/AooMg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/kprobes: Fix Oops by passing ppc_inst as a
 pointer to emulate_step() on ppc32
In-Reply-To: <b44b66f4-3e46-425b-3c8e-d5a7a180494a@csgroup.eu>
References: <5bdc8cbc9a95d0779e27c9ddbf42b40f51f883c0.1624425798.git.christophe.leroy@csgroup.eu>
 <1624531892.3vdz8ibfty.naveen@linux.ibm.com>
 <b44b66f4-3e46-425b-3c8e-d5a7a180494a@csgroup.eu>
Date:   Fri, 25 Jun 2021 14:48:50 +1000
Message-ID: <871r8q1rd9.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 24/06/2021 =C3=A0 12:59, Naveen N. Rao a =C3=A9crit=C2=A0:
>> Christophe Leroy wrote:
>>> From: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>>>
>>> Trying to use a kprobe on ppc32 results in the below splat:
>>> =C2=A0=C2=A0=C2=A0 BUG: Unable to handle kernel data access on read at =
0x7c0802a6
>>> =C2=A0=C2=A0=C2=A0 Faulting instruction address: 0xc002e9f0
>>> =C2=A0=C2=A0=C2=A0 Oops: Kernel access of bad area, sig: 11 [#1]
>>> =C2=A0=C2=A0=C2=A0 BE PAGE_SIZE=3D4K PowerPC 44x Platform
>>> =C2=A0=C2=A0=C2=A0 Modules linked in:
>>> =C2=A0=C2=A0=C2=A0 CPU: 0 PID: 89 Comm: sh Not tainted 5.13.0-rc1-01824=
-g3a81c0495fdb #7
>>> =C2=A0=C2=A0=C2=A0 NIP:=C2=A0 c002e9f0 LR: c0011858 CTR: 00008a47
>>> =C2=A0=C2=A0=C2=A0 REGS: c292fd50 TRAP: 0300=C2=A0=C2=A0 Not tainted=C2=
=A0 (5.13.0-rc1-01824-g3a81c0495fdb)
>>> =C2=A0=C2=A0=C2=A0 MSR:=C2=A0 00009000 <EE,ME>=C2=A0 CR: 24002002=C2=A0=
 XER: 20000000
>>> =C2=A0=C2=A0=C2=A0 DEAR: 7c0802a6 ESR: 00000000
>>> =C2=A0=C2=A0=C2=A0 <snip>
>>> =C2=A0=C2=A0=C2=A0 NIP [c002e9f0] emulate_step+0x28/0x324
>>> =C2=A0=C2=A0=C2=A0 LR [c0011858] optinsn_slot+0x128/0x10000
>>> =C2=A0=C2=A0=C2=A0 Call Trace:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 opt_pre_handler+0x7c/0xb4 (unreliable)
>>> =C2=A0=C2=A0=C2=A0=C2=A0 optinsn_slot+0x128/0x10000
>>> =C2=A0=C2=A0=C2=A0=C2=A0 ret_from_syscall+0x0/0x28
>>>
>>> The offending instruction is:
>>> =C2=A0=C2=A0=C2=A0 81 24 00 00=C2=A0=C2=A0=C2=A0=C2=A0 lwz=C2=A0=C2=A0=
=C2=A0=C2=A0 r9,0(r4)
>>>
>>> Here, we are trying to load the second argument to emulate_step():
>>> struct ppc_inst, which is the instruction to be emulated. On ppc64,
>>> structures are passed in registers when passed by value. However, per
>>> the ppc32 ABI, structures are always passed to functions as pointers.
>>> This isn't being adhered to when setting up the call to emulate_step()
>>> in the optprobe trampoline. Fix the same.
>>>
>>> Fixes: eacf4c0202654a ("powerpc: Enable OPTPROBES on PPC32")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>>> ---
>>> v2: Rebased on powerpc/merge 7f030e9d57b8
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>=20
>> Thanks for rebasing this!
>>=20
>> I think git am drops everything after three dashes, so applying this pat=
ch will drop your SOB. The=20
>> recommended style (*) for adding a changelog is to include it within [] =
before the second SOB.
>
> Yes, I saw that after sending the mail. Usually I add a signed-off-by wit=
h 'git --amend -s' when I=20
> add the history, so it goes before the '---' I'm adding.
>
> This time I must have forgotten the '-s' so it was added by the 'git form=
at-patch -s' which is in my=20
> submit script, and so it was added at the end.
>
> It's not really a big deal, up to Michael to either move it at the right =
place or discard it, I=20
> don't really mind. Do the easiest for you.

I just added Christophe's SoB.

cheers
