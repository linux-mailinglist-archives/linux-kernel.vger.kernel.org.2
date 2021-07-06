Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D4F3BC84B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 11:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhGFJKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 05:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhGFJKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 05:10:01 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0522C061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 02:07:21 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f13so10297071lfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 02:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X/3HzjS40NCzeCxcicoEsvFijQpXDThbZ/r8InzKdlc=;
        b=e1zNBH9vDY0TRtaFRs+O1SVfb//TvklWU2MYVnDt39eqZ/HX7JlEcg+Tlm/9p31a/z
         CnlGOqXMya3RDLPBteSg7gvFvEx31Ps6yyaCvwJJvl6r4hKb3q1Q0bPlTbJwh8udkprf
         4nfyX87h0i7G1AceII8sU+xH4bd2Km6m6k2+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X/3HzjS40NCzeCxcicoEsvFijQpXDThbZ/r8InzKdlc=;
        b=poHiz88GFxqWcFfy+NOJZVaRsb9YP3MsGT9e4uQhsAsRplcmdm/qKwx4bM7B62VXEK
         PbkN1D0DAoru89E6EJeMKGow0HdSj9c9HArOM5yuaduoJGIsXdIy/wyXSOWqXy68XHjh
         5h+S3/OtoQA5ZzKd30NRgZ4cZxHYHJwzNf2v8gHcMctqivGogoy6sGWysoYovdzavfhN
         GPWCEpLcrFtlG1wRcgrgHMFzsBdY9zIsbPxArXnmJKbUaRmjXWZhokqfaK/obkXstS20
         0GfeSpb+PARVlcHyH4gMgSol0gy6ZkzPUqawN7kpo6rweVk00xv2twwQNqQeIkL9ok+V
         S2jQ==
X-Gm-Message-State: AOAM532iB49fCTyjNlkoIbCggWF+v+FNSKI5z/54pcY8EiBLKEOKNuJY
        NJMaM0rQ8GCSdPvZKLWX00IKvJrIK+WAdiSjkefxQA==
X-Google-Smtp-Source: ABdhPJysvxKwdpFsCEfj9/EBHKTte7fcaL772GEGT+XYjWLqMbh2CPlWIhbJho7kLQMGyI3WRJwcsoA0w7pyzu7pM0Y=
X-Received: by 2002:a05:6512:6d0:: with SMTP id u16mr1458924lff.587.1625562440122;
 Tue, 06 Jul 2021 02:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com> <20210616224743.5109-10-chun-jie.chen@mediatek.com>
In-Reply-To: <20210616224743.5109-10-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 6 Jul 2021 17:07:09 +0800
Message-ID: <CAGXv+5F0hTL2Meafo6cQ4FaAMkU+nRZBcnLgeXOgrHAttrNkBQ@mail.gmail.com>
Subject: Re: [PATCH 09/22] clk: mediatek: Add MT8195 imgsys clock support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 17, 2021 at 7:01 AM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8195 imgsys clock providers
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/Kconfig          |  6 ++
>  drivers/clk/mediatek/Makefile         |  1 +
>  drivers/clk/mediatek/clk-mt8195-img.c | 98 +++++++++++++++++++++++++++
>  3 files changed, 105 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt8195-img.c
>
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index 6a6e496d08a4..f92d0b6b7eec 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -612,6 +612,12 @@ config COMMON_CLK_MT8195_CCUSYS
>         help
>           This driver supports MediaTek MT8195 ccusys clocks.
>
> +config COMMON_CLK_MT8195_IMGSYS
> +       bool "Clock driver for MediaTek MT8195 imgsys"
> +       depends on COMMON_CLK_MT8195
> +       help
> +         This driver supports MediaTek MT8195 imgsys clocks.
> +
>  config COMMON_CLK_MT8516
>         bool "Clock driver for MediaTek MT8516"
>         depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index bb8aac6f9185..1768eda917c2 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -85,5 +85,6 @@ obj-$(CONFIG_COMMON_CLK_MT8195_AUDSYS) += clk-mt8195-aud.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_AUDSYS_SRC) += clk-mt8195-aud_src.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_CAMSYS) += clk-mt8195-cam.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_CCUSYS) += clk-mt8195-ccu.o
> +obj-$(CONFIG_COMMON_CLK_MT8195_IMGSYS) += clk-mt8195-img.o
>  obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
>  obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
> diff --git a/drivers/clk/mediatek/clk-mt8195-img.c b/drivers/clk/mediatek/clk-mt8195-img.c
> new file mode 100644
> index 000000000000..923fa82aedae
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8195-img.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Copyright (c) 2021 MediaTek Inc.
> +// Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> +
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-mtk.h"
> +#include "clk-gate.h"
> +
> +#include <dt-bindings/clock/mt8195-clk.h>
> +
> +static const struct mtk_gate_regs img_cg_regs = {
> +       .set_ofs = 0x4,
> +       .clr_ofs = 0x8,
> +       .sta_ofs = 0x0,
> +};
> +
> +#define GATE_IMG(_id, _name, _parent, _shift)                  \
> +       GATE_MTK(_id, _name, _parent, &img_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
> +
> +static const struct mtk_gate img_clks[] = {
> +       GATE_IMG(CLK_IMG_LARB9, "img_larb9", "img_sel", 0),
> +       GATE_IMG(CLK_IMG_TRAW0, "img_traw0", "img_sel", 1),
> +       GATE_IMG(CLK_IMG_TRAW1, "img_traw1", "img_sel", 2),
> +       GATE_IMG(CLK_IMG_TRAW2, "img_traw2", "img_sel", 3),
> +       GATE_IMG(CLK_IMG_TRAW3, "img_traw3", "img_sel", 4),
> +       GATE_IMG(CLK_IMG_DIP0, "img_dip0", "img_sel", 8),
> +       GATE_IMG(CLK_IMG_WPE0, "img_wpe0", "img_sel", 9),
> +       GATE_IMG(CLK_IMG_IPE, "img_ipe", "img_sel", 10),
> +       GATE_IMG(CLK_IMG_DIP1, "img_dip1", "img_sel", 11),
> +       GATE_IMG(CLK_IMG_WPE1, "img_wpe1", "img_sel", 12),
> +       GATE_IMG(CLK_IMG_GALS, "img_gals", "img_sel", 31),
> +};
> +
> +static const struct mtk_gate img1_dip_top_clks[] = {
> +       GATE_IMG(CLK_IMG1_DIP_TOP_LARB10, "img1_dip_top_larb10", "img_sel", 0),
> +       GATE_IMG(CLK_IMG1_DIP_TOP_DIP_TOP, "img1_dip_top_dip_top", "img_sel", 1),
> +};
> +
> +static const struct mtk_gate img1_dip_nr_clks[] = {
> +       GATE_IMG(CLK_IMG1_DIP_NR_RESERVE, "img1_dip_nr_reserve", "img_sel", 0),

Adding a clock for a bit that is named "reserved" is sort of weird.
Does it actually exist and function?

Otherwise,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
