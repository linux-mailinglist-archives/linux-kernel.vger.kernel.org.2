Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD9431142F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 23:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhBEWBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 17:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbhBEO6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:58:33 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A249C0617AB
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 08:28:16 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id t25so7431019otc.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 08:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZl6RPhUke505ereioXy1G3s8m2Fn5RLxns2xlj+B9w=;
        b=PY+nccQghw+5zm1Mk1aCm54cMN0qPbtbVn+2f12BswUjGtcFl/3j1z6ef6B7sZDZpV
         Au15Ey/rdin4mQ5lCXiwY8k9OR5IDH/LGFSBVp21CMfKR0wdL3YjJ8LQw9AqsTs96WbY
         /gFENLLnraXVHFKt4ppA161/Vy/4/kQjRoibQRb2+gTfkO53DIiYuuwhQrZ8BXNCGPu6
         Yy+uSvNACZ631BkaJ1g1eNplV+HC4kQNDygXAJULPI0OJN1LUHBrXX8isR/8Z37mRz8F
         oaL4wHZsrY7REFQVxZUIZIkN7zQ8zSpxpBM1DlhHOcY7t/H9+DZdBcv/M8TlOpkKqmP/
         ypXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZl6RPhUke505ereioXy1G3s8m2Fn5RLxns2xlj+B9w=;
        b=kKuyRpmLWIy2NNA4VB/AuXjnTXtPQroQtUCQaiVUH3kDNGdSkqdU/XQK1cf30TPzlH
         OSPGZ/nagZLVwtcB1yQBKgyQYvPRtt2KJ6yvNjxCYg4ljcaf49p05DrKM3xgA1GgiQpA
         Hl48+EEymEsUwm12/oKyKjKGG9x23Ko/wkhMVAYCVJLq43R7Cj42lTB1XbLd8jrFYLYT
         kCvfZjmvvwUiPV7qZ/nRkld+c1VKd62DkJQNSNsAjLPLIX3HXNdWtP4T+ehzgH1Ru5k4
         Z8fd/aVyMfEOUk8zUvtqNaFk0MInwIWsFWBJMLi7IbMIk8DKlGbweHK8t5ZuKs2Wms/Q
         Ytsg==
X-Gm-Message-State: AOAM532ehX35weKD+rRba3N6u2M8FLP3+RF5xBLQKehkAvy6OnfwTL6G
        nMZfvNkV9Qnf5CpZRlva3JMNANgpj9bFlklGIXWuj5sPqT/7jjtw
X-Google-Smtp-Source: ABdhPJzF/8+coxm8NVL7h/r1o77FLvPSTsfQvUN9NOKN1v1IeGt0PPlsWTJvLteOVe0nTehK7kqjiFAusuej6p37sjU=
X-Received: by 2002:ab0:338c:: with SMTP id y12mr3012660uap.19.1612535082406;
 Fri, 05 Feb 2021 06:24:42 -0800 (PST)
MIME-Version: 1.0
References: <20210121081349.8266-1-liu.xiang@zlingsmart.com>
In-Reply-To: <20210121081349.8266-1-liu.xiang@zlingsmart.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 5 Feb 2021 15:24:06 +0100
Message-ID: <CAPDyKFpOFRGdd0L4Sx9ynV3O_9YJvO=2VBxvWYTfBHjabiDaUg@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: use REQ_HIPRI flag to complete request
 directly in own complete workqueue
To:     Liu Xiang <liu.xiang@zlingsmart.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        liuxiang_1999@126.com, Christoph Hellwig <hch@lst.de>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Adrian, Christoph

On Thu, 21 Jan 2021 at 09:13, Liu Xiang <liu.xiang@zlingsmart.com> wrote:
>
> After commit "40d09b53bfc557af7481b9d80f060a7ac9c7d314", request is
> completed in softirq. This may cause the system to suffer bad preemptoff
> time.
> The mmc driver has its own complete workqueue, but it can not work
> well now.
> The REQ_HIPRI flag can be used to complete request directly in its own
> complete workqueue and the preemptoff problem could be avoided.

I am trying to understand all of the problem, but I don't quite get
it, sorry. Would it be possible for you to extend the description in
the commit message a bit?

More exactly, what will happen if we tag a request with REQ_HIPRI
before completing it? Apologize for my ignorance, but I am currently a
bit overwhelmed with work, so I didn't have the time to really look it
up myself.

>
> Signed-off-by: Liu Xiang <liu.xiang@zlingsmart.com>
> ---
>  drivers/mmc/core/block.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 42e27a298..c27239a89 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1985,8 +1985,10 @@ static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req)
>          */
>         if (mq->in_recovery)
>                 mmc_blk_mq_complete_rq(mq, req);
> -       else if (likely(!blk_should_fake_timeout(req->q)))
> +       else if (likely(!blk_should_fake_timeout(req->q))) {
> +               req->cmd_flags |= REQ_HIPRI;
>                 blk_mq_complete_request(req);

Is there a specific reason why REQ_HIPRI is applicable only for
mmc_blk_mq_post_req() case?

We have other paths where we complete requests for MMC as well, are
those not relevant?

> +       }
>
>         mmc_blk_mq_dec_in_flight(mq, req);
>  }
> --
> 2.17.1
>

Kind regards
Uffe
