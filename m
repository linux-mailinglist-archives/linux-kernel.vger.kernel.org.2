Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7A345A75B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbhKWQSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238848AbhKWQSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:18:11 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2467BC06173E
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 08:15:03 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id d11so12149832ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 08:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1/M8/TbMw2+bg8CP1g2Qa/yEQ2sPxMoDxHHt0iItv3k=;
        b=sKybRDpkGeiFZMJgsGd9hp98heI5epsxXD/mRJsUdUkSM1IE+uycLqAQHeWYLI2/Cd
         EVVTYBwBx5fBXJeqhTbEwcZgUc+n7yK9xxJwDDZe+I4qm5k1CB080RAnps/y9axGsWTw
         lth9H5D3KalF+QUvatCE/ShPEmO7pXoaVV1dVogwpOhhOHjukOKM3FJQfG5qe+esqzVS
         z+gVApA+thXSXmnI2Ft8EvAnvrbwMsmuCYS4/onlzWe7Y35b159ntRSETK562DEkuJOA
         nQwsoRrygoxJsORI35hN4vLznToYf8CQ9wFiUU9lJoWDnzpY41enooiTQt4opquOrNTl
         8XJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1/M8/TbMw2+bg8CP1g2Qa/yEQ2sPxMoDxHHt0iItv3k=;
        b=SFqTpefANgtRdsUp2nxqaa+0CobfrY7/hN7Gr1mpOOb1d/M6lWq97E6yUIAu8sZ977
         nKWHnYVs57nmTk2mXeRlyb8aA4CbcolZVzeme6ufbGP5byvrKnFftJhTV6482CVJueD+
         SMMAsQaMLHqmnF+GGZi1C8uNNMLuw+3QwYqEnvOU+ipoDEdvG4Irx9qUIaPLUhZFSSrr
         JxleffsqacXYRNS8/jrsmcogtYlR1c/P1dZ2BB3SD2KCh3E3fweAeMgpkJ1WneE05hcj
         WUZU57EkmF3/x63b1H0SKqxudO7L9eg3MmP8P/9gBCXX0liSaX8hORzjtRWtaaTXXsKR
         Gzuw==
X-Gm-Message-State: AOAM530/Ypf/jRGKLCAJoBKqa8DDDN7LNrzDOOUSQprZUwc9a6xtFgKH
        d/fqdosdhwzzRYOJb8ATp5l9GdyV7qMzjIS05TdnsQ==
X-Google-Smtp-Source: ABdhPJz2OQIkPHuviN3voFUT32CIBpBVvOS0Emtx3t3DGrqeSJ91ZMgzgYmaIa86pU/AY+h65EDCq0IwQjz7L7+T8L0=
X-Received: by 2002:a2e:a5c8:: with SMTP id n8mr6705979ljp.367.1637684101255;
 Tue, 23 Nov 2021 08:15:01 -0800 (PST)
MIME-Version: 1.0
References: <20211115160226.20885-1-wbartczak@marvell.com>
In-Reply-To: <20211115160226.20885-1-wbartczak@marvell.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Nov 2021 17:14:24 +0100
Message-ID: <CAPDyKFrkLQaFp_L0uZzB_KWnNkehg8ECK4cnf8o1yGCB9UZkBQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: cavium: Ensure proper mapping between request and interrupt
To:     Wojciech Bartczak <wbartczak@marvell.com>
Cc:     linux-mmc@vger.kernel.org, rric@kernel.org, beanhuo@micron.com,
        tanxiaofei@huawei.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021 at 17:04, Wojciech Bartczak <wbartczak@marvell.com> wrote:
>
> The MMC block in octeontx2 uses architecture, where data lines are
> shared between up to three supported cards. To keep the track of the
> request hardware reports bus_id for the command complete interrupt.
> At the same time the driver keeps information about the request on the
> fly. This change combines these information to ensure proper mapping
> between the request and the response.
>
> Signed-off-by: Wojciech Bartczak <wbartczak@marvell.com>
> ---
>  drivers/mmc/host/cavium.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
> index 95a41983c6c0..24ea03f5a7c0 100644
> --- a/drivers/mmc/host/cavium.c
> +++ b/drivers/mmc/host/cavium.c
> @@ -438,6 +438,8 @@ irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
>         struct mmc_request *req;
>         u64 emm_int, rsp_sts;
>         bool host_done;
> +       struct cvm_mmc_slot *slot;
> +       int bus_id;
>
>         if (host->need_irq_handler_lock)
>                 spin_lock(&host->irq_handler_lock);
> @@ -455,7 +457,19 @@ irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
>         if (!req)
>                 goto out;
>
> +       slot = mmc_priv(req->host);
> +
> +       /* Get response */
>         rsp_sts = readq(host->base + MIO_EMM_RSP_STS(host));
> +       /* Map request to cvm_mmc_slot */
> +       bus_id = FIELD_GET(MIO_EMM_RSP_STS_BUS_ID, rsp_sts);
> +       if (bus_id != slot->bus_id) {
> +               dev_err(mmc_classdev(slot->mmc),
> +                       "Remapping, request for slot %d, interrupt for %d!\n",
> +                       slot->bus_id, bus_id);
> +               slot = host->slot[bus_id];
> +       }
> +
>         /*
>          * dma_val set means DMA is still in progress. Don't touch
>          * the request and wait for the interrupt indicating that
> @@ -493,8 +507,9 @@ irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
>             (rsp_sts & MIO_EMM_RSP_STS_DMA_PEND))
>                 cleanup_dma(host, rsp_sts);
>
> +       if (mrq->done)
> +               mrq->done(mrq);
>         host->current_req = NULL;
> -       req->done(req);

This looks unrelated, please drop this from @subject patch.

>
>  no_req_done:
>         if (host->dmar_fixup_done)
> @@ -669,6 +684,7 @@ static void cvm_mmc_dma_request(struct mmc_host *mmc,
>                 set_wdog(slot, data->timeout_ns);
>
>         WARN_ON(host->current_req);
> +       mrq->host = mmc;

Please, no. We don't want the host driver to update the mrq->host. If
that should be done, which is kind of questionable to me, that should
be managed by the core layer.

In this particular case, an option could be to store the bus-id that
corresponds to the slot for the request that is about to be started.
Along the lines of how we store host->current_req, below.

>         host->current_req = mrq;
>
>         emm_dma = prepare_ext_dma(mmc, mrq);
> @@ -776,6 +792,7 @@ static void cvm_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>         mods = cvm_mmc_get_cr_mods(cmd);
>
>         WARN_ON(host->current_req);
> +       mrq->host = mmc;
>         host->current_req = mrq;
>
>         if (cmd->data) {

Kind regards
Uffe
