Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153F537F750
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 14:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhEMMBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 08:01:47 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:59577 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233201AbhEMMBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 08:01:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UYlBm3y_1620907228;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UYlBm3y_1620907228)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 May 2021 20:00:29 +0800
Subject: Re: [PATCH] ocfs2: remove redundant assignment to pointer queue
To:     Colin King <colin.king@canonical.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, ocfs2-devel@oss.oracle.com,
        akpm <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210513113957.57539-1-colin.king@canonical.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <c8f57f1f-22f8-8e1b-3c22-e0613feff638@linux.alibaba.com>
Date:   Thu, 13 May 2021 20:00:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210513113957.57539-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/21 7:39 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer queue is being initialized with a value that is never read
> and it is being updated later with a new value. The initialization is
> redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/dlm/dlmmaster.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/dlm/dlmmaster.c b/fs/ocfs2/dlm/dlmmaster.c
> index 4960a6de768d..9b88219febb5 100644
> --- a/fs/ocfs2/dlm/dlmmaster.c
> +++ b/fs/ocfs2/dlm/dlmmaster.c
> @@ -2977,7 +2977,7 @@ static u8 dlm_pick_migration_target(struct dlm_ctxt *dlm,
>  				    struct dlm_lock_resource *res)
>  {
>  	enum dlm_lockres_list idx;
> -	struct list_head *queue = &res->granted;
> +	struct list_head *queue;
>  	struct dlm_lock *lock;
>  	int noderef;
>  	u8 nodenum = O2NM_MAX_NODES;
> 
