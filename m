Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239273DFAEE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 07:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbhHDFJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 01:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhHDFJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 01:09:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF3FC0613D5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 22:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=x2kveh6MX8WtvBCZHJLiO2ubdj35EJ/bK6xFlP58AM0=; b=EcUr6r2kiwO98YS4yCDVWJSCTj
        OmZq+ocMZHLs55m53dYBvYG1gQGfk6CwVIoahemncr6ApbVRc00/frS3brqwV3mbR8otrb5D2ip9X
        XLGi49dvTmDBxnHGpvE/Sl1G0akbZDB7UAT4+kBFTNkilKVr0nCQsO5QErrW/hXN7V9+PF45Qtrgq
        iBZRxqWpP8KOC+GyYRgPCyAhaEmcSec/cGY6+ecu5mz7/vyuG6osoqIfiyKn27ZcaGBlXZ330bfas
        upwjTU7rVZKZxIeEce82ro5ufRroPjhUbYvn4+EtLP9Gk/8PfRhx7u6vfQYjHxCfRttSOquK2KUx+
        xxi6d6lg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mB99N-005Qpl-1i; Wed, 04 Aug 2021 05:09:14 +0000
Subject: Re: [PATCH -next/-mmotm] kernel/user.c: fix build when POLL not
 enabled
To:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>
References: <20210803204609.32329-1-rdunlap@infradead.org>
 <1628051945.fens3r99ox.astroid@bobo.none>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <06ea8c29-ed66-7014-53bd-7760b7eac632@infradead.org>
