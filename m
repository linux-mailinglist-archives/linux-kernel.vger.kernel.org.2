Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26056305898
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbhA0Khe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:37:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:60750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232831AbhA0KfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:35:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 42B47ACBA;
        Wed, 27 Jan 2021 10:34:38 +0000 (UTC)
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20210127103033.15318-1-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <1563c0d6-cb24-0861-5a4a-a5aabfab7f9d@suse.de>
Date:   Wed, 27 Jan 2021 11:34:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210127103033.15318-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/21 11:30 AM, Daniel Wagner wrote:
> nvme_round_robin_path() should test if the return ns pointer is
> valid. nvme_next_ns() will return a NULL pointer if there is no path
> left.
> 
> Fixes: 75c10e732724 ("nvme-multipath: round-robin I/O policy")
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> v2:
>    - moved NULL test into the if conditional statement
>    - added Fixes tag
> 
>   drivers/nvme/host/multipath.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 9ac762b28811..282b7a4ea9a9 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -221,7 +221,7 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
>   	}
>   
>   	for (ns = nvme_next_ns(head, old);
> -	     ns != old;
> +	     ns && ns != old;
>   	     ns = nvme_next_ns(head, ns)) {
>   		if (nvme_path_is_disabled(ns))
>   			continue;
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
