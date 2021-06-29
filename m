Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3140B3B6C16
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 03:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhF2BmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 21:42:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29682 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231947AbhF2BmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 21:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624930787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nmC6ZFHpVYRnCzG7FJlyXZBzfKH6rggjduLG+czT85I=;
        b=QoQoX+9Br4y+Z9ismWJtmGml9vdNakJp7F9l9H1AnWE11y3mY8nK68dJGIRNzz5AzTqFr7
        qywQClgf9/UUt0RAjeysDPjO9SX5TCAOXLtv6CtBQ/dxvFfttl6y0PeYZ5Mm+jmjIuIpON
        20x99yVFkveMgJkSH2T01BlQD8jAjXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-Av_utp_hNxmyHvGGDqGEUw-1; Mon, 28 Jun 2021 21:39:45 -0400
X-MC-Unique: Av_utp_hNxmyHvGGDqGEUw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91F28106B7E4;
        Tue, 29 Jun 2021 01:39:44 +0000 (UTC)
Received: from T590 (ovpn-12-115.pek2.redhat.com [10.72.12.115])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DC955C1D0;
        Tue, 29 Jun 2021 01:39:35 +0000 (UTC)
Date:   Tue, 29 Jun 2021 09:39:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvme-fc: Wait with a timeout for queue to freeze
Message-ID: <YNp50pmlzN6M0kNX@T590>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625101649.49296-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625101649.49296-3-dwagner@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 12:16:49PM +0200, Daniel Wagner wrote:
> Do not wait indifinitly for all queues to freeze. Instead use a
> timeout and abort the operation if we get stuck.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  drivers/nvme/host/fc.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index a9645cd89eca..d8db85aa5417 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2955,7 +2955,14 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
>  		dev_info(ctrl->ctrl.device,
>  			"reconnect: revising io queue count from %d to %d\n",
>  			prior_ioq_cnt, nr_io_queues);
> -		nvme_wait_freeze(&ctrl->ctrl);
> +		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
> +			/*
> +			 * If we timed out waiting for freeze we are likely to
> +			 * be stuck.  Fail the controller initialization just
> +			 * to be safe.
> +			 */
> +			return -ENODEV;
> +		}
>  		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
>  		nvme_unfreeze(&ctrl->ctrl);

Can you investigate a bit on why there is the hang? FC shouldn't use
managed IRQ, so the interrupt won't be shutdown.

blk-mq debugfs may help to dump the requests after the hang is triggered,
or you still can add debug code in nvme_wait_freeze_timeout() to dump
all requests if blk-mq debugfs doesn't work.


Thanks,
Ming