Date:   Tue, 3 Aug 2021 22:09:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1628051945.fens3r99ox.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/21 9:59 PM, Nicholas Piggin wrote:
> Excerpts from Randy Dunlap's message of August 4, 2021 6:46 am:
>> Fix build errors in kernel/user.c when CONFIG_EPOLL is not set/enabled.
>>
>> ../kernel/user.c: In function ‘free_user’:
>> ../kernel/user.c:141:30: error: ‘struct user_struct’ has no member named ‘epoll_watches’; did you mean ‘nr_watches’?
>>    percpu_counter_destroy(&up->epoll_watches);
>>                                ^~~~~~~~~~~~~
>> In file included from ../include/linux/sched/user.h:7:0,
>>                   from ../kernel/user.c:17:
>> ../kernel/user.c: In function ‘alloc_uid’:
>> ../kernel/user.c:189:33: error: ‘struct user_struct’ has no member named ‘epoll_watches’; did you mean ‘nr_watches’?
>>     if (percpu_counter_init(&new->epoll_watches, 0, GFP_KERNEL)) {
>>                                   ^
>> ../kernel/user.c:203:33: error: ‘struct user_struct’ has no member named ‘epoll_watches’; did you mean ‘nr_watches’?
>>      percpu_counter_destroy(&new->epoll_watches);
>>                                   ^~~~~~~~~~~~~
>> In file included from ../include/linux/sched/user.h:7:0,
>>                   from ../kernel/user.c:17:
>> ../kernel/user.c: In function ‘uid_cache_init’:
>> ../kernel/user.c:225:37: error: ‘struct user_struct’ has no member named ‘epoll_watches’; did you mean ‘nr_watches’?
>>    if (percpu_counter_init(&root_user.epoll_watches, 0, GFP_KERNEL))
>>                                       ^
>> Also fix type: "cpunter" -> "counter" in a panic message.
> 
> Gah, thanks Randy. The ifdefs aren't horrible but could I suggest a
> slight tweak?

Sure, no problem. Thanks.

> 
> --
> From: Randy Dunlap <rdunlap@infradead.org>
> Subject: [PATCH] kernel/user.c: fix build when EPOLL not enabled
> 
> Fix build errors in kernel/user.c when CONFIG_EPOLL is not set/enabled.
> 
> ../kernel/user.c: In function ‘free_user’:
> ../kernel/user.c:141:30: error: ‘struct user_struct’ has no member named ‘epoll_watches’; did you mean ‘nr_watches’?
>    percpu_counter_destroy(&up->epoll_watches);
>                                ^~~~~~~~~~~~~
> In file included from ../include/linux/sched/user.h:7:0,
>                   from ../kernel/user.c:17:
> ../kernel/user.c: In function ‘alloc_uid’:
> ../kernel/user.c:189:33: error: ‘struct user_struct’ has no member named ‘epoll_watches’; did you mean ‘nr_watches’?
>     if (percpu_counter_init(&new->epoll_watches, 0, GFP_KERNEL)) {
>                                   ^
> ../kernel/user.c:203:33: error: ‘struct user_struct’ has no member named ‘epoll_watches’; did you mean ‘nr_watches’?
>      percpu_counter_destroy(&new->epoll_watches);
>                                   ^~~~~~~~~~~~~
> In file included from ../include/linux/sched/user.h:7:0,
>                   from ../kernel/user.c:17:
> ../kernel/user.c: In function ‘uid_cache_init’:
> ../kernel/user.c:225:37: error: ‘struct user_struct’ has no member named ‘epoll_watches’; did you mean ‘nr_watches’?
>    if (percpu_counter_init(&root_user.epoll_watches, 0, GFP_KERNEL))
>                                       ^
> Also fix type: "cpunter" -"counter" in a panic message.
> 
> Fixes: e75b89477811 ("fs/epoll: use a per-cpu counter for user's watches count")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> [np: move ifdefs into wrapper functions, slightly improve panic message]
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nick Piggin <npiggin@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> ---
>   kernel/user.c | 25 ++++++++++++++++++++-----
>   1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/user.c b/kernel/user.c
> index a2673f940506..57d53568cb33 100644
> --- a/kernel/user.c
> +++ b/kernel/user.c
> @@ -129,6 +129,21 @@ static struct user_struct *uid_hash_find(kuid_t uid, struct hlist_head *hashent)
>   	return NULL;
>   }
>   
> +static int user_epoll_alloc(struct user_struct *up)
> +{
> +#ifdef CONFIG_EPOLL
> +	return percpu_counter_init(&up->epoll_watches, 0, GFP_KERNEL);
> +#endif
> +	return 0;
> +}
> +
> +static void user_epoll_free(struct user_struct *up)
> +{
> +#ifdef CONFIG_EPOLL
> +	percpu_counter_destroy(&up->epoll_watches);
> +#endif
> +}
> +
>   /* IRQs are disabled and uidhash_lock is held upon function entry.
>    * IRQ state (as stored in flags) is restored and uidhash_lock released
>    * upon function exit.
> @@ -138,7 +153,7 @@ static void free_user(struct user_struct *up, unsigned long flags)
>   {
>   	uid_hash_remove(up);
>   	spin_unlock_irqrestore(&uidhash_lock, flags);
> -	percpu_counter_destroy(&up->epoll_watches);
> +	user_epoll_free(up);
>   	kmem_cache_free(uid_cachep, up);
>   }
>   
> @@ -186,7 +201,7 @@ struct user_struct *alloc_uid(kuid_t uid)
>   
>   		new->uid = uid;
>   		refcount_set(&new->__count, 1);
> -		if (percpu_counter_init(&new->epoll_watches, 0, GFP_KERNEL)) {
> +		if (user_epoll_alloc(new)) {
>   			kmem_cache_free(uid_cachep, new);
>   			return NULL;
>   		}
> @@ -200,7 +215,7 @@ struct user_struct *alloc_uid(kuid_t uid)
>   		spin_lock_irq(&uidhash_lock);
>   		up = uid_hash_find(uid, hashent);
>   		if (up) {
> -			percpu_counter_destroy(&new->epoll_watches);
> +			user_epoll_free(new);
>   			kmem_cache_free(uid_cachep, new);
>   		} else {
>   			uid_hash_insert(new, hashent);
> @@ -222,8 +237,8 @@ static int __init uid_cache_init(void)
>   	for(n = 0; n < UIDHASH_SZ; ++n)
>   		INIT_HLIST_HEAD(uidhash_table + n);
>   
> -	if (percpu_counter_init(&root_user.epoll_watches, 0, GFP_KERNEL))
> -		panic("percpu cpunter alloc failed");
> +	if (user_epoll_alloc(&root_user))
> +		panic("root_user epoll percpu counter alloc failed");
>   
>   	/* Insert the root user immediately (init already runs as root) */
>   	spin_lock_irq(&uidhash_lock);
> 


-- 
~Randy

