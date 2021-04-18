Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E735F363710
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 19:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbhDRRui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 13:50:38 -0400
Received: from gate.crashing.org ([63.228.1.57]:50864 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232148AbhDRRug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 13:50:36 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 13IHknVD022627;
        Sun, 18 Apr 2021 12:46:49 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 13IHkmbE022624;
        Sun, 18 Apr 2021 12:46:48 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sun, 18 Apr 2021 12:46:48 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: PPC_FPU, ALTIVEC: enable_kernel_fp, put_vr, get_vr
Message-ID: <20210418174648.GN26583@gate.crashing.org>
References: <7107fcae-5c7a-ac94-8d89-326f2cd4cd33@infradead.org> <8b1cb0a2-ed3a-7da0-a73a-febbda528703@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b1cb0a2-ed3a-7da0-a73a-febbda528703@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2021 at 06:24:29PM +0200, Christophe Leroy wrote:
> Le 17/04/2021 à 22:17, Randy Dunlap a écrit :
> >Should the code + Kconfigs/Makefiles handle that kind of
> >kernel config or should ALTIVEC always mean PPC_FPU as well?
> 
> As far as I understand, Altivec is completely independant of FPU in Theory. 

And, as far as the hardware is concerned, in practice as well.

> So it should be possible to use Altivec without using FPU.

Yup.

> However, until recently, it was not possible to de-activate FPU support on 
> book3s/32. I made it possible in order to reduce unneccessary processing on 
> processors like the 832x that has no FPU.

The processor has to implement FP to be compliant to any version of
PowerPC, as far as I know?  So that is all done by emulation, including
all the registers?  Wow painful.

> As far as I can see in cputable.h/.c, 832x is the only book3s/32 without 
> FPU, and it doesn't have ALTIVEC either.

602 doesn't have double-precision hardware, also no 64-bit FP registers.
But that CPU was never any widely used :-)

> So we can in the future ensure that Altivec can be used without FPU 
> support, but for the time being I think it is OK to force selection of FPU 
> when selecting ALTIVEC in order to avoid build failures.

It is useful to allow MSR[VEC,FP]=1,0 but yeah there are no CPUs that
have VMX (aka AltiVec) but that do not have FP.  I don't see how making
that artificial dependency buys anything, but maybe it does?

> >I have patches to fix the build errors with the config as
> >reported but I don't know if that's the right thing to do...

Neither do we, we cannot see those patches :-)


Segher
