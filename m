Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A714B33229B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 11:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhCIKI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 05:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhCIKIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 05:08:55 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCF7C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 02:08:55 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id l7so9178359pfd.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 02:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rDStk8DgxtEE1GF5JjL7SE91exow+FT+q7nfT2+yXh8=;
        b=R3zKbYbxbsS0Suufmnc5FerkZosS+1IOgQpr2GSfCHVFVd2c+JH68wUlVC6XDH0JWv
         LxQ5sfNo58G6gsSU7ei7nXN5UPw9TJgL9TVhf1K2gJiLLiKA4orF0hgfI5NEGlf+aQdl
         rfnV7I9WBXowUKWor+jseIBxrkEfVcbSEr2Bs3Bd140HAOPXhIurZTPDdPAcEeDvkTbd
         X/aZfbI4DnwAykwRxuOCOZ2P0jqzQbe00uO5NsSIVJy5H5ExaauMNTfQkH8airPoJbBN
         m0GfL7VqW9y3qSFGVkPlRUP+f+PyB3wnB/PxLTlxdmedSXOMDq9ig3sCZhOp0tlR8q6e
         zNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rDStk8DgxtEE1GF5JjL7SE91exow+FT+q7nfT2+yXh8=;
        b=t9pKCk6HiZAxyg3Y7z0kwJ1e8npFbifFBWX3gFNyOArEpCBYqRxT2CpWjdOSxG/ehE
         TRhXXs6GwVkZEcZk/NkqgmxRHp1NI4YuxHiTclH67rPLNZjzDx4D9SetprL0v1LO7MJS
         FrzE6owHteWhjI6rjHEiVk0n6517Ixv8rG3db5/NeFp6d6jRXk9TNRV+sZV+REb7wfXm
         BDZYr9jzZwqfN1sQ/GYehEvI/mzCO29UrYvHs71AA+18M/f8Sb7R1empmFJFw18dVA6D
         xvxvTTo0/ff9uy71KSfpkLv/OLxEtS1EslkgC6/oZdgBvMUBHJ28jzpQxPp2HdLw+3XO
         DDZw==
X-Gm-Message-State: AOAM531SY2lDTVm3D2et4hyqPO1XToErK54k5bOgYFb3JSQS8uGVa18b
        4JRkTxiWGWqLBQcPIwUmuGevIw==
X-Google-Smtp-Source: ABdhPJycIi2+Vn9ABatwajG+Dhilho0TN/FMMDjOnoziaYPiya9elHzBD+iWU3/AWPVr+pYv/+OyLA==
X-Received: by 2002:a62:3c4:0:b029:1ee:9771:2621 with SMTP id 187-20020a6203c40000b02901ee97712621mr2874134pfd.47.1615284535384;
        Tue, 09 Mar 2021 02:08:55 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id a70sm9258424pfa.202.2021.03.09.02.08.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Mar 2021 02:08:54 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 0/4] Use obj_cgroup APIs to charge kmem pages
Date:   Tue,  9 Mar 2021 18:07:13 +0800
Message-Id: <20210309100717.253-1-songmuchun@bytedance.com>
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

Muchun Song (4):
  mm: memcontrol: introduce obj_cgroup_{un}charge_pages
  mm: memcontrol: make page_memcg{_rcu} only applicable for non-kmem
    page
  mm: memcontrol: use obj_cgroup APIs to charge kmem pages
  mm: memcontrol: move PageMemcgKmem to the scope of CONFIG_MEMCG_KMEM

 include/linux/memcontrol.h | 103 ++++++++++++++++++++++++------
 mm/memcontrol.c            | 156 +++++++++++++++++++++++++++++++--------------
 mm/page_alloc.c            |   4 +-
 3 files changed, 191 insertions(+), 72 deletions(-)

-- 
2.11.0

