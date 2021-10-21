Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A481A435AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 08:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhJUGb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 02:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhJUGbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 02:31:25 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9ABC06161C;
        Wed, 20 Oct 2021 23:29:09 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id d205so967186qke.3;
        Wed, 20 Oct 2021 23:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0e08ZBM6li1C7tIxn5UtaiVKx16gPUU53/VSVrg5fJo=;
        b=Td2fY8rzFcaK0Z8RxrmdaIX5MS//Nz7s/uqzHILWSw/VIPmQfG3YXqAP3T1TWwk4LQ
         eMvK7Ag7S9dMbVvXNTU8YFYN2X6ZGEwsN9UDFtp2yhjHSGFoVOMfTWUlJ93HGpFvj+hT
         stQqNCSOAwW1/HSCSJGI9Ad5OtyUezsZ8YbT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0e08ZBM6li1C7tIxn5UtaiVKx16gPUU53/VSVrg5fJo=;
        b=MftQizB8+9mAic15kUMvnQ9yCt4lkxwjD0YDX8i8YqGlMCP99JcKB1nyq+FjjhM6Qd
         YrFHSyH9KOpA/qyBeWyWYC64IIqCecxcyofjXInvjuwJrIe51o7ShrFXPHTbl05A/jqG
         FFAkjfyR0na2sahjj5JJ2SvNO4H9sW05sSgpiMGtI6DHhsiUSIywK1eyrZL79lEMGag7
         wVeyxkXxd0bMb6mSa8iVyL/WR8C/QwNzIJfKnNAxzosx3MsMMN2AAdMTIE5PQ05u/ASh
         ics+4nkDWM6FkO1A6i1/qWUDzN8+T0UtRQsWXvq4iQ/xgBt3QRVWHlaRkV9PHB2tgNVf
         65GA==
X-Gm-Message-State: AOAM530VqtBs0OnaM4Xb25EEV9LCJjIevKu0UaRYF3IWoLHHMYcgiCWA
        Bgkeva1W8a421AOrw+iBqDt5i3icttV9seIi85PH4T1I
X-Google-Smtp-Source: ABdhPJzYRyu7h/1T0GKhoPH0Q6POzzEPYiGIWsiuBu5bnlqmFPvMvmpbey9PZ3ED3wlZtCpFep2wbVDF16aMVFxE040=
X-Received: by 2002:a05:620a:4010:: with SMTP id h16mr3013062qko.292.1634797748541;
 Wed, 20 Oct 2021 23:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210927023053.6728-1-chiawei_wang@aspeedtech.com>
 <20210927023053.6728-2-chiawei_wang@aspeedtech.com> <CACPK8Xc+9yFJn_pO1sAVQJu_FWkA1U9XnbB+TLYgfdbHi1TyaQ@mail.gmail.com>
In-Reply-To: <CACPK8Xc+9yFJn_pO1sAVQJu_FWkA1U9XnbB+TLYgfdbHi1TyaQ@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 21 Oct 2021 06:28:56 +0000
Message-ID: <CACPK8Xfj=wJBCX5ogyf02pLJsLrooVWBJ92GJ1E+jxQW5wiFEw@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] ARM: dts: aspeed: Drop reg-io-width from LPC nodes
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Oskar Senft <osk@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Oct 2021 at 04:35, Joel Stanley <joel@jms.id.au> wrote:
>
> On Mon, 27 Sept 2021 at 02:31, Chia-Wei Wang
> <chiawei_wang@aspeedtech.com> wrote:
> >
> > The 'reg-io-width' properties are not used by LPC drivers
> > nor documented as part of bindings. Therefore drop them.
>
> I assume they are there due to the lpc having a 'syscon' compatible.
> THey are documented in the syscon bindings:
>
> Documentation/devicetree/bindings/mfd/syscon.yaml
>
> Andrew, do you have any comments?

Andrew indicated to me that he agreed with my observation: the
properties should be present as they are used by the regmap/syscon.

>
> >
> > This is in preparation to move aspeed-lpc.txt to YAML schema.
> >
> > Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > ---
> >  arch/arm/boot/dts/aspeed-g4.dtsi | 1 -
> >  arch/arm/boot/dts/aspeed-g5.dtsi | 1 -
> >  arch/arm/boot/dts/aspeed-g6.dtsi | 1 -
> >  3 files changed, 3 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> > index c5aeb3cf3a09..45a25eb4baa4 100644
> > --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> > +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> > @@ -345,7 +345,6 @@
> >                         lpc: lpc@1e789000 {
> >                                 compatible = "aspeed,ast2400-lpc-v2", "simple-mfd", "syscon";
> >                                 reg = <0x1e789000 0x1000>;
> > -                               reg-io-width = <4>;
> >
> >                                 #address-cells = <1>;
> >                                 #size-cells = <1>;
> > diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> > index 73ca1ec6fc24..8e1d00d8445e 100644
> > --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> > +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> > @@ -436,7 +436,6 @@
> >                         lpc: lpc@1e789000 {
> >                                 compatible = "aspeed,ast2500-lpc-v2", "simple-mfd", "syscon";
> >                                 reg = <0x1e789000 0x1000>;
> > -                               reg-io-width = <4>;
> >
> >                                 #address-cells = <1>;
> >                                 #size-cells = <1>;
> > diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> > index 1b47be1704f8..0d1aae6887cd 100644
> > --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> > +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> > @@ -490,7 +490,6 @@
> >                         lpc: lpc@1e789000 {
> >                                 compatible = "aspeed,ast2600-lpc-v2", "simple-mfd", "syscon";
> >                                 reg = <0x1e789000 0x1000>;
> > -                               reg-io-width = <4>;
> >
> >                                 #address-cells = <1>;
> >                                 #size-cells = <1>;
> > --
> > 2.17.1
> >
