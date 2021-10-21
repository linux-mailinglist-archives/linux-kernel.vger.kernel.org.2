Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CC7436C7E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 23:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhJUVPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 17:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhJUVPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 17:15:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C3976121F;
        Thu, 21 Oct 2021 21:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634850786;
        bh=/l4crKTJU+mgntsEJ0sR+1pGqv6aNLYCFVgceEpMNns=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=djh2vmZOkvA7MRz++gJ2Kx4d6rk9C4vkjpVZpL72HvTpAXdOZUstQ19Qk1jVSYwxS
         hNeKrJFfTN6Y6mixVXAYbZdfTU0SJ8Bev1iROgELhCylnnrXfWLqyZIvVYe0cTPcbp
         m26Jil9nUvyFAkFWs127Qr7q4/v3MHKOQW+UpHsdbpB7rzCXXVu37N61jLH0xdfj/v
         /8zTlqcAU+FkzxXEOqgzmPB/8LAHc2CFrtCjd4RIvPA/iPui7KWRhPF/MXchHEGIqb
         d0mGucOwaW2vXYPqUx1z9IYXvuMPaXgTduqkaS14/h7CV0WePk5gKkuFtJUfnZH7p2
         LPQTBfbRghqNQ==
Received: by mail-ed1-f46.google.com with SMTP id z20so664318edc.13;
        Thu, 21 Oct 2021 14:13:06 -0700 (PDT)
X-Gm-Message-State: AOAM5305Vc2s98JSZV/JCwcTZV/o3ulqLWTdIIXoEGIttgfUl3z1cIA2
        aIQ6sxTn3KBAtE1Vd0hWZ6fxQb4+oKjqhC3vyQ==
X-Google-Smtp-Source: ABdhPJwm2zVi1mzlkMOdp/sBnRpDO9JribQiGYt16+7dDjKNxMl8q6Dpu/5Zug7CNLK2Ux9X3/NUFfLZmItNXrgFcPs=
X-Received: by 2002:a17:906:71d4:: with SMTP id i20mr10141556ejk.390.1634850784991;
 Thu, 21 Oct 2021 14:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210928192143.1841497-1-robh@kernel.org> <20211004061406.tyhldt4f26zilaaw@vireshk-i7>
In-Reply-To: <20211004061406.tyhldt4f26zilaaw@vireshk-i7>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 21 Oct 2021 16:12:52 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJzb3mOO-0_y+7zOQO6DMNLhAN99pDfuj55ooLULKb4WA@mail.gmail.com>
Message-ID: <CAL_JsqJzb3mOO-0_y+7zOQO6DMNLhAN99pDfuj55ooLULKb4WA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: spear13xx: Drop malformed 'interrupt-map' on
 PCI nodes
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 1:14 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 28-09-21, 14:21, Rob Herring wrote:
> > The spear13xx PCI 'interrupt-map' property is not parse-able.
> > '#interrupt-cells' is missing and there are 3 #address-cells. Based on the
> > driver, the only supported interrupt is for MSI. Therefore, 'interrupt-map'
> > is not needed.
> >
> > Cc: Viresh Kumar <vireshk@kernel.org>
> > Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  arch/arm/boot/dts/spear1310.dtsi | 6 ------
> >  arch/arm/boot/dts/spear1340.dtsi | 2 --
> >  2 files changed, 8 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/spear1310.dtsi b/arch/arm/boot/dts/spear1310.dtsi
> > index c4b49baf9804..2f746a9428a7 100644
> > --- a/arch/arm/boot/dts/spear1310.dtsi
> > +++ b/arch/arm/boot/dts/spear1310.dtsi
> > @@ -82,8 +82,6 @@ pcie0: pcie@b1000000 {
> >                       reg = <0xb1000000 0x4000>, <0x80000000 0x20000>;
> >                       reg-names = "dbi", "config";
> >                       interrupts = <0 68 0x4>;
> > -                     interrupt-map-mask = <0 0 0 0>;
> > -                     interrupt-map = <0x0 0 &gic 0 68 0x4>;
> >                       num-lanes = <1>;
> >                       phys = <&miphy0 1>;
> >                       phy-names = "pcie-phy";
> > @@ -101,8 +99,6 @@ pcie1: pcie@b1800000 {
> >                       reg = <0xb1800000 0x4000>, <0x90000000 0x20000>;
> >                       reg-names = "dbi", "config";
> >                       interrupts = <0 69 0x4>;
> > -                     interrupt-map-mask = <0 0 0 0>;
> > -                     interrupt-map = <0x0 0 &gic 0 69 0x4>;
> >                       num-lanes = <1>;
> >                       phys = <&miphy1 1>;
> >                       phy-names = "pcie-phy";
> > @@ -120,8 +116,6 @@ pcie2: pcie@b4000000 {
> >                       reg = <0xb4000000 0x4000>, <0xc0000000 0x20000>;
> >                       reg-names = "dbi", "config";
> >                       interrupts = <0 70 0x4>;
> > -                     interrupt-map-mask = <0 0 0 0>;
> > -                     interrupt-map = <0x0 0 &gic 0 70 0x4>;
> >                       num-lanes = <1>;
> >                       phys = <&miphy2 1>;
> >                       phy-names = "pcie-phy";
> > diff --git a/arch/arm/boot/dts/spear1340.dtsi b/arch/arm/boot/dts/spear1340.dtsi
> > index 1a8f5e8b10e3..827e887afbda 100644
> > --- a/arch/arm/boot/dts/spear1340.dtsi
> > +++ b/arch/arm/boot/dts/spear1340.dtsi
> > @@ -47,8 +47,6 @@ pcie0: pcie@b1000000 {
> >                       reg = <0xb1000000 0x4000>, <0x80000000 0x20000>;
> >                       reg-names = "dbi", "config";
> >                       interrupts = <0 68 0x4>;
> > -                     interrupt-map-mask = <0 0 0 0>;
> > -                     interrupt-map = <0x0 0 &gic 0 68 0x4>;
> >                       num-lanes = <1>;
> >                       phys = <&miphy0 1>;
> >                       phy-names = "pcie-phy";
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Are you going to apply this?

Rob
