Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A66401EEB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 19:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238249AbhIFRK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 13:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhIFRKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 13:10:51 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD965C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 10:09:46 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id d16so12321754ljq.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 10:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kPdYFCV+vKZ4TQdTslv8+T4RJlQzhCm6iqn6XOsBv64=;
        b=OYSxCqfRQPO7YuRvad5pqw6YM1aCXkOGH8vEqm3zzlUUAU6NsJUK5b5gq5ejQ5/eEn
         LcVxLUm0M/11/KBEKvZbSRZEZkSlKo1jaGCG9Z+q+wbRqGtMoyXd2/LpHRy5nzsZ/2Ml
         eYwVEJtMxKWdHXGyRtmVNf5VCWPfrJxUNyVQsjroF/cji+mg10DUjsIFM6Yto0/xssKM
         b2CVQZIej6IHmGIRd0kSqSKUGtLPNt54K88fw7Rtywt6KSDPVOXY3UF/nR6MGcwKLgox
         ZvYpLTKC3rPcxA5VdYKCPjin+sRYe2b5tGq5a9u3ZHLf4dd3qexhXSJRrF2Ub5qdVPRY
         diGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kPdYFCV+vKZ4TQdTslv8+T4RJlQzhCm6iqn6XOsBv64=;
        b=eM0dUWEzjwKtSskAr3kfFSDBGZupnHMX/y91sJMziQ203VKURWVXE2NEPcWaNchJxY
         ZlanlSJYx994FzGhw1fPdPCy1Deza/ddhk3BIjpNWxkgn/7KWm4q8WxXid+89VFM+wpP
         tYl9Ja074EmqCPNKjeUeyyyZ5DxjGXudlSKPoWs0PcJJxavv5QOhAhyLcCEWx2dVdfVs
         mOa9lO2o93Z8Go+pzVRmVbTqjd1CNBym/OqQuOb39TyKYJmKqTb/mQy3ETESAH1lonId
         BT7YCuZhToMsYKvbmj878Q2PFBRDYESPsA8jYvkcQSeij70lY4cuYSwvBTNQYolpd4n6
         CQXA==
X-Gm-Message-State: AOAM530t3Oml3V3Sl+xItj5zpGovGV+Ht9nRSnQdHhLaRlaoGpVKlpV0
        T7/5MjQSr6cAA8u1OMHqdLgLU2R9r+u7akx2k6cJqqb3Jx4=
X-Google-Smtp-Source: ABdhPJxTqhtkITmJ60nRns4IhVDTNDmefm183BbXddBdDA/nr63HA1HZQdqxWgvL3m3cIO8VbILVZRFtNrwur6Yjk4o=
X-Received: by 2002:a05:651c:1b3:: with SMTP id c19mr11753747ljn.16.1630948185017;
 Mon, 06 Sep 2021 10:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210825114213.7429-1-vincent.whitchurch@axis.com>
In-Reply-To: <20210825114213.7429-1-vincent.whitchurch@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Sep 2021 19:09:08 +0200
Message-ID: <CAPDyKFoF1ghyRb+GsAcuHnCWVZx_TW7+XD4cSJ8GYPLffQqkmA@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Only inject fault before done/error
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>, kernel <kernel@axis.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2021 at 13:42, Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> The fault injection function can set EVENT_DATA_ERROR but skip the
> setting of ->data_status to an error status if it hits just after a data
> over interrupt.  This confuses the tasklet which can later end up
> triggering the WARN_ON(host->cmd || ..) in dw_mci_request_end() since
> dw_mci_data_complete() would return success.
>
> Prevent the fault injection function from doing this since this is not a
> real case, and ensure that the fault injection doesn't race with a real
> error either.
>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Applied for fixes and by adding a fixes tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 6578cc64ae9e..380f9aa56eb2 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1802,10 +1802,15 @@ static enum hrtimer_restart dw_mci_fault_timer(struct hrtimer *t)
>
>         spin_lock_irqsave(&host->irq_lock, flags);
>
> -       if (!host->data_status)
> +       /*
> +        * Only inject an error if we haven't already got an error or data over
> +        * interrupt.
> +        */
> +       if (!host->data_status) {
>                 host->data_status = SDMMC_INT_DCRC;
> -       set_bit(EVENT_DATA_ERROR, &host->pending_events);
> -       tasklet_schedule(&host->tasklet);
> +               set_bit(EVENT_DATA_ERROR, &host->pending_events);
> +               tasklet_schedule(&host->tasklet);
> +       }
>
>         spin_unlock_irqrestore(&host->irq_lock, flags);
>
> @@ -2721,12 +2726,16 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>                 }
>
>                 if (pending & DW_MCI_DATA_ERROR_FLAGS) {
> +                       spin_lock(&host->irq_lock);
> +
>                         /* if there is an error report DATA_ERROR */
>                         mci_writel(host, RINTSTS, DW_MCI_DATA_ERROR_FLAGS);
>                         host->data_status = pending;
>                         smp_wmb(); /* drain writebuffer */
>                         set_bit(EVENT_DATA_ERROR, &host->pending_events);
>                         tasklet_schedule(&host->tasklet);
> +
> +                       spin_unlock(&host->irq_lock);
>                 }
>
>                 if (pending & SDMMC_INT_DATA_OVER) {
> --
> 2.28.0
>
