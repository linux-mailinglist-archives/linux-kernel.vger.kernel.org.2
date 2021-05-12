Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFCFF37C557
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 17:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbhELPjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 11:39:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:51870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231533AbhELPRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:17:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CA3FDAF80;
        Wed, 12 May 2021 15:15:52 +0000 (UTC)
Subject: Re: [PATCH v1 6/8] loop: add error handling support for add_disk()
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk
Cc:     bvanassche@acm.org, ming.lei@redhat.com, hch@infradead.org,
        jack@suse.cz, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210512064629.13899-1-mcgrof@kernel.org>
 <20210512064629.13899-7-mcgrof@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <65f45d01-2f22-e7b9-1eb9-9055a7b483cd@suse.de>
Date:   Wed, 12 May 2021 17:15:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210512064629.13899-7-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/21 8:46 AM, Luis Chamberlain wrote:
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   drivers/block/loop.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index d58d68f3c7cd..a22d8c985bf3 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -2170,10 +2170,15 @@ static int loop_add(struct loop_device **l, int i)
>   	disk->private_data	= lo;
>   	disk->queue		= lo->lo_queue;
>   	sprintf(disk->disk_name, "loop%d", i);
> -	add_disk(disk);
> +	err = add_disk(disk);
> +	if (err)
> +		goto out_put_disk;
> +
>   	*l = lo;
>   	return lo->lo_number;
>   
> +out_put_disk:
> +	put_disk(lo->lo_disk);
>   out_free_queue:
>   	blk_cleanup_queue(lo->lo_queue);
>   out_cleanup_tags:
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
