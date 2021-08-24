Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8E33F5C11
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbhHXK1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:27:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44252 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbhHXK1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:27:21 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 056A01FD81;
        Tue, 24 Aug 2021 10:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629800796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dwi4vkaEZHnDhMZRTAJRdX2WqykvpPTQJv4cPVY4Bdw=;
        b=hTwjcTHfF3uldb6+DpNuavdAdy3XuuCLlQwKvyFzM13CkQjZlU7wgY1v25w2UZ/jGspabv
        0peoNY5aJwp84RjIFWp0kLP+dOEdCv/5Eg6NXrE91oCuSoAgBNx1bhhS2NpA+GvXpDNgOB
        c5FRhx6v9UYK6f3kijJFzjw4q4h7PG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629800796;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dwi4vkaEZHnDhMZRTAJRdX2WqykvpPTQJv4cPVY4Bdw=;
        b=i9WlgQV6oIQyCD5SBQhKS1393r9qYgtrHmhu9F1qllpW1KpzcJIB3VLz93KdxEwr8xJJvL
        qf2eNFNa4kZVuSAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0188C13AA1;
        Tue, 24 Aug 2021 10:26:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Iyx6L1jJJGFuRgAAMHmgww
        (envelope-from <colyli@suse.de>); Tue, 24 Aug 2021 10:26:32 +0000
Subject: Re: [PATCH] mmc: queue: Match the data type of max_segments
To:     Chanwoo Lee <cw9316.lee@samsung.com>
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, sh043.lee@samsung.com,
        adrian.hunter@intel.com, axboe@kernel.dk, ebiggers@google.com,
        pcc@google.com, porzio@gmail.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20210824074651epcas1p3b6965040fa6a4660a31192f96125c374@epcas1p3.samsung.com>
 <20210824073934.19727-1-cw9316.lee@samsung.com>
From:   Coly Li <colyli@suse.de>
Message-ID: <23afe53a-f73d-f8ff-322c-6d77d56ee9fa@suse.de>
Date:   Tue, 24 Aug 2021 18:26:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210824073934.19727-1-cw9316.lee@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 3:39 PM, Chanwoo Lee wrote:
> From: ChanWoo Lee <cw9316.lee@samsung.com>
>
> Each function has a different data type for max_segments,
> Modify to match unsigned short(host->max_segs).
> * unsigned short          max_segs;       /* see blk_queue_max_segments */
>
> 1) Return type : unsigned int
> static unsigned int mmc_get_max_segments(struct mmc_host *host)
> {
>        return host->can_dma_map_merge ? MMC_DMA_MAP_MERGE_SEGMENTS :
>                                          host->max_segs;
> }
>
> 2) Parameter type : int
>  mmc_alloc_sg(mmc_get_max_segments(host), gfp);
>    -> static struct scatterlist *mmc_alloc_sg(int sg_len, gfp_t gfp)
>
> 3) Parameter type : unsigned short
>  blk_queue_max_segments(mq->queue, mmc_get_max_segments(host));
>    -> void blk_queue_max_segments(struct request_queue *q,
>                                         unsigned short max_segments)
>
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>

I am not sure whether it is mandatory necessary here, but it is OK for me.

Acked-by: Coly Li <colyli@suse.de>

Thanks.

Coly Li

> ---
>  drivers/mmc/core/queue.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index cc3261777637..48304bcf963c 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -163,7 +163,7 @@ static void mmc_mq_recovery_handler(struct work_struct *work)
>  	blk_mq_run_hw_queues(q, true);
>  }
>  
> -static struct scatterlist *mmc_alloc_sg(int sg_len, gfp_t gfp)
> +static struct scatterlist *mmc_alloc_sg(unsigned short sg_len, gfp_t gfp)
>  {
>  	struct scatterlist *sg;
>  
> @@ -193,7 +193,7 @@ static void mmc_queue_setup_discard(struct request_queue *q,
>  		blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
>  }
>  
> -static unsigned int mmc_get_max_segments(struct mmc_host *host)
> +static unsigned short mmc_get_max_segments(struct mmc_host *host)
>  {
>  	return host->can_dma_map_merge ? MMC_DMA_MAP_MERGE_SEGMENTS :
>  					 host->max_segs;

