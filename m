Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDD23F49AA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbhHWLXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236603AbhHWLXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:23:34 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B25EC061764
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 04:22:52 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z2so37261890lft.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 04:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ELGM60ioRNSpEBzYZwyHjOCmGIGPOYG6GuLk6IRUkX8=;
        b=Zltmc5NLRVbIQ8NyRHU2exemKEv33SP1S6SB4IcnWOtnDM5jBR+Kaq6FJ37spEGpU4
         9xILArIF32MOXrRQA6vRU4rd+wWWbkLgyQbBgKSAImUFGA3B3/zXzkBY3uncPeM8kSFB
         FzQk8innsUI2hULjvtCr50zg667kzG2noY9gI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ELGM60ioRNSpEBzYZwyHjOCmGIGPOYG6GuLk6IRUkX8=;
        b=uFEYjWRVBMQbTAGx+ffQrZyrk/u/yzGh9Z+Azhlh/qBKTbEYfWkZO6tYsdYc8ducXZ
         So2wcJxq61ENjk3PATSDYuoCZDTy0Dtt2ccCrD51klVnxQnvKl4/CCQGb3hTf7C7+35H
         mvZK6HKTskeDGDIFPNrOBbdFgiQyv+4FunNHy/I9peVPZ44/1YcoVJAVYiUBa/oVolyf
         5qWG2x3yME1htbiapp9eVFXNGyTBCzVaThFQvWQOk39de/6DtRia/F1hpd59POWkuLFl
         9uhsutuwsUOxQCa0TSnYLMitJ5K9JspqtKyypgPQN0HV0Mhf9FbkVVAVlEk10U/SOA6+
         ZA+A==
X-Gm-Message-State: AOAM532dlzJMApURAxZ1ng7kwl83RsC+q50jAhgSi+YHflwFGtnc+upQ
        pb3p8ltezQLouovXc4rV8vWHZK6nYx/Z6p1hSOVeRQ==
X-Google-Smtp-Source: ABdhPJwP9D31B1uYiBuq2tMnF2HScsZGxvRJlqQkq5AEq3DdOVXuXbdYvtGrLT0w0XdcfiX69R1/S0lj0GEqrYmeyrU=
X-Received: by 2002:a19:ca09:: with SMTP id a9mr9039073lfg.342.1629717770496;
 Mon, 23 Aug 2021 04:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210820111504.350-1-chun-jie.chen@mediatek.com> <20210820111504.350-9-chun-jie.chen@mediatek.com>
In-Reply-To: <20210820111504.350-9-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 23 Aug 2021 19:22:39 +0800
Message-ID: <CAGXv+5GqELj5QEx7bCvyMkKdjG5jOFziefA4pHZGqiZgHR58BQ@mail.gmail.com>
Subject: Re: [v2 08/24] clk: mediatek: Add MT8195 peripheral clock support
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

On Fri, Aug 20, 2021 at 7:20 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8195 peripheral clock controller which provides clock
> gate control for ethernet/flashif/pcie/ssusb.
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/Makefile             |  2 +-
>  drivers/clk/mediatek/clk-mt8195-peri_ao.c | 62 +++++++++++++++++++++++
>  2 files changed, 63 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/mediatek/clk-mt8195-peri_ao.c
>
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index a142342a0cea..d5ee396dcded 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -80,6 +80,6 @@ obj-$(CONFIG_COMMON_CLK_MT8192_MSDC) += clk-mt8192-msdc.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_SCP_ADSP) += clk-mt8192-scp_adsp.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_VDECSYS) += clk-mt8192-vdec.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_VENCSYS) += clk-mt8192-venc.o
> -obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o
> +obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o clk-mt8195-peri_ao.o

This line is getting too long. Please wrap it to within 100 characters.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
