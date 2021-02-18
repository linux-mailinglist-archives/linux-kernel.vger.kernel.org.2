Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5498431EA13
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 13:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhBRMz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 07:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbhBRLJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 06:09:48 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81D0C061786
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 03:09:06 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DhBmD2nnDz9sBy;
        Thu, 18 Feb 2021 22:08:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1613646541;
        bh=FI/8oTE5bkbdBk+8MaZLD5d3X4CkdRwqha/+Gur5zTU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Pi0C2QGaJmZNA/K+Bkq2LB54x78RZRqQVAZMzzEJMzHcDoiELdojVfZItDediPgnW
         4Pm1B/tsgUT/Jbf2pmV/vVV0xEy5sSY/NIw5BoyQWr+/7eE1DwQXmh7oE726tMZBb+
         8zEcwdcvr2Ooao1x/BtftK/A3bkjBBPTt5esgi2JIJoyC0vKT/ZFWECkegyKwjcpws
         JisH3DOHNMQAtvwXgrFuK7PEDcOFcChCrqiccVzMmpJN6T4+C2M5nY1XJo6HCt3V15
         xudi01Ch9SK5bNYlcVu+pihEadj5qLyjUZaaGo5x49ghd+qE7y/aXG0FqcRBlOO/Zr
         Fva6nvshS6QPQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        lkp <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: {standard input}:577: Error: unsupported relocation against base
In-Reply-To: <20210217104915.GB44989@shbuild999.sh.intel.com>
References: <202101051834.FGH835Vs-lkp@intel.com>
 <98587e13-d22f-973f-1e16-f7a811f71016@csgroup.eu>
 <20210205100821.GA71063@shbuild999.sh.intel.com>
 <87lfbouzgd.fsf@mpe.ellerman.id.au>
 <20210217104915.GB44989@shbuild999.sh.intel.com>
Date:   Thu, 18 Feb 2021 22:08:58 +1100
Message-ID: <87wnv5tyyd.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feng Tang <feng.tang@intel.com> writes:
> Hi Michael,
>
> On Tue, Feb 16, 2021 at 08:36:02PM +1100, Michael Ellerman wrote:
>> Feng Tang <feng.tang@intel.com> writes:
>> > Hi Christophe and Michael,
>> >
>> > On Mon, Jan 18, 2021 at 10:24:08PM +0800, Christophe Leroy wrote:
>> >>=20
>> >> Le 05/01/2021 ? 11:58, kernel test robot a =E9=96=8Frit :
>> >> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git master
>> >> > head:   e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
>> >> > commit: 8b8319b181fd9d6821703fef1228b4dcde613a16 powerpc/44x: Don't=
 support 440 when CONFIG_PPC_47x is set
>> >>=20
>> >> I see no link with that commit. Looks like the problem has been exist=
ing for some time.
>> >> It exists on the commit before that one, it exists on v5.9 and it exi=
sts on v5.10 with that commit
>> >> reverted.
>> >=20=20
>> > Yes, this seems to be a long-standing issue, and we just double checked
>> > this compile error.=20
>> >
>> > It happend when compiling arch/powerpc/platforms/44x/fsp2.c, macro
>> > 'mfdcr' requirs an instant number as parameter, while is not met by
>> > show_plbopb_regs(). Changing show_plbopb_regs() from function to
>> > a macro fixes the error, as the patch below:
>> >
>> > Thanks,
>> > Feng
>> >
>> >
>> > From 3bcb9638afc873d0e803aea1aad4f77bf1c2f6f6 Mon Sep 17 00:00:00 2001
>> > From: Feng Tang <feng.tang@intel.com>
>> > Date: Fri, 5 Feb 2021 16:08:43 +0800
>> > Subject: [PATCH] powerpc/44x/fsp2: fix a compiling error regarding mac=
ro
>> >  'mdfcr'
>> >
>> > 0day's kbuild test found error:
>> >
>> > "
>> >   CC      arch/powerpc/platforms/44x/fsp2.o
>> >
>> >   {standard input}:577: Error: unsupported relocation against base
>> >   {standard input}:580: Error: unsupported relocation against base
>> >   {standard input}:583: Error: unsupported relocation against base
>> > "
>> >
>> > The reason is macro 'mfdcr' requirs an instant number as parameter,
>> > which is not met by show_plbopb_regs().
>>=20
>> It doesn't require a constant, it checks if the argument is constant:
>
> Aha, seems my grep found the wrong target: arch/powerpc/boot/dcr.h,
> which has=20=20
>
> #define mfdcr(rn) \
> 	({	\
> 		unsigned long rval; \
> 		asm volatile("mfdcr %0,%1" : "=3Dr"(rval) : "i"(rn)); \
> 		rval; \
> 	})

Yeah, annoyingly we have several macros like that duplicated in
arch/powerpc/boot.

>> #define mfdcr(rn)						\
>> 	({unsigned int rval;					\
>> 	if (__builtin_constant_p(rn) && rn < 1024)		\
>> 		asm volatile("mfdcr %0," __stringify(rn)	\
>> 		              : "=3Dr" (rval));			\
>> 	else if (likely(cpu_has_feature(CPU_FTR_INDEXED_DCR)))	\
>> 		rval =3D mfdcrx(rn);				\
>> 	else							\
>> 		rval =3D __mfdcr(rn);				\
>> 	rval;})
>>=20
>> But the error you're seeing implies the compiler is choosing the first
>> leg of the if, even when rn =3D=3D "base + x", which is surprising.
>
> Yes, it might be related to compiler (though myself isn't faimiliar
> with it). As show_plbopb_regs() was introduced by commit 7813043e1bbc
> ("powerpc/44x/fsp2: Add irq error handlers") back in 2017, while it
> was just reported.

It seems to be something in the config, I can only reproduce with the
config attached to the original report. I can't see any reason why the
config matters for this bug, but perhaps it's enabling something that's
confusing the compiler somehow.

Anyway I'll post a patch to change the asm so the bug goes away.

cheers
