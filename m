Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C454C3F7155
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 10:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbhHYI65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 04:58:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:33746 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231963AbhHYI64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 04:58:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="215639879"
X-IronPort-AV: E=Sophos;i="5.84,350,1620716400"; 
   d="scan'208";a="215639879"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 01:58:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,350,1620716400"; 
   d="scan'208";a="473782218"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga008.jf.intel.com with ESMTP; 25 Aug 2021 01:58:06 -0700
Subject: Re: [PATCH v2] mmc: queue: Remove unused parameters(request_queue)
To:     Chanwoo Lee <cw9316.lee@samsung.com>, ulf.hansson@linaro.org,
        colyli@suse.de, axboe@kernel.dk, ebiggers@google.com,
        pcc@google.com, porzio@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, sh043.lee@samsung.com
References: <CGME20210825075311epcas1p4b64d6a5a824983c91f7d5d1dc24a4cc2@epcas1p4.samsung.com>
 <20210825074601.8881-1-cw9316.lee@samsung.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <8b189f2d-dfe3-b23e-9598-668b8509f501@intel.com>
Date:   Wed, 25 Aug 2021 11:58:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210825074601.8881-1-cw9316.lee@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/21 10:46 am, Chanwoo Lee wrote:
> From: ChanWoo Lee <cw9316.lee@samsung.com>
> 
> In function mmc_exit_request, the request_queue structure(*q) is not used.
> I remove the unnecessary code related to the request_queue structure.
> 
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

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
>  					 host->max_segs;
>  }
>  
> -/**
> - * mmc_init_request() - initialize the MMC-specific per-request data
> - * @mq: the request queue
> - * @req: the request
> - * @gfp: memory allocation policy
> - */
> -static int __mmc_init_request(struct mmc_queue *mq, struct request *req,
> -			      gfp_t gfp)
> +static int mmc_mq_init_request(struct blk_mq_tag_set *set, struct request *req,
> +			       unsigned int hctx_idx, unsigned int numa_node)
>  {
>  	struct mmc_queue_req *mq_rq = req_to_mmc_queue_req(req);
> +	struct mmc_queue *mq = set->driver_data;
>  	struct mmc_card *card = mq->card;
>  	struct mmc_host *host = card->host;
>  
> -	mq_rq->sg = mmc_alloc_sg(mmc_get_max_segments(host), gfp);
> +	mq_rq->sg = mmc_alloc_sg(mmc_get_max_segments(host), GFP_KERNEL);
>  	if (!mq_rq->sg)
>  		return -ENOMEM;
>  
>  	return 0;
>  }
>  
> -static void mmc_exit_request(struct request_queue *q, struct request *req)
> +static void mmc_mq_exit_request(struct blk_mq_tag_set *set, struct request *req,
> +				unsigned int hctx_idx)
>  {
>  	struct mmc_queue_req *mq_rq = req_to_mmc_queue_req(req);
>  
> @@ -227,20 +223,6 @@ static void mmc_exit_request(struct request_queue *q, struct request *req)
>  	mq_rq->sg = NULL;
>  }
>  
> -static int mmc_mq_init_request(struct blk_mq_tag_set *set, struct request *req,
> -			       unsigned int hctx_idx, unsigned int numa_node)
> -{
> -	return __mmc_init_request(set->driver_data, req, GFP_KERNEL);
> -}
> -
> -static void mmc_mq_exit_request(struct blk_mq_tag_set *set, struct request *req,
> -				unsigned int hctx_idx)
> -{
> -	struct mmc_queue *mq = set->driver_data;
> -
> -	mmc_exit_request(mq->queue, req);
> -}
> -
>  static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>  				    const struct blk_mq_queue_data *bd)
>  {
> 

