Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821F33F4555
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 08:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbhHWGyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 02:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbhHWGy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 02:54:29 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56730C061756
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 23:53:47 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id k5so35842443lfu.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 23:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ykVwd28+PpS9RdFtwLjN4T/dzr4Pp61Ec9sxPTtcctc=;
        b=J1ffpX3IK1WLgUymbrNtz4fC5SSzlNQoHe9i5k3n9fPJ3OyXL1cEhKhqg7JTfQXsqb
         gxIp9u/kV11VpBiYxcQ7TKGNkG5fheHOcrJHHRE/xv2ZKa13vPtCsMEnMhaT1ZyqP/gq
         PVBK1Gbsn2A6HFPU7XC7ioqAN3pMiNhqFPrPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ykVwd28+PpS9RdFtwLjN4T/dzr4Pp61Ec9sxPTtcctc=;
        b=lxHTg+IkMpu0xCcgIsGxtC0q9erQcwRkqlj1KcI8tvda97FTTXR+thSxmSHjmWZaS8
         0yUDqQDunPBRYhgRaTyoF5pX6XfWLuPBxS0AW+HvdlEkC2KQM8Ny1a/831aRHOwJGbG1
         pBwETtkWPaEDqa386NBfmOLs3ZqWQC6HHI0PYO5ve8wdjg/njUt6+aarrn6XBUFzyOAF
         qJ/1G1mFdpH4+U0vv5oCGJK/QUk1J7FHPKVAiXqwRWqLIVeNXOg7JuqUzUNClZluma5v
         UiEGMEJBJWOx8cMUukTFxLzGuDueB2iS73urawqlo9ytAMjUAysumNYFyIFK1Wk0brBj
         WI8Q==
X-Gm-Message-State: AOAM532WnW1KuO9YA5eMYZmmJIlBx+k+If2hwiAWY4w4lQnfBIV0IzZZ
        ftZecEV7I3dqIJ41LclruEB4XvRhPIOnjx5DHN1vFg==
X-Google-Smtp-Source: ABdhPJxh0ZhiKQDi+P2hyKg41D5UpaAEP74ceBsTgaXwXWkhWXIx8uAAhgWwAorVWvx9v84bqXxUIka1tGuDnu6MVd8=
X-Received: by 2002:a19:ca09:: with SMTP id a9mr8363402lfg.342.1629701625387;
 Sun, 22 Aug 2021 23:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210820111504.350-1-chun-jie.chen@mediatek.com> <20210820111504.350-2-chun-jie.chen@mediatek.com>
In-Reply-To: <20210820111504.350-2-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 23 Aug 2021 14:53:34 +0800
Message-ID: <CAGXv+5FAEFD+dQsZzyZOzmwDDnwLZO3Z8wv8Z-=wVYdjjc3FYg@mail.gmail.com>
Subject: Re: [v2 01/24] dt-bindings: ARM: Mediatek: Add new document bindings
 of MT8195 clock
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 20, 2021 at 7:17 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> This patch adds the new binding documentation for system clock
> and functional clock on Mediatek MT8195.
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  .../arm/mediatek/mediatek,mt8195-clock.yaml   | 254 ++++++++++++++++++
>  .../mediatek/mediatek,mt8195-sys-clock.yaml   |  73 +++++
>  2 files changed, 327 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml
>
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
> new file mode 100644
> index 000000000000..17fcbb45d121
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
> @@ -0,0 +1,254 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt8195-clock.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: MediaTek Functional Clock Controller for MT8195
> +
> +maintainers:
> +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
> +
> +description:
> +  The clock architecture in Mediatek like below
> +  PLLs -->
> +          dividers -->
> +                      muxes
> +                           -->
> +                              clock gate
> +
> +  The devices except apusys_pll provide clock gate control in different IP blocks.
> +  The apusys_pll provides Plls which generated from SoC 26m for AI Processing Unit.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8195-scp_adsp
> +          - mediatek,mt8195-imp_iic_wrap_s
> +          - mediatek,mt8195-imp_iic_wrap_w
> +          - mediatek,mt8195-mfgcfg
> +          - mediatek,mt8195-vppsys0
> +          - mediatek,mt8195-wpesys
> +          - mediatek,mt8195-wpesys_vpp0
> +          - mediatek,mt8195-wpesys_vpp1
> +          - mediatek,mt8195-vppsys1
> +          - mediatek,mt8195-imgsys
> +          - mediatek,mt8195-imgsys1_dip_top
> +          - mediatek,mt8195-imgsys1_dip_nr
> +          - mediatek,mt8195-imgsys1_wpe
> +          - mediatek,mt8195-ipesys
> +          - mediatek,mt8195-camsys
> +          - mediatek,mt8195-camsys_rawa
> +          - mediatek,mt8195-camsys_yuva
> +          - mediatek,mt8195-camsys_rawb
> +          - mediatek,mt8195-camsys_yuvb
> +          - mediatek,mt8195-camsys_mraw
> +          - mediatek,mt8195-ccusys
> +          - mediatek,mt8195-vdecsys_soc
> +          - mediatek,mt8195-vdecsys
> +          - mediatek,mt8195-vdecsys_core1
> +          - mediatek,mt8195-vencsys
> +          - mediatek,mt8195-vencsys_core1
> +          - mediatek,mt8195-apusys_pll

The indentation is slightly off by 2 extra spaces.

[...]

> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml
> new file mode 100644
> index 000000000000..dbf33ea6cb9f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt8195-sys-clock.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: MediaTek System Clock Controller for MT8195
> +
> +maintainers:
> +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
> +
> +description:
> +  The clock architecture in Mediaek like below

Typo.

> +  PLLs -->
> +          dividers -->
> +                      muxes
> +                           -->
> +                              clock gate
> +
> +  The apmixedsys provides most of PLLs which generated from SoC 26m.
> +  The topckgen provides dividers and muxes which provide the clock source to other IP blocks.
> +  The infracfg_ao and pericfg_ao provides clock gate in peripheral and infrastructure IP blocks.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8195-topckgen
> +          - mediatek,mt8195-infracfg_ao
> +          - mediatek,mt8195-apmixedsys
> +          - mediatek,mt8195-pericfg_ao

Indentation off here as well.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
