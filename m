Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186913F7479
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 13:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbhHYLk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 07:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbhHYLky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 07:40:54 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236CDC0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 04:40:08 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id m4so8290796ljq.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 04:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EBZuV88pzuw+Utaj04PasP/41EJ4vd/yd+gwCxY9UrU=;
        b=mZa9ODjFAlloFGduYEqaTO902w+oDyx3AX1SSokAkNLaVDfKLBrLXZbRbxaKd2VsNX
         CLf9p8nVSdT4Bj8/5mV2PzNe9XR1Gd9xy9RYjvSk3UiHCLUGpRvJX4l3Vq259dcrtmhL
         8/0MXnNb5kz9KLlqjOPN3SB33PNFiNdXspKaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EBZuV88pzuw+Utaj04PasP/41EJ4vd/yd+gwCxY9UrU=;
        b=gK/BYIZ7ZBf5cyHRbrPN5QZhx0AptlomYvUsCJavET/QeA9zdCXuaxKrkxQN3M/3Zc
         7pYeRXzDNwLIpkcuuvFR1xQO9oJlYzlWoSNRT9LIk1tqvQelewOggr0EyL5my2lNeeQi
         SkponD0C/PPU5OBLfTCvaxNZVkiBfsOAjW90VvAzeL0JheQ1t5satUabwtCaUywL5g7Y
         7Kk8mMyE3Um3kw3ZUYSr3FVi2EJ31pR3Zi7yCmyQBnoFrZ73wZ4VHEEjyLH8oVZhZpT1
         FW5sc0jzRYZEoa9JDMXw14gcSgpggAmH0s8yVS9QzvR08NvJSUUfOvwmg4xNzaapUjSI
         B8CQ==
X-Gm-Message-State: AOAM533MdPq581yS8i3qBENbvPR7stZLKRY83jObmV5p8YUkpX2JjSKA
        fOB+D4rCNEKjrPt3/gtr4IqjdoNlYtvYNCuTioZ4kw==
X-Google-Smtp-Source: ABdhPJzCtvn8fAS4/q6M3YBoqbcAFrN7nTepCa+MUbbEZGiTzZRCqQ+Z7ipvuJp8aEquToQ/qlt7CrzkIDbTsII0zEs=
X-Received: by 2002:a2e:8546:: with SMTP id u6mr24817270ljj.185.1629891605061;
 Wed, 25 Aug 2021 04:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210820111504.350-1-chun-jie.chen@mediatek.com> <20210820111504.350-3-chun-jie.chen@mediatek.com>
In-Reply-To: <20210820111504.350-3-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 25 Aug 2021 19:39:54 +0800
Message-ID: <CAGXv+5Eb4ZiXZXURvoApSEk_myhNpEugOhr2DrzvkxGfDKJneg@mail.gmail.com>
Subject: Re: [v2 02/24] clk: mediatek: Add dt-bindings of MT8195 clocks
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

On Fri, Aug 20, 2021 at 7:17 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8195 clock dt-bindings, include topckgen, apmixedsys,
> infracfg_ao, pericfg_ao and subsystem clocks.
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  include/dt-bindings/clock/mt8195-clk.h | 864 +++++++++++++++++++++++++
>  1 file changed, 864 insertions(+)
>  create mode 100644 include/dt-bindings/clock/mt8195-clk.h
>
> diff --git a/include/dt-bindings/clock/mt8195-clk.h b/include/dt-bindings/clock/mt8195-clk.h
> new file mode 100644
> index 000000000000..95cf812a0b37
> --- /dev/null
> +++ b/include/dt-bindings/clock/mt8195-clk.h
> @@ -0,0 +1,864 @@

[...]

