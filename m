Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78806361774
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 04:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238130AbhDPCP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 22:15:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54299 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235057AbhDPCP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 22:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618539303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NtUYVy/xaclh6IHTZhhHN0cvRVFfOsj+jeNxCiXaxeg=;
        b=I8HJUX5eG2DxpM0yfmVodHFh3OdR/GlfWHBgHrnhG5982JkJIZV/q3DipA4sYA7BO+2lvR
        FVe0Hu2XIA+bQLJC8RxZ61g8qxRxsAwkXT3qLSUpdJG4qCHwyIZpgFfUDOzjsO/JJhCC/a
        xAVqFDzg/v9x+QmgG0AOOT5OkUimgjo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-Z-eyIDWeMbKlSmag4j7wtA-1; Thu, 15 Apr 2021 22:15:01 -0400
X-MC-Unique: Z-eyIDWeMbKlSmag4j7wtA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B5FF881D72;
        Fri, 16 Apr 2021 02:15:00 +0000 (UTC)
Received: from T590 (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 234DA5D9DE;
        Fri, 16 Apr 2021 02:14:52 +0000 (UTC)
Date:   Fri, 16 Apr 2021 10:14:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Lin Feng <linf@wangsu.com>
Cc:     axboe@kernel.dk, paolo.valente@linaro.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] bfq/mq-deadline: remove redundant check for
 passthrough request
Message-ID: <YHjzGPO+SoHMEghy@T590>
References: <20210415034326.214227-1-linf@wangsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415034326.214227-1-linf@wangsu.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 11:43:26AM +0800, Lin Feng wrote:
> Since commit 01e99aeca39796003 'blk-mq: insert passthrough request into
> hctx->dispatch directly', passthrough request should not appear in
> IO-scheduler any more, so blk_rq_is_passthrough checking in addon IO
> schedulers is redundant.
> 
> (Notes: this patch passes generic IO load test with hdds under SAS
> controller and hdds under AHCI controller but obviously not covers all.
> Not sure if passthrough request can still escape into IO scheduler from
> blk_mq_sched_insert_requests, which is used by blk_mq_flush_plug_list and
> has lots of indirect callers.)
> 
> Signed-off-by: Lin Feng <linf@wangsu.com>
> ---
>  block/bfq-iosched.c | 2 +-
>  block/mq-deadline.c | 7 ++-----
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 95586137194e..b827c9212b02 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5627,7 +5627,7 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  
>  	spin_lock_irq(&bfqd->lock);
>  	bfqq = bfq_init_rq(rq);
> -	if (!bfqq || at_head || blk_rq_is_passthrough(rq)) {
> +	if (!bfqq || at_head) {
>  		if (at_head)
>  			list_add(&rq->queuelist, &bfqd->dispatch);
>  		else
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index f3631a287466..04aded71ead2 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -500,11 +500,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  
>  	trace_block_rq_insert(rq);
>  
> -	if (at_head || blk_rq_is_passthrough(rq)) {
> -		if (at_head)
> -			list_add(&rq->queuelist, &dd->dispatch);
> -		else
> -			list_add_tail(&rq->queuelist, &dd->dispatch);
> +	if (at_head) {
> +		list_add(&rq->queuelist, &dd->dispatch);
>  	} else {
>  		deadline_add_rq_rb(dd, rq);
>  
> -- 
> 2.30.2
> 

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

