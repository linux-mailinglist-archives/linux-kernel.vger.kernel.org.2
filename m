Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D243F60D6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238014AbhHXOp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:45:27 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:44665 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237582AbhHXOp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:45:26 -0400
Received: by mail-ot1-f47.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so38181401otg.11;
        Tue, 24 Aug 2021 07:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aJH/4Wz71I23MU2srknICQJ9rD7Y4ljj2of9b/CEP0E=;
        b=c6jJQbS6GP1scZEqUv7IljEQKgEPIUZgw4A13CfIV0tkM60M9XxmWaJgKaoKThbM6X
         jHaGCOgtmk45CAkQYnfjVthPqHfrfNyCTJ/pwmzsDyAf9X25t4sIdpR+M/YjHuPufopl
         szMxJbNLEhE0T2e2T2JibPXRUEkoqk7T0h55c5191M14tiDmzmx2im+foPrt3Rpp3LZE
         7rtQ9W0fD8bzNaOZrJbs5nxoMSmAaAsyIujdZNWJDl1jMxdp9OSV3e0Hs3ZS8o6hxLkf
         Q01Ts8PNMrCBd77RneWxB409Z+dYNtNC00bVilqEN4aqH0EJY6zuYXK0Y9Jie1WonFqT
         5ZMA==
X-Gm-Message-State: AOAM531ms8wLln+mv5yYe4LeI7Bk1QnhtExZLf2hGQjKK/HlRtd5JWvI
        OfHWsTlecy3IcqMGuVFpOA==
X-Google-Smtp-Source: ABdhPJy6vDSJt+2Ck3xeOse/ZCrzza/jwGRdp/B+jAHApeYlfASuRvLwRR/YsKxDPNWiiIv9Vr8qpg==
X-Received: by 2002:a9d:798c:: with SMTP id h12mr28578498otm.215.1629816282067;
        Tue, 24 Aug 2021 07:44:42 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t1sm4592857otp.9.2021.08.24.07.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 07:44:41 -0700 (PDT)
Received: (nullmailer pid 416238 invoked by uid 1000);
        Tue, 24 Aug 2021 14:44:40 -0000
Date:   Tue, 24 Aug 2021 09:44:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [v2 01/24] dt-bindings: ARM: Mediatek: Add new document bindings
 of MT8195 clock
Message-ID: <YSUF18AZ2HgOnkce@robh.at.kernel.org>
References: <20210820111504.350-1-chun-jie.chen@mediatek.com>
 <20210820111504.350-2-chun-jie.chen@mediatek.com>
 <CAGXv+5FAEFD+dQsZzyZOzmwDDnwLZO3Z8wv8Z-=wVYdjjc3FYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXv+5FAEFD+dQsZzyZOzmwDDnwLZO3Z8wv8Z-=wVYdjjc3FYg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 02:53:34PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Fri, Aug 20, 2021 at 7:17 PM Chun-Jie Chen
> <chun-jie.chen@mediatek.com> wrote:
> >
> > This patch adds the new binding documentation for system clock
> > and functional clock on Mediatek MT8195.
> >
> > Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> > ---
> >  .../arm/mediatek/mediatek,mt8195-clock.yaml   | 254 ++++++++++++++++++
> >  .../mediatek/mediatek,mt8195-sys-clock.yaml   |  73 +++++
> >  2 files changed, 327 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
> >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
> > new file mode 100644
> > index 000000000000..17fcbb45d121
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
> > @@ -0,0 +1,254 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt8195-clock.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: MediaTek Functional Clock Controller for MT8195
> > +
> > +maintainers:
> > +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
> > +
> > +description:
> > +  The clock architecture in Mediatek like below
> > +  PLLs -->
> > +          dividers -->
> > +                      muxes
> > +                           -->
> > +                              clock gate
> > +
> > +  The devices except apusys_pll provide clock gate control in different IP blocks.
> > +  The apusys_pll provides Plls which generated from SoC 26m for AI Processing Unit.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - mediatek,mt8195-scp_adsp
> > +          - mediatek,mt8195-imp_iic_wrap_s
> > +          - mediatek,mt8195-imp_iic_wrap_w
> > +          - mediatek,mt8195-mfgcfg
> > +          - mediatek,mt8195-vppsys0
> > +          - mediatek,mt8195-wpesys
> > +          - mediatek,mt8195-wpesys_vpp0
> > +          - mediatek,mt8195-wpesys_vpp1
> > +          - mediatek,mt8195-vppsys1
> > +          - mediatek,mt8195-imgsys
> > +          - mediatek,mt8195-imgsys1_dip_top
> > +          - mediatek,mt8195-imgsys1_dip_nr
> > +          - mediatek,mt8195-imgsys1_wpe
> > +          - mediatek,mt8195-ipesys
> > +          - mediatek,mt8195-camsys
> > +          - mediatek,mt8195-camsys_rawa
> > +          - mediatek,mt8195-camsys_yuva
> > +          - mediatek,mt8195-camsys_rawb
> > +          - mediatek,mt8195-camsys_yuvb
> > +          - mediatek,mt8195-camsys_mraw
> > +          - mediatek,mt8195-ccusys
> > +          - mediatek,mt8195-vdecsys_soc
> > +          - mediatek,mt8195-vdecsys
> > +          - mediatek,mt8195-vdecsys_core1
> > +          - mediatek,mt8195-vencsys
> > +          - mediatek,mt8195-vencsys_core1
> > +          - mediatek,mt8195-apusys_pll
> 
> The indentation is slightly off by 2 extra spaces.

No it's not. Indentation is always 2 more that the prior keyword. If in 
doubt, make sure yamllint is installed and this is checked as part of 
the build.

Rob
