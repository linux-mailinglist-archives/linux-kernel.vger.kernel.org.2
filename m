Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74EFF32BAD3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbhCCL72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451332AbhCCGCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 01:02:36 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419E6C061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 22:01:56 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id g4so15577359pgj.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 22:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w7StTxcyXcafl4uEbG/aIE82ifm7bKYtlIbdebIFMPE=;
        b=ugTE4jP9VW9bZE+/2dIrXgQ3ommzWl3Nxt2OliKGmVfndlY8ZaqWwe3VdgUozFbtbO
         JLK+h1YW00HCqURjk55+KtMDyzm+naagIlF02qDulyra+eoNWMnNxNIUUgkJDkIMbJ6K
         cHpg+9UTHAUDsVRZZwGgRbYFCtk3r6vNHy1ml8OTz/JW68UeHkFORFSWLc41tsIwoMxz
         4BXIdQA8/wdwwmqUrLaqu0Px3XNEw+BwGzfQGQXRm8OdpIuQawHq5M4iK7zXvjleGBHW
         XQ7+2OP6j6JMfldjPRA48T5uz0iGKCOA+TdRoLYrNXkL1z0iJeqQpq0aqqSFVC4Rq0YD
         bZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w7StTxcyXcafl4uEbG/aIE82ifm7bKYtlIbdebIFMPE=;
        b=m1Ebk5uyABaxS31vBdqYPZKOmjZCw2vjwxnEHKvSHYsc41l1q0itvCmV9DXTzIbrif
         vi0Gm9LkZE+KGG3smoWgS/l+s6RJapY8qKutJipKb3Ps+3vBR3RV0r8EPy+R+/NMWSB7
         4PERy7DA/emP1xoEGLy/6FbPtafkKr/zVWd+fa57a980fxTkRHkV+lGXD8Rwq97OzcKT
         X484IpvHclaB6CHgw4wnHP8qmQykycG5qTDwd7Gnsc0aYh6jAoyQ/la5Y5tGIWio5w3t
         GtSlAxub9YJL2BDkzripHh/lDvh9G2n9i/0vczfI7WdU1T4n3hY7eJd20rrToAuuMJAe
         Y/Dg==
X-Gm-Message-State: AOAM530S4hQoaKcyx6IViETue9KxCI4Ptk33Gty/O0NGQYw77OuPxZlX
        AO7Cs1fzJCB1AMLx4GPsVj2Jig==
X-Google-Smtp-Source: ABdhPJwp+JatXF/+aMDFUZxyOjFQpcFSO9nkpqnoJ3n4zsSHtLSG3bwWOPuE6m9zfrTO6FBdTkjrVA==
X-Received: by 2002:a63:1843:: with SMTP id 3mr21857213pgy.253.1614751315725;
        Tue, 02 Mar 2021 22:01:55 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id x11sm6131088pjh.0.2021.03.02.22.01.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Mar 2021 22:01:55 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 0/5] Use obj_cgroup APIs to charge kmem pages
Date:   Wed,  3 Mar 2021 13:59:12 +0800
Message-Id: <20210303055917.66054-1-songmuchun@bytedance.com>
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

Patch 1-3 use obj_cgroup APIs to charge kmem pages.
Patch 4 introduces remote objcg charging APIs.
Patch 5 uses remote objcg charging APIs to charge kernel memory.

Changlogs in v2:
  1. Fix some types in the commit log (Thanks Roman).
  2. Do not introduce page_memcg_kmem helper (Thanks to Johannes and Shakeel).
  3. Reduce the CC list to mm/memcg folks (Thanks to Johannes).
  4. Introduce remote objcg charging APIs instead of convert "remote memcg
     charging APIs" to "remote objcg charging APIs".

Muchun Song (5):
  mm: memcontrol: introduce obj_cgroup_{un}charge_page
  mm: memcontrol: make page_memcg{_rcu} only applicable for non-kmem
    page
  mm: memcontrol: charge kmem pages by using obj_cgroup APIs
  mm: memcontrol: introduce remote objcg charging API
  mm: memcontrol: use remote objcg charging APIs to charge kernel memory

 fs/buffer.c                          |  10 +-
 fs/notify/fanotify/fanotify.c        |   6 +-
 fs/notify/fanotify/fanotify_user.c   |   2 +-
 fs/notify/group.c                    |   3 +-
 fs/notify/inotify/inotify_fsnotify.c |   8 +-
 fs/notify/inotify/inotify_user.c     |   2 +-
 include/linux/bpf.h                  |   2 +-
 include/linux/fsnotify_backend.h     |   2 +-
 include/linux/memcontrol.h           | 114 +++++++++++++---
 include/linux/sched.h                |   4 +
 include/linux/sched/mm.h             |  38 ++++++
 kernel/bpf/syscall.c                 |  35 ++---
 kernel/fork.c                        |   3 +
 mm/memcontrol.c                      | 257 ++++++++++++++++++++++++++---------
 mm/page_alloc.c                      |   4 +-
 15 files changed, 372 insertions(+), 118 deletions(-)

-- 
2.11.0

