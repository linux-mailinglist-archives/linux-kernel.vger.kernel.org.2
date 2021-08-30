Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A3A3FB457
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 13:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbhH3LGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 07:06:11 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:56268 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235818AbhH3LGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 07:06:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Umb.v-4_1630321514;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Umb.v-4_1630321514)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 30 Aug 2021 19:05:15 +0800
Subject: Re: [PATCH v2] ocfs2: ocfs2_downconvert_lock failure results in
 deadlock
To:     Gang He <ghe@suse.com>, mark@fasheh.com, jlbec@evilplan.org
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        akpm@linux-foundation.org
References: <20210830044621.12544-1-ghe@suse.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <471dd2b4-fb62-3f4a-dbf3-cbf2340aed6f@linux.alibaba.com>
Date:   Mon, 30 Aug 2021 19:05:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210830044621.12544-1-ghe@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/21 12:46 PM, Gang He wrote:
> Usually, ocfs2_downconvert_lock() function always downconverts
> dlm lock to the expected level for satisfy dlm bast requests
> from the other nodes.
> But there is a rare situation. When dlm lock conversion is being
> canceled, ocfs2_downconvert_lock() function will return -EBUSY.
> You need to be aware that ocfs2_cancel_convert() function is
> asynchronous in fsdlm implementation.
> If we does not requeue this lockres entry, ocfs2 downconvert
> thread no longer handles this dlm lock bast request. Then, the
> other nodes will not get the dlm lock again, the current node's
> process will be blocked when acquire this dlm lock again.
> 
> Signed-off-by: Gang He <ghe@suse.com>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
> v2: keep error print in ocfs2_downconvert_lock function, add more detailed
> comments in code, add msleep to avoid repeated attempts. 
> ---
>  fs/ocfs2/dlmglue.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
> index 48fd369c29a4..f8f561850470 100644
> --- a/fs/ocfs2/dlmglue.c
> +++ b/fs/ocfs2/dlmglue.c
> @@ -16,6 +16,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>
>  #include <linux/time.h>
> +#include <linux/delay.h>
>  #include <linux/quotaops.h>
>  #include <linux/sched/signal.h>
>  
> @@ -3912,6 +3913,17 @@ static int ocfs2_unblock_lock(struct ocfs2_super *osb,
>  	spin_unlock_irqrestore(&lockres->l_lock, flags);
>  	ret = ocfs2_downconvert_lock(osb, lockres, new_level, set_lvb,
>  				     gen);
> +	/* The dlm lock convert is being cancelled in background,
> +	 * ocfs2_cancel_convert() is asynchronous in fs/dlm,
> +	 * requeue it, try again later.
> +	 */
> +	if (ret == -EBUSY) {
> +		ctl->requeue = 1;
> +		mlog(ML_BASTS, "lockres %s, ReQ: Downconvert busy\n",
> +		     lockres->l_name);
> +		ret = 0;
> +		msleep(20);
> +	}
>  
>  leave:
>  	if (ret)
> 
