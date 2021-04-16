Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F205361768
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 04:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbhDPCKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 22:10:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31725 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235058AbhDPCKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 22:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618539027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mlRPn97nJzfL/YSQqBED+cxJcSwhch861xmnBFyG2xw=;
        b=ZO+thkXBK8x1pWms5oK5ZPcZ6pkUnmzn3vnha2bnpYPuDVmyWejmudoclMDY4RAOYACz0e
        aYh8CHcQOoU0wOnb8SYIdeNkcYLkOmgsM7IyxkNN1AHfwcc4LEysbq9zadc1F7tjf5W9sX
        BrYty02Zo9MOKu6TzBJnmnxCpIk131c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-JwJVUmrsMj6vRwQM4pEi8w-1; Thu, 15 Apr 2021 22:10:25 -0400
X-MC-Unique: JwJVUmrsMj6vRwQM4pEi8w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 533CC107ACED;
        Fri, 16 Apr 2021 02:10:22 +0000 (UTC)
Received: from T590 (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4586C62677;
        Fri, 16 Apr 2021 02:10:19 +0000 (UTC)
Date:   Fri, 16 Apr 2021 10:10:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Lin Feng <linf@wangsu.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] blk-mq: bypass IO scheduler's limit_depth for
 passthrough request
Message-ID: <YHjyB4UhmzUcH+c1@T590>
References: <20210415033920.213963-1-linf@wangsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415033920.213963-1-linf@wangsu.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 11:39:20AM +0800, Lin Feng wrote:
> Commit 01e99aeca39796003 ("blk-mq: insert passthrough request into
> hctx->dispatch directly") gives high priority to passthrough requests and
> bypass underlying IO scheduler. But as we allocate tag for such request it
> still runs io-scheduler's callback limit_depth, while we really want is to
> give full sbitmap-depth capabity to such request for acquiring available
> tag.
> blktrace shows PC requests(dmraid -s -c -i) hit bfq's limit_depth:
>   8,0    2        0     0.000000000 39952 1,0  m   N bfq [bfq_limit_depth] wr_busy 0 sync 0 depth 8
>   8,0    2        1     0.000008134 39952  D   R 4 [dmraid]
>   8,0    2        2     0.000021538    24  C   R [0]
>   8,0    2        0     0.000035442 39952 1,0  m   N bfq [bfq_limit_depth] wr_busy 0 sync 0 depth 8
>   8,0    2        3     0.000038813 39952  D   R 24 [dmraid]
>   8,0    2        4     0.000044356    24  C   R [0]
> 
> This patch introduce a new wrapper to make code not that ugly.
> 
> Signed-off-by: Lin Feng <linf@wangsu.com>
> ---
>  block/blk-mq.c         | 3 ++-
>  include/linux/blkdev.h | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d4d7c1caa439..927189a55575 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -361,11 +361,12 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
>  
>  	if (e) {
>  		/*
> -		 * Flush requests are special and go directly to the
> +		 * Flush/passthrough requests are special and go directly to the
>  		 * dispatch list. Don't include reserved tags in the
>  		 * limiting, as it isn't useful.
>  		 */
>  		if (!op_is_flush(data->cmd_flags) &&
> +		    !blk_op_is_passthrough(data->cmd_flags) &&
>  		    e->type->ops.limit_depth &&
>  		    !(data->flags & BLK_MQ_REQ_RESERVED))
>  			e->type->ops.limit_depth(data->cmd_flags, data);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 158aefae1030..0d81eed39833 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -272,6 +272,12 @@ static inline bool bio_is_passthrough(struct bio *bio)
>  	return blk_op_is_scsi(op) || blk_op_is_private(op);
>  }
>  
> +static inline bool blk_op_is_passthrough(unsigned int op)
> +{
> +	return (blk_op_is_scsi(op & REQ_OP_MASK) ||
> +			blk_op_is_private(op & REQ_OP_MASK));
> +}
> +
>  static inline unsigned short req_get_ioprio(struct request *req)
>  {
>  	return req->ioprio;
> -- 
> 2.30.2
> 

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks, 
Ming

