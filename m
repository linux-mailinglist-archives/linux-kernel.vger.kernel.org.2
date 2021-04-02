Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83222352DA7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbhDBQVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 12:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhDBQVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 12:21:52 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CB9C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 09:21:51 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id f12so4017881qtq.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 09:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FUlQRD9aV+zj7opu6rOthM9Q96oqDVj/1tA3QisClZE=;
        b=Q8rZcY0UMPsGT+S2mqGboscTi6d1sChA2xWs9Yeoa+ybEH/xfXuwlFZZM2GVtqSDfM
         W8NsBSeZy8vsmH+t8bmpQAhi0BNW1Zs1fIU3CmbsgwWJpmY+HhDgqRek9jvTDKptwRZD
         J9gRRUbwiR+d17DeD0KcDCxHcmNdlSmDjKgQzmzf5V8PFXBzeLWy5mKllovPGyV1ZuDm
         mD4PfUS7I9z0fIQ28qOLokYndjq3xrvr0Y+s8iSZeNBy9RjEPy9zTzSYHc6SxE/tZZbH
         aBjRx96p1nHZC97VaedkdUhePGqtyNupQr1e8t2RIsPEc4oaU0mkADLL4umnqTYfrXVj
         vBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FUlQRD9aV+zj7opu6rOthM9Q96oqDVj/1tA3QisClZE=;
        b=FcOUGFIotMpxec3uz90WIGDdYfaoxLxfw1IB71UivRVW2RuYqy+zjoiw62459dR+ys
         JdFnpOekX7STrC9my/sbpIhR+Uod6v7Z/MnA3JxdoxU0o9IN80j2tYqMbMcItBUubLQu
         QYYaPCV5lpzRcUPe8skF0Xpc8Q/mgyQrY+oOP8mu/TkjXdmRLxgKr7A0T7LbgHZJ7NOf
         kT1gCo9XRFM8oBtfGV0JCVemwtvjQjplzLnPlXqLbJRWKR8/sEBSjVYvPpo58HCVgz4p
         UhUIL/qFcSydexPPQmz3w7zhBqzOhQEubr/Uj1J3GJcGPpQEl47dA+R6ZDeelSLqQ7x1
         zHJg==
X-Gm-Message-State: AOAM531TAIehxJArmMsMw0ytELO2MMnkeafU8U+zFchN9AgK509mwaON
        7m/qsGllpEyXMvJu/a1elyjEjw==
X-Google-Smtp-Source: ABdhPJx+EhVROckOcijsC7PVaDR3aHTqp3e5bbq3r/xHLQ9dqvsXI9ytw9bIJ2Z/TSwtMnLbFJYhxw==
X-Received: by 2002:ac8:6690:: with SMTP id d16mr12250066qtp.312.1617380510240;
        Fri, 02 Apr 2021 09:21:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:8ca7])
        by smtp.gmail.com with ESMTPSA id j15sm7284831qtr.34.2021.04.02.09.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 09:21:49 -0700 (PDT)
Date:   Fri, 2 Apr 2021 12:21:48 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, mhocko@kernel.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Hugh Dickins <hughd@google.com>
Subject: Re: [RFC PATCH 04/15] mm: memcontrol: use lruvec_memcg in
 lruvec_holds_page_lru_lock
Message-ID: <YGdEnN6WkKbNp1QJ@cmpxchg.org>
References: <20210330101531.82752-1-songmuchun@bytedance.com>
 <20210330101531.82752-5-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330101531.82752-5-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 06:15:20PM +0800, Muchun Song wrote:
> We already have a helper lruvec_memcg() to get the memcg from lruvec, we
> do not need to do it ourselves in the lruvec_holds_page_lru_lock(). So use
> lruvec_memcg() instead.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/memcontrol.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index a35a22994cf7..6e3283828391 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -744,20 +744,20 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
>  	return mem_cgroup_lruvec(memcg, pgdat);
>  }
>  
> +static inline struct mem_cgroup *lruvec_memcg(struct lruvec *lruvec);

Please reorder the functions instead to avoid forward decls.

>  static inline bool lruvec_holds_page_lru_lock(struct page *page,
>  					      struct lruvec *lruvec)
>  {
>  	pg_data_t *pgdat = page_pgdat(page);
>  	const struct mem_cgroup *memcg;
> -	struct mem_cgroup_per_node *mz;
>  
>  	if (mem_cgroup_disabled())
>  		return lruvec == &pgdat->__lruvec;
>  
> -	mz = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
>  	memcg = page_memcg(page) ? : root_mem_cgroup;
>  
> -	return lruvec->pgdat == pgdat && mz->memcg == memcg;
> +	return lruvec->pgdat == pgdat && lruvec_memcg(lruvec) == memcg;

Looks reasonable to me, but I wonder if there is more we can do.

lruvec_memcg() already handles CONFIG_MEMCG and mem_cgroup_disabled()
combinations, and there is also a lruvec_pgdat() which does.

One thing that is odd is page_memcg(page) ? : root_mem_cgroup. How can
lruvec pages not have a page_memcg()? mem_cgroup_page_lruvec() has:

	memcg = page_memcg(page);
	VM_WARN_ON_ONCE_PAGE(!memcg && !mem_cgroup_disabled(), page);

Unless I'm missing something, we should be able to have a single
definition for this function that works for !CONFIG_MEMCG,
CONFIG_MEMCG + mem_cgroup_disabled() and CONFIG_MEMCG:

lruvec_holds_page_lru_lock()
{
	return lruvec_pgdat(lruvec) == page_pgdat(page) &&
		lruvec_memcg(lruvec) == page_memcg(page);
}
