Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC26A3F4A72
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 14:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbhHWMP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 08:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236864AbhHWMPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 08:15:24 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABC7C0619F6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 05:14:09 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y34so37439641lfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 05:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eVtZNqos1Uj8nVU7A68cFH5SksBGPlDtgJ1wjTiX97U=;
        b=RhqJDGeOtqUx7Razl8VfrpFJnXXewY+c6hqjK5nNkefvqqjvEaQoYZxF0bodUfAEuQ
         RNYypGJdSGrTiAm07z/iI68GyQtYiGIsmq5DVyq+Yt/dRY8PsDOufqsZdOsHTKN96iYL
         1NCvNjcs0Ws6E5UXLCj0RB9rI1YNhwb9TXNc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eVtZNqos1Uj8nVU7A68cFH5SksBGPlDtgJ1wjTiX97U=;
        b=cbY/mZPqTfF+EO9LD2YFblXX3MpK4vyjTe6M4b/fQWhA9VNVeK3Cu9yASRUzwit136
         GNXDCiVqfmQU4iTY9AsuZzVIQlAXm3kaDyLVpluI8VOFW3rDyJfvqAs9XTendpw0fy+m
         y9Q/eai8ww2185vbZZqUSfUrvTWlMHnrbUrvNtWMBoKseLY8RA3RNR5JV8ZKVvuFxorj
         wJ4ftKaLoO80pILYeATl/Xdjo2IolIZgBfs/r0gXQwy4wr4W8VlDEEJeFZ8oSAd6HuyT
         jpnFAf55P+Syo0VBynjMJ3Bzi3pw6mxs3w/ceFEQ7Y30KYDFQF+PZB3SSKY/GFUzeDwM
         ULzw==
X-Gm-Message-State: AOAM5337w35gXxEng7wJiRwWbbRYBa7X0XTVE70p+UFT6lLevBSSndCo
        /v/PxbJKsAmqOtbOuxMmLEeoUpJNgHFH9Yq+/iIzEw==
X-Google-Smtp-Source: ABdhPJwrlfSQYMdqbYrEgwxn7wBOO+2G6mAsp2Jq0PdZ+FDkTRSbUkreb53Sw0fdjMpceYj13dgvGxu/2HRe+7mlXHQ=
X-Received: by 2002:a05:6512:ac7:: with SMTP id n7mr25121383lfu.479.1629720847844;
 Mon, 23 Aug 2021 05:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210820111504.350-1-chun-jie.chen@mediatek.com> <20210820111504.350-12-chun-jie.chen@mediatek.com>
In-Reply-To: <20210820111504.350-12-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 23 Aug 2021 20:13:56 +0800
Message-ID: <CAGXv+5EMoZq8BohUA_OoChmEdHL988pphxUJX077hO88htRUtA@mail.gmail.com>
Subject: Re: [v2 11/24] clk: mediatek: Add MT8195 ccusys clock support
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

On Fri, Aug 20, 2021 at 7:23 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8195 ccusys clock controller which provides clock gate
> control in Camera Computing Unit.

Could you offer a bit more explanation about this unit? Is it an ISP?
Or some other function that does computation on images?

> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/clk/mediatek/Makefile         |  3 +-
>  drivers/clk/mediatek/clk-mt8195-ccu.c | 50 +++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/mediatek/clk-mt8195-ccu.c
>
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index 718bbb04191b..03fb020834f3 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -80,6 +80,7 @@ obj-$(CONFIG_COMMON_CLK_MT8192_MSDC) += clk-mt8192-msdc.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_SCP_ADSP) += clk-mt8192-scp_adsp.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_VDECSYS) += clk-mt8192-vdec.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_VENCSYS) += clk-mt8192-venc.o
> -obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o clk-mt8195-peri_ao.o clk-mt8195-infra_ao.o clk-mt8195-cam.o
> +obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o clk-mt8195-peri_ao.o clk-mt8195-infra_ao.o clk-mt8195-cam.o \
> +                                       clk-mt8195-ccu.o

When wrapping, please align with previous line. "clk-mt8195-ccu.o" should
align with "clk-mt8195-apmixedsys.o".


ChenYu
