Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9382135D956
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239858AbhDMHw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238805AbhDMHwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:52:25 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBFCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 00:52:04 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id c123so12140174qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 00:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=bZdhpnprCwHd3jMiHPqHn5OaB0UoYsuLnDKhRtGCdMU=;
        b=RiEu2nLioxXM96nsAA3ew5lKyZj+pU5TOo70G4yBiZRdIBQkF5IZ6sEn87ENSCWR2r
         GdYs55uCxiAAyyRi21cKhVtljaP5ZNLmsWWAWPf8Nk+4rNqqwF61Nlw2C8THeD+YWtfy
         i8LwLgCwhfe2x0DH3SK69crtq0G/W4qzplgbxeD7x9NBA3y9frMPWDrh79sMve6R1vtw
         u1/cmLWslp//Eesy18CVk7yXtvzVxsgOVjV9eLXi6MHs7eBTQAxi4UT9R9SJoI+Z03ig
         q9y1qPRAYnatVyKjKHsQPdNhEbrMYtpYMYtADqze4/2DG7NMFwWk6WPT6UaQOli9+uNa
         N5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=bZdhpnprCwHd3jMiHPqHn5OaB0UoYsuLnDKhRtGCdMU=;
        b=rkRZisMoV4X0GWB3grg904LJYAocNkevkPzXRwm/De/gN/ii+tC1ghPiRBLaksKX2f
         WopjYfTtyDFdaw+6sdmTcYZ8vljF9HIO429mgSjeM2wcDrvulGuHAHg9HpvMbLG4bgFM
         uOmYx6d7oBkOqKp5DLYe64R0an877URtTEJp6Ccrcft4S19BrHwYxLEZXY/f+I4o7q/O
         tvcaWCbh0g0FDfpjlul+uymeuJeQlBmLC71jOci5FO0JjvvJLpzWHqTnlXf9dex5HSnB
         Qwh6ru6mc74Wy8JlmAxRi4WD1+aHZC0Hpk5/9T69IOVw5+nFVvmFkxDGbQrn6UgSFm5N
         1uJg==
X-Gm-Message-State: AOAM530OWbwq7JHNV/JyTMkpBo6fbQ3ZdF4TbmC18cRugm8w7/8cuYrE
        UsJxGJEIZc/reuzXJ6M9mPc=
X-Google-Smtp-Source: ABdhPJyDTONZeCMedx5IRHCIfoYu5+9XDkPpScol3SG+KkgqYEBioeDmE6yjfC6+IqPyf7h14e9F/A==
X-Received: by 2002:a37:2c41:: with SMTP id s62mr30872541qkh.205.1618300323847;
        Tue, 13 Apr 2021 00:52:03 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id c26sm9243271qtj.92.2021.04.13.00.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 00:52:03 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     Yu Zhao <yuzhao@google.com>
Cc:     linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Manes <ben.manes@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michael Larabel <michael@michaellarabel.com>,
        Michal Hocko <mhocko@suse.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Rong Chen <rong.a.chen@intel.com>,
        SeongJae Park <sjpark@amazon.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, lkp@lists.01.org,
        page-reclaim@google.com
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
Date:   Tue, 13 Apr 2021 07:51:55 +0000
Message-Id: <20210413075155.32652-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210413065633.2782273-1-yuzhao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Hello,


Very interesting work, thank you for sharing this :)

On Tue, 13 Apr 2021 00:56:17 -0600 Yu Zhao <yuzhao@google.com> wrote:

> What's new in v2
> ================
> Special thanks to Jens Axboe for reporting a regression in buffered
> I/O and helping test the fix.

Is the discussion open?  If so, could you please give me a link?

> 
> This version includes the support of tiers, which represent levels of
> usage from file descriptors only. Pages accessed N times via file
> descriptors belong to tier order_base_2(N). Each generation contains
> at most MAX_NR_TIERS tiers, and they require additional MAX_NR_TIERS-2
> bits in page->flags. In contrast to moving across generations which
> requires the lru lock, moving across tiers only involves an atomic
> operation on page->flags and therefore has a negligible cost. A
> feedback loop modeled after the well-known PID controller monitors the
> refault rates across all tiers and decides when to activate pages from
> which tiers, on the reclaim path.
> 
> This feedback model has a few advantages over the current feedforward
> model:
> 1) It has a negligible overhead in the buffered I/O access path
>    because activations are done in the reclaim path.
> 2) It takes mapped pages into account and avoids overprotecting pages
>    accessed multiple times via file descriptors.
> 3) More tiers offer better protection to pages accessed more than
>    twice when buffered-I/O-intensive workloads are under memory
>    pressure.
> 
> The fio/io_uring benchmark shows 14% improvement in IOPS when randomly
> accessing Samsung PM981a in the buffered I/O mode.

Improvement under memory pressure, right?  How much pressure?

[...]
> 
> Differential scans via page tables
> ----------------------------------
> Each differential scan discovers all pages that have been referenced
> since the last scan. Specifically, it walks the mm_struct list
> associated with an lruvec to scan page tables of processes that have
> been scheduled since the last scan.

Does this means it scans only virtual address spaces of processes and therefore
pages in the page cache that are not mmap()-ed will not be scanned?

> The cost of each differential scan
> is roughly proportional to the number of referenced pages it
> discovers. Unless address spaces are extremely sparse, page tables
> usually have better memory locality than the rmap. The end result is
> generally a significant reduction in CPU usage, for workloads using a
> large amount of anon memory.

When and how frequently it scans?


Thanks,
SeongJae Park

[...]
