Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACF330B4D6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 02:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhBBBtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 20:49:00 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:40451 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229852AbhBBBs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 20:48:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UNd8U2r_1612230491;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UNd8U2r_1612230491)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Feb 2021 09:48:12 +0800
Subject: Re: [PATCH] ocfs2: Fix a use after free on error
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Fasheh <mark@fasheh.com>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Joel Becker <jlbec@evilplan.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <YBfzR7AbZZ4Pp6sq@mwanda>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <2809e2b1-fcb4-bd91-d855-9812ede19447@linux.alibaba.com>
Date:   Tue, 2 Feb 2021 09:48:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YBfzR7AbZZ4Pp6sq@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/21 8:25 PM, Dan Carpenter wrote:
> The error handling in this function frees "reg" but it is still on the
> "o2hb_all_regions" list so it will lead to a use after free.  The fix
> for this is to only add it to the list after everything has succeeded.
> 
Seems we have to clear the bitmap as well in error case.
So how about add a new error label and handle them both?

Thanks,
Joseph

> Fixes: 1cf257f51191 ("ocfs2: fix memory leak")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> This is from static analysis and hasn't been tested.
> 
>  fs/ocfs2/cluster/heartbeat.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
> index 0179a73a3fa2..92af4dc813e7 100644
> --- a/fs/ocfs2/cluster/heartbeat.c
> +++ b/fs/ocfs2/cluster/heartbeat.c
> @@ -2025,7 +2025,6 @@ static struct config_item *o2hb_heartbeat_group_make_item(struct config_group *g
>  		}
>  		set_bit(reg->hr_region_num, o2hb_region_bitmap);
>  	}
> -	list_add_tail(&reg->hr_all_item, &o2hb_all_regions);
>  	spin_unlock(&o2hb_live_lock);
>  
>  	config_item_init_type_name(&reg->hr_item, name, &o2hb_region_type);
> @@ -2053,6 +2052,10 @@ static struct config_item *o2hb_heartbeat_group_make_item(struct config_group *g
>  
>  	o2hb_debug_region_init(reg, o2hb_debug_dir);
>  
> +	spin_lock(&o2hb_live_lock);
> +	list_add_tail(&reg->hr_all_item, &o2hb_all_regions);
> +	spin_unlock(&o2hb_live_lock);
> +
>  	return &reg->hr_item;
>  
>  unregister_handler:
> 
