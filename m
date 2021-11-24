Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141C745CC9A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbhKXTBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 14:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhKXTBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 14:01:46 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FECEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:58:37 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id z9so3686098qtj.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+bM/O38rPI+qfv/U3PQAO1yZ/WpbjgCs1jId/KOne+A=;
        b=pz5C3pEbbdneSHJvWhBW5lm6IawjQHl9mVUDrg4QAY7SXoUoWMFjgkOTCoVFrhtpjS
         RJp6W7x41zz3Iv5jQwBM9bKUiOxEwssfknMeY4jXOt4krof5vDMTNa89NnzMK6czNnQd
         0T1Onq3p9iGFQIm1j9Tcb/KlZKNvWxywL/YdVaLUqBM35kjuL3VO+hdwN/monOn6+kvS
         PCCnFe+LL+JLva6sWD9/YVvveb1TyXlULDmlqyIVUW7Y6Dt9xm6W6Tg1c56P2veknlj4
         aVm3FF6nmA8ypFVbtjp5S6TLK4qDUc6ffbvIQPlyjJAY3Ece5V8oOGBdBX6dCWZaqb4x
         XeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+bM/O38rPI+qfv/U3PQAO1yZ/WpbjgCs1jId/KOne+A=;
        b=xfEkC5RfImyBFd0hKFbOl51Owa2AO7ArUhqzpLZwVUfjs1jK7Obcddb7/545p1Csyt
         K379OnTNg+NGdNw53TFI0iut0MiUVPkU9UMX5U/PjpLdNAp1T3meLXkR49XEMZR6VDk1
         YkRJDsYGikTjeIQVwhmt7oAc0MV0JECjT395bvT4dGi42wWD7qmfcu5TAlHVOkYQzL6E
         C8dy3Kl/QKfNufMoNlL9ocBVjpelpei0E1Vj9v89vxG7j6GkO+FWunc4UJKn+/TblP8n
         D0cXfvTgZmCpXS+NZihz/9IMwVUBOOp84c6OjK0NhTdGy3UGlcKtL0VQE6Z0vuBGq4uu
         yflQ==
X-Gm-Message-State: AOAM5326WrUuRw8GDK+LGNaKG4CkQVifQvAkCItXjnqan3ZPPr3xUJIb
        rE5QWXwqfuy/cX73yj7MLzw=
X-Google-Smtp-Source: ABdhPJxzTa/waov5WY5oCFmmWu5OPXhZW+907iSmGhMIrLsEp8ZzjCqSha54/PcbOBR9Hmwd2GTVOA==
X-Received: by 2002:ac8:5fc5:: with SMTP id k5mr1298352qta.502.1637780316136;
        Wed, 24 Nov 2021 10:58:36 -0800 (PST)
Received: from hasanalmaruf-mbp.thefacebook.com ([2620:10d:c091:480::1:a1b0])
        by smtp.gmail.com with ESMTPSA id r16sm315775qkp.42.2021.11.24.10.58.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Nov 2021 10:58:35 -0800 (PST)
From:   Hasan Al Maruf <hasan3050@gmail.com>
X-Google-Original-From: Hasan Al Maruf <hasanalmaruf@fb.com>
To:     dave.hansen@linux.intel.com, ying.huang@intel.com,
        yang.shi@linux.alibaba.com, mgorman@techsingularity.net,
        riel@surriel.com, hannes@cmpxchg.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Transparent Page Placement for Tiered-Memory
Date:   Wed, 24 Nov 2021 13:58:25 -0500
Message-Id: <cover.1637778851.git.hasanalmaruf@fb.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[resend in proper format]

With the advent of new memory types and technologies, we can see different
types of memory together, e.g. DRAM, PMEM, CXL-enabled memory, etc. In
recent future, we can see CXL-Memory be available in the physical address-
space as a CPU-less NUMA node along with the native DDR memory channels.
As different types of memory have different level of performance impact,
how we manage pages across the NUMA nodes should be a matter of concern.

