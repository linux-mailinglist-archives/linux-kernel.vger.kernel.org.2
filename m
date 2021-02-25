Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8143248B3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 03:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbhBYB66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 20:58:58 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:34937 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233739AbhBYB6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 20:58:55 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UPV7NGF_1614218291;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UPV7NGF_1614218291)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Feb 2021 09:58:12 +0800
Subject: Re: [PATCH] ocfs2: Replace DEFINE_SIMPLE_ATTRIBUTE with
 DEFINE_DEBUGFS_ATTRIBUTE
To:     Yang Li <yang.lee@linux.alibaba.com>,
        akpm <akpm@linux-foundation.org>
Cc:     jlbec@evilplan.org, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org, Mark Fasheh <mark@fasheh.com>
References: <1614155230-57292-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <c51e3d66-5ffa-d0ed-1dd2-b2a59e7f4173@linux.alibaba.com>
Date:   Thu, 25 Feb 2021 09:58:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1614155230-57292-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/21 4:27 PM, Yang Li wrote:
> Fix the following coccicheck warning:
> ./fs/ocfs2/blockcheck.c:232:0-23: WARNING: blockcheck_fops should be
> defined with DEFINE_DEBUGFS_ATTRIBUTE
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/blockcheck.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/blockcheck.c b/fs/ocfs2/blockcheck.c
> index 6e07ddb..dabfef9 100644
> --- a/fs/ocfs2/blockcheck.c
> +++ b/fs/ocfs2/blockcheck.c
> @@ -229,7 +229,7 @@ static int blockcheck_u64_get(void *data, u64 *val)
>  	*val = *(u64 *)data;
>  	return 0;
>  }
> -DEFINE_SIMPLE_ATTRIBUTE(blockcheck_fops, blockcheck_u64_get, NULL, "%llu\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(blockcheck_fops, blockcheck_u64_get, NULL, "%llu\n");
>  
>  static void ocfs2_blockcheck_debug_remove(struct ocfs2_blockcheck_stats *stats)
>  {
> 