> +/* WPESYS_VPP0 */
> +
> +#define CLK_WPE_VPP0_VECI              0
> +#define CLK_WPE_VPP0_VEC2I             1
> +#define CLK_WPE_VPP0_VEC3I             2
> +#define CLK_WPE_VPP0_WPEO              3
> +#define CLK_WPE_VPP0_MSKO              4
> +#define CLK_WPE_VPP0_VGEN              5
> +#define CLK_WPE_VPP0_EXT               6
> +#define CLK_WPE_VPP0_VFC               7
> +#define CLK_WPE_VPP0_CACH0_TOP         8
> +#define CLK_WPE_VPP0_CACH0_DMA         9
> +#define CLK_WPE_VPP0_CACH1_TOP         10
> +#define CLK_WPE_VPP0_CACH1_DMA         11
> +#define CLK_WPE_VPP0_CACH2_TOP         12
> +#define CLK_WPE_VPP0_CACH2_DMA         13
> +#define CLK_WPE_VPP0_CACH3_TOP         14
> +#define CLK_WPE_VPP0_CACH3_DMA         15
> +#define CLK_WPE_VPP0_PSP               16
> +#define CLK_WPE_VPP0_PSP2              17
> +#define CLK_WPE_VPP0_SYNC              18
> +#define CLK_WPE_VPP0_C24               19
> +#define CLK_WPE_VPP0_MDP_CROP          20
> +#define CLK_WPE_VPP0_ISP_CROP          21
> +#define CLK_WPE_VPP0_TOP               22
> +#define CLK_WPE_VPP0_NR_CLK            23
> +
> +/* WPESYS_VPP1 */
> +
> +#define CLK_WPE_VPP1_VECI              0
> +#define CLK_WPE_VPP1_VEC2I             1
> +#define CLK_WPE_VPP1_VEC3I             2
> +#define CLK_WPE_VPP1_WPEO              3
> +#define CLK_WPE_VPP1_MSKO              4
> +#define CLK_WPE_VPP1_VGEN              5
> +#define CLK_WPE_VPP1_EXT               6
> +#define CLK_WPE_VPP1_VFC               7
> +#define CLK_WPE_VPP1_CACH0_TOP         8
> +#define CLK_WPE_VPP1_CACH0_DMA         9
> +#define CLK_WPE_VPP1_CACH1_TOP         10
> +#define CLK_WPE_VPP1_CACH1_DMA         11
> +#define CLK_WPE_VPP1_CACH2_TOP         12
> +#define CLK_WPE_VPP1_CACH2_DMA         13
> +#define CLK_WPE_VPP1_CACH3_TOP         14
> +#define CLK_WPE_VPP1_CACH3_DMA         15
> +#define CLK_WPE_VPP1_PSP               16
> +#define CLK_WPE_VPP1_PSP2              17
> +#define CLK_WPE_VPP1_SYNC              18
> +#define CLK_WPE_VPP1_C24               19
> +#define CLK_WPE_VPP1_MDP_CROP          20
> +#define CLK_WPE_VPP1_ISP_CROP          21
> +#define CLK_WPE_VPP1_TOP               22
> +#define CLK_WPE_VPP1_NR_CLK            23

If WPE_VPP0 and WPE_VPP1 end up being identical hardware, then there's
no need to have two separate lists.

[...]

> +/* VENCSYS */
> +
> +#define CLK_VENC_LARB                  0
> +#define CLK_VENC_VENC                  1
> +#define CLK_VENC_JPGENC                        2
> +#define CLK_VENC_JPGDEC                        3
> +#define CLK_VENC_JPGDEC_C1             4
> +#define CLK_VENC_GALS                  5
> +#define CLK_VENC_NR_CLK                        6
> +
> +/* VENCSYS_CORE1 */
> +
> +#define CLK_VENC_CORE1_LARB            0
> +#define CLK_VENC_CORE1_VENC            1
> +#define CLK_VENC_CORE1_JPGENC          2
> +#define CLK_VENC_CORE1_JPGDEC          3
> +#define CLK_VENC_CORE1_JPGDEC_C1       4
> +#define CLK_VENC_CORE1_GALS            5
> +#define CLK_VENC_CORE1_NR_CLK          6

Same for VENC and VENC_CORE1.


ChenYu
