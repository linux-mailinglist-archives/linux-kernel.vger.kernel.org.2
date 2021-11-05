Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF3A445EFE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 05:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhKEEGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 00:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhKEEGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 00:06:07 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5035C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 21:03:28 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id h17so3860110qtx.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 21:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fc58r/t2jY2c5ky17n3aPeo946grK/8InB/YHBMFXg0=;
        b=hUefx7guT4tDLT5XGyklHCcGIW1VPdCcQRBzE6azcgWKgPGaTSkv59UR+HbKaPenbu
         1RyaykiT3gGeHfV3KsAlZ9NxHLs0aBizgSnItZFCaj1LtoBMjwUKWNAur0B5z0BSOlUa
         F2FW0XwYGf8OHQ3G2cunukrvXQuvqj41QWCDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fc58r/t2jY2c5ky17n3aPeo946grK/8InB/YHBMFXg0=;
        b=f5jS4EFYo4XKbbenTTk3DRUyHOPYCCvddfQw70av01HuFLWx2WLVB5nxJmiwnqm/fx
         VQyR2QxPp1aGJ4By+Zf2V/qLMiwn3D5fM/f/DGbJiAWjtANdZbTwIYRrd85ElshqNua+
         /F6XMgXo+RUpLCOgJlNJNIYBdC4Lu3ZUjvlOXL7ds+s8n/kG9rvTeW8MzLvdfrJk1gIf
         8ilbEpEBPv3YAwqGeiuvKQ21mPeNjqNZ0Qy+Lvt5mKw4ndSjV+rHugvXdwEHolsvcJeS
         noi/TleYub6EZWxDClSK9mTv/MRzBl7SYPTVKbY3JeO66VLr5jQVe3sOdneQ4JJpM0tn
         OhsA==
X-Gm-Message-State: AOAM530XgYFXIDLkKVx4o4y29GY4fN5HcJZQ/2S8t4oXFj1gvq3hCFzA
        q3EqqqbutrmKnYwtURYCIuN6IZcLWmNuZp8QWno=
X-Google-Smtp-Source: ABdhPJzfPavatG8fz8XDOwBDZsLLephzECNg76r7i3JlbR1TwNWIDvIl3n5RB+4ILqhQIz7sZl7ZobnqnfcA0TeT/hM=
X-Received: by 2002:ac8:5812:: with SMTP id g18mr668756qtg.392.1636085008050;
 Thu, 04 Nov 2021 21:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211105005955.107419-1-osk@google.com> <CACPK8XcXR=V5-Q+sC4MniNJZJgvbiysFD-5yu6v30_2BwDRTSA@mail.gmail.com>
 <CABoTLcS=s0XuM9jiisYW3=1gXtiwP8WeopqTOeBwnTX1XCky9Q@mail.gmail.com>
 <CACPK8XebNsSr3wiMdMxDwQuMGX3p0g2Kid91dekUc6TGcHqfYQ@mail.gmail.com> <CABoTLcTb5uGABwe9FG4haj1888NA4mdZqJFTeQcSotBnq1aZVg@mail.gmail.com>
In-Reply-To: <CABoTLcTb5uGABwe9FG4haj1888NA4mdZqJFTeQcSotBnq1aZVg@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 5 Nov 2021 04:03:15 +0000
Message-ID: <CACPK8Xc0cmgDqOwGDWu4H+x9ySEvwwPVr0M+vJZ=hTOCj3VxiA@mail.gmail.com>
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

On Fri, 5 Nov 2021 at 03:29, Oskar Senft <osk@google.com> wrote:
>
> Hi Joel
>
> > I test the kernels independently of yocto; I recommend doing that with
> > a cross compiler when submitting patches upstream. My flow looks like
> > this:
> > [...]
> > A few notes:
> >  - I use the cross compiler from my distro. Debian unstable has GCC
> > 11.2.0, which is the same as openbmc. You can use the compiler from
> > your openbmc build tree if you aren't able to install a modern
> > compiler
> I couldn't figure out how to use the compiler from the OpenBMC tree.
> The biggest issue is that it has "openbmc" in its name and Linux build
> was getting confused by it. I gave up on that approach and found how
> to install the right cross compiler in our environment. That worked
> well. Thanks for the hints!

Cool. For reference, you should be able to do this:

CROSS_COMPILE="openbmc/build/p10bmc/tmp/sysroots-components/x86_64/gcc-cross-arm/usr/bin/arm-openbmc-linux-gnueabi/arm-openbmc-linux-gnueabi-"

>
> >  - building with -s means warnings stand out
> Excellent idea, thank you!
>
> >  - if you're working on device trees and want to ensure your binary is
> > being built each time, omit the -s and build the 'dtbs' target
> Ack.
>
> I'll send a PATCH v3 now.
>
> Oskar.
