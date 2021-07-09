Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073AF3C1F56
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 08:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhGIGcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 02:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhGIGcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 02:32:21 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C96DC0613DD
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 23:29:38 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id t30so6342783ljo.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 23:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0rx0EbhWByOl6cO2pdh8SAXgIpsICZIPHug/dkp8j8A=;
        b=K65KQSyKS71qo3hjtjQy+Y3yBhrGXDAuaTt6jzAsnooUZXo2J8oG0tpn5NA01Vm2rK
         OSs3VphgbYYpymPYEoYMQfNT4+zKaiJSHeGAga2GHPIfhVEIr14FvLQ471ZZm19q2emT
         whq33uc06EG8sPFqkVKmJgjrar1rTea9O7Kzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0rx0EbhWByOl6cO2pdh8SAXgIpsICZIPHug/dkp8j8A=;
        b=TKMTsbTZ4Ys456gDK7ZUICvxshC0D92pBrn0YnLiGGJheLf8MZF5ImulFcsBVA+TqU
         bCmAwwiVLdFLdnaimDkSrUxn5Q7HwIBNIE5PrGCGIlH6Hvi+0k3rr357w+mg7WubbCeT
         dyTpu91ffgU1JzjB3i+7roXmIC1IQ+MR1GmxT+Dor1qTEf/cw9vL7g7QjAjF/zS0qBib
         jc496HkQvAbiYWNw2tnYH1wwZn9ZP8hPiDpRfvk8Remd7H3tc9o6TpBxsSUP7wqLdRcV
         mBaQkGITlnhvFEyu+SOu9W4w5QaVLHpYqYD++AYympYN5IlrHMItP9XMqdjB26fS2x4p
         tiYA==
X-Gm-Message-State: AOAM532AfzNe8D0NNx5JdEoTNKMmeAJH3iyfIJ87zdNwfcxKRtaHUjtM
        vgVhKcxwUYMNcfibLNtDsIfOhgqjsYutV3Joizx1Eg==
X-Google-Smtp-Source: ABdhPJw6yDemUk5wkz0plF6I4pQaqZpW7hTyE9DIQd88yVnnamwNZrem1BKYanDJeNzgbs5JjEnnE681wN8bzDJ+uwo=
X-Received: by 2002:a05:651c:2115:: with SMTP id a21mr27409410ljq.185.1625812176116;
 Thu, 08 Jul 2021 23:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com> <20210616224743.5109-12-chun-jie.chen@mediatek.com>
In-Reply-To: <20210616224743.5109-12-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 9 Jul 2021 14:29:24 +0800
Message-ID: <CAGXv+5GOK=iVxxEj84tnxH=UgLfh1kKNZcVxzM7DkFP=XjodFQ@mail.gmail.com>
Subject: Re: [PATCH 11/22] clk: mediatek: Add MT8195 mfgcfg clock support
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

On Thu, Jun 17, 2021 at 7:08 AM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8195 mfgcfg clock provider

Same thing about the commit log. More context please.

> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/Kconfig          |  6 ++++
>  drivers/clk/mediatek/Makefile         |  1 +
>  drivers/clk/mediatek/clk-mt8195-mfg.c | 49 +++++++++++++++++++++++++++
>  3 files changed, 56 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt8195-mfg.c
>
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index ef7d4b433eee..066c14a89cee 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -624,6 +624,12 @@ config COMMON_CLK_MT8195_IPESYS
>         help
>           This driver supports MediaTek MT8195 ipesys clocks.
>
> +config COMMON_CLK_MT8195_MFGCFG
> +       bool "Clock driver for MediaTek MT8195 mfgcfg"
> +       depends on COMMON_CLK_MT8195
> +       help
> +         This driver supports MediaTek MT8195 mfgcfg clocks.
> +

Same thing about the Kconfig option. I don't think it's necessary to have
separate Kconfig options for clock controllers within the same SoC.

>  config COMMON_CLK_MT8516
>         bool "Clock driver for MediaTek MT8516"
>         depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index 991a9be7ac46..9b09e7f640d1 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -87,5 +87,6 @@ obj-$(CONFIG_COMMON_CLK_MT8195_CAMSYS) += clk-mt8195-cam.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_CCUSYS) += clk-mt8195-ccu.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_IMGSYS) += clk-mt8195-img.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_IPESYS) += clk-mt8195-ipe.o
> +obj-$(CONFIG_COMMON_CLK_MT8195_MFGCFG) += clk-mt8195-mfg.o
>  obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
>  obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
> diff --git a/drivers/clk/mediatek/clk-mt8195-mfg.c b/drivers/clk/mediatek/clk-mt8195-mfg.c
> new file mode 100644
> index 000000000000..a9b1d337cd01
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8195-mfg.c

Code looks good.


ChenYu
