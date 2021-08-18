Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A463F03A8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 14:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbhHRMW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 08:22:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55372 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235550AbhHRMW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 08:22:27 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E144D1FFA2;
        Wed, 18 Aug 2021 12:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629289311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZwEvRtIuyZEjCL/vXUBtkJZmR2erkZdAfEZBkHpZlxw=;
        b=Z0dWAVnQqeFhuAJpni2TL/i9Gff5CwWehE4oQF+fyNALjOxVVtNkezGMGg90YUhr2neSJ7
        tUX3hW64JUIdL5ZiauTs2IFZkO/FOHu2TpRXUs66xEjMnR0/WGOfyiOWDuOI33wR2eliCw
        RZMQYx3tcqFcM579BCVEq7dpmXg/7TY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629289311;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZwEvRtIuyZEjCL/vXUBtkJZmR2erkZdAfEZBkHpZlxw=;
        b=Z+721H+As6XuSxoWxCwuLiO8DCMp1tNx9P/ZuyeViJknaTyeE43wAHb/SfcT89P28lY0A3
        YaabV2T0bAv93iAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D03E614454;
        Wed, 18 Aug 2021 12:21:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id w+aZMl/7HGGKJAAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 18 Aug 2021 12:21:51 +0000
Subject: Re: [PATCH v5 3/3] nvme-fc: fix controller reset hang during traffic
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        James Smart <jsmart2021@gmail.com>
References: <20210818120530.130501-1-dwagner@suse.de>
 <20210818120530.130501-4-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <ba6ebacb-6554-7683-7a7f-577241356bfa@suse.de>
Date:   Wed, 18 Aug 2021 14:21:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210818120530.130501-4-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/21 2:05 PM, Daniel Wagner wrote:
> From: James Smart <jsmart2021@gmail.com>
> 
> commit fe35ec58f0d3 ("block: update hctx map when use multiple maps")
> exposed an issue where we may hang trying to wait for queue freeze
> during I/O. We call blk_mq_update_nr_hw_queues which may attempt to freeze
> the queue. However we never started queue freeze when starting the
> reset, which means that we have inflight pending requests that entered the
> queue that we will not complete once the queue is quiesced.
> 
> So start a freeze before we quiesce the queue, and unfreeze the queue
> after we successfully connected the I/O queues (the unfreeze is already
> present in the code). blk_mq_update_nr_hw_queues will be called only
> after we are sure that the queue was already frozen.
> 
> This follows to how the pci driver handles resets.
> 
> This patch added logic introduced in commit 9f98772ba307 "nvme-rdma: fix
> controller reset hang during traffic".
> 
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> CC: Sagi Grimberg <sagi@grimberg.me>
> Tested-by: Daniel Wagner <dwagner@suse.de>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> ---
>  drivers/nvme/host/fc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 3ff783a2e9f7..99dadab2724c 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2974,9 +2974,10 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
>  			return -ENODEV;
>  		}
>  		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
> -		nvme_unfreeze(&ctrl->ctrl);
>  	}
>  
> +	nvme_unfreeze(&ctrl->ctrl);
> +
>  	return 0;
>  
>  out_delete_hw_queues:
> @@ -3215,6 +3216,9 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
>  	ctrl->iocnt = 0;
>  	spin_unlock_irqrestore(&ctrl->lock, flags);
>  
> +	if (ctrl->ctrl.queue_count > 1)
> +		nvme_start_freeze(&ctrl->ctrl);
> +
>  	__nvme_fc_abort_outstanding_ios(ctrl, false);
>  
>  	/* kill the aens as they are a separate path */
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
