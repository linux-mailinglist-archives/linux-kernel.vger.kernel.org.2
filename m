Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C4C3B7216
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 14:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhF2MeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 08:34:22 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40084 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbhF2MeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 08:34:18 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 25491226C5;
        Tue, 29 Jun 2021 12:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624969911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y4g4C2c4FJ507ilwRKpysNSC5KlV8Tgsj2EAb0yKOhY=;
        b=oyt0qFRI87bPzuOA/rdHaDjLT6IdTfszUqoazGxslhEhl0ZkAG92u+WxegPG1AUaOGcPlK
        tc3F4EInxgcGhb8PyGRx4aHY0GRRFawJZGAX3p/+oLXUex7Y0PPZOxhAQySi0CJrHxDqZU
        A9mf2nEZk7yXt4JcSjk8nQwnm+U3QXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624969911;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y4g4C2c4FJ507ilwRKpysNSC5KlV8Tgsj2EAb0yKOhY=;
        b=By0u6ThelRgPo7IE/L//b8hqRxCJHhfIxPxbmFDyCaTm+r/oAjvHKocO0KNzm0SjvyB3eu
        wJkEoncTSEoFJrBA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 4FBE211906;
        Tue, 29 Jun 2021 12:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624969911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y4g4C2c4FJ507ilwRKpysNSC5KlV8Tgsj2EAb0yKOhY=;
        b=oyt0qFRI87bPzuOA/rdHaDjLT6IdTfszUqoazGxslhEhl0ZkAG92u+WxegPG1AUaOGcPlK
        tc3F4EInxgcGhb8PyGRx4aHY0GRRFawJZGAX3p/+oLXUex7Y0PPZOxhAQySi0CJrHxDqZU
        A9mf2nEZk7yXt4JcSjk8nQwnm+U3QXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624969911;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y4g4C2c4FJ507ilwRKpysNSC5KlV8Tgsj2EAb0yKOhY=;
        b=By0u6ThelRgPo7IE/L//b8hqRxCJHhfIxPxbmFDyCaTm+r/oAjvHKocO0KNzm0SjvyB3eu
        wJkEoncTSEoFJrBA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id flwlCbYS22AbSgAALh3uQQ
        (envelope-from <hare@suse.de>); Tue, 29 Jun 2021 12:31:50 +0000
Subject: Re: [PATCH 2/2] nvme-fc: Wait with a timeout for queue to freeze
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625101649.49296-3-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <aef60901-b1d0-0499-211c-b87dc0745e2d@suse.de>
Date:   Tue, 29 Jun 2021 14:31:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210625101649.49296-3-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/21 12:16 PM, Daniel Wagner wrote:
> Do not wait indifinitly for all queues to freeze. Instead use a
> timeout and abort the operation if we get stuck.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fc.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index a9645cd89eca..d8db85aa5417 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2955,7 +2955,14 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
>   		dev_info(ctrl->ctrl.device,
>   			"reconnect: revising io queue count from %d to %d\n",
>   			prior_ioq_cnt, nr_io_queues);
> -		nvme_wait_freeze(&ctrl->ctrl);
> +		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
> +			/*
> +			 * If we timed out waiting for freeze we are likely to
> +			 * be stuck.  Fail the controller initialization just
> +			 * to be safe.
> +			 */
> +			return -ENODEV;
> +		}
>   		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
>   		nvme_unfreeze(&ctrl->ctrl);
>   	}
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
