Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353D6319F83
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 14:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhBLNJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 08:09:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:35898 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231856AbhBLMrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 07:47:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E648BAC69;
        Fri, 12 Feb 2021 12:46:59 +0000 (UTC)
Subject: Re: [PATCH] nvme/hwmon: Return error code when registration fails
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20210212093015.2846-1-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <a58de23b-40c2-4534-cae0-36b1e42f2d45@suse.de>
Date:   Fri, 12 Feb 2021 13:46:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210212093015.2846-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/21 10:30 AM, Daniel Wagner wrote:
> The hwmon pointer wont be NULL if the registration fails. Though the
> exit code path will assign it to ctrl->hwmon_device. Later
> nvme_hwmon_exit() will try to free the invalid pointer. Avoid this by
> returning the error code from hwmon_device_register_with_info().
> 
> Fixes: ec420cdcfab4 ("nvme/hwmon: rework to avoid devm allocation")
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> 
> This patch is against linux-block/for-next.
> 
>   drivers/nvme/host/hwmon.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
> index 8f9e96986780..0a586d712920 100644
> --- a/drivers/nvme/host/hwmon.c
> +++ b/drivers/nvme/host/hwmon.c
> @@ -248,6 +248,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
>   	if (IS_ERR(hwmon)) {
>   		dev_warn(dev, "Failed to instantiate hwmon device\n");
>   		kfree(data);
> +		return PTR_ERR(hwmon);
>   	}
>   	ctrl->hwmon_device = hwmon;
>   	return 0;
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
