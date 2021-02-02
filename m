Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C1B30B8A1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 08:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhBBH2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 02:28:47 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:39729 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229470AbhBBH2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 02:28:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UNfEvgh_1612250881;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UNfEvgh_1612250881)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Feb 2021 15:28:02 +0800
Subject: Re: [PATCH] ocfs2: Simplify the calculation of variables
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        akpm <akpm@linux-foundation.org>
Cc:     jlbec@evilplan.org, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org, Mark Fasheh <mark@fasheh.com>
References: <1612235424-80367-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <fc27c9b4-e04a-fb76-4c7c-da07343040c8@linux.alibaba.com>
Date:   Tue, 2 Feb 2021 15:28:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1612235424-80367-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/2/21 11:10 AM, Jiapeng Chong wrote:
> Fix the following coccicheck warnings:
> 
> ./fs/ocfs2/refcounttree.c:981:16-18: WARNING !A || A && B is equivalent
> to !A || B.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/refcounttree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
> index 3b397fa..115365e85 100644
> --- a/fs/ocfs2/refcounttree.c
> +++ b/fs/ocfs2/refcounttree.c
> @@ -978,7 +978,7 @@ static int ocfs2_get_refcount_cpos_end(struct ocfs2_caching_info *ci,
>  		return 0;
>  	}
>  
> -	if (!eb || (eb && !eb->h_next_leaf_blk)) {
> +	if (!eb || !eb->h_next_leaf_blk) {
>  		/*
>  		 * We are the last extent rec, so any high cpos should
>  		 * be stored in this leaf refcount block.
> 
