Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0EF34220E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 17:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhCSQjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 12:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhCSQij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 12:38:39 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A33C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:38:39 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x26so6274921pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iJa75g1dgQtxiTA2vP7trUyHDt/yfHb4pEZP0XDxdyk=;
        b=TD3mNIlSrsMDaKcOHYRI65gHJMne1XlHoPhiRB3+wRhzdE6taAm3jxf9rtSNhT9b66
         mg9Qlynm0WqYQuzMrO62bvLQJYCSZnp6x9um5iX+OCiuvzt0BbDcin1Vp7lrjsGek26e
         XNflfPFLZ50IZwwdsxqrX4fwJqCOa2mVMr86tPHKD2Tg5a5PsFTtPr2EN5Cmxu9g21/u
         C4qvForVWGxuIhvwwMZeBfmF9JKXkCBKDlO5v6EnABh+7xpnPoaEqw7xFy8jpPgJk3Na
         EXGImFUfVB5Smo/oRSc/Q3emfiosPsu4Tyn/HQ4MBddkUeQsvZuLfwX+lr94DN0noy0I
         LKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iJa75g1dgQtxiTA2vP7trUyHDt/yfHb4pEZP0XDxdyk=;
        b=D45SMXa70RO2IN17zE5VSklnnqIpLhtonrbe7Q3smZCw2C3agdqnOwjs8RC+5XREKQ
         OGhr19GgdlD73KkOGvxuVePI5shcBOjUBeqkCMi72oZ4EC1BvP7gh1VGN/wSZugQukVL
         8stGOSLcm2ZpJYCFTSIC82GiMG4LLoFqsZqbfVsV7Z1tf5VyJj/aYapdmxrMGcpV4aIG
         m7SeuTTu6TStXpUwiWZ4k5vuQBs18JisDKKNyjmWXzbqU7lVb2PWrADBsRf1Zy655jL1
         ohQORAXszDiOYe8SJ7nlNQxQZoHnnEUpTSbH780b3NKL2oSx1Uqgfb3o2+e5W/zT/lfd
         AzyQ==
X-Gm-Message-State: AOAM5327FTskM8rCuds39jakuPHkd1tFi8u1GOBhW3vswvzopHNv6jRa
        M+hwudhWbkG/BvgZfk1whXVniw==
X-Google-Smtp-Source: ABdhPJw7RYbYhSMGGfMO4TDIe8w0j7nS6xxCIu6L88if3semVnkeQaxK/TzMdTh1se/cr6b6QWfuag==
X-Received: by 2002:a63:f14b:: with SMTP id o11mr12268388pgk.440.1616171918486;
        Fri, 19 Mar 2021 09:38:38 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id z25sm5860239pfn.37.2021.03.19.09.38.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Mar 2021 09:38:38 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 0/7] Use obj_cgroup APIs to charge kmem pages
Date:   Sat, 20 Mar 2021 00:38:13 +0800
Message-Id: <20210319163821.20704-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Roman series "The new cgroup slab memory controller" applied. All
slab objects are charged with the new APIs of obj_cgroup. The new APIs
introduce a struct obj_cgroup to charge slab objects. It prevents
long-living objects from pinning the original memory cgroup in the memory.
But there are still some corner objects (e.g. allocations larger than
order-1 page on SLUB) which are not charged with the new APIs. Those
objects (include the pages which are allocated from buddy allocator
directly) are charged as kmem pages which still hold a reference to
the memory cgroup.

E.g. We know that the kernel stack is charged as kmem pages because the
size of the kernel stack can be greater than 2 pages (e.g. 16KB on x86_64
or arm64). If we create a thread (suppose the thread stack is charged to
memory cgroup A) and then move it from memory cgroup A to memory cgroup
B. Because the kernel stack of the thread hold a reference to the memory
cgroup A. The thread can pin the memory cgroup A in the memory even if
we remove the cgroup A. If we want to see this scenario by using the
following script. We can see that the system has added 500 dying cgroups
(This is not a real world issue, just a script to show that the large
kmallocs are charged as kmem pages which can pin the memory cgroup in the
memory).

	#!/bin/bash

	cat /proc/cgroups | grep memory

	cd /sys/fs/cgroup/memory
	echo 1 > memory.move_charge_at_immigrate

	for i in range{1..500}
	do
		mkdir kmem_test
		echo $$ > kmem_test/cgroup.procs
		sleep 3600 &
		echo $$ > cgroup.procs
		echo `cat kmem_test/cgroup.procs` > cgroup.procs
		rmdir kmem_test
	done

	cat /proc/cgroups | grep memory

This patchset aims to make those kmem pages to drop the reference to memory
cgroup by using the APIs of obj_cgroup. Finally, we can see that the number
of the dying cgroups will not increase if we run the above test script.

Changlogs in v5:
  1. Add a new patch (1st) to fix a potential issue.
  2. Rename get_obj_cgroup_memcg() to get_mem_cgroup_from_objcg().
  3. Remove get_mem_cgroup_from_current() and get_active_memcg().
  4. Add a comment to uncharge_page().
  5. Add a separate patch to inline __memcg_kmem_{un}charge() into
     obj_cgroup_{un}charge_pages().
  6. Collect Acked-by and Reviewed-by tags.

  Thanks to Johannes and Shakeel's review and suggestions.

Changlogs in v4:
  1. Do not change behavior of page_memcg() and page_memcg_rcu().
  2. Rework uncharge_page() and uncharge_batch().
  3. Add two patches (patch #2 and patch #3).

  Thanks to Johannes and Shakeel and Roman's review and suggestions.

Changlogs in v3:
  1. Drop "remote objcg charging APIs" patch.
  2. Rename obj_cgroup_{un}charge_page to obj_cgroup_{un}charge_pages.
  3. Make page_memcg/page_memcg_rcu safe for adding new memcg_data flags.
  4. Reuse the ug infrastructure to uncharge the kmem pages.
  5. Add a new patch to move PageMemcgKmem to the scope of CONFIG_MEMCG_KMEM.

  Thanks to Roman's review and suggestions.

Changlogs in v2:
  1. Fix some types in the commit log (Thanks Roman).
  2. Do not introduce page_memcg_kmem helper (Thanks to Johannes and Shakeel).
  3. Reduce the CC list to mm/memcg folks (Thanks to Johannes).
  4. Introduce remote objcg charging APIs instead of convert "remote memcg
     charging APIs" to "remote objcg charging APIs".

Muchun Song (7):
  mm: memcontrol: slab: fix obtain a reference to a freeing memcg
  mm: memcontrol: introduce obj_cgroup_{un}charge_pages
  mm: memcontrol: directly access page->memcg_data in mm/page_alloc.c
  mm: memcontrol: change ug->dummy_page only if memcg changed
  mm: memcontrol: use obj_cgroup APIs to charge kmem pages
  mm: memcontrol: inline __memcg_kmem_{un}charge() into
    obj_cgroup_{un}charge_pages()
  mm: memcontrol: move PageMemcgKmem to the scope of CONFIG_MEMCG_KMEM

 include/linux/memcontrol.h | 123 +++++++++++++++++++++------
 mm/memcontrol.c            | 206 +++++++++++++++++++++++----------------------
 mm/page_alloc.c            |   4 +-
 3 files changed, 207 insertions(+), 126 deletions(-)

-- 
2.11.0

