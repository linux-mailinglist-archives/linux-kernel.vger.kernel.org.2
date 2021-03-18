Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380753408BC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhCRPYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhCRPXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:23:50 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9929C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:23:49 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id d20so2366278qkc.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=83eSfMshydOehdsQas9XVeyiqjOb6ETR5e73nz99axM=;
        b=FNs7oGhmem/QqkDrdV/bSV0IrY6lwraMRbypnquZjTYMqSPez0sxTQMUgXb3xR+tkt
         c+/Kmqf1+nBgWgVev7X8BpTA8pZnJGJ0QH3oHhb/V0IbKKhPfqZAxJNFL1amw2h8pdJC
         P3psE1zU5P3VFHUf7sMO+b43jQwMWtWMF0wN/7mT2w/b0aLLBhNbVQim3LSMNoy5x0wv
         yb8IqIWtslHSVVt5cKwbFB/GVNVjm8yAnjfHX7ESih022t1rZUNF2iUHQG9SReH9s8OV
         XdqzdX1C+/2qqbZ1hJhmYB3QfjiA/HHll4Zd9zZL7MyLpWb7VF8WAhjTL92bYkt6dax+
         WFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=83eSfMshydOehdsQas9XVeyiqjOb6ETR5e73nz99axM=;
        b=L+bhdDqd2DPD6jPUxCWTPbHwCmQx9IekGZ4l0s1HTbZuELLRewcDZ+pwVyYo/GAPQW
         a5cwt7Ls9YBuW98LAyxEGKMbiHinVNCc77ecCR8RI+3PA9O62ioCU03vXHjKN0FAyVFk
         MRgpV7dJfSGu3XiIDhEgR42FOn6zN4pp35dS/3ibGeKGL8fNlV/QTaePJo3QimcVbNg4
         7AfXmmWr6G2KctoZgpY+FcjgFl0fjTlQ8Fx0fiRhv0nX1EEeefIhHv2nStrSJDbulZrj
         CfbU6VwYam4Q+r8EUYEgK9JMmRBuHjAG0RGlngvK0j3/PT9nxoCFGPaKeT3gKSPSsKxH
         kGXA==
X-Gm-Message-State: AOAM533pq7mrhGI/EOWvfL9cqBDiEOBlci3dgaqJwEPeEE7kt3Zgz4yk
        UTdI5MwCJ27/E49yhRBuldkpvA==
X-Google-Smtp-Source: ABdhPJwmywL6WZSKRco5PsaSF2jLsPauxK+yvfTRzPnity0ONAhCMbUrBMzI0Qgl2cX+fLYv1aVgHw==
X-Received: by 2002:a05:620a:1502:: with SMTP id i2mr4826610qkk.373.1616081028824;
        Thu, 18 Mar 2021 08:23:48 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e46c])
        by smtp.gmail.com with ESMTPSA id 30sm1624852qta.38.2021.03.18.08.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:23:48 -0700 (PDT)
Date:   Thu, 18 Mar 2021 11:23:47 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, mhocko@kernel.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com
Subject: Re: [PATCH v4 4/5] mm: memcontrol: use obj_cgroup APIs to charge
 kmem pages
Message-ID: <YFNwg8pw+44EgvEB@cmpxchg.org>
References: <20210318110658.60892-1-songmuchun@bytedance.com>
 <20210318110658.60892-5-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318110658.60892-5-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 07:06:57PM +0800, Muchun Song wrote:
> Since Roman series "The new cgroup slab memory controller" applied. All
> slab objects are charged via the new APIs of obj_cgroup. The new APIs
> introduce a struct obj_cgroup to charge slab objects. It prevents
> long-living objects from pinning the original memory cgroup in the memory.
> But there are still some corner objects (e.g. allocations larger than
> order-1 page on SLUB) which are not charged via the new APIs. Those
> objects (include the pages which are allocated from buddy allocator
> directly) are charged as kmem pages which still hold a reference to
> the memory cgroup.
> 
> We want to reuse the obj_cgroup APIs to charge the kmem pages.
> If we do that, we should store an object cgroup pointer to
> page->memcg_data for the kmem pages.
> 
> Finally, page->memcg_data will have 3 different meanings.
> 
>   1) For the slab pages, page->memcg_data points to an object cgroups
>      vector.
> 
>   2) For the kmem pages (exclude the slab pages), page->memcg_data
>      points to an object cgroup.
> 
>   3) For the user pages (e.g. the LRU pages), page->memcg_data points
>      to a memory cgroup.
> 
> We do not change the behavior of page_memcg() and page_memcg_rcu().
> They are also suitable for LRU pages and kmem pages. Why?
> 
> Because memory allocations pinning memcgs for a long time - it exists
> at a larger scale and is causing recurring problems in the real world:
> page cache doesn't get reclaimed for a long time, or is used by the
> second, third, fourth, ... instance of the same job that was restarted
> into a new cgroup every time. Unreclaimable dying cgroups pile up,
> waste memory, and make page reclaim very inefficient.
> 
> We can convert LRU pages and most other raw memcg pins to the objcg
> direction to fix this problem, and then the page->memcg will always
> point to an object cgroup pointer. At that time, LRU pages and kmem
> pages will be treated the same. The implementation of page_memcg()
> will remove the kmem page check.
> 
> This patch aims to charge the kmem pages by using the new APIs of
> obj_cgroup. Finally, the page->memcg_data of the kmem page points to
> an object cgroup. We can use the __page_objcg() to get the object
> cgroup associated with a kmem page. Or we can use page_memcg()
> to get the memory cgroup associated with a kmem page, but caller must
> ensure that the returned memcg won't be released (e.g. acquire the
> rcu_read_lock or css_set_lock).
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Thanks for the updated version, looks good to me!

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
