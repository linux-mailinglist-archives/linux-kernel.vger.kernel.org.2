Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132A130BDC8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhBBMKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:10:16 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:59406 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231299AbhBBMJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:09:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UNgkalg_1612267708;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UNgkalg_1612267708)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Feb 2021 20:08:29 +0800
Subject: Re: [PATCH v2] ocfs2: Fix a use after free on error
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Fasheh <mark@fasheh.com>
Cc:     Joel Becker <jlbec@evilplan.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Takashi Iwai <tiwai@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Jiri Slaby <jirislaby@kernel.org>, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <YBk4M6HUG8jB/jc7@mwanda>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <56634c6b-1c68-83dc-e372-09fd4bda3c7d@linux.alibaba.com>
Date:   Tue, 2 Feb 2021 20:08:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YBk4M6HUG8jB/jc7@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/2/21 7:32 PM, Dan Carpenter wrote:
> The error handling in this function frees "reg" but it is still on the
> "o2hb_all_regions" list so it will lead to a use after freew.  Joseph Qi
> points out that we need to clear the bit in the "o2hb_region_bitmap" as
> well
> 
> Fixes: 1cf257f51191 ("ocfs2: fix memory leak")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Looks good.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
> v2: The first version didn't clear the bit.
> 
>  fs/ocfs2/cluster/heartbeat.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
> index 0179a73a3fa2..12a7590601dd 100644
> --- a/fs/ocfs2/cluster/heartbeat.c
> +++ b/fs/ocfs2/cluster/heartbeat.c
> @@ -2042,7 +2042,7 @@ static struct config_item *o2hb_heartbeat_group_make_item(struct config_group *g
>  			o2hb_nego_timeout_handler,
>  			reg, NULL, &reg->hr_handler_list);
>  	if (ret)
> -		goto free;
> +		goto remove_item;
>  
>  	ret = o2net_register_handler(O2HB_NEGO_APPROVE_MSG, reg->hr_key,
>  			sizeof(struct o2hb_nego_msg),
> @@ -2057,6 +2057,12 @@ static struct config_item *o2hb_heartbeat_group_make_item(struct config_group *g
>  
>  unregister_handler:
>  	o2net_unregister_handler_list(&reg->hr_handler_list);
> +remove_item:
> +	spin_lock(&o2hb_live_lock);
> +	list_del(&reg->hr_all_item);
> +	if (o2hb_global_heartbeat_active())
> +		clear_bit(reg->hr_region_num, o2hb_region_bitmap);
> +	spin_unlock(&o2hb_live_lock);
>  free:
>  	kfree(reg);
>  	return ERR_PTR(ret);
> 