Dave Hansen's patchset on "Migrate Pages in lieu of discard" demotes
toptier pages to a slow tier node during the reclamation process.

    		https://lwn.net/Articles/860215/

However, that patchset does not include the features to promote pages on
slow tier memory node to the toptier one. As a result, pages demoted or
newly allocated on the slow tier node, experiences NUMA latency and hurt
application performance. In this patch set, we augment existing AutoNUMA
mechanism to promote pages from slow tier nodes to toptier nodes.

We decouple reclamation and allocation logics for the toptier node so that
reclamation gets triggered at a higher watermark and demotes colder pages
to the slow-tier memory. As a result, toptier nodes can maintain some free
space to accept both new allocation and promotion from slowtier nodes.
During promotion, we add hysteresis to page and only promote pages that
are less likely to be demoted within a short period of time. This reduces
the chance for a page being ping-ponged across the NUMA nodes due to
frequent demotion and promotion within a short period of time.

We tested this patchset on systems with CXL-enabled DRAM and PMEM tiers.
We find this patchset can bring hotter pages to the toptier node while
moving the colder pages to the slow-tier nodes for a good range of Meta
production workloads with live traffic. As a result, toptier nodes serve
more hot pages and the application performance improves.

Case Study of a Meta cache application with two NUMA nodes
==========================================================
Toptier node: DRAM directly attached to the CPU
Slowtier node: DRAM attached through CXL

Toptier vs Slowtier memory capacity ratio is 1:4

With default page placement policy, file caches fills up the toptier node
and anons get trapped in the slowtier node. Only 14% of the total anons
reside in toptier node. Remote NUMA read bandwidth is 80%. Throughput
regression is 18% compared to all memory being served from toptier node.

This patchset brings 80% of the anons to the toptier node. Anons on the
slowtier memory is mostly cold anons. As the toptier node can not host all
the hot memory, some hot files still remain on the slowtier node. Even
though, remote NUMA read bandwidth reduces from 80% to 40%. With this
patchset, throughput regression is only 5% compared to the baseline of
toptier node serving the whole working set.

Hasan Al Maruf (5):
  Promotion and demotion related statistics
  NUMA balancing for tiered-memory system
  Decouple reclaim and allocation for toptier nodes
  Reclaim to satisfy WMARK_DEMOTE on toptier nodes
  active LRU-based promotion to avoid ping-pong

 Documentation/admin-guide/sysctl/kernel.rst | 18 +++++
 Documentation/admin-guide/sysctl/vm.rst     | 12 ++++
 include/linux/mempolicy.h                   | 11 ++-
 include/linux/mm.h                          |  4 ++
 include/linux/mmzone.h                      |  5 ++
 include/linux/node.h                        |  7 ++
 include/linux/page-flags.h                  |  9 +++
 include/linux/page_ext.h                    |  3 +
 include/linux/sched/numa_balancing.h        | 63 ++++++++++++++++-
 include/linux/sched/sysctl.h                |  6 ++
 include/linux/vm_event_item.h               | 13 ++++
 include/trace/events/mmflags.h              | 10 ++-
 kernel/sched/core.c                         | 36 ++++++++--
 kernel/sched/fair.c                         | 23 ++++++-
 kernel/sched/sched.h                        |  2 +
 kernel/sysctl.c                             | 19 ++++--
 mm/huge_memory.c                            | 29 +++++---
 mm/memory.c                                 | 15 +++-
 mm/mempolicy.c                              | 30 +++++++-
 mm/migrate.c                                | 48 ++++++++++---
 mm/mprotect.c                               |  8 ++-
 mm/page_alloc.c                             | 34 ++++++++-
 mm/vmscan.c                                 | 76 +++++++++++++++++++--
 mm/vmstat.c                                 | 20 +++++-
 24 files changed, 451 insertions(+), 50 deletions(-)

--
2.30.2
