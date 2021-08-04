Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79F33DFC02
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 09:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbhHDHYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 03:24:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46570 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbhHDHYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 03:24:03 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EF9D6221AB;
        Wed,  4 Aug 2021 07:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628061829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oOGybBe6w0jPITI2UQ0wM1DQGqv5itcWuZ3umMNAP8w=;
        b=WJGE1vWvY3By2QDkuZFXHD/+c77Cw4L3VVFsFaRmxX5dPJRGFIXwen7n4RTUZJbQWD6xT0
        wG/fdnWysxqpPfIsQPLBmBmC6/9bdklpmxjyTau2svhzaMu4ZebVxVyyKBHyAjfNQ55FJu
        VRLFbbso74fbnMWU2DA6fsYOoJvt9Ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628061829;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oOGybBe6w0jPITI2UQ0wM1DQGqv5itcWuZ3umMNAP8w=;
        b=qKS+WgJoF9+2uSgJdPWlhycd3K8g23/KoE0nNPleM2TqwdCRGFUUmo2vg8PswODXgX6ab/
        atnuYhdv4yjPY4BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF79A139FC;
        Wed,  4 Aug 2021 07:23:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OfIeNoVACmGPdAAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 04 Aug 2021 07:23:49 +0000
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Wen Xiong <wenxiong@us.ibm.com>,
        James Smart <jsmart2021@gmail.com>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-7-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 6/8] nvme-fc: fix controller reset hang during traffic
Message-ID: <79c89923-f586-79e7-6dfd-c15ceb21f569@suse.de>
Date:   Wed, 4 Aug 2021 09:23:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210802112658.75875-7-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/21 1:26 PM, Daniel Wagner wrote:
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
> [dwagner: call nvme_unfreeze() unconditionally in
>           nvme_fc_recreate_io_queues() to match the nvme_start_freeze()]
> Tested-by: Daniel Wagner <dwagner@suse.de>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> ---
>  drivers/nvme/host/fc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 133b87db4f1d..b292af0fd655 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2486,6 +2486,7 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
>  	 * (but with error status).
>  	 */
>  	if (ctrl->ctrl.queue_count > 1) {
> +		nvme_start_freeze(&ctrl->ctrl);
>  		nvme_stop_queues(&ctrl->ctrl);
>  		nvme_sync_io_queues(&ctrl->ctrl);
>  		blk_mq_tagset_busy_iter(&ctrl->tag_set,
> @@ -2966,8 +2967,8 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
>  			return -ENODEV;
>  		}
>  		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
> -		nvme_unfreeze(&ctrl->ctrl);
>  	}
> +	nvme_unfreeze(&ctrl->ctrl);
>  
>  	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
>  	if (ret)
> 
There still is now an imbalance, as we're always calling
'nvme_unfreeze()' (irrespective on the number of queues), but will only
call 'nvme_start_freeze()' if we have more than one queue.

This might lead to an imbalance on the mq_freeze_depth counter.
Wouldn't it be better to move the call to 'nvme_start_freeze()' out of
the if() condition to avoid the imbalance?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
