Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452A833A929
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 01:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhCOAwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 20:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhCOAwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 20:52:34 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139FBC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 17:52:34 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id f10so7851417ilq.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 17:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zc50leSX2oieymemRjcX1In4Wa04eq4VV3W1lZ9TsKU=;
        b=giFIm+IxQarWD5opEWon9FvSYpKP+CsgV1c3/qcHH14QnszSL3GG7RZb19uknDZl9m
         QkeWCQeHkk3joLKBKaYcuwQUBgVbkeZ5DF9dGu68YTfFSIiZwPpBh5hGmPvZOnduRFjr
         URmeEdq4q1IFZw7X6tfcOXYw6qBg0wikhjrcoDk1lRbgYEsTMzVEuOnmt6m+rq9mxDI/
         CU9mH92LL8u2jhe4wxHeVpusoC1k0WgdbzI8bpXsowYbMHfZJct5yIIU6ThnvuYoHyeR
         vZQVeFe04ZFxbOCb2l5AJoT9Tpagi4PV01N55yWGxmyhfkKCZ2vgRmA/GiyTQEuhqzfl
         HnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zc50leSX2oieymemRjcX1In4Wa04eq4VV3W1lZ9TsKU=;
        b=AN5lrv7+qO8cOQ0yFYRMECc4odkbvVJAWThIFXQtBwTe/Bu7nJf+XtXJ0cnynCNOL0
         CNQMV1qtAJX46E7cnQHi67ohZZ2b4ozmftNO4UqAJl3Yr9/kt59QpxjmmED6ASYaBT1P
         jknkFt/U1WDxZXPFbGcTIj8Pu2pWCxqsKFxNFIEOgWKjwdQb/ZlnPDaQqKb8CT4n9d5H
         b+btREtsLN4UFcuLIoyU0TND9HNXmg8HFGEKipb2IZdPBjPTmMeBSjgBU7Lb29miD6Uq
         YnS18wQXF+MGoOj6jjvIUKTjhMBy+7B5j76XrECACcT3LrIy8TbezqjNSRDm/SNusLOD
         Eskw==
X-Gm-Message-State: AOAM5316hGd8gEsDSLNK0egBkjkftw4/yqELFXnkeGoc1arKyEnI56CF
        AyqRiuNDxgf0BHnExSlHl3XzTQ==
X-Google-Smtp-Source: ABdhPJxGO1gE3oyXjD8B7ZlEPhyrulhBec6YpXJQLlrbYpp9OhyiGd7pL/PNtz4PHfIa2qUmiO2vrA==
X-Received: by 2002:a05:6e02:f90:: with SMTP id v16mr9694973ilo.294.1615769553344;
        Sun, 14 Mar 2021 17:52:33 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:4d84:eb70:5c32:32b8])
        by smtp.gmail.com with ESMTPSA id c18sm7091908ild.37.2021.03.14.17.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 17:52:32 -0700 (PDT)
Date:   Sun, 14 Mar 2021 18:52:28 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, page-reclaim@google.com
Subject: Re: [PATCH v1 00/14] Multigenerational LRU
Message-ID: <YE6vzPwyAApryYrf@google.com>
References: <20210313075747.3781593-1-yuzhao@google.com>
 <B2FE37C5-85B7-43AC-B6B2-43660E13FDFF@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B2FE37C5-85B7-43AC-B6B2-43660E13FDFF@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 06:48:17PM -0400, Zi Yan wrote:
> On 13 Mar 2021, at 2:57, Yu Zhao wrote:

> > Problems
> > ========

> >   31.03%  page_vma_mapped_walk
> >   25.59%  lzo1x_1_do_compress
> >    4.63%  do_raw_spin_lock
> >    3.89%  vma_interval_tree_iter_next
> >    3.33%  vma_interval_tree_subtree_search

> > Solutions
> > =========

> >   49.36%  lzo1x_1_do_compress
> >    4.54%  page_vma_mapped_walk
> >    4.45%  memset_erms
> >    3.47%  walk_pte_range
> >    2.88%  zram_bvec_rw
> 
> Is this profile from a system with this patchset applied or not?
> Do you mind sharing some profiling data with before and after applying
> the patchset? So it would be easier to see the improvement brought by
> this patchset.

I've snipped everything else to make the context more clear.

These two kswapd profiles were collected under roughly the same memory
pressure. In other words, kswapd reclaimed (compressed) about the same
number of pages and therefore spent about the same amount of CPU time
in lzo1x_1_do_compress() in each profile.

The percentages of lzo1x_1_do_compress() are different because the
total CPU usage are different. Dividing the second percentage by the
first, we know we have roughly cut kswapd CPU usage by half.

> Are there any performance numbers for specific application (before and
> after applying the patches) you can show to demonstrate the improvement?

The kswapd profiles are from Chrome OS, i.e., laptops running the
v5.11 kernel and the Chrome browser. And we've also collected
benchmarks from various workloads on servers and phones running older
kernel versions too. Do you have a platform in mind? I'd be happy to
share the data with you. Or if you have some workloads/benchmarks, I
could collect some numbers from them too.
