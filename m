Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA06D3641D8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 14:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239234AbhDSMkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 08:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239095AbhDSMkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 08:40:16 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE546C061760
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 05:39:45 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id t23so1136329vso.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 05:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dCgf0UyEDbuAQcdjW3A/2DyuF5Yu/jNA8mZrnhHTsic=;
        b=Ng+XW4kTt/2k/byFWBo8TBLnivqKioqq7Y7Q26+nqjeMa1t6fBTzrNW2wSzDjFmUST
         6+VMQ/GVSTMGMIXwJA3FWn0TNCMpfF/RQJnQKAlTrNaf0LD0WDnGwJhddi7s8fNg9/It
         o9iVzdQm5HA38ElnyZS/fAi0EY3dzuFCfyZhsYGvDo29mXwEIvuWgUySYwdScl2nHNll
         3cwUyc6UQlA0yjuIPu8tLEta//tFjsz1i1wyjxr0G7Xr9+KIN5q/KRautINTxIiS9/Xq
         hL4IZmIxqMSecR2J/1/pp54wnmnySz28xj404hQrwDfPSTKZOdAVKrlfAs3qe1hwduVZ
         8pHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dCgf0UyEDbuAQcdjW3A/2DyuF5Yu/jNA8mZrnhHTsic=;
        b=DW7jV748rvoc0uEzvzFmT/zhu0tESDbRt6JXsK9itV57s22II3il68hFNelyr18N9a
         jDc8kAD1DkCgRXUS1hp2Zj/zApnwE9ukZhN6RrPN25T4ncF2fXEF3suQa/nqyx3eueAA
         3QEDIQMOytfPalJcCxZnPRwp19ocou86CC/MD6B09pm0O9MKUfTOygJhWAMSOkWn+p5w
         WOgr3B5fzjnpD+B2rcSSQEs9GalZGi9Nf5T7vIVkGbTL8BY8NB1vhEEuaKKt6Ld6x2Dh
         DgBQg5wAQhTJi78AAQWhRt+0Bl+jHIwbiUPsjIPwKi6T08iYvib1v16ZqDiN4erLypua
         fPng==
X-Gm-Message-State: AOAM531TGN0nrmIJQrEuYJhuku/YbMkTDwMKgbAkEo/hRTVzai6urZ+F
        yme7oNw/BN2+6Ox39bwlgnjrWdkOjQYRyWfPGGiVUQ==
X-Google-Smtp-Source: ABdhPJyX/b5BWYpl5iKqfU3YNGdN/GTWGfg1E3ikFLdRAIUPlAUnPw9+zJ0a54ID+ky9W0R0E+StZNAFDACZFzLYmYc=
X-Received: by 2002:a67:fd48:: with SMTP id g8mr13799346vsr.55.1618835985083;
 Mon, 19 Apr 2021 05:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210418055953.26959-1-avri.altman@wdc.com> <20210418055953.26959-2-avri.altman@wdc.com>
In-Reply-To: <20210418055953.26959-2-avri.altman@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 19 Apr 2021 14:39:08 +0200
Message-ID: <CAPDyKFqAdXcVO9=26pTbQyzYprax9-_i0T1XMeXTWAYOMAaovw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: block: Issue flush only if allowed
To:     Avri Altman <avri.altman@wdc.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Peter <bpeter@lytx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Apr 2021 at 08:00, Avri Altman <avri.altman@wdc.com> wrote:
>
> The cache may be flushed to the nonvolatile storage by writing to
> FLUSH_CACHE byte (EXT_CSD byte [32]). When in command queueing mode, the
> cache may be flushed by issuing a CMDQ_TASK_ DEV_MGMT (CMD48) with a
> FLUSH_CACHE op-code.  Either way, verify that The cache function is
> turned ON before doing so.

Avri, thanks for your patch. Overall this looks good to me.

However things are becoming more and more messy in these layers of the
mmc core. In particular, I would like us to take advantage of the
bus_ops callbacks, when eMMC and/or SD specific features need
different implementations.

I have posted a patch [1], that moves the eMMC cache flushing into a
bus_ops callback. Would you mind rebasing this series on top of that?

Kind regards
Uffe

[1]
https://patchwork.kernel.org/project/linux-mmc/patch/20210419122943.68234-1-ulf.hansson@linaro.org/

>
> fixes: 1e8e55b67030 (mmc: block: Add CQE support)
>
> Reported-by: Brendan Peter <bpeter@lytx.com>
> Tested-by: Brendan Peter <bpeter@lytx.com>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/block.c   | 7 +++++++
>  drivers/mmc/core/mmc_ops.c | 4 +---
>  drivers/mmc/core/mmc_ops.h | 5 +++++
>  3 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index fe5892d30778..6800feb70c92 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1476,6 +1476,11 @@ static int mmc_blk_cqe_issue_flush(struct mmc_queue *mq, struct request *req)
>         struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>         struct mmc_request *mrq = mmc_blk_cqe_prep_dcmd(mqrq, req);
>
> +       if (mmc_card_mmc(mq->card) && !mmc_flush_allowed(mq->card)) {
> +               blk_mq_end_request(req, BLK_STS_OK);
> +               return -EPERM;
> +       }
> +
>         mrq->cmd->opcode = MMC_SWITCH;
>         mrq->cmd->arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
>                         (EXT_CSD_FLUSH_CACHE << 16) |
> @@ -2226,6 +2231,8 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
>                 switch (req_op(req)) {
>                 case REQ_OP_FLUSH:
>                         ret = mmc_blk_cqe_issue_flush(mq, req);
> +                       if (ret == -EPERM)
> +                               return MMC_REQ_FINISHED;
>                         break;
>                 case REQ_OP_READ:
>                 case REQ_OP_WRITE:
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index f413474f0f80..9c2a665be034 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -967,9 +967,7 @@ int mmc_flush_cache(struct mmc_card *card)
>  {
>         int err = 0;
>
> -       if (mmc_card_mmc(card) &&
> -                       (card->ext_csd.cache_size > 0) &&
> -                       (card->ext_csd.cache_ctrl & 1)) {
> +       if (mmc_card_mmc(card) && mmc_flush_allowed(card)) {
>                 err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>                                  EXT_CSD_FLUSH_CACHE, 1,
>                                  MMC_CACHE_FLUSH_TIMEOUT_MS);
> diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> index 632009260e51..bf2b315addd7 100644
> --- a/drivers/mmc/core/mmc_ops.h
> +++ b/drivers/mmc/core/mmc_ops.h
> @@ -19,6 +19,11 @@ enum mmc_busy_cmd {
>  struct mmc_host;
>  struct mmc_card;
>
> +static inline bool mmc_flush_allowed(struct mmc_card *card)
> +{
> +       return card->ext_csd.cache_size > 0 && (card->ext_csd.cache_ctrl & 1);
> +}
> +
>  int mmc_select_card(struct mmc_card *card);
>  int mmc_deselect_cards(struct mmc_host *host);
>  int mmc_set_dsr(struct mmc_host *host);
> --
> 2.25.1
>
