Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E5E40AC1E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 12:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhINK7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 06:59:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60694 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbhINK7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 06:59:30 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D8353220C5;
        Tue, 14 Sep 2021 10:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631617092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0BswG7qSJgCzajVNxbDwn7zIx+XZp6tCFNp9WPxMd8s=;
        b=SZQ7KSjLP75G3pTSVq1YE5zzy3v5t+Suur6vN4bpPHr6xh1K2OLR45bOWk8LbjgtcAqayb
        IEKyn6HQ6j1pkYZgseFsB6mJu7eHax0zEBE/FG+nKFGkwN7FuVpbdgLfCdjAuRoMy2I1tX
        KBRLm2LW3D1A393UMiYYlRja1EkGpWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631617092;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0BswG7qSJgCzajVNxbDwn7zIx+XZp6tCFNp9WPxMd8s=;
        b=8Q69zGwW0+E2TV7wgqXp6fxR9qTqUiOcZzNQh4KbTm2Jz/rPA2Ew1i7tt/ASIqZtexdIjw
        el9oerfT5Z7WmHAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BAB6D13D3F;
        Tue, 14 Sep 2021 10:58:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KMn8LESAQGHadgAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 14 Sep 2021 10:58:12 +0000
Subject: Re: [PATCH v7 3/3] nvme-fc: Remove freeze/unfreeze around
 update_nr_hw_queues
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        James Smart <jsmart2021@gmail.com>
References: <20210914092008.40370-1-dwagner@suse.de>
 <20210914092008.40370-4-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <040a7eef-3603-2d8f-0576-3fceafc80de8@suse.de>
Date:   Tue, 14 Sep 2021 12:58:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210914092008.40370-4-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/21 11:20 AM, Daniel Wagner wrote:
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
>  
>  	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
