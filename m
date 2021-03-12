Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A843399E9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 00:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbhCLXHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 18:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbhCLXHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 18:07:21 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3BEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 15:07:20 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id l4so26117577qkl.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 15:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HAWUFqDRsl0lKLydzEvVMYU91e/yIqLXEOvNq/hwJqM=;
        b=oA1bo+kDeW9dkhGQjpbyrvQr7fQBvTy0fC3+V1fjLUG5W4gAFJWqhEUcovl32HC2BK
         xtbIIu8rLER2gAShaOCaz1ln4C6bEk4XPi+GidYNGfLbJAB0rrOYmpwNsdIn+wskv90h
         OpjoK/mTjDKahBIqaqOV3P45KWvkGfRPPoZjEZUfL4GCrOpSxJKlKqw3n4FAo3oyrZv4
         q3g7TbYP/CD3EDgst23vFD3RYiJxLWIkNtHDiJ2aqr4LYlmYRIwopVn7JqK4IycctlZf
         qpJQFOu/jM1HvDEuZRql6oj5o3i/iiv8wfp1u4EoZmAQfvJznERa4Ds/YbaL9nfgrZVt
         hHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HAWUFqDRsl0lKLydzEvVMYU91e/yIqLXEOvNq/hwJqM=;
        b=sb+ZEhhSO/k1wxh5CLA4rWZAqb898X5XSFMwy7Zrh6t8SaJNOpllsxMfV/M4YC/Qlc
         hSoYTS7qdzpSlZHkwCAmDC2iZNzEiE3WAmvmmD7I+sjfVlNqXM+iyVlwCJIMrpxPX1TI
         FiXvOkolCDeZcK84TGF/uzjfiDeT2eavNh5ODYvXsiJw8NkvvVDyrXrE4n/SDIsdhmOE
         REXQUblWqhbwrRPFUOea+6987kzYOtdELaG1dKwrQ0wzr7DSYgx1hK85w7XVVfY5T3fK
         KW9NYbGkH92nus9CrQkVzWCGqHVKbbqF1kzhLjXH/suZ46tmmCxHpGX6wvq10vgrVm/C
         oRJg==
X-Gm-Message-State: AOAM533KDWq6y78L0VgGy4DDNnYTYBL/RuIBziy+1dQLCbY72a+KhbK0
        raE0BEVOwqz+NITRG97KWIxzHg==
X-Google-Smtp-Source: ABdhPJxKwzD6dI/j0cDEYqXK+pwMw9Bs9xP09zaVtJeLlXPDAWvbxod2xcXdmblXkgfX7YcPVOTlfQ==
X-Received: by 2002:a37:4643:: with SMTP id t64mr14631379qka.344.1615590440098;
        Fri, 12 Mar 2021 15:07:20 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:e6d2])
        by smtp.gmail.com with ESMTPSA id q187sm5477897qkb.36.2021.03.12.15.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 15:07:19 -0800 (PST)
Date:   Fri, 12 Mar 2021 18:07:18 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Subject: Re: [External] Re: [PATCH v3 2/4] mm: memcontrol: make
 page_memcg{_rcu} only applicable for non-kmem page
Message-ID: <YEv0JkGtgotHJlO2@cmpxchg.org>
References: <20210309100717.253-1-songmuchun@bytedance.com>
 <20210309100717.253-3-songmuchun@bytedance.com>
 <YEoXLX37sVgULO4A@cmpxchg.org>
 <CAMZfGtXZqe7g6e4wf=tUZqxBs-F1QkS2=01Td4Rv3_qTuF0bPA@mail.gmail.com>
 <YEu/pnK0n8nI2OBy@cmpxchg.org>
 <CALvZod5sEcsu9AHAzdkJyjxm4ws_aKXyyer99+f2rs-OnOQAMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5sEcsu9AHAzdkJyjxm4ws_aKXyyer99+f2rs-OnOQAMg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 02:42:45PM -0800, Shakeel Butt wrote:
> Hi Johannes,
> 
> On Fri, Mar 12, 2021 at 11:23 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> [...]
> >
> > Longer term we most likely need it there anyway. The issue you are
> > describing in the cover letter - allocations pinning memcgs for a long
> > time - it exists at a larger scale and is causing recurring problems
> > in the real world: page cache doesn't get reclaimed for a long time,
> > or is used by the second, third, fourth, ... instance of the same job
> > that was restarted into a new cgroup every time. Unreclaimable dying
> > cgroups pile up, waste memory, and make page reclaim very inefficient.
> >
> 
> For the scenario described above, do we really want to reparent the
> page cache pages? Shouldn't we recharge the pages to the second,
> third, fourth and so on, memcgs? My concern is that we will see a big
> chunk of page cache pages charged to root and will only get reclaimed
> on global pressure.

Sorry, I'm proposing to reparent to the ancestor, not root. It's an
optimization, not a change in user-visible behavior.

As far as the user can tell, the pages already belong to the parent
after deletion: they'll show up in the parent's stats, naturally, and
they will get reclaimed as part of the parent being reclaimed.

The dead cgroup doesn't even have its own limit anymore after
.css_reset() has run. And we already physically reparent slab objects
in memcg_reparent_objcgs() and memcg_drain_all_list_lrus().

I'm just saying we should do the same thing for LRU pages.
