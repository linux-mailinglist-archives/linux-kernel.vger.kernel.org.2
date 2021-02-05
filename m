Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E701310FD0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbhBEQlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbhBEQeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:34:04 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0E5C0613D6
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 10:15:42 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id z32so5627373qtd.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 10:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XIgSkeXWHW1iLdxhmfSy4vGDVypEJJKaTvz/+TUywfw=;
        b=h3S3h+C3rXQ+iT7q44q8ThSjMNuxNz+xsM6CGSL6Hj4noskqYapqnJM+rdc1eRECvH
         YkiJQTBjKNdep/452yExfB/n2Ii3ypd4q5ygcUoCf6F9MqWu+QhyTOLVwBaD0wn9Tgmr
         RAl69uYMB36ucKfSVfiJ9xaRs8GnZ08lcc/Dt+lxnxmsHDKs2qNvtekBQiFaNA1arh/+
         d8Vi0Y9FC0tl7fLu7RewHBz+sKCM4lmOo79AayMW2O46Bv+Jp9OsX+yHzqITi+ATTrTG
         IxVYgTLTp6yp60AJUZ3IQwBltqRHOtugETh+kS/2HwuFjfXHCPsxmasmaoTlXfIZXn6c
         P0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XIgSkeXWHW1iLdxhmfSy4vGDVypEJJKaTvz/+TUywfw=;
        b=o+LyPPAiSTh33+K5aiAE9c7uDQZBl0+4jn1N3f83YmxT0PlZOK2/6C2H/uk+tbAJjO
         sAUEzTYl6GzygRdG3AIR014GAVccRrkNxOzUFdAjyDLu1OP1JPcuCw7f2pccNwM+vMtz
         siIawaOdcVM3qO3byxDsh8SSPiVmMpSTod5qxKZa9Jizc0TJl2eTMh+5LFe5hrC03pex
         qwTvYeja9F/+/CAptCsTSIUh366ejkOEe1DFTCQK/aZVPlLX5A8lAo+/7hDDVvCS44lo
         G13A/nJEGFNqoVG2l6PwyaXi4ys1jEU46g54noMVxRw5BRoEow8owtfQNtTL6vfnHvDd
         v4rA==
X-Gm-Message-State: AOAM533gSFCxusNRmQ8r3bfBrJJuu12VQYisNgsFB7zdKK0MAKc4dW/S
        TEhEQdpmeUkdmhJxLa8lzaCEbg==
X-Google-Smtp-Source: ABdhPJynku4WsNlWNkLqPPMEO+1WL/Aj8gCdIhU0G1o/UHEQQuwkMIOX7PU1QvPU2jXKenGmJv5YYA==
X-Received: by 2002:ac8:480b:: with SMTP id g11mr5306250qtq.290.1612548941572;
        Fri, 05 Feb 2021 10:15:41 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id x62sm5248278qkd.1.2021.02.05.10.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 10:15:40 -0800 (PST)
Date:   Fri, 5 Feb 2021 13:15:40 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: remove rcu_read_lock from
 get_mem_cgroup_from_page
Message-ID: <YB2LTIeTPN72Xrxj@cmpxchg.org>
References: <20210205062719.74431-1-songmuchun@bytedance.com>
 <YB0DnAlCaQza4Uf9@dhcp22.suse.cz>
 <CAMZfGtVhBrwgkJVwiah6eDsppSf8fYp+uZ=tZmHBLDFeTmQX3w@mail.gmail.com>
 <YB0euLiMU+T/9bMK@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YB0euLiMU+T/9bMK@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 11:32:24AM +0100, Michal Hocko wrote:
> On Fri 05-02-21 17:14:30, Muchun Song wrote:
> > On Fri, Feb 5, 2021 at 4:36 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Fri 05-02-21 14:27:19, Muchun Song wrote:
> > > > The get_mem_cgroup_from_page() is called under page lock, so the page
> > > > memcg cannot be changed under us.
> > >
> > > Where is the page lock enforced?
> > 
> > Because it is called from alloc_page_buffers(). This path is under
> > page lock.
> 
> I do not see any page lock enforecement there. There is not even a
> comment requiring that. Can we grow more users where this is not the
> case? There is no actual relation between alloc_page_buffers and
> get_mem_cgroup_from_page except that the former is the only _current_
> existing user. I would be careful to dictate locking based solely on
> that.

Since alloc_page_buffers() holds the page lock throughout the entire
time it uses the memcg, there is no actual reason for it to use RCU or
even acquire an additional reference on the css. We know it's pinned,
the charge pins it, and the page lock pins the charge. It can neither
move to a different cgroup nor be uncharged.

So what do you say we switch alloc_page_buffers() to page_memcg()?

And because that removes the last user of get_mem_cgroup_from_page(),
we can kill it off and worry about a good interface once a consumer
materializes for it.

diff --git a/fs/buffer.c b/fs/buffer.c
index 96c7604f69b3..12a10f461b81 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -847,7 +847,7 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 	if (retry)
 		gfp |= __GFP_NOFAIL;
 
-	memcg = get_mem_cgroup_from_page(page);
+	memcg = page_memcg(page);
 	old_memcg = set_active_memcg(memcg);
 
 	head = NULL;
@@ -868,7 +868,6 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 	}
 out:
 	set_active_memcg(old_memcg);
-	mem_cgroup_put(memcg);
 	return head;
 /*
  * In case anything failed, we just free everything we got.
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a8c7a0ccc759..a44b2d51aecc 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -687,8 +687,6 @@ struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
 
 struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
 
-struct mem_cgroup *get_mem_cgroup_from_page(struct page *page);
-
 struct lruvec *lock_page_lruvec(struct page *page);
 struct lruvec *lock_page_lruvec_irq(struct page *page);
 struct lruvec *lock_page_lruvec_irqsave(struct page *page,
@@ -1169,11 +1167,6 @@ static inline struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 	return NULL;
 }
 
-static inline struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
-{
-	return NULL;
-}
-
 static inline void mem_cgroup_put(struct mem_cgroup *memcg)
 {
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 490357945f2c..ff52550d2f65 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1048,29 +1048,6 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 }
 EXPORT_SYMBOL(get_mem_cgroup_from_mm);
 
-/**
- * get_mem_cgroup_from_page: Obtain a reference on given page's memcg.
- * @page: page from which memcg should be extracted.
- *
- * Obtain a reference on page->memcg and returns it if successful. Otherwise
- * root_mem_cgroup is returned.
- */
-struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
-{
-	struct mem_cgroup *memcg = page_memcg(page);
-
-	if (mem_cgroup_disabled())
-		return NULL;
-
-	rcu_read_lock();
-	/* Page should not get uncharged and freed memcg under us. */
-	if (!memcg || WARN_ON_ONCE(!css_tryget(&memcg->css)))
-		memcg = root_mem_cgroup;
-	rcu_read_unlock();
-	return memcg;
-}
-EXPORT_SYMBOL(get_mem_cgroup_from_page);
-
 static __always_inline struct mem_cgroup *active_memcg(void)
 {
 	if (in_interrupt())
