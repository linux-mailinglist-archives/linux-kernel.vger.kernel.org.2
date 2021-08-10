Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B819A3E217E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 04:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238382AbhHFCZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 22:25:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48784 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236363AbhHFCZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 22:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628216717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=igQnA9D1hdAyUyyYbSq9puQAhcJsd3GOaAKOTOyqDWE=;
        b=VR2SqGcX6ettPlZkBfZlM300h/QTOMd2DOGrgrJzOab/E0YfiU1rSyJbl/cKvRZtRY1iab
        xByzMPE9lJWpVEU8vLwut+lWc66eTk5Wi8zRqJXqsG4cVknI1EEpQYyiwIXOv3vlJHb3aK
        pLA/OpL1dUzjQ9CjWdGdLKH+c1nOiqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-67U0QC8COT-MPZdwC0eqaA-1; Thu, 05 Aug 2021 22:25:16 -0400
X-MC-Unique: 67U0QC8COT-MPZdwC0eqaA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECF8E3639F;
        Fri,  6 Aug 2021 02:25:14 +0000 (UTC)
Received: from T590 (ovpn-12-45.pek2.redhat.com [10.72.12.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1705360CC6;
        Fri,  6 Aug 2021 02:25:07 +0000 (UTC)
Date:   Fri, 6 Aug 2021 10:25:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH] blk-mq: clear active_queues before clearing
 BLK_MQ_F_TAG_QUEUE_SHARED
Message-ID: <YQydfkffPhBEFpwB@T590>
References: <20210731062130.1533893-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210731062130.1533893-1-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2021 at 02:21:30PM +0800, Yu Kuai wrote:
> We run a test that delete and recover devcies frequently(two devices on
> the same host), and we found that 'active_queues' is super big after a
> period of time.
> 
> If device a and device b share a tag set, and a is deleted, then
> blk_mq_exit_queue() will clear BLK_MQ_F_TAG_QUEUE_SHARED because there
> is only one queue that are using the tag set. However, if b is still
> active, the active_queues of b might never be cleared even if b is
> deleted.
> 
> Thus clear active_queues before BLK_MQ_F_TAG_QUEUE_SHARED is cleared.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-mq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 2c4ac51e54eb..2fe396385a4a 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2994,10 +2994,12 @@ static void queue_set_hctx_shared(struct request_queue *q, bool shared)
>  	int i;
>  
>  	queue_for_each_hw_ctx(q, hctx, i) {
> -		if (shared)
> +		if (shared) {
>  			hctx->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
> -		else
> +		} else {
> +			blk_mq_tag_idle(hctx);
>  			hctx->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
> +		}
>  	}
>  }

Looks correct, the only remained queue in tagset has to be idled before
clearing BLK_MQ_F_TAG_QUEUE_SHARED:

Reviewed-by: Ming Lei <ming.lei@redhat.com>



Thanks,
Ming

