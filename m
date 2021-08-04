Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01353E0882
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 21:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbhHDTOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 15:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhHDTOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 15:14:37 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF815C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 12:14:24 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id bh26so2507847oib.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 12:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UZonuGJ8VkYNHwmXwXzIo4frsEbKWL+ZSdo9g+DHA+s=;
        b=jz0juuoU5oMYzXMJnZ49V1KjTBb+/sIFW7jz62HZdyMUEb6ax/HZvcaExC+rpi5ebb
         O4qFAPqcUGhO2EHXke5ZQJBTi8DMnlXEJEkql3dz2BJ2Vocny2cHiaZhLA7edonIKISr
         Eoli/andtyxutBhtc7hsumpL5sD54uL41Rxcjsc7qQMLATHDL9FhYDK/lqTIPLk2mM/h
         uM/weRUDD3FxCTiOF0X2fPhjGTFNfVClHS7PKisHl5Xxqe2DL+ylFtzOQSWE93JzC1IT
         kNEtBExtz1rrEAd6Oq4Iuzf81G6kLsu8jwoV5omz/8VMu+fNaBBx/czEfhKanjJJI1tV
         KqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=UZonuGJ8VkYNHwmXwXzIo4frsEbKWL+ZSdo9g+DHA+s=;
        b=YPtlWxQoI/Nd3Px0aBeMDbfZblFS8UVYd1jxvSHjOWksF3iNhXBHsBAzkPuXc17ejY
         GgXP5Tp7PfCI25AD3uJekw88jQhkoBoi4XWWwKH+/nXJ4U0jHgiFEa6zC7AD19qbR0Ke
         PdkHgrv+iLtaaQiISSf0dfs3t43UNqcIR6wa9rhuC5B0v4L/sAkuSvtffpaT6rbqBd6l
         RRWVqkLBbqLNhxpq7BXX/WWyhj3oiZXQjEVp9t+3Tp7Oy99/euuT9hfX9X/X1VTPqFCQ
         dEpw//fyy00mudgU9fXudb0f01Qw0toPIMKTSl8UdOkXdPHUgVt2FPCKcIHPYJlyl9aj
         O5vA==
X-Gm-Message-State: AOAM533s0V8d3HyoTeJLw+EVX0+cKiHCotdT9pFnPmEUmo/Lji8WxK4u
        FmGW3D8k/xRpUlnLSP85NZk=
X-Google-Smtp-Source: ABdhPJxboCfMPqjCisomWfpecWMmEdOgxl4PfC8mdqkDA0MH0QfqzXXVd6QFY8P9gB/pG3tXSRvCVQ==
X-Received: by 2002:a05:6808:695:: with SMTP id k21mr723188oig.52.1628104463383;
        Wed, 04 Aug 2021 12:14:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x8sm450927oof.27.2021.08.04.12.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 12:14:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 4 Aug 2021 12:14:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH -next/-mmotm] kernel/user.c: fix build when POLL not
 enabled
Message-ID: <20210804191421.GA1900577@roeck-us.net>
References: <20210803204609.32329-1-rdunlap@infradead.org>
 <1628051945.fens3r99ox.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1628051945.fens3r99ox.astroid@bobo.none>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 02:59:23PM +1000, Nicholas Piggin wrote:
