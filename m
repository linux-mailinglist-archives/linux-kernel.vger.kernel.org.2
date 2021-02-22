Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F143A320F3E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 02:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhBVBpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 20:45:43 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12560 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbhBVBpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 20:45:41 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DkQ1G0XTMzMccn;
        Mon, 22 Feb 2021 09:42:58 +0800 (CST)
Received: from [10.174.179.140] (10.174.179.140) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Mon, 22 Feb 2021 09:44:53 +0800
Subject: Re: [PATCH] mm: Use rcu_dereference in in_vfork
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20210221194207.1351703-1-willy@infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <28850db2-687d-e604-2bd3-3a72344c1e7d@huawei.com>
Date:   Mon, 22 Feb 2021 09:44:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210221194207.1351703-1-willy@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.140]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/22 3:42, Matthew Wilcox (Oracle) wrote:
> Fix a sparse warning by using rcu_dereference().  Technically this is a
> bug and a sufficiently aggressive compiler could reload the `real_parent'
> pointer outside the protection of the rcu lock (and access freed memory),
> but I think it's pretty unlikely to happen.
> 
> Fixes: b18dc5f291c0 ("mm, oom: skip vforked tasks from being selected")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good to me. Thanks!
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> ---
>  include/linux/sched/mm.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 1ae08b8462a4..90b2a0bce11c 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -140,7 +140,8 @@ static inline bool in_vfork(struct task_struct *tsk)
>  	 * another oom-unkillable task does this it should blame itself.
>  	 */
>  	rcu_read_lock();
> -	ret = tsk->vfork_done && tsk->real_parent->mm == tsk->mm;
> +	ret = tsk->vfork_done &&
> +			rcu_dereference(tsk->real_parent)->mm == tsk->mm;
>  	rcu_read_unlock();
>  
>  	return ret;
> 

