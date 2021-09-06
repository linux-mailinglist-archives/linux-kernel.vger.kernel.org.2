Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44EF401F00
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 19:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243927AbhIFRLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 13:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243797AbhIFRLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 13:11:47 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69149C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 10:10:42 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id m4so12306940ljq.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 10:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g2B76iGb/MvAFL/fqwBXAafaG+ZhGIUwhCY1ak7fyyI=;
        b=Qaq6D5JS3cWjYVjgYxZRkOoXeNX5pjffsV5NAIqydMEoigzxhzJ4Psue87vIspCszS
         vrE7rn4XVI7WeVDTBUKL2E9EGT0rAzkMRfX9MBTDtjNHx2oHkiOp4bkKDsFSY6arpP7g
         OpblIA7orJmsnURtExNxKBU1zFn3oHv24AssgtwnHadNO+TL8tciL0JFnnG6sinH00sN
         +WEIxJsTH+P2AxxT+4XWRzGz6nG+Zno0TLgZ+t/51s6buvrDUYG3npElUi6YcN+aFfHh
         yrItNVsgOaeECRcj51OfDMbJXaX7kqvWseeLswVkpFNl1BvgUkrrF+OhXgQblXWlll8s
         4TfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g2B76iGb/MvAFL/fqwBXAafaG+ZhGIUwhCY1ak7fyyI=;
        b=Ccl1WyfwHKToDfrjAUNu7qIYcqa8ndP0jhtZz64Xl9V+lSTZwIpzfr4NRg2jjGJmPV
         4EmJDSDOpxys6aQftn+02OQc24bZVMF2SULi5WSA1WaNGVygCnMTndTwxfIqCb8xBdH+
         mdP8UZo1OemQXkqglcGfMh039IG5qZ1E4xee+nYX+7RdMhWLtkMCYdD51dinp84aUwrE
         qZDYpHjogyCtkzsaxqqS88jQJZPUpPEZ3R2gQC6FmDWsIsJjuJLRzeB0acXzQ92e4mwH
         zWgt9BTlKUNIwnEkZD4pv1T7xV8UwlQQI6/4mLQzudGCgGts0wNISL7Sc762l+kYDwgT
         OgkA==
X-Gm-Message-State: AOAM530TIStneh32QweYYdjk0T2ANt93ybRfa+QXAidVsYi9VY+jOenE
        Ki/Qd/5XFDbcwIfZUCjW97ifE5qZCTBaX8DS9PEkFQ==
X-Google-Smtp-Source: ABdhPJw2WazDx6ltshqgFzZJ15YF3sOJrKyyamAfpMdAE96du0/LoDwinquUUOD4VsO/nUFaNHGbVxIZB0fhs8JEymI=
X-Received: by 2002:a2e:8495:: with SMTP id b21mr11848281ljh.4.1630948240811;
 Mon, 06 Sep 2021 10:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210830022507epcas1p43b45563c6e36bd00e3b6160bb42605bf@epcas1p4.samsung.com>
 <20210830021749.5947-1-cw9316.lee@samsung.com>
In-Reply-To: <20210830021749.5947-1-cw9316.lee@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Sep 2021 19:10:05 +0200
Message-ID: <CAPDyKFot9rL3Vs1g4ZH3QYnqrHL29Or362Ga_nZD3DBBtM+NFw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mtk-sd: Remove unused parameters
To:     Chanwoo Lee <cw9316.lee@samsung.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, grant.jung@samsung.com,
        jt77.jang@samsung.com, DooHyun Hwang <dh0421.hwang@samsung.com>,
        Seunghui Lee <sh043.lee@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2021 at 04:25, Chanwoo Lee <cw9316.lee@samsung.com> wrote:
>
> From: ChanWoo Lee <cw9316.lee@samsung.com>
>
> Remove unused parameters
> 1. msdc_start_data() - struct mmc_request *mrq
> 2. msdc_track_cmd_data() - struct mmc_data *data
>
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>

Queued for v5.16 on the temporary devel branch, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 4dfc246c5f95..a8736067c409 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1043,8 +1043,8 @@ static inline u32 msdc_cmd_prepare_raw_cmd(struct msdc_host *host,
>         return rawcmd;
>  }
>
> -static void msdc_start_data(struct msdc_host *host, struct mmc_request *mrq,
> -                           struct mmc_command *cmd, struct mmc_data *data)
> +static void msdc_start_data(struct msdc_host *host, struct mmc_command *cmd,
> +               struct mmc_data *data)
>  {
>         bool read;
>
> @@ -1112,8 +1112,7 @@ static void msdc_recheck_sdio_irq(struct msdc_host *host)
>         }
>  }
>
> -static void msdc_track_cmd_data(struct msdc_host *host,
> -                               struct mmc_command *cmd, struct mmc_data *data)
> +static void msdc_track_cmd_data(struct msdc_host *host, struct mmc_command *cmd)
>  {
>         if (host->error)
>                 dev_dbg(host->dev, "%s: cmd=%d arg=%08X; host->error=0x%08X\n",
> @@ -1134,7 +1133,7 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
>         host->mrq = NULL;
>         spin_unlock_irqrestore(&host->lock, flags);
>
> -       msdc_track_cmd_data(host, mrq->cmd, mrq->data);
> +       msdc_track_cmd_data(host, mrq->cmd);
>         if (mrq->data)
>                 msdc_unprepare_data(host, mrq->data);
>         if (host->error)
> @@ -1295,7 +1294,7 @@ static void msdc_cmd_next(struct msdc_host *host,
>         else if (!cmd->data)
>                 msdc_request_done(host, mrq);
>         else
> -               msdc_start_data(host, mrq, cmd, cmd->data);
> +               msdc_start_data(host, cmd, cmd->data);
>  }
>
>  static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
> --
> 2.29.0
>
