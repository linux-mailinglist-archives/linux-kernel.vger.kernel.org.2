Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371853B6C11
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 03:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhF2Bez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 21:34:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53639 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231959AbhF2Bey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 21:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624930348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9kYorP//K1VhOVzWqSp9mV6M/r7OM0NYvrvalKQnHOw=;
        b=TpZJQBxGV66Q8xrRnDHYwMYwteTIpSdhpbhXk7S2gZLCMBElKG/YpuQbRLIPC4VwHGZPR5
        CcLM4JnRDWHLPZk4KIt2ggaNjTxujetjurXVCv9+pPZ/TT9Qj9JwtnaEm8kGGFQpmeynyL
        6a8EpxqsRKkL3FXWvaiHJ+rhfMTpOHQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-CeCnM6Y8McyxyIO4A5ZA2g-1; Mon, 28 Jun 2021 21:32:24 -0400
X-MC-Unique: CeCnM6Y8McyxyIO4A5ZA2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0592A8015F8;
        Tue, 29 Jun 2021 01:32:23 +0000 (UTC)
Received: from T590 (ovpn-12-115.pek2.redhat.com [10.72.12.115])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E74D360C13;
        Tue, 29 Jun 2021 01:32:15 +0000 (UTC)
Date:   Tue, 29 Jun 2021 09:32:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/2] nvme-fc: Update hardware queues before using them
Message-ID: <YNp4GyXwOlJeqtby@T590>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625101649.49296-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625101649.49296-2-dwagner@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 12:16:48PM +0200, Daniel Wagner wrote:
> In case the number of hardware queues changes, do the update the
> tagset and ctx to hctx first before using the mapping to recreate and
> connnect the IO queues.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  drivers/nvme/host/fc.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 8a3c4814d21b..a9645cd89eca 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2951,14 +2951,6 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
>  	if (ctrl->ctrl.queue_count == 1)
>  		return 0;
>  
> -	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
> -	if (ret)
> -		goto out_free_io_queues;
> -
> -	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
> -	if (ret)
> -		goto out_delete_hw_queues;
> -
>  	if (prior_ioq_cnt != nr_io_queues) {
>  		dev_info(ctrl->ctrl.device,
>  			"reconnect: revising io queue count from %d to %d\n",
> @@ -2968,6 +2960,14 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
>  		nvme_unfreeze(&ctrl->ctrl);
>  	}
>  
> +	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
> +	if (ret)
> +		goto out_free_io_queues;
> +
> +	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
> +	if (ret)
> +		goto out_delete_hw_queues;
> +
>  	return 0;
>  
>  out_delete_hw_queues:
> -- 
> 2.29.2
> 

This way may cause correct hctx_idx to be passed to blk_mq_alloc_request_hctx(), so:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

