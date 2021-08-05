Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD143E0C64
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 04:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbhHECRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 22:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhHECRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 22:17:40 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A16C0613C1;
        Wed,  4 Aug 2021 19:17:26 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 14so4848454qkc.4;
        Wed, 04 Aug 2021 19:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rkGOSVQF9TOhjzyiUoCJV05ZbHNx5GT+bf4KeZ6f2IA=;
        b=B/uPjSmx60H4ihwfZ8wtzF6CYCbTEPVmk4keYAeCgxiUr7EbcO/Xr18Udj7qjH5pDi
         +hLao+j9kUFgzdXaH/y6DvRYXsBXnRnMH9bAa2Mo3Heh8Xn1tVLhLpaZSygh2NrmMsQB
         KSa+jXTwJWa9pcw6CjXCG92kKr9d5tF9FPV/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rkGOSVQF9TOhjzyiUoCJV05ZbHNx5GT+bf4KeZ6f2IA=;
        b=mncUUw4yicUrLWFApbuXw+JkfqeZCMdVk/hkgGhk/Yra9d45VPnXJIAGXo74TQ8Kxy
         rETq7bdGuc+y6IAbiSUNjodkNqpx3tAiOafg+YSUekBcPVeLP7WL8OBCLKpIjvu+DG3q
         hs7Uze7xDrPpdjGLf/YTl1Fv5TjSJx+4+Kzsm+NsLbrEdNs8Rt/krFNr7WkBg5czJ20A
         FSR7n3GpQvs26VRbN5pT0GY5XoWSjmYPMQLRbizM5dvyDB5YGtC4yS6IjiGvdm41Uv5t
         s2bzCUROpBas+U3F9ScFMyFsvBvhuHDliBsuNX92OjSGXyulMMK2te3mPxHOi9D9EAsX
         qQKA==
X-Gm-Message-State: AOAM530cXzZfLHod8Qt+mblGt0Iw2zYEO7CBOyktn2IQRs+4c4kjcXxa
        iA0mApyW7xwbZ7PrKECkvOUu0olPGVlAT2F3xjs=
X-Google-Smtp-Source: ABdhPJysI08p+xS1rb4jB6N4wAriNvzo2kltaAaQt1+UjwLYcRVjKGA2lAJPptqP1gzrQhP151sLslPnoPHg6ECB8Y8=
X-Received: by 2002:a05:620a:893:: with SMTP id b19mr2511179qka.487.1628129845723;
 Wed, 04 Aug 2021 19:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210728233755.17963-1-rentao.bupt@gmail.com> <20210728233755.17963-7-rentao.bupt@gmail.com>
 <CACPK8XemZkV7nK_b4883DN+dJKhL=tXfqK6=DpHQe=fZRu_ETQ@mail.gmail.com>
 <20210805011951.GA28444@taoren-ubuntu-R90MNF91> <CACPK8XcwsOa5NzsUZeiv5qdWV5H6HBa7WK+cwbnqayP4zhoNkg@mail.gmail.com>
 <20210805020946.GA29371@taoren-ubuntu-R90MNF91>
In-Reply-To: <20210805020946.GA29371@taoren-ubuntu-R90MNF91>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 5 Aug 2021 02:17:13 +0000
Message-ID: <CACPK8XfewBvd4BLgkgkC0DBzVk5pmV4ZTVaVt=otrKfqJ6m5Lg@mail.gmail.com>
Subject: Re: [PATCH 6/6] ARM: dts: aspeed: Add Facebook Fuji (AST2600) BMC
To:     Tao Ren <rentao.bupt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2021 at 02:09, Tao Ren <rentao.bupt@gmail.com> wrote:
>
> On Thu, Aug 05, 2021 at 01:37:29AM +0000, Joel Stanley wrote:
> > On Thu, 5 Aug 2021 at 01:20, Tao Ren <rentao.bupt@gmail.com> wrote:
> > > > > +&ehci1 {
> > > > > +       status = "okay";
> > > > > +};
> > > >
> > > > Have you verified that USB works with mainline? I've had reports of it
> > > > working on 5.8 but it seems to have regressed as of v5.10.
> > >
> > > It stopped working on ASPEED since commit 280a9045bb18 ("ehci: fix EHCI
> > > host controller initialization sequence"): ehci_handshake() returns
> > > error because HCHalted bit EHCI24[12] stays at 1.
> > >
> > > I have a dirty hack in my tree (ignoring the halt bit) and it "works" on
> > > AST2500 and AST2600. Let me send an email to openbmc and aspeed email
> > > groups to see if anyone has more context.
> >
> > We discovered the same, except in my testing it wasn't actually
> > "working" on my EVB. I have a A3 EVB on my desk and when plugging in a
> > USB key nothing happened.
>
> We have a non-removable USB device on Fuji (AST2600) BMC and it can be
> enumerated successfully (after applying the hack). Let me vist the lab
> and plug a USB key to CMM (AST2500) BMC sometime next week. Will collect
> results and send out email then.

Thanks!

> > > status is set in ast2600 common dtsi, but let me set it here to avoid
> > > confusion. Will update pinmux in v2. Thanks.
> >
> > Are you looking at mainline? I think it's disabled by default there:
> >
> > https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/aspeed-g6.dtsi#L246
>
> Sorry for the confusion, Joel. I mean the device is enabled in
> "ast2600-facebook-netbmc-common.dtsi" (patch #3 in the series). Do we
> still need to set status to "okay" explicitly in platform dts (to avoid
> confusion)?

I see, thanks for explaining. It's a downside of the device tree
bindings for the ethernet device.

Given you will be the one working with the board, I think it's up to
you how you lay it out. You could choose to add a comment to the
platform dts, or put the hunk you currently have in the common.dtsi in
the platform.

>
> &mac3 {
>         status = "okay";
>         phy-mode = "rgmii";
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_rgmii4_default>;
> };
