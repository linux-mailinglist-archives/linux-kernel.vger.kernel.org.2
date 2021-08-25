Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1173F71AF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbhHYJ0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239635AbhHYJYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:24:13 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2225EC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 02:23:28 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id j12so28030431ljg.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 02:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kJ3IRgkWrnbEBgK8GKbfb9hriWmM8713CJTXI0Prmzs=;
        b=NmbKoUY+Ii3vbCq7K4YkwFAmGH3DPkkiCuNXGSh7R/6F/2uMM1gEln0n9STY6mHt7+
         QdwY3g8gRcAD9O1yPdBkfaE8HsHk32YaFSGdsnmcY2RLI9EOVluFdptDR+OM/JSqmd7B
         aCgMkag/20lw9XkhZOJx4FCUHIaLmDhFviY7y4xiLXoRlA2mu+PMBRK0Xq1PPiXAANUm
         87qFZLlsRpOxBLnjSttWSgaKLU8/GFgKlpR6IDfvLLgOWUoTImPbi6lYw2wgb209EFXR
         //gWznw7Zkhn3UDbiiFrRxWw+u7iTyKa4O+AZd81YHTVfr+Wn2XZ3KM5MwRVQjXL1UU7
         rZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kJ3IRgkWrnbEBgK8GKbfb9hriWmM8713CJTXI0Prmzs=;
        b=umVK+PhxVThV+DTL08TzsNVowA8OeX1DPXl6KjzYh2dxKbQCWEYtNqUSh4od2ZcKRn
         12NZN8fG4yTXhLOL72NcT5NI2txiHe4rkUTw0L3VolvQrPgl/xuvNCnb5N4Fjhu1iq1t
         s6CBUcjwqV6aypYjluwKPdC3eY2fI3PUSxEqIBj7JW2Wq7xrz8NcoEEInauKVk0PyPRv
         s2bjcrSqVIr9wtDqeDQEIQgnp1ayU+thhRkgOj0MDU0c6RxxQQbzf5fxOCrgA9QwSckL
         9kNRefuCd6RL3+bndCMUJkyxyKLXWh6gkqlZcjzgyq4ekGTBP0GqjZIhFMR+dy9FXAIM
         ODBA==
X-Gm-Message-State: AOAM530fPwILKV9tYSlYoF2be5UdxhNe9YnxMr7LS8kAa1ty8l9uZA4f
        WQ1oXYSI3kE9oEVaR2ZfybkH65k0p0QnH7WtYPq/vA==
X-Google-Smtp-Source: ABdhPJy68y5drwgRG638DefaX+hbJVUsTJhIxTNnagsH1Inp/3VQYaIo3xhtDp91sKKBhPkHrUyt3qSxkUCbb/03dH8=
X-Received: by 2002:a2e:a410:: with SMTP id p16mr33667752ljn.364.1629883406536;
 Wed, 25 Aug 2021 02:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210825075311epcas1p4b64d6a5a824983c91f7d5d1dc24a4cc2@epcas1p4.samsung.com>
 <20210825074601.8881-1-cw9316.lee@samsung.com>
In-Reply-To: <20210825074601.8881-1-cw9316.lee@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 25 Aug 2021 11:22:50 +0200
Message-ID: <CAPDyKFqCTYq9MDJ0_7xo_-Qwj80Giuc2M0ueYNHonNVO8+4q2A@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: queue: Remove unused parameters(request_queue)
To:     Chanwoo Lee <cw9316.lee@samsung.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>,
        Eric Biggers <ebiggers@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Luca Porzio <porzio@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        grant.jung@samsung.com, jt77.jang@samsung.com,
        DooHyun Hwang <dh0421.hwang@samsung.com>,
        Seunghui Lee <sh043.lee@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2021 at 09:53, Chanwoo Lee <cw9316.lee@samsung.com> wrote:
>
> From: ChanWoo Lee <cw9316.lee@samsung.com>
>
> In function mmc_exit_request, the request_queue structure(*q) is not used.
> I remove the unnecessary code related to the request_queue structure.
>
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
> v1->v2:
>  * Put the code directly into mmc_mq_init_reuqest()/mmc_mq_exit_request().
> ---
>  drivers/mmc/core/queue.c | 30 ++++++------------------------
>  1 file changed, 6 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index cc3261777637..5526e4ca2834 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -199,27 +199,23 @@ static unsigned int mmc_get_max_segments(struct mmc_host *host)
>                                          host->max_segs;
>  }
>
> -/**
> - * mmc_init_request() - initialize the MMC-specific per-request data
> - * @mq: the request queue
> - * @req: the request
> - * @gfp: memory allocation policy
> - */
> -static int __mmc_init_request(struct mmc_queue *mq, struct request *req,
> -                             gfp_t gfp)
> +static int mmc_mq_init_request(struct blk_mq_tag_set *set, struct request *req,
> +                              unsigned int hctx_idx, unsigned int numa_node)
>  {
>         struct mmc_queue_req *mq_rq = req_to_mmc_queue_req(req);
> +       struct mmc_queue *mq = set->driver_data;
>         struct mmc_card *card = mq->card;
>         struct mmc_host *host = card->host;
>
> -       mq_rq->sg = mmc_alloc_sg(mmc_get_max_segments(host), gfp);
> +       mq_rq->sg = mmc_alloc_sg(mmc_get_max_segments(host), GFP_KERNEL);
>         if (!mq_rq->sg)
>                 return -ENOMEM;
>
>         return 0;
>  }
>
> -static void mmc_exit_request(struct request_queue *q, struct request *req)
> +static void mmc_mq_exit_request(struct blk_mq_tag_set *set, struct request *req,
> +                               unsigned int hctx_idx)
>  {
>         struct mmc_queue_req *mq_rq = req_to_mmc_queue_req(req);
>
> @@ -227,20 +223,6 @@ static void mmc_exit_request(struct request_queue *q, struct request *req)
>         mq_rq->sg = NULL;
>  }
>
> -static int mmc_mq_init_request(struct blk_mq_tag_set *set, struct request *req,
> -                              unsigned int hctx_idx, unsigned int numa_node)
> -{
> -       return __mmc_init_request(set->driver_data, req, GFP_KERNEL);
> -}
> -
> -static void mmc_mq_exit_request(struct blk_mq_tag_set *set, struct request *req,
> -                               unsigned int hctx_idx)
> -{
> -       struct mmc_queue *mq = set->driver_data;
> -
> -       mmc_exit_request(mq->queue, req);
> -}
> -
>  static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>                                     const struct blk_mq_queue_data *bd)
>  {
> --
> 2.29.0
>
