Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720983599C9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbhDIJsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:48:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16510 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhDIJsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:48:42 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGtY03JgDzPnX8;
        Fri,  9 Apr 2021 17:45:40 +0800 (CST)
Received: from [10.174.178.48] (10.174.178.48) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 17:48:20 +0800
Subject: Re: [PATCH -next] dlm: use DEFINE_MUTEX() for mutex lock
To:     Ye Bin <yebin10@huawei.com>,
        Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>
CC:     <cluster-devel@redhat.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
References: <20210409095139.2293922-1-yebin10@huawei.com>
From:   "weiyongjun (A)" <weiyongjun1@huawei.com>
Message-ID: <ea193d44-5416-66ff-6749-5a77a1661901@huawei.com>
Date:   Fri, 9 Apr 2021 17:48:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210409095139.2293922-1-yebin10@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.48]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

两个标题一样的可以合并

在 2021/4/9 17:51, Ye Bin 写道:
> mutex lock can be initialized automatically with DEFINE_MUTEX()
> rather than explicitly calling mutex_init().
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>   fs/dlm/lockspace.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
> index c14cf2b7faab..fa3ae801aa43 100644
> --- a/fs/dlm/lockspace.c
> +++ b/fs/dlm/lockspace.c
> @@ -26,7 +26,7 @@
>   #include "ast.h"
>   
>   static int			ls_count;
> -static struct mutex		ls_lock;
> +static DEFINE_MUTEX(ls_lock);
>   static struct list_head		lslist;
>   static spinlock_t		lslist_lock;
>   static struct task_struct *	scand_task;
> @@ -231,7 +231,6 @@ static const struct kset_uevent_ops dlm_uevent_ops = {
>   int __init dlm_lockspace_init(void)
>   {
>   	ls_count = 0;
> -	mutex_init(&ls_lock);
>   	INIT_LIST_HEAD(&lslist);
>   	spin_lock_init(&lslist_lock);
>   
>
