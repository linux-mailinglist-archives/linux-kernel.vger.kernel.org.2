Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDD73BF827
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 12:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhGHKPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 06:15:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43152 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbhGHKPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 06:15:04 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9777E22360;
        Thu,  8 Jul 2021 10:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625739141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IKJzJF5tCumCbWebteEOvrLHiJPh+40M7IbuEO+NlOI=;
        b=rPqiYhvAwWq1ArT7bQvl0xOR4z6zEqWTso/BaP00HogF+U0nX2nEkeeeNhs8V/V4OcYwBD
        krtC6xVusFSAJ+BajKhGuTBAiLii6Mh3tmgSMa7+mAvTyD24dVF0uBK0xRFN/shF4mlBn1
        E1Ou6fCe0492ZQHw9NRHKMhtzq41XCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625739141;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IKJzJF5tCumCbWebteEOvrLHiJPh+40M7IbuEO+NlOI=;
        b=d0QIo+yfd6JyQac+aUWnWf7nmGC2KBlR/uJwryrPG+uA1x7YHl6x9PFKfDHZ89AvsobT9Z
        mbRkJ6trKNa1LADw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 747811338E;
        Thu,  8 Jul 2021 10:12:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id kIe2G4XP5mA5MwAAGKfGzw
        (envelope-from <hare@suse.de>); Thu, 08 Jul 2021 10:12:21 +0000
Subject: Re: [PATCH v2 4/5] nvme-fc: Wait with a timeout for queue to freeze
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>
References: <20210708092755.15660-1-dwagner@suse.de>
 <20210708092755.15660-5-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <bf265380-6164-2462-ff30-6144e9f9b2ea@suse.de>
Date:   Thu, 8 Jul 2021 12:12:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210708092755.15660-5-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/21 11:27 AM, Daniel Wagner wrote:
> Do not wait indifinitly for all queues to freeze. Instead use a
> timeout and abort the operation if we get stuck.
> 
> Reviewed-by: James Smart <jsmart2021@gmail.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fc.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index d0eb81387d4e..8e1fc3796735 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2956,7 +2956,14 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
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

For controller reset we're using '-ENOTCONN'; maybe it's worthwhile to 
use the same error code here.
But that's just a minor detail.

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
