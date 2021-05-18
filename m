Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBC43871A8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 08:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245740AbhERGPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 02:15:15 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33849 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229531AbhERGPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 02:15:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Fkm0c37mNz9sW1;
        Tue, 18 May 2021 16:13:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1621318434;
        bh=IV7+QbI4uh3lLtagt784pHwtdDzEOKkcFGpA1YF+BnY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pNt1eTIi54r2BF6idmSaqa/SVJwyaW7MWUkYiczrrtrYa/pzo0YwDLue+ox+Wu8ar
         hMwQL2oW2PQr0nTvd0aq0Aii/hA8Snaq89FwtqQfbfI6tMw38q2fU957w5DG5mkc19
         TobmiRLm9ADLRSt+t9ZI1stEezRzfmr/2IaILzAhZT3mn9Gx/jme6PjKxGh5f/hXz2
         V0QwGeA9cHXd5lAPL7M+Jc1hnz5qo7ELbARY9Iz1AwHu8oz3mMUv06O1IsIE5lxf26
         23av0QMe703eZ/UGUz5MD+KJpPfel73/THzo3BNQGSqQhDul2f/kAMm/p2Q9s40L9L
         aXJ8Siv0f1Jzw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Daniel Axtens <dja@axtens.net>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Joe Perches <joe@perches.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc/powernv/pci: remove dead code from !CONFIG_EEH
In-Reply-To: <CAKwvOdmMugQkTRwC3HOEt2-em2zSfAoi7gpvJRkqfdzSDRMeEg@mail.gmail.com>
References: <20210422195405.4053917-1-ndesaulniers@google.com>
 <87lf99zzl3.fsf@dja-thinkpad.axtens.net>
 <CAOSf1CGoN5R0LUrU=Y=UWho1Z_9SLgCX8s3SbFJXwJXc5BYz4A@mail.gmail.com>
 <CAKwvOdmMugQkTRwC3HOEt2-em2zSfAoi7gpvJRkqfdzSDRMeEg@mail.gmail.com>
Date:   Tue, 18 May 2021 16:13:50 +1000
Message-ID: <87cztok1r5.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Desaulniers <ndesaulniers@google.com> writes:
> On Thu, Apr 22, 2021 at 6:13 PM Oliver O'Halloran <oohall@gmail.com> wrote:
>>
>> On Fri, Apr 23, 2021 at 9:09 AM Daniel Axtens <dja@axtens.net> wrote:
>> >
>> > Hi Nick,
>> >
>> > > While looking at -Wundef warnings, the #if CONFIG_EEH stood out as a
>> > > possible candidate to convert to #ifdef CONFIG_EEH, but it seems that
>> > > based on Kconfig dependencies it's not possible to build this file
>> > > without CONFIG_EEH enabled.
>> >
>> > This seemed odd to me, but I think you're right:
>> >
>> > arch/powerpc/platforms/Kconfig contains:
>> >
>> > config EEH
>> >         bool
>> >         depends on (PPC_POWERNV || PPC_PSERIES) && PCI
>> >         default y
>> >
>> > It's not configurable from e.g. make menuconfig because there's no prompt.
>> > You can attempt to explicitly disable it with e.g. `scripts/config -d EEH`
>> > but then something like `make oldconfig` will silently re-enable it for
>> > you.
>> >
>> > It's been forced on since commit e49f7a9997c6 ("powerpc/pseries: Rivet
>> > CONFIG_EEH for pSeries platform") in 2012 which fixed it for
>> > pseries. That moved out from pseries to pseries + powernv later on.
>> >
>> > There are other cleanups in the same vein that could be made, from the
>> > Makefile (which has files only built with CONFIG_EEH) through to other
>> > source files. It looks like there's one `#ifdef CONFIG_EEH` in
>> > arch/powerpc/platforms/powernv/pci-ioda.c that could be pulled out, for
>> > example.
>> >
>> > I think it's probably worth trying to rip out all of those in one patch?
>>
>> The change in commit e49f7a9997c6 ("powerpc/pseries: Rivet CONFIG_EEH
>> for pSeries platform") never should have been made.
>
> I'll change my patch to keep the conditionals, but use #ifdef instead
> of #if then?

Yeah, please.

I'm not sure I agree with oohal that untangling pseries/powernv from
EEH is something we should do, but let's kick that can down the road by
just fixing up the ifdef.

cheers