> Excerpts from Randy Dunlap's message of August 4, 2021 6:46 am:
> > Fix build errors in kernel/user.c when CONFIG_EPOLL is not set/enabled.
> > 
> > ../kernel/user.c: In function ‘free_user’:
> > ../kernel/user.c:141:30: error: ‘struct user_struct’ has no member named ‘epoll_watches’; did you mean ‘nr_watches’?
> >   percpu_counter_destroy(&up->epoll_watches);
> >                               ^~~~~~~~~~~~~
> > In file included from ../include/linux/sched/user.h:7:0,
> >                  from ../kernel/user.c:17:
> > ../kernel/user.c: In function ‘alloc_uid’:
> > ../kernel/user.c:189:33: error: ‘struct user_struct’ has no member named ‘epoll_watches’; did you mean ‘nr_watches’?
> >    if (percpu_counter_init(&new->epoll_watches, 0, GFP_KERNEL)) {
> >                                  ^
> > ../kernel/user.c:203:33: error: ‘struct user_struct’ has no member named ‘epoll_watches’; did you mean ‘nr_watches’?
> >     percpu_counter_destroy(&new->epoll_watches);
> >                                  ^~~~~~~~~~~~~
> > In file included from ../include/linux/sched/user.h:7:0,
> >                  from ../kernel/user.c:17:
> > ../kernel/user.c: In function ‘uid_cache_init’:
> > ../kernel/user.c:225:37: error: ‘struct user_struct’ has no member named ‘epoll_watches’; did you mean ‘nr_watches’?
> >   if (percpu_counter_init(&root_user.epoll_watches, 0, GFP_KERNEL))
> >                                      ^
> > Also fix type: "cpunter" -> "counter" in a panic message.
> 
> Gah, thanks Randy. The ifdefs aren't horrible but could I suggest a 
> slight tweak?
> 
> --
> From: Randy Dunlap <rdunlap@infradead.org>
> Subject: [PATCH] kernel/user.c: fix build when EPOLL not enabled
> 
> Fix build errors in kernel/user.c when CONFIG_EPOLL is not set/enabled.
> 
> ../kernel/user.c: In function ‘free_user’:
> ../kernel/user.c:141:30: error: ‘struct user_struct’ has no member named ‘epoll_watches’; did you mean ‘nr_watches’?
>   percpu_counter_destroy(&up->epoll_watches);
>                               ^~~~~~~~~~~~~
> In file included from ../include/linux/sched/user.h:7:0,
>                  from ../kernel/user.c:17:
> ../kernel/user.c: In function ‘alloc_uid’:
> ../kernel/user.c:189:33: error: ‘struct user_struct’ has no member named ‘epoll_watches’; did you mean ‘nr_watches’?
>    if (percpu_counter_init(&new->epoll_watches, 0, GFP_KERNEL)) {
>                                  ^
> ../kernel/user.c:203:33: error: ‘struct user_struct’ has no member named ‘epoll_watches’; did you mean ‘nr_watches’?
>     percpu_counter_destroy(&new->epoll_watches);
>                                  ^~~~~~~~~~~~~
> In file included from ../include/linux/sched/user.h:7:0,
>                  from ../kernel/user.c:17:
> ../kernel/user.c: In function ‘uid_cache_init’:
> ../kernel/user.c:225:37: error: ‘struct user_struct’ has no member named ‘epoll_watches’; did you mean ‘nr_watches’?
>   if (percpu_counter_init(&root_user.epoll_watches, 0, GFP_KERNEL))
>                                      ^
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
>  kernel/user.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/user.c b/kernel/user.c
> index a2673f940506..57d53568cb33 100644
> --- a/kernel/user.c
> +++ b/kernel/user.c
> @@ -129,6 +129,21 @@ static struct user_struct *uid_hash_find(kuid_t uid, struct hlist_head *hashent)
>  	return NULL;
>  }
>  
> +static int user_epoll_alloc(struct user_struct *up)
> +{
> +#ifdef CONFIG_EPOLL
> +	return percpu_counter_init(&up->epoll_watches, 0, GFP_KERNEL);
> +#endif
> +	return 0;

#else
	return 0;
#endif

> +}
> +
> +static void user_epoll_free(struct user_struct *up)
> +{
> +#ifdef CONFIG_EPOLL
> +	percpu_counter_destroy(&up->epoll_watches);
> +#endif
> +}
> +
>  /* IRQs are disabled and uidhash_lock is held upon function entry.
>   * IRQ state (as stored in flags) is restored and uidhash_lock released
>   * upon function exit.
> @@ -138,7 +153,7 @@ static void free_user(struct user_struct *up, unsigned long flags)
>  {
>  	uid_hash_remove(up);
>  	spin_unlock_irqrestore(&uidhash_lock, flags);
> -	percpu_counter_destroy(&up->epoll_watches);
> +	user_epoll_free(up);
>  	kmem_cache_free(uid_cachep, up);
>  }
>  
> @@ -186,7 +201,7 @@ struct user_struct *alloc_uid(kuid_t uid)
>  
>  		new->uid = uid;
>  		refcount_set(&new->__count, 1);
> -		if (percpu_counter_init(&new->epoll_watches, 0, GFP_KERNEL)) {
> +		if (user_epoll_alloc(new)) {
>  			kmem_cache_free(uid_cachep, new);
>  			return NULL;
>  		}
> @@ -200,7 +215,7 @@ struct user_struct *alloc_uid(kuid_t uid)
>  		spin_lock_irq(&uidhash_lock);
>  		up = uid_hash_find(uid, hashent);
>  		if (up) {
> -			percpu_counter_destroy(&new->epoll_watches);
> +			user_epoll_free(new);
>  			kmem_cache_free(uid_cachep, new);
>  		} else {
>  			uid_hash_insert(new, hashent);
> @@ -222,8 +237,8 @@ static int __init uid_cache_init(void)
>  	for(n = 0; n < UIDHASH_SZ; ++n)
>  		INIT_HLIST_HEAD(uidhash_table + n);
>  
> -	if (percpu_counter_init(&root_user.epoll_watches, 0, GFP_KERNEL))
> -		panic("percpu cpunter alloc failed");
> +	if (user_epoll_alloc(&root_user))
> +		panic("root_user epoll percpu counter alloc failed");
>  
>  	/* Insert the root user immediately (init already runs as root) */
>  	spin_lock_irq(&uidhash_lock);
> -- 
> 2.23.0
> 
