Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71419340434
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhCRLIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhCRLI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:08:27 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA19C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 04:08:27 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id w11so1119738ply.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 04:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yZ33cKi5KuIfXO9xxvNPTIxQT4GFvVDZu4co6ScWjWQ=;
        b=QVjE2DHLlcMBALEI9tK7xOXy2Gj1UBMGDPIqtzdlB/+O4LfIXhTNhGAmBRCOx5rGSJ
         eWdenLdyvKVK8EVh28tMimvHkrN3GpbIBzDC+8Z0cz23AB8J+lml+/0wd6378CHZ8IF2
         iZFGILrOKVaBMuBgeFXGALyE/nHrYD1haX4zi4wqy1wPN/vRBIq5irG5eLiwekqlYreC
         sezJVSR2oVzsYL0/JRY4MF//DPkpTyQ03+hGiTzKj2esF9wPLk1z1lHGyWQS1AV8Oco/
         S8slZ+DchdNqXfw17VrlxcwqlpKGilQZqFQsiEXoTAG/Z2LMUbiu6EToCO3hWlQ0zQZk
         srwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yZ33cKi5KuIfXO9xxvNPTIxQT4GFvVDZu4co6ScWjWQ=;
        b=B4ei839iBzJZ34AcWWapk9wJF2jeA8fNStLGaCrImrdEUe3AZ/bG4yYXhSYqrfM85V
         LI50eO//RatDH26ucyW6DIrWCY/fwkIH2XWxAfVjViIFAxviCEWBsMqlCCxJdqoAH/xd
         5d/OMQQZIeJTuN7uM5ef6UPHS08MyZA4eMDvTEOSb715nJUAJ4e+dPCx4rJcc/hXa6fV
         701NEBePbGfNV+TW0TN+yco0AAMVLGJCG483Ou7IS5E0OCQJWeaNvvZ7sNMxyMlchAva
         bJxS46lT/ArE1iEkRu2zRINKnxfBu0OHJUJjY1O7sZghTXc4hsIgLzSWUl8eIxTxGYc+
         PrBA==
X-Gm-Message-State: AOAM532B/ddPhmBlrSPnjIbNDP7rPl2uujio9h7vJWjejDtROJpdm74Q
        N6QtUELxjrTpOxK8jG422cS2SA==
X-Google-Smtp-Source: ABdhPJwgPH7ggihGVwRnBCXzHXsa34A0wexo+pHFMBlyVyGR1piyNlL1Rtq3bH8qNyDAwK/NZvw1Gg==
X-Received: by 2002:a17:90a:55ca:: with SMTP id o10mr3643841pjm.173.1616065706522;
        Thu, 18 Mar 2021 04:08:26 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id e21sm1779509pgv.74.2021.03.18.04.08.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Mar 2021 04:08:26 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 0/5] Use obj_cgroup APIs to charge kmem pages
Date:   Thu, 18 Mar 2021 19:06:53 +0800
Message-Id: <20210318110658.60892-1-songmuchun@bytedance.com>
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

Muchun Song (5):
  mm: memcontrol: introduce obj_cgroup_{un}charge_pages
  mm: memcontrol: directly access page->memcg_data in mm/page_alloc.c
  mm: memcontrol: change ug->dummy_page only if memcg changed
  mm: memcontrol: use obj_cgroup APIs to charge kmem pages
  mm: memcontrol: move PageMemcgKmem to the scope of CONFIG_MEMCG_KMEM

 include/linux/memcontrol.h | 123 ++++++++++++++++++++++++++++++++---------
 mm/memcontrol.c            | 133 ++++++++++++++++++++++++++++++---------------
 mm/page_alloc.c            |   4 +-
 3 files changed, 188 insertions(+), 72 deletions(-)

-- 
2.11.0

