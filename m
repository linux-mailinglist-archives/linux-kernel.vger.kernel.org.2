Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5871945A44D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbhKWODx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhKWODw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:03:52 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEB9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 06:00:44 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b40so91455794lfv.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 06:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M5qj5wwgDDOjYxs26fOkrwGqoqUS/daI8VCa+zgPh2o=;
        b=IM7a8kgtMvTyRtufIbIt7g+DOLQ50st+d8LZTnl3NaJZBq8aL026C3acFsQk5B49jQ
         Knn1o7zc18/ZvrYwkqhesY1s5YGw/1aNOUgeiyA0NBBM2Ds3/Pyk70mhYPS1GweZM9AQ
         nggBbwjyGcI3+Owva3hmR8YBGJrhP85/yj+KFSe48zdWSj3o6kVyyzPOHgCsbNVCIENs
         1AvHmk3H6r5PnEKsEdwXS61GJVmK1kG4zyBqxhToujhANwCWq/91Arb1XJaaMg0pg1OA
         YeozW+Ig1FxjN/8jbXA1+MHbwQvsa8EnPyUwSw9Q0AWeZCTxqWbJj7MsF/Km+EtrPoOj
         kDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M5qj5wwgDDOjYxs26fOkrwGqoqUS/daI8VCa+zgPh2o=;
        b=xbL96+ogZZ6syu7OUcVhfeFP8TxqSa7dAdvnL459m4SlUM6TpERhrL3XosdV7auRuD
         J/kMC5bqF6QS8h4RZmUlTqJ80tfJzj2KJL364Kh9ixNVTD9IWXPGRzSA5sDdYlzALNys
         2gEW7wBmzBlN+ZxrDOuN6GNO369dqnlfiD6nJMTCbwJGpEu2jLcowGbSDcbCl9tpeqbL
         Jmk26lyXTBV9UACZqhm9nGJ3aWA/xwWV7vEayhFpiY0a70nVwBNgR6ilKqRg1yB4NO/C
         Nm8qm4VIQI2+/8P7gj9A745IZW38MVIXchkbuG3H3L1PAZkSVWak4/QfWnPCRWQWM0BD
         Bu1g==
X-Gm-Message-State: AOAM532/zY89+xDk916yfqAB8jEoHCL0Pc3Rqv2Enc8vmqBVzAqx4DY1
        j4W36/E2MSNgkDOw7TKeQia4kQMJ/lEKxkpPCHw05A==
X-Google-Smtp-Source: ABdhPJw3+BjoP79/Y1fE1CQYBaOTAtfhTURZ68IcYhBbZql//bpUU/iUeD1dgtOyMHfcDiXS+5EkEr2br4fcG5CDuKI=
X-Received: by 2002:ac2:5607:: with SMTP id v7mr4972841lfd.71.1637676040864;
 Tue, 23 Nov 2021 06:00:40 -0800 (PST)
MIME-Version: 1.0
References: <20211115211533.6971-1-wbartczak@marvell.com> <20211115215426.1554-1-wbartczak@marvell.com>
In-Reply-To: <20211115215426.1554-1-wbartczak@marvell.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Nov 2021 15:00:04 +0100
Message-ID: <CAPDyKFoe2MgGcsMXPKPsFNtiBwQ=u6ZNCy_59rYoyAWa2ip2cQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: cavium: Improve request handling by proper use of API
To:     Wojciech Bartczak <wbartczak@marvell.com>
Cc:     linux-mmc@vger.kernel.org, rric@kernel.org, beanhuo@micron.com,
        tanxiaofei@huawei.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021 at 22:54, Wojciech Bartczak <wbartczak@marvell.com> wrote:
>
> The driver for cavium/marvell platforms uses directly mrq->done() callback
> to signalize the request completion. This method to finalize request
> processing is not correct.
>
> Following fix introduces proper use of mmc_request_done() API for
> all paths involved into handling MMC core requests.
>
> Changes v1 => v2:
> - Added missing variable slot and functionality to retrive
>   slot base on bus_id contained in response status register.

Version history is great, but should come outside the actual commit
message. See below.

>
> Signed-off-by: Wojciech Bartczak <wbartczak@marvell.com>
> ---

Version history should come here along with other information. Then
add the below three dashes to end the section.

---

>  drivers/mmc/host/cavium.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
> index 95a41983c6c0..674cfaf5d64e 100644
> --- a/drivers/mmc/host/cavium.c
> +++ b/drivers/mmc/host/cavium.c
> @@ -435,8 +435,10 @@ static void cleanup_dma(struct cvm_mmc_host *host, u64 rsp_sts)
>  irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
>  {
>         struct cvm_mmc_host *host = dev_id;
> +       struct cvm_mmc_slot *slot;
>         struct mmc_request *req;
>         u64 emm_int, rsp_sts;
> +       int bus_id;
>         bool host_done;
>
>         if (host->need_irq_handler_lock)
> @@ -456,6 +458,8 @@ irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
>                 goto out;
>
>         rsp_sts = readq(host->base + MIO_EMM_RSP_STS(host));
> +       bus_id = get_bus_id(rsp_sts);
> +       slot = host->slot[bus_id];  /* bus_id is in a range 0..2 */
>         /*
>          * dma_val set means DMA is still in progress. Don't touch
>          * the request and wait for the interrupt indicating that
> @@ -493,8 +497,8 @@ irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
>             (rsp_sts & MIO_EMM_RSP_STS_DMA_PEND))
>                 cleanup_dma(host, rsp_sts);
>

> +       mmc_request_done(slot->mmc, req);
>         host->current_req = NULL;
> -       req->done(req);

Flipping the order doesn't really matter here, as cvm_mmc_request() is
protected with the ->acquire_bus() lock.

However, I think it's good practise from the mmc core point of view,
to clear host->current_req prior to calling mmc_request_done(). Can
you please change this.

>
>  no_req_done:
>         if (host->dmar_fixup_done)
> @@ -699,8 +703,7 @@ static void cvm_mmc_dma_request(struct mmc_host *mmc,
>
>  error:
>         mrq->cmd->error = -EINVAL;
> -       if (mrq->done)
> -               mrq->done(mrq);
> +       mmc_request_done(mmc, mrq);
>         host->release_bus(host);
>  }
>

Kind regards
Uffe
