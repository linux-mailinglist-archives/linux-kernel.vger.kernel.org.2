Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A01A401EFC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 19:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242248AbhIFRLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 13:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243797AbhIFRLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 13:11:37 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904F3C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 10:10:32 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id k13so14562386lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 10:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=noINKmz3hzTGqq034jTZ5E+LdSOi2uYpC/Rle/66Vl4=;
        b=iYuhyd4uCzT8/2bOYiqWul/nZlbxsr1/PhzUk73eDC6N2l4dLguCZl2MbY01uzkgRA
         RbG+L1yM5kQiLZ3pmvpdIhRjJBRqnBNohvQRqQT5f/4IxftO5212RnLbyNyxomeQl1r4
         CY7+Y360ktzEFLIeLa4nSSw+fMsv8wixGi6JYB2AwTsc7yjcHeBazmWagk7Sd+oqZxn9
         7xxvydbz7tR3J+hjS3d9gRdPT9RbxBce8cRBPn1kkEL2cU4C3WlUjvgTiIbgrzWRV7Qx
         4NPpu9hltTXmywS3o97zRq+1YeB8PUdWLZKz4w0/MZR2JiX7yjgZk8jDSkxu7+AaJt8P
         hkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=noINKmz3hzTGqq034jTZ5E+LdSOi2uYpC/Rle/66Vl4=;
        b=TWUjhnTcmQCuxfxYVB+6JNTR2QAUZxlr8fb2Ma+Lm/uJ9xqmuDtpjlrzpvAcQ5gCkP
         +/CnsuHf6OL63oeMSyg7jFKA94MTDWZd0bNsA/V9h5s5/3FPX9t0AY0+qdJ8alVRn38q
         D6QL/3hzZpZcm/wdHQQj5IOebaNsjCHLXz77c2/7NXIE6e+BSiyidV6JmBlZNUPVVYrl
         uTPSoO7xRIux6PfscBGjiJbJn7STXP3FV9CbVOeo+3MGD++BkrQgvMMDAi9TZTypgjo9
         uJQIRSQDRh7pkc2IZzLPhkbtuEKmKUlnX1xMGvtli47Gg7z0J5CN0PYkWSQNVDJ25Hvc
         W5zg==
X-Gm-Message-State: AOAM532+AVV03dODIMJCkhoGnZiu/sLgTFt6+VfWoMon66SKGe4DTmp6
        Q1vAEXuXqWwgXvdsuisfYA9DLmTGJikTV6o9bOhIPg==
X-Google-Smtp-Source: ABdhPJxlhFOEzJRlkJCRsUZZ2Q4TuaOmHRL8uGNY7RMU3fpBcQJG/A6CDs3tVr/JkHXbcvF9vj/fRKk5UtWSuPkrEEo=
X-Received: by 2002:a05:6512:3ca5:: with SMTP id h37mr10177779lfv.254.1630948230961;
 Mon, 06 Sep 2021 10:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210827071537.1034-1-derong.liu@mediatek.com>
In-Reply-To: <20210827071537.1034-1-derong.liu@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Sep 2021 19:09:54 +0200
Message-ID: <CAPDyKFpubTas6HMe=uzqJyQuQS9TRnDGuGjaS80ymjevN_CFMQ@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: mediatek: add wait dma stop done flow
To:     Derong Liu <derong.liu@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wsp_upstream@mediatek.com, Peng Zhou <peng.zhou@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2021 at 09:15, Derong Liu <derong.liu@mediatek.com> wrote:
>
> We found this issue on a 5G platform, during CMDQ error handling, if DMA status is active when it call msdc_reset_hw, it means mmc host hw reset and DMA transfer will be parallel, mmc host may access sram region unexpectedly.
> According to the programming guide of mtk mmc host, it needs to wait for dma stop done after set dma stop.
> This change should be applied to all SoCs.
>
> Change-Id: I9b87523f19b24ca73958bbcb83bb418413c5a180

I am dropping this tag.

> Signed-off-by: Derong Liu <derong.liu@mediatek.com>

Applied for next, thanks! I guess we should also tag this for stable
kernels, right?

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 4dfc246c5f95..b99330bad6a5 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -8,6 +8,7 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/iopoll.h>
>  #include <linux/ioport.h>
>  #include <linux/irq.h>
>  #include <linux/of_address.h>
> @@ -2330,6 +2331,7 @@ static void msdc_cqe_enable(struct mmc_host *mmc)
>  static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
>  {
>         struct msdc_host *host = mmc_priv(mmc);
> +       unsigned int val = 0;
>
>         /* disable cmdq irq */
>         sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INT_CMDQ);
> @@ -2339,6 +2341,9 @@ static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
>         if (recovery) {
>                 sdr_set_field(host->base + MSDC_DMA_CTRL,
>                               MSDC_DMA_CTRL_STOP, 1);
> +               if (WARN_ON(readl_poll_timeout(host->base + MSDC_DMA_CFG, val,
> +                       !(val & MSDC_DMA_CFG_STS), 1, 3000)))
> +                       return;
>                 msdc_reset_hw(host);
>         }
>  }
> --
> 2.18.0
