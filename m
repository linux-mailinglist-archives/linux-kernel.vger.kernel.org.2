Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846F63ED1F2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 12:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbhHPK2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 06:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbhHPK2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:28:12 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BBCC0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 03:27:41 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a4so7333864uae.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 03:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pRH4TVFPj1g2bLXry7U6Q5PGawo78fbiYn7oa4P7TUE=;
        b=wUONjgu57oYf3OfxDDScC3ZokM5dNXLU+0GsEWRZ3QVzsyATXYqT58BpdtitRkQkIH
         9j4dHB+IpVqScnNr9gIh/8BBpPPN1oyuqGiBT28prUs0TV2sjtlrXSEKM44kpi29mtgm
         hsFDminvf3C0rKryy/W0IFmoq+mJr3YJ2W9yriAbTRxX9XMEUC0KHf/vO6t4PmpcBVwV
         eHlohxqA6fWnbXgZMYVKahwwM+7oOdp60WFDNSxi1+1S4L3v05kNYa3zKRhdV51s5eyf
         6A1sXyDRMjedq0EvnMhnzh20FFACX3TsDX7epWJFWhh3U9Q8UvF+J3vSXdfACqnJmYBH
         0W0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pRH4TVFPj1g2bLXry7U6Q5PGawo78fbiYn7oa4P7TUE=;
        b=fhyhfXEbPx9/XjWJbuLeqIu/7EXUWkXgGwxoWKWKPA/CL7Q3HFiYd3Dy2tEZ0i+uF/
         OlPMrRvN4D5oZkUxlok3KefNVeyTzTlL3EmMQ4e6zJy/ff11+T2wY7qdug1bUHOIMhnr
         /O914dsK8P643Xcx3LfJQz+40HobfwLJMJZ2trNHhbgbciSLrs/nFC8hUS+eEIENMG/G
         +PXXM8cl3e8fM8nzOe7pGMMo9EVk8dEUiQaKk6qDctK7Qv/Z3nV2aT0Rz++YoTiV+C1B
         P9CyF0iB7h9uC3cdll07Ttj+MvRorNAqs5aDZHypoXalpg40I/jWnv0D7zzVM6J566qG
         yKjg==
X-Gm-Message-State: AOAM5329j1NMQcj3Rc730o30GKdA4US9Xv173P4a6I08vpdFIq6Bsw4u
        WNs4GzqyQ9tTZDpGt5sN5kUadLDBlO6/Qe8nMKg/qQ==
X-Google-Smtp-Source: ABdhPJx12b+Bqmk2bxuZlUu8XnA8FFpwLQVJjtElcHZQSIpFTlWvmHagxQPgWDu9OhRbbdZgmffyA5kUa3yLHHrPYLQ=
X-Received: by 2002:a9f:25a7:: with SMTP id 36mr8092627uaf.129.1629109660385;
 Mon, 16 Aug 2021 03:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210809072315.1127-1-derong.liu@mediatek.com>
In-Reply-To: <20210809072315.1127-1-derong.liu@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Aug 2021 12:27:04 +0200
Message-ID: <CAPDyKFq3_eia7cvo-1Ajj5wcrfEHtp_EsMp27uL4dC_n+vPWZQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mediatek: add wait dma stop done flow
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

On Mon, 9 Aug 2021 at 09:25, Derong Liu <derong.liu@mediatek.com> wrote:
>
> We found this issue on a 5G platform, during CMDQ error handling, if DMA status is active when it call msdc_reset_hw, it means mmc host hw reset and DMA transfer will be parallel, mmc host may access sram region unexpectedly.
>
> According to the programming guide of mtk mmc host,it needs to wait for dma stop done after set dma stop.
> This change should be applied to all SoCs.
>
> Signed-off-by: Derong Liu <derong.liu@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 4dfc246c5f95..1dfd2842471b 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2339,6 +2339,8 @@ static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
>         if (recovery) {
>                 sdr_set_field(host->base + MSDC_DMA_CTRL,
>                               MSDC_DMA_CTRL_STOP, 1);
> +               while (readl(host->base + MSDC_DMA_CFG) & MSDC_DMA_CFG_STS)
> +                       cpu_relax();

I suggest you look into using readl_poll_timeout() - as we don't want
to hang indefinitely, no matter what.

>                 msdc_reset_hw(host);
>         }
>  }
> --
> 2.18.0

Kind regards
Uffe
