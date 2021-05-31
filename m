Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4127396980
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 00:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhEaWEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 18:04:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231240AbhEaWEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 18:04:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6400610E7;
        Mon, 31 May 2021 22:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1622498551;
        bh=5ro2yd7/l1B26WTmAhjAsxZqQV6JJ76rUjTohSCFwiw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cvdQJ8ksHOiV0MC7lG4BzkGwz6r/Qt/CJ/QvMJnimlDCH0Y/QIxQfiTxOKJHJRE0z
         R9Z8YKioc1/3UC6ibdrErMbni4ybzQ4hSt6bp4nXJHv7cAod3xcIkH1UNbIrAOEn55
         VBy+hj917Gr7taSapmYi1E4Pqgb3aw7QV5UXktL4=
Date:   Mon, 31 May 2021 15:02:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Bixuan Cui <cuibixuan@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>, Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH -next v2] mm/mmap_lock: fix warning when CONFIG_TRACING
 is not defined
Message-Id: <20210531150231.2e7bfdb063db06dfdfb81a26@linux-foundation.org>
In-Reply-To: <20210531033426.74031-1-cuibixuan@huawei.com>
References: <20210531033426.74031-1-cuibixuan@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 May 2021 11:34:26 +0800 Bixuan Cui <cuibixuan@huawei.com> wrote:

> Fix the warning: [-Wunused-function]
> mm/mmap_lock.c:157:20: warning: ‘get_mm_memcg_path’ defined but not used
>  static const char *get_mm_memcg_path(struct mm_struct *mm)
>                     ^~~~~~~~~~~~~~~~~
> 
> Move get_mm_memcg_path() into #ifdef CONFIG_TRACING.

Thanks, I queued this as a fix against Mel's "mm/mmap_lock: remove dead
code for !CONFIG_TRACING configurations".


>  mm/mmap_lock.c | 60 ++++++++++++++++++++++++++------------------------
>  1 file changed, 31 insertions(+), 29 deletions(-)
> 
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index 03ee85c696ef..29e99af73144 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -142,6 +142,37 @@ static inline void put_memcg_path_buf(void)
>  	rcu_read_unlock();
>  }
>  
> +#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
> +	do {                                                                   \
> +		const char *memcg_path;                                        \
> +		preempt_disable();                                             \
> +		memcg_path = get_mm_memcg_path(mm);                            \
> +		trace_mmap_lock_##type(mm,                                     \
> +				       memcg_path != NULL ? memcg_path : "",   \
> +				       ##__VA_ARGS__);                         \
> +		if (likely(memcg_path != NULL))                                \
> +			put_memcg_path_buf();                                  \
> +		preempt_enable();                                              \
> +	} while (0)
> +
> +#else /* !CONFIG_MEMCG */
> +
> +int trace_mmap_lock_reg(void)
> +{
> +	return 0;
> +}
> +
> +void trace_mmap_lock_unreg(void)
> +{
> +}
> +
> +#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
> +	trace_mmap_lock_##type(mm, "", ##__VA_ARGS__)
> +
> +#endif /* CONFIG_MEMCG */
> +
> +#ifdef CONFIG_TRACING
> +#ifdef CONFIG_MEMCG
>  /*
>   * Write the given mm_struct's memcg path to a percpu buffer, and return a
>   * pointer to it. If the path cannot be determined, or no buffer was available
> @@ -175,37 +206,8 @@ static const char *get_mm_memcg_path(struct mm_struct *mm)
>  out:
>  	return buf;
>  }
> -
> -#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
> -	do {                                                                   \
> -		const char *memcg_path;                                        \
> -		preempt_disable();                                             \
> -		memcg_path = get_mm_memcg_path(mm);                            \
> -		trace_mmap_lock_##type(mm,                                     \
> -				       memcg_path != NULL ? memcg_path : "",   \
> -				       ##__VA_ARGS__);                         \
> -		if (likely(memcg_path != NULL))                                \
> -			put_memcg_path_buf();                                  \
> -		preempt_enable();                                              \
> -	} while (0)
> -
> -#else /* !CONFIG_MEMCG */
> -
> -int trace_mmap_lock_reg(void)
> -{
> -	return 0;
> -}
> -
> -void trace_mmap_lock_unreg(void)
> -{
> -}
> -
> -#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
> -	trace_mmap_lock_##type(mm, "", ##__VA_ARGS__)
> -
>  #endif /* CONFIG_MEMCG */
>  
> -#ifdef CONFIG_TRACING
>  /*
>   * Trace calls must be in a separate file, as otherwise there's a circular
>   * dependency between linux/mmap_lock.h and trace/events/mmap_lock.h.
> -- 
> 2.17.1
