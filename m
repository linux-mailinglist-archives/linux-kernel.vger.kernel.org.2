Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452753D89A8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 10:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbhG1IV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 04:21:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27952 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234510AbhG1IVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 04:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627460484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6gWJqZpysylhm0r71/CN5q60nzTxNxEk/7whHXN4TyA=;
        b=KNSjTgJhFN2Q3lKgEe5jhz7+3+4O6KJILLuDxlweRrO0PWdZsZkQi5AiYgXln50Gmgwfu0
        ju0OtnWj3TK/Tz7Ar+eM7JWBVQe7EesrCYsHLilffjK3ZCLj6J8QuDddii84R2K9F5hx8c
        bMi/rxQE+vrGKEivzRC8gfGtsGlHQhE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-Qdw2VUZEP7WKFksemTY9Hg-1; Wed, 28 Jul 2021 04:21:21 -0400
X-MC-Unique: Qdw2VUZEP7WKFksemTY9Hg-1
Received: by mail-wr1-f72.google.com with SMTP id o8-20020a5d4a880000b029013a10564614so619925wrq.15
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 01:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6gWJqZpysylhm0r71/CN5q60nzTxNxEk/7whHXN4TyA=;
        b=q1FawPS9y24yKeQzAZJDB4aUnLyw9jE9Zk0Ne0l4GY/mQDp1PU9syQfJRN/AT1XSV9
         FCU6uvJurr1NRjJb5SL8IgaCXYLBqd8BwM3W3zc1N6sUhDlSPrGzDciY6elaSxky8pVi
         FXtN+XCduaJacEZa4MJ+Jwh1nB7NpohmPojsL1eIA+s1jvGi6q1BiZHxw/PYOApj+t/Y
         6jamsNgjLFrbKozazkiQ5SrJ5LADfrXrZYk6r5WvtBuQLtGbn/ah7les7wa3utq3SS83
         CHj9JKfNb9/ElUHZHWGgWemIvyExxx9pfqW08H9xRp3pwGBG3fnDW4fGlXa058fsufQK
         CAAg==
X-Gm-Message-State: AOAM532RJJ2fNI9w2YGt2xBLz+FJb3W/Lm2TS9XMR46r3cZ3jxzODTRw
        vwsqqCXGY03Tu+0rB/xVv5ISNclJ56ieq8Pe2qE6zu59vIuYm7aeayt6FHbFu7FxPlK5NqWxIre
        QkWpi6vqITYodkT4rSHxAX5y+jRR9zseEl3JHgGnI4O9N7KCYV9QT5f6V2j6s2KcRSoUnFI8c
X-Received: by 2002:a05:600c:2210:: with SMTP id z16mr1463184wml.92.1627460479877;
        Wed, 28 Jul 2021 01:21:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywozPvYuAuinyeJcKYXHRgjRzubPJmW42EHxOhWmI72/fa0axCzQ3ARxBmOyn7dHEFAcgp9g==
X-Received: by 2002:a05:600c:2210:: with SMTP id z16mr1463157wml.92.1627460479606;
        Wed, 28 Jul 2021 01:21:19 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id z2sm5312534wma.45.2021.07.28.01.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 01:21:19 -0700 (PDT)
Subject: Re: [PATCH] memcg: cleanup racy sum avoidance code
To:     Shakeel Butt <shakeelb@google.com>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210728012243.3369123-1-shakeelb@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <8c35e469-b355-63b0-6cd4-ca39c39ddb79@redhat.com>
Date:   Wed, 28 Jul 2021 10:21:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210728012243.3369123-1-shakeelb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.07.21 03:22, Shakeel Butt wrote:
> We used to have per-cpu memcg and lruvec stats and the readers have to
> traverse and sum the stats from each cpu. This summing was racy and may
> expose transient negative values. So, an explicit check was added to
> avoid such scenarios. Now these stats are moved to rstat infrastructure
> and are no more per-cpu, so we can remove the fixup for transient
> negative values.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>   include/linux/memcontrol.h | 15 ++-------------
>   1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 7028d8e4a3d7..5f2a39a43d47 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -991,30 +991,19 @@ static inline void mod_memcg_state(struct mem_cgroup *memcg,
>   
>   static inline unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
>   {
> -	long x = READ_ONCE(memcg->vmstats.state[idx]);
> -#ifdef CONFIG_SMP
> -	if (x < 0)
> -		x = 0;
> -#endif
> -	return x;
> +	return READ_ONCE(memcg->vmstats.state[idx]);
>   }
>   
>   static inline unsigned long lruvec_page_state(struct lruvec *lruvec,
>   					      enum node_stat_item idx)
>   {
>   	struct mem_cgroup_per_node *pn;
> -	long x;
>   
>   	if (mem_cgroup_disabled())
>   		return node_page_state(lruvec_pgdat(lruvec), idx);
>   
>   	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> -	x = READ_ONCE(pn->lruvec_stats.state[idx]);
> -#ifdef CONFIG_SMP
> -	if (x < 0)
> -		x = 0;
> -#endif
> -	return x;
> +	return READ_ONCE(pn->lruvec_stats.state[idx]);
>   }
>   
>   static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

