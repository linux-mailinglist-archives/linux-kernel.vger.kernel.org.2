Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8DC3DC62B
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 15:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbhGaN5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 09:57:24 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:52470 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232770AbhGaN5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 09:57:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UhXKjCz_1627739833;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UhXKjCz_1627739833)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 31 Jul 2021 21:57:14 +0800
Subject: Re: [PATCH] ocfs2: quota_local: fix possible uninitialized-variable
 access in ocfs2_local_read_info()
To:     Tuo Li <islituo@gmail.com>, mark@fasheh.com, jlbec@evilplan.org
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, TOTE Robot <oslab@tsinghua.edu.cn>
References: <20210731075659.73505-1-islituo@gmail.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <607936a1-a21d-7d2f-7a89-2abeb4c5b1d4@linux.alibaba.com>
Date:   Sat, 31 Jul 2021 21:57:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210731075659.73505-1-islituo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the efforts.
For the issue you mentioned, I'd like just initialized
oinfo->dqi_gqinode as NULL before calling ocfs2_global_read_info().
But it seems still have other issues here such as dqi_gqlock.
We need take care all those initialized in ocfs2_global_read_info()
carefully.

Thanks,
Joseph

On 7/31/21 3:56 PM, Tuo Li wrote:
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
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Tuo Li <islituo@gmail.com>
> ---
>  fs/ocfs2/quota_local.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
> index b1a8b046f4c2..4c1219e08b49 100644
> --- a/fs/ocfs2/quota_local.c
> +++ b/fs/ocfs2/quota_local.c
> @@ -693,7 +693,7 @@ static int ocfs2_local_read_info(struct super_block *sb, int type)
>  
>  	info->dqi_max_spc_limit = 0x7fffffffffffffffLL;
>  	info->dqi_max_ino_limit = 0x7fffffffffffffffLL;
> -	oinfo = kmalloc(sizeof(struct ocfs2_mem_dqinfo), GFP_NOFS);
> +	oinfo = kzalloc(sizeof(struct ocfs2_mem_dqinfo), GFP_NOFS);
>  	if (!oinfo) {
>  		mlog(ML_ERROR, "failed to allocate memory for ocfs2 quota"
>  			       " info.");
> 
