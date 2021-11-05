Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20505445DB8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 02:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhKECBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 22:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhKECBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 22:01:04 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043D9C061203
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 18:58:26 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id x10so5555849qta.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 18:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AeKwDr457TEy1j7kjVV2jCK6h090tNYB4LhZy/b7ri8=;
        b=dJsQFa/dJTSnRPc9y2iFjuO/OIOPV0z4tsmcTmYxo2vTs+LEAYjYbJTd6ccKl/fJe9
         STDdGnd3TCRLV/69vP9cUgnroTmStJ3Y884WDftrN0Jy3RtC+zfAQD8gyz8u9t9rTZ7L
         USusRtWg7DziqDNW5kWP81SqKFYB4hvdKaYPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AeKwDr457TEy1j7kjVV2jCK6h090tNYB4LhZy/b7ri8=;
        b=DvKSKFtnNP7mzAa3Y4h/shQQYMnJ310jYI8SQkyj5h8487PuyQe00F1CusujWg3E2E
         BGOn+4rYDN7LyYU1Fbo0GClVi74OVAuJuqYmYSq7Hh7bkOCgD7CoJWhjER7sKKVAPbZF
         7iKJk/PlOitbz0zy4vkW/Ucn8KVTRL2kjMgLUFsgww6FfdIYNOr143YKL/6p0rYf3KHE
         AN7XnUIvzPJRLb24n9YtixYTGJJKXTGVBBAN9tEDonsFFNd0+L6TVhwGme6tL2ILBmX4
         kfrmkti1WjFH44PA0rj6Vels7ORqKgEHwVVGhEtf7B+f2usCfvd29+EpAENqeJdsGehu
         8zQA==
X-Gm-Message-State: AOAM533QCowQKgbXb+V08iO/wFt7t04Ryui5ONAKtlJNYFD4uKgnGTR0
        93qNBLoBySJe4KOjSPhP/mM6FIaN6ybE+/itsdI=
X-Google-Smtp-Source: ABdhPJwvj9CTW1q5TyiaSF+P3VtUT2HVTx4qLOVyun3i3huquNri6xChl0ILjGXXWjkgSGVeSuRnKaUKz2JYSU1g2sY=
X-Received: by 2002:a05:622a:1006:: with SMTP id d6mr57856637qte.259.1636077505009;
 Thu, 04 Nov 2021 18:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211105005955.107419-1-osk@google.com> <CACPK8XcXR=V5-Q+sC4MniNJZJgvbiysFD-5yu6v30_2BwDRTSA@mail.gmail.com>
 <CABoTLcS=s0XuM9jiisYW3=1gXtiwP8WeopqTOeBwnTX1XCky9Q@mail.gmail.com>
In-Reply-To: <CABoTLcS=s0XuM9jiisYW3=1gXtiwP8WeopqTOeBwnTX1XCky9Q@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 5 Nov 2021 01:58:13 +0000
Message-ID: <CACPK8XebNsSr3wiMdMxDwQuMGX3p0g2Kid91dekUc6TGcHqfYQ@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: aspeed: tyan-s7106: Update nct7802 config
To:     Oskar Senft <osk@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Nov 2021 at 01:47, Oskar Senft <osk@google.com> wrote:
>
> Hi Joel
>
> Oh man, this is embarrassing!

Don't worry about it. I'm a bit confused as to why I didn't see it
this morning; I thought I did a build test then.

>
> > I applied this and tried comple testing, and got this warning:
> >
> >   DTC     arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dtb
> > ../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:217.4-14: Warning
> > (reg_format): /ahb/apb/bus@1e78a000/i2c-bus@40/nct7802@28/channel@0:reg:
> > property has invalid length (4 bytes) (#address-cells == 2,
> > #size-cells == 1)
> > [...]
> > You need to add this to the nct node:
> >
> > #address-cells = <1>;
> > #size-cells = <0>;
> Oh yeah, of course. It's even in the example in the binding that I wrote.
>
> > Did you see this with your testing? I'm building on top of v5.15 and
> > my distro's dtc is 1.6.0.
> I built (as part of OpenBMC) and ran (on actual HW), but these
> warnings don't make it out to the console. In my "defense", I did run
> checkpatch.pl, though.
>
> Is there an easy way for me to see these types of warnings? Or should
> they really come out as errors?

Good question. v5.15 adds -Werror to the top level makefile, but as
these warnings come from the device tree compiler they won't cause the
build to fail. We should probably fix that, as I consider any dtc
warning cause to rework the patch.

I test the kernels independently of yocto; I recommend doing that with
a cross compiler when submitting patches upstream. My flow looks like
this:

CROSS_COMPILE="ccache arm-linux-gnueabi-" ARCH=arm make
O=aspeed-g5-dev aspeed_g5_defconfig
CROSS_COMPILE="ccache arm-linux-gnueabi-" ARCH=arm make -j8 O=aspeed-g5-dev -s
qemu-system-arm -M rainier-bmc -nographic -net nic -kernel
aspeed-g5-dev/arch/arm/boot/zImage -dtb
aspeed-g5-dev/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dtb -initrd
/home/joel/dev/kernels/misc/broomstick.cpio.xz -append
'console=ttyS4,115200n8 quiet' -no-reboot

A few notes:
 - I use the cross compiler from my distro. Debian unstable has GCC
11.2.0, which is the same as openbmc. You can use the compiler from
your openbmc build tree if you aren't able to install a modern
compiler

 - Using ccache is optional

 - building with -s means warnings stand out

 - if you're working on device trees and want to ensure your binary is
being built each time, omit the -s and build the 'dtbs' target

 - booting in qemu is a quick smoke test. You don't need to your board
supported in qemu to test it (although it does help to avoid warnings
from eg. i2c devices that won't probe if the hardware isn't present)

 - adding 'quiet' to the qemu command line again makes it easier to
pick out warnings

That's a bit about how I work. You don't have to follow my work flow,
but feel free to cherry pick bits that are useful.

>
> I'll fix and send a PATCH v3.
>
> I'm really sorry, this shouldn't be so much work for you!

No problem at all. Good work on iterating quickly.

Cheers,

Joel

>
> Oskar.
