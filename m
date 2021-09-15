Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A746240BC79
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 02:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbhIOAKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 20:10:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46939 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229520AbhIOAKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 20:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631664526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j3gS2bVHtavXJZxhTa4jjCutn22zS2x7UQx9KxqqqFw=;
        b=E+Xo9/ko4hUrUHny5QrPoS4ZXUphwKUN755UxH+wGDBOItqRkkSs6GyV+fCHUOPGuVvrlg
        DfF+kJ6fYp6KXMZCCYLocKlF8IiYi/pYuoRu3FosMiuLibtUasUHX8CgHK30iOZtQfKSCB
        uZ4LPuTsggbM4uSve1lJ8SeamNTrST4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-euj7gUv1OuK5UkuNAtA6rw-1; Tue, 14 Sep 2021 20:08:43 -0400
X-MC-Unique: euj7gUv1OuK5UkuNAtA6rw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5D61108468B;
        Wed, 15 Sep 2021 00:08:41 +0000 (UTC)
Received: from T590 (ovpn-12-59.pek2.redhat.com [10.72.12.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A7E35D9F4;
        Wed, 15 Sep 2021 00:08:33 +0000 (UTC)
Date:   Wed, 15 Sep 2021 08:08:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH v7 3/3] nvme-fc: Remove freeze/unfreeze around
 update_nr_hw_queues
Message-ID: <YUE5i77P7JF2zjpT@T590>
References: <20210914092008.40370-1-dwagner@suse.de>
 <20210914092008.40370-4-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914092008.40370-4-dwagner@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 11:20:08AM +0200, Daniel Wagner wrote:
> From: James Smart <jsmart2021@gmail.com>
> 
> Remove the freeze/unfreeze around changes to the number of hardware
> queues. Study and retest has indicated there are no ios that can be
> active at this point so there is nothing to freeze.
> 
> nvme-fc is draining the queues in the shutdown and error recovery path
> in __nvme_fc_abort_outstanding_ios.
> 
> This patch primarily reverts 88e837ed0f1f "nvme-fc: wait for queues to
> freeze before calling update_hr_hw_queues". It's not an exact revert as
> it leaves the adjusting of hw queues only if the count changes.
> 
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> [dwagner: added explanation why no IO is pending]
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  drivers/nvme/host/fc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 6ebe68396712..aa14ad963d91 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2957,9 +2957,7 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
>  		dev_info(ctrl->ctrl.device,
>  			"reconnect: revising io queue count from %d to %d\n",
>  			prior_ioq_cnt, nr_io_queues);
> -		nvme_wait_freeze(&ctrl->ctrl);
>  		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
> -		nvme_unfreeze(&ctrl->ctrl);
>  	}

Both connect queue and ns queues are added to this tag_set, so blk_mq_update_nr_hw_queues()
will freeze them all before updating nr_hw_queues.

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

