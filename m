Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411CA3426DA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 21:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhCSU2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 16:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbhCSU1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 16:27:37 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9723C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 13:27:36 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id h25so4453689pgm.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 13:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QOTQx/USRTzP3QrlR22trv7JfPrYqpobWO1pUMGwjUs=;
        b=aB+TrpTWiZ9dtw6bmg71SxBRdZpIiTUo8EQ0gcE+A4eEASWbM+chn6bMlJNkfiJjJM
         g6siio1JZbabG22WbRZBWpjiJZfGlIlSrvQZtPziwmfRQ+QasD6CIcdzEqqEp2uyc7W6
         wMKuNyphL7NNciXS4a826tTxAT0BdfSbLv7LW6LL/W1IJ1QyutBcnfTB98RRBL6Xba+T
         Koi6KZ9EaD9YxJY8EWeazJwQZhPA1uYUEvkh4eX4nTYh8IikeicHSxdHxC4vksTepUCz
         vBpBak9urCcXE1WYGeQF6b7QuiIHzLUnAsfQvOlrHmiqFC6pwNKSwRVf4KZfhzShy5Ro
         OHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QOTQx/USRTzP3QrlR22trv7JfPrYqpobWO1pUMGwjUs=;
        b=MudIqO7TFQ8gE1qnXrn/+gYiHGKPEmmznjw18im4Jxtg5xzXD0oAnxCLyPJw8EjfdG
         aG1VTlpULr5PwX8jolz2vL1HYb78RxzUZNN9YSoJs0B5jlnz+wylgxNpBeQzQ78VE0TA
         +hkV5wkpyewaZdok8UAlJOIbD644OOsWo+r6WLrv5VMYG2/bGoWsWeRHYznqN9DWNusU
         TEr1bYXeO0xuzawX5WQAzJ0R7qetekeNzbhM1tKIQCMhrJZ6ZjuP40JVc6txAyJ+5CRI
         TLDrppegl9XcvCfHYuUmW9Tr++FpwCQkGDr4/csM/ziT73lw4Zn8WOlTTU1lIdGBk8bq
         Lqkw==
X-Gm-Message-State: AOAM530QWLx4CdNNV4sAsGnQfXNg7aqVqpAaUFf7gahCdnlO1PHIL+sY
        pL/3xFsrknhfl4Jr+MOUGcHwDw==
X-Google-Smtp-Source: ABdhPJywQERULtmJgaMif8e0k3JviiFpdzaXEvVjnZ8vnMMeeXJagHkeA3hrz9gb8xB7eAN6qAdpRw==
X-Received: by 2002:a63:ed07:: with SMTP id d7mr13171631pgi.164.1616185656190;
        Fri, 19 Mar 2021 13:27:36 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id x11sm8870951pjh.0.2021.03.19.13.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 13:27:35 -0700 (PDT)
Subject: Re: [PATCH V3] blk-mq: Trivial typo fix and sentence construction for
 better readability
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
References: <20210319202359.8893-1-unixbhaskar@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <771aa286-5270-9642-7d6d-9cdb2f7014f8@kernel.dk>
Date:   Fri, 19 Mar 2021 14:27:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210319202359.8893-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/21 2:23 PM, Bhaskar Chowdhury wrote:
> 
> A typo fix and sentence reconstruction for better readability.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>   Changes from V2:
>   Thanks, Randy and Tom for the suggestion,mould it.
>   Missed the subject line prefix of pattern,so added back
> 
>  block/blk-mq-tag.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 9c92053e704d..9da426d20f12 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -373,8 +373,8 @@ static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
>  }
> 
>  /**
> - * blk_mq_tagset_wait_completed_request - wait until all completed req's
> - * complete funtion is run
> + * blk_mq_tagset_wait_completed_request - wait until all the req's
> + * functions completed their run

This is still nonsense, see reply to previous version.

-- 
Jens Axboe

