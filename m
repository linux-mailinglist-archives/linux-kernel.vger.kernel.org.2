Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67ED43AFB21
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 04:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhFVClM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 22:41:12 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:8287 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhFVClM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 22:41:12 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G89ST0mxYz1BQKK;
        Tue, 22 Jun 2021 10:33:45 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 22 Jun 2021 10:38:53 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 dggema761-chm.china.huawei.com (10.1.198.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 22 Jun 2021 10:38:53 +0800
Subject: Re: [PATCH] ubifs: Remove a redundant null check on pointer lp
To:     Colin King <colin.king@canonical.com>,
        Richard Weinberger <richard@nod.at>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        <linux-mtd@lists.infradead.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210621152249.20901-1-colin.king@canonical.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <f2ea606a-4a05-8d14-4380-d96ca0f981a1@huawei.com>
Date:   Tue, 22 Jun 2021 10:38:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210621152249.20901-1-colin.king@canonical.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema761-chm.china.huawei.com (10.1.198.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2021/6/21 23:22, Colin King Ð´µÀ:
> From: Colin Ian King <colin.king@canonical.com>
> 
> An earlier fix to replace an IS_ERR check on lp with a null check
> on lp didn't remove a following null check on lp. The second null
> check is redundant and can be removed.
> 
> Addresses-Coverity: ("Logically dead code")
> Fixes: c770cd5190ba ("ubifs: fix an IS_ERR() vs NULL check")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   fs/ubifs/gc.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/fs/ubifs/gc.c b/fs/ubifs/gc.c
> index 7cc22d7317ea..465beea52176 100644
> --- a/fs/ubifs/gc.c
> +++ b/fs/ubifs/gc.c
> @@ -899,8 +899,6 @@ int ubifs_gc_start_commit(struct ubifs_info *c)
>   			err = -ENOMEM;
>   			goto out;
>   		}
Hi Colin,
I just found out about it today thanks to your patch. Commit 
c770cd5190ba ("ubifs: fix an IS_ERR() vs NULL check") did import a new 
problem that ubifs_gc_start_commit() may return -ENOMEM while syncing fs.
I guess ubifs_fast_find_frdi_idx() return NULL pointer is the 
termination condition in while-loop, which means we cannot get a 
freeable index LEB in ubifs_gc_start_commit().

> -		if (!lp)
> -			break;
>   		idx_gc = kmalloc(sizeof(struct ubifs_gced_idx_leb), GFP_NOFS);
>   		if (!idx_gc) {
>   			err = -ENOMEM;
> 
BTW, the following modifications may be what you want?
diff --git a/fs/ubifs/gc.c b/fs/ubifs/gc.c
index 7cc22d7317ea..b1f276599b04 100644
--- a/fs/ubifs/gc.c
+++ b/fs/ubifs/gc.c
@@ -895,10 +895,6 @@ int ubifs_gc_start_commit(struct ubifs_info *c)
         /* Record index freeable LEBs for unmapping after commit */
         while (1) {
                 lp = ubifs_fast_find_frdi_idx(c);
-               if (!lp) {
-                       err = -ENOMEM;
-                       goto out;
-               }
                 if (!lp)
                         break;
                 idx_gc = kmalloc(sizeof(struct ubifs_gced_idx_leb), 
GFP_NOFS);
