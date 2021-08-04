Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6504A3DF9B6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 04:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbhHDChO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 22:37:14 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:56580 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231950AbhHDChN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 22:37:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UhvWjaO_1628044619;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UhvWjaO_1628044619)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Aug 2021 10:37:00 +0800
Subject: Re: [PATCH v2] ocfs2: quota_local: fix possible
 uninitialized-variable access in ocfs2_local_read_info()
To:     Tuo Li <islituo@gmail.com>, mark@fasheh.com, jlbec@evilplan.org
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, TOTE Robot <oslab@tsinghua.edu.cn>
References: <20210804014510.29430-1-islituo@gmail.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <9b977911-1d62-ea72-0efa-185fe5937355@linux.alibaba.com>
Date:   Wed, 4 Aug 2021 10:36:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210804014510.29430-1-islituo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/4/21 9:45 AM, Tuo Li wrote:
> A memory block is allocated through kmalloc(), and its return value is
> assigned to the pointer oinfo. If the return value of
> ocfs2_global_read_info() at line 709 is less than zero,
> oinfo->dqi_gqinode may be not initialized. However, it is accessed at
> line 775:
>   iput(oinfo->dqi_gqinode);
> 
> To fix this possible uninitialized-variable access, replace kmalloc()
> with kzalloc() when allocating memory for oinfo.
> 

Update description as well.

> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Tuo Li <islituo@gmail.com>
> ---
> v2:
> * Replace kzalloc() with NULL assignment to oinfo->dqi_gqinode.
>   Thank Joseph Qi for helpful advice.
> ---
>  fs/ocfs2/quota_local.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
> index b1a8b046f4c2..de5aae584d5d 100644
> --- a/fs/ocfs2/quota_local.c
> +++ b/fs/ocfs2/quota_local.c
> @@ -703,6 +703,7 @@ static int ocfs2_local_read_info(struct super_block *sb, int type)
>  	oinfo->dqi_type = type;
>  	INIT_LIST_HEAD(&oinfo->dqi_chunk);
>  	oinfo->dqi_rec = NULL;
> +	oinfo->dqi_gqinode = NULL;
>  	oinfo->dqi_lqi_bh = NULL;
>  	oinfo->dqi_libh = NULL;
>  

We need take care oinfo->dqi_gqlock as well. How about the following way?

diff --git a/fs/ocfs2/quota_global.c b/fs/ocfs2/quota_global.c
index eda8348..f033de7 100644
--- a/fs/ocfs2/quota_global.c
+++ b/fs/ocfs2/quota_global.c
@@ -357,7 +357,6 @@ int ocfs2_global_read_info(struct super_block *sb, int type)
 	}
 	oinfo->dqi_gi.dqi_sb = sb;
 	oinfo->dqi_gi.dqi_type = type;
-	ocfs2_qinfo_lock_res_init(&oinfo->dqi_gqlock, oinfo);
 	oinfo->dqi_gi.dqi_entry_size = sizeof(struct ocfs2_global_disk_dqblk);
 	oinfo->dqi_gi.dqi_ops = &ocfs2_global_ops;
 	oinfo->dqi_gqi_bh = NULL;
diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index b1a8b04..0e4b16d 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -702,6 +702,8 @@ static int ocfs2_local_read_info(struct super_block *sb, int type)
 	info->dqi_priv = oinfo;
 	oinfo->dqi_type = type;
 	INIT_LIST_HEAD(&oinfo->dqi_chunk);
+	oinfo->dqi_gqinode = NULL;
+	ocfs2_qinfo_lock_res_init(&oinfo->dqi_gqlock, oinfo);
 	oinfo->dqi_rec = NULL;
 	oinfo->dqi_lqi_bh = NULL;
 	oinfo->dqi_libh = NULL;
