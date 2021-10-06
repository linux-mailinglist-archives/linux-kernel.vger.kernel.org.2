Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52002423DD5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 14:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhJFMkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 08:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229894AbhJFMkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 08:40:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4721361139;
        Wed,  6 Oct 2021 12:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633523907;
        bh=UHuY6TlmNNN+9dHIfYDo1fNOZhjqyzlZ9T9CCgL0xEU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C6XLGYKJMIUTIFB3v5Z3aPyrXFLANzTlqK6mY1kaDMw2515WjRbTCGB+RbtKMTAA9
         qYvUhycw8W9yioJnWovT/vuccHGqEmm1dGi4vvf0nU5++5/10pggkw9c0sGaXXl66s
         ZHs110uAcm+rQvQNyKZG4gFXIivB9Q+k8fw1zAAMNw9T6CA/tPUuKjv22ozATVu8kI
         2zA/IkOSvE3JR2mcWa+kz0BmlRN+sQBS+rTOwZZ6V0Xzq7uOVKFVX56Ip7qYMj/nJy
         4JprW3C7ykm0P/Y8ic6sHYdawoYsBt1oIx52GR47hR+RI3+nvk/dSGROF30Mvq011/
         raVN5086XlUlg==
Received: by mail-ed1-f53.google.com with SMTP id g10so9346274edj.1;
        Wed, 06 Oct 2021 05:38:27 -0700 (PDT)
X-Gm-Message-State: AOAM530KkHImkmk2lTKYdTzzGFy8IMGROOkSoR5S3K+kdMFK37CLdQ+p
        LQWP78nfiVRlJdUJs0Gl2FUCEfnMCYvhGcCZQg==
X-Google-Smtp-Source: ABdhPJyAb9U55hRGrJFM5z+LO/Z/GHO9Bc2eJXtu9imIRuHnkqUJxRxM+FC9hlNN13H9dupCP+6z5hNjuJUGX5lXUSg=
X-Received: by 2002:a17:906:5a47:: with SMTP id my7mr31284501ejc.128.1633523904621;
 Wed, 06 Oct 2021 05:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211005152453.89330-1-amelie.delaunay@foss.st.com>
 <20211005152453.89330-3-amelie.delaunay@foss.st.com> <1633473959.465401.106809.nullmailer@robh.at.kernel.org>
 <491ab475-e7dc-eb71-85aa-6d82543b74db@foss.st.com>
In-Reply-To: <491ab475-e7dc-eb71-85aa-6d82543b74db@foss.st.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 6 Oct 2021 07:38:09 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLEPd9_4SgmDh8GakyNxQeuMKhJeGzaLbZSdxDJ_-dZYg@mail.gmail.com>
Message-ID: <CAL_JsqLEPd9_4SgmDh8GakyNxQeuMKhJeGzaLbZSdxDJ_-dZYg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: phy: phy-stm32-usbphyc: add optional
 phy tuning properties
To:     Amelie DELAUNAY <amelie.delaunay@foss.st.com>
Cc:     "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-phy@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 1:51 AM Amelie DELAUNAY
<amelie.delaunay@foss.st.com> wrote:
>
> Hi Rob,
>
> On 10/6/21 12:45 AM, Rob Herring wrote:
> > On Tue, 05 Oct 2021 17:24:52 +0200, Amelie Delaunay wrote:
> >> This patch adds the description of new optional phy tuning properties
> >> for usbphyc phy sub nodes.
> >>
> >> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> >> ---
> >> Changes in v2:
> >> - st,phy-tuning property removed
> >> - tuning properties are now put directly in each child node
> >> - tuning properties are no more free form text and their name reworked
> >> ---
> >>   .../bindings/phy/phy-stm32-usbphyc.yaml       | 126 ++++++++++++++++++
> >>   1 file changed, 126 insertions(+)
> >>
> >
> > Running 'make dtbs_check' with the schema in this patch gives the
> > following warnings. Consider if they are expected or the schema is
> > incorrect. These may not be new warnings.
> >
> > Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> > This will change in the future.
> >
> > Full log is available here: https://patchwork.ozlabs.org/patch/1536730
> >
> >
> > usbphyc@5a006000: usb-phy@0: 'phy-supply' is a required property
> >       arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-ctouch2.dt.yaml
> >       arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-edimm2.2.dt.yaml
> >       arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0.dt.yaml
> >       arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dt.yaml
> >       arch/arm/boot/dts/stm32mp157c-lxa-mc1.dt.yaml
> >       arch/arm/boot/dts/stm32mp157c-odyssey.dt.yaml
> >
> > usbphyc@5a006000: usb-phy@1: 'phy-supply' is a required property
> >       arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-ctouch2.dt.yaml
> >       arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-edimm2.2.dt.yaml
> >       arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0.dt.yaml
> >       arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dt.yaml
> >       arch/arm/boot/dts/stm32mp157c-lxa-mc1.dt.yaml
> >       arch/arm/boot/dts/stm32mp157c-odyssey.dt.yaml
> >
>
> These warnings are due to the fact that usbphyc parent node is disabled
> in parent device tree (stm32mp151.dtsi) but not the "usb-phy" child
> nodes. These warnings are not introduced by this current patch "optional
> phy tuning properties" but anyway.

Yes, I said that may be the case.

> The device trees mentioned don't
> enable usbphyc, so they don't have to set phy-supply in usbphyc child nodes.
>
> $ git diff arch/arm/boot/dts/stm32mp151.dtsi
> diff --git a/arch/arm/boot/dts/stm32mp151.dtsi
> b/arch/arm/boot/dts/stm32mp151.dtsi
> index bd289bf5d269..abef8b6be40a 100644
> --- a/arch/arm/boot/dts/stm32mp151.dtsi
> +++ b/arch/arm/boot/dts/stm32mp151.dtsi
> @@ -1507,11 +1507,13 @@ usbphyc: usbphyc@5a006000 {
>                          usbphyc_port0: usb-phy@0 {
>                                  #phy-cells = <0>;
>                                  reg = <0>;
> +                               status = "disabled";
>                          };
>
>                          usbphyc_port1: usb-phy@1 {
>                                  #phy-cells = <1>;
>                                  reg = <1>;
> +                               status = "disabled";
>                          };
>                  };
>
> Disable child nodes while parent node is already disabled fixes the
> warning. But it means to add status = "okay"; in child nodes everywhere
> usbphyc is enabled.

Presumably, you already have to add phy-supply everywhere.

> Is it normal dtbs_check checks in child nodes when parent node is disabled?

I'll look into doing that.

Rob
