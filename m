Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7D631C82D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 10:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhBPJhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 04:37:01 -0500
Received: from ozlabs.org ([203.11.71.1]:51451 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhBPJgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 04:36:50 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Dfwnw1P1xz9sVF;
        Tue, 16 Feb 2021 20:36:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1613468164;
        bh=w01ZzXg+X4lswScuetPh6d5R2awZ8eJK8kV/DFk/9G4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DvanBx7AL1g74lkUsfxDVc69dv1YNkEwIgcUl1qqHx1uS7I0m4umKPZA4jFa1ryT7
         CsvSeg8RrNY1p0XnUMpatEMSzpx7VeSvj2dL77+LJ4Hp4J+nUhuQ+szH+xj8EwHMfN
         IeI2vUHFb5tGVTniXNeTap36+ppe4GU42tWcDTHRGOrR9pYsEWvMze+2rRQNI3CBkB
         pk4wOFsdHLWrqLh/GCCTHL7YKblU3l9OmAJWFK2sRrqKfVCviGdzCITCNdi2jX4nmR
         yLJgWwcAFQ2rqlTAUngSNaEhrl1dmLpyeO9cIs/keVIGdHokXLYENZFiaboSo9G4a9
         oNU3B6RAEzQ5g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Feng Tang <feng.tang@intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     lkp <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: {standard input}:577: Error: unsupported relocation against base
In-Reply-To: <20210205100821.GA71063@shbuild999.sh.intel.com>
References: <202101051834.FGH835Vs-lkp@intel.com>
 <98587e13-d22f-973f-1e16-f7a811f71016@csgroup.eu>
 <20210205100821.GA71063@shbuild999.sh.intel.com>
Date:   Tue, 16 Feb 2021 20:36:02 +1100
Message-ID: <87lfbouzgd.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feng Tang <feng.tang@intel.com> writes:
> Hi Christophe and Michael,
>
> On Mon, Jan 18, 2021 at 10:24:08PM +0800, Christophe Leroy wrote:
>>=20
>> Le 05/01/2021 ? 11:58, kernel test robot a =E9=96=8Frit :
>> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
.git master
>> > head:   e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
>> > commit: 8b8319b181fd9d6821703fef1228b4dcde613a16 powerpc/44x: Don't su=
pport 440 when CONFIG_PPC_47x is set
>>=20
>> I see no link with that commit. Looks like the problem has been existing=
 for some time.
>> It exists on the commit before that one, it exists on v5.9 and it exists=
 on v5.10 with that commit
>> reverted.
>=20=20
> Yes, this seems to be a long-standing issue, and we just double checked
> this compile error.=20
>
> It happend when compiling arch/powerpc/platforms/44x/fsp2.c, macro
> 'mfdcr' requirs an instant number as parameter, while is not met by
> show_plbopb_regs(). Changing show_plbopb_regs() from function to
> a macro fixes the error, as the patch below:
>
> Thanks,
> Feng
>
>
> From 3bcb9638afc873d0e803aea1aad4f77bf1c2f6f6 Mon Sep 17 00:00:00 2001
> From: Feng Tang <feng.tang@intel.com>
> Date: Fri, 5 Feb 2021 16:08:43 +0800
> Subject: [PATCH] powerpc/44x/fsp2: fix a compiling error regarding macro
>  'mdfcr'
>
> 0day's kbuild test found error:
>
> "
>   CC      arch/powerpc/platforms/44x/fsp2.o
>
>   {standard input}:577: Error: unsupported relocation against base
>   {standard input}:580: Error: unsupported relocation against base
>   {standard input}:583: Error: unsupported relocation against base
> "
>
> The reason is macro 'mfdcr' requirs an instant number as parameter,
> which is not met by show_plbopb_regs().

It doesn't require a constant, it checks if the argument is constant:

#define mfdcr(rn)						\
	({unsigned int rval;					\
	if (__builtin_constant_p(rn) && rn < 1024)		\
		asm volatile("mfdcr %0," __stringify(rn)	\
		              : "=3Dr" (rval));			\
	else if (likely(cpu_has_feature(CPU_FTR_INDEXED_DCR)))	\
		rval =3D mfdcrx(rn);				\
	else							\
		rval =3D __mfdcr(rn);				\
	rval;})

But the error you're seeing implies the compiler is choosing the first
leg of the if, even when rn =3D=3D "base + x", which is surprising.

We've had cases in the past of __builtin_constant_p() returning false
for things that a human can see are constant at build time, but I've
never seen the reverse.

cheers
