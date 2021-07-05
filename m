Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5FFA3BBAD7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 12:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhGEKKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 06:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbhGEKKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 06:10:01 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D83AC061760
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 03:07:24 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so11483507pjo.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 03:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=URzqQGQoXOhjWiVA59OemrOZ6RGERDqTdQyNEXeAAck=;
        b=W+oJyrd0cywPJ2WKOIn0+/TZJnDNS67AnkdeDildmOBCR2YDCCSxGoymgaKDCH/Xs2
         2Tt2Ykz8fdNewWrffXxMSL+OWuktoSP4WM0aP454Xp46wwMb5eQDfNyXE37UeyxZgEgh
         ZqpnLRE0tGHO7RNqsdazo3gKrVWcANSkbLE+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=URzqQGQoXOhjWiVA59OemrOZ6RGERDqTdQyNEXeAAck=;
        b=pv03NZ1Sq8PfT7U+Oz+LFNW2sOWCFvZ4ZYSg4fdtRMQ7mRrCNKm2rcy9Elnldf6nLS
         hOaW2EDD0cNsZyZVzz/hVO1xb9nWPlv3OcUBx92ednhWfOF3kqaKvTd4j2S+384afDyH
         6Ndt1CH5zSh+0NESTxOT1Jy46WbN5bniZ3Ja7y54KIQQ1v1EgDSIW0LSneKg0dubcjz0
         vY1BVYdbgNH/EbZOlTb4Qhg2y253y1mXyzUGWX8wuycfDxTab5iWlBUvuakaL+O7vsqQ
         A6jAJI0GtSEEWTrAYv6InCZgUdJwGEtyuXcN6Lr4+fuifkDGjvgC+km8Xe7lNaq5JCRM
         k7DQ==
X-Gm-Message-State: AOAM531jK3QYl16MT6O4s0vNZKDB/g4wU5PDifd4ODmOafty34PDm3kv
        dYoOga5bDrzBdFSsxZVLHzTI9g==
X-Google-Smtp-Source: ABdhPJzLaiyM+hJRO34T6/7krD6/7coonwGydXEI2SqB2V3Cc/mLh/HDAsZW7o4nnnI4Moc5m/2Myw==
X-Received: by 2002:a17:902:bd03:b029:11c:d504:c1ce with SMTP id p3-20020a170902bd03b029011cd504c1cemr11838106pls.7.1625479643848;
        Mon, 05 Jul 2021 03:07:23 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:f66e:ef34:adcd:b33b])
        by smtp.gmail.com with ESMTPSA id s126sm12354864pfb.164.2021.07.05.03.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 03:07:23 -0700 (PDT)
Date:   Mon, 5 Jul 2021 18:07:19 +0800
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH 06/22] clk: mediatek: Add MT8195 audio src clock support
Message-ID: <YOLZ12WWkk/0kAnd@google.com>
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
 <20210616224743.5109-7-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616224743.5109-7-chun-jie.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 17, 2021 at 06:47:27AM +0800, Chun-Jie Chen wrote:
> Add MT8195 audio src source clock provider
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/Kconfig              |  6 +++
>  drivers/clk/mediatek/Makefile             |  1 +
>  drivers/clk/mediatek/clk-mt8195-aud_src.c | 60 +++++++++++++++++++++++
>  3 files changed, 67 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt8195-aud_src.c
> 
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index e2bae9d490a4..62dd02bc2755 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -594,6 +594,12 @@ config COMMON_CLK_MT8195_AUDSYS
>  	help
>  	  This driver supports MediaTek MT8195 audsys clocks.
>  
> +config COMMON_CLK_MT8195_AUDSYS_SRC
> +	bool "Clock driver for MediaTek MT8195 audsys_src"
> +	depends on COMMON_CLK_MT8195
> +	help
> +	  This driver supports MediaTek MT8195 audsys_src clocks.
> +

Same comments regarding the Kconfig symbol as the previous patch.

>  config COMMON_CLK_MT8516
>  	bool "Clock driver for MediaTek MT8516"
>  	depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index f27c04314186..52a5d3f49ff0 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -82,5 +82,6 @@ obj-$(CONFIG_COMMON_CLK_MT8192_VDECSYS) += clk-mt8192-vdec.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_VENCSYS) += clk-mt8192-venc.o
>  obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_AUDSYS) += clk-mt8195-aud.o
> +obj-$(CONFIG_COMMON_CLK_MT8195_AUDSYS_SRC) += clk-mt8195-aud_src.o
>  obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
>  obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
> diff --git a/drivers/clk/mediatek/clk-mt8195-aud_src.c b/drivers/clk/mediatek/clk-mt8195-aud_src.c
> new file mode 100644
> index 000000000000..7cabe0d68825
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8195-aud_src.c
> @@ -0,0 +1,60 @@
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
> +static const struct mtk_gate_regs aud_src_cg_regs = {
> +	.set_ofs = 0x1004,
> +	.clr_ofs = 0x1004,
> +	.sta_ofs = 0x1004,
> +};
> +
> +#define GATE_AUD_SRC(_id, _name, _parent, _shift)			\
> +	GATE_MTK(_id, _name, _parent, &aud_src_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
> +
> +static const struct mtk_gate aud_src_clks[] = {
> +	GATE_AUD_SRC(CLK_AUD_SRC_ASRC0, "aud_src_asrc0", "asm_h_sel", 0),
> +	GATE_AUD_SRC(CLK_AUD_SRC_ASRC1, "aud_src_asrc1", "asm_h_sel", 1),
> +	GATE_AUD_SRC(CLK_AUD_SRC_ASRC2, "aud_src_asrc2", "asm_h_sel", 2),
> +	GATE_AUD_SRC(CLK_AUD_SRC_ASRC3, "aud_src_asrc3", "asm_h_sel", 3),
> +	GATE_AUD_SRC(CLK_AUD_SRC_ASRC4, "aud_src_asrc4", "asm_h_sel", 4),
> +	GATE_AUD_SRC(CLK_AUD_SRC_ASRC5, "aud_src_asrc5", "asm_h_sel", 5),
> +	GATE_AUD_SRC(CLK_AUD_SRC_ASRC6, "aud_src_asrc6", "asm_h_sel", 6),
> +	GATE_AUD_SRC(CLK_AUD_SRC_ASRC7, "aud_src_asrc7", "asm_h_sel", 7),
> +	GATE_AUD_SRC(CLK_AUD_SRC_ASRC8, "aud_src_asrc8", "asm_h_sel", 8),
> +	GATE_AUD_SRC(CLK_AUD_SRC_ASRC9, "aud_src_asrc9", "asm_h_sel", 9),
> +	GATE_AUD_SRC(CLK_AUD_SRC_ASRC10, "aud_src_asrc10", "asm_h_sel", 10),
> +	GATE_AUD_SRC(CLK_AUD_SRC_ASRC11, "aud_src_asrc11", "asm_h_sel", 11),

And same thing about moving this into the audio driver. AFAICT there is
no audio driver supporting this hardware block, so this will never get
used.


Regards
ChenYu
