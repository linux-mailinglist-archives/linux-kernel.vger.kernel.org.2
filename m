Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DAE4185DB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 05:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhIZDQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 23:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhIZDQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 23:16:22 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753C4C061575
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 20:14:46 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id rm6-20020a17090b3ec600b0019ece2bdd20so898890pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 20:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LEYifntHxbf4niSsmSpCrKDuNhYqIVKqpWQAsAPTlHE=;
        b=xBIjsPWVojFMyikX+rFQV8u30ob7OW1w1Doopm/Ga0IUEY+5mWB73wotObWku3swqc
         ui7S7R/lvkJkn0dFO//pFNEkI1gOsnDkvZu2OL4rXY7zJNZfG4XJSZmhbL8mF4uVQ07x
         NIR0u3Q3bNKZZVgPR97DmVOM7y4yAupSFekTZGGtIppJV+SXCDEp71ruORbum87Rx1lD
         0Yib4SoD5/XjCCX5QWRtJXeXebqk8awsEvfeRYX2ijL5HWeTM8J1Escl53XOE5ojsobW
         DJLXjIJVI0snw5yio+G+kOCNX3tQg+j2z5d5/g+KkNR9+06dJi13bnxmrlBwCjeWFgqh
         5zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LEYifntHxbf4niSsmSpCrKDuNhYqIVKqpWQAsAPTlHE=;
        b=x2DX8xGG6ImskbtDunpisbua9KbhwUyk8WBMlJnb1ubg+SkD+Eb9yYRVfceSb6hfG4
         UBa27lT+ZyAnqiX1kSjkrRlPIgrfX5zt3SpvrcsJh9CEb5TjFktUD/TbRIPt/4S9AERV
         yteaFVnh8dxRV2Od0bZMtzk7GaB4i4Ya0lhRR8L6XL+rOggqGajHiH0xyBcWNd0ZhCD0
         II0N/2g2FPVq3UeyKfvY8AJ81bvgOZgbNFKrHmgNEkhauON53TqB+XYGt+XRPqCbBLKx
         dnJEQInWNiwpOXdM9mieb3CGrQLm698tadUlzYZxhXILy/l6CUQNA7KXt3jARdi0uxaD
         BPLA==
X-Gm-Message-State: AOAM531M8bE+2upKcq9v89KCiQMPJl9GTH5rDZCI1yRXa/Y13OQpOf6Q
        PrCfb6nuBA+5KL9rbK2jj7a/pA==
X-Google-Smtp-Source: ABdhPJwMzvrM16dg/m4qcSFzcidAmRqAqvBipOxS9Il4c7S1MnsH7sAHbdpqUR7Pw1vEGQwEUgtjaA==
X-Received: by 2002:a17:902:c084:b0:13d:c6ef:7cf0 with SMTP id j4-20020a170902c08400b0013dc6ef7cf0mr16099713pld.4.1632626085852;
        Sat, 25 Sep 2021 20:14:45 -0700 (PDT)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id v26sm13374862pfm.175.2021.09.25.20.14.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Sep 2021 20:14:45 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net, willy@infradead.org, 21cnbao@gmail.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 0/5] Free the 2nd vmemmap page associated with each HugeTLB page
Date:   Sun, 26 Sep 2021 11:13:34 +0800
Message-Id: <20210926031339.40043-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series can minimize the overhead of struct page for 2MB HugeTLB pages
significantly, comments and reviews are welcome. Thanks.

After the feature of "Free sonme vmemmap pages of HugeTLB page" is enabled,
the mapping of the vmemmap addresses associated with a 2MB HugeTLB page
becomes the figure below.

     HugeTLB                  struct pages(8 pages)         page frame(8 pages)
 +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+---> PG_head
 |           |                     |     0     | -------------> |     0     |
 |           |                     +-----------+                +-----------+
 |           |                     |     1     | -------------> |     1     |
 |           |                     +-----------+                +-----------+
 |           |                     |     2     | ----------------^ ^ ^ ^ ^ ^
 |           |                     +-----------+                   | | | | |
 |           |                     |     3     | ------------------+ | | | |
 |           |                     +-----------+                     | | | |
 |           |                     |     4     | --------------------+ | | |
 |    2MB    |                     +-----------+                       | | |
 |           |                     |     5     | ----------------------+ | |
 |           |                     +-----------+                         | |
 |           |                     |     6     | ------------------------+ |
 |           |                     +-----------+                           |
 |           |                     |     7     | --------------------------+
 |           |                     +-----------+
 |           |
 |           |
 |           |
 +-----------+

As we can see, the 2nd vmemmap page frame (indexed by 1) is reused and remaped.
However, the 2nd vmemmap page frame is also can be freed to the buddy allocator,
then we can change the mapping from the figure above to the figure below.

    HugeTLB                  struct pages(8 pages)         page frame(8 pages)
 +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+---> PG_head
 |           |                     |     0     | -------------> |     0     |
 |           |                     +-----------+                +-----------+
 |           |                     |     1     | ---------------^ ^ ^ ^ ^ ^ ^
 |           |                     +-----------+                  | | | | | |
 |           |                     |     2     | -----------------+ | | | | |
 |           |                     +-----------+                    | | | | |
 |           |                     |     3     | -------------------+ | | | |
 |           |                     +-----------+                      | | | |
 |           |                     |     4     | ---------------------+ | | |
 |    2MB    |                     +-----------+                        | | |
 |           |                     |     5     | -----------------------+ | |
 |           |                     +-----------+                          | |
 |           |                     |     6     | -------------------------+ |
 |           |                     +-----------+                            |
 |           |                     |     7     | ---------------------------+
 |           |                     +-----------+
 |           |
 |           |
 |           |
 +-----------+

After we do this, all tail vmemmap pages (1-7) are mapped to the head vmemmap
page frame (0). In other words, there are more than one page struct with
PG_head associated with each HugeTLB page.  We __know__ that there is only one
head page struct, the tail page structs with PG_head are fake head page structs.
We need an approach to distinguish between those two different types of page
structs so that compound_head(), PageHead() and PageTail() can work properly
if the parameter is the tail page struct but with PG_head.

The following code snippet describes how to distinguish between real and fake
head page struct.

	if (test_bit(PG_head, &page->flags)) {
		unsigned long head = READ_ONCE(page[1].compound_head);

		if (head & 1) {
			if (head == (unsigned long)page + 1)
				==> head page struct
			else
				==> tail page struct
		} else
			==> head page struct
	}

We can safely access the field of the @page[1] with PG_head because the @page
is a compound page composed with at least two contiguous pages. The main
implementation is in the patch 1.

In our server, we can save extra 2GB memory with this patchset applied if there
are 1 TB HugeTLB (2 MB) pages. If the size of the HugeTLB page is 1 GB, it only
can save 4MB. For 2 MB HugeTLB page, it is a nice gain.

Changlogs in v4:
  1. Move hugetlb_free_vmemmap_enabled from hugetlb.h to page-flags.h.
  2. Collect Reviewed-by.
  3. Add a new patch to move vmemmap functions related to HugeTLB to
     the scope of the CONFIG_HUGETLB_PAGE_FREE_VMEMMAP.

  Thanks Barry for his suggestions and reviews.

Changlogs in v3:
  1. Rename page_head_if_fake() to page_fixed_fake_head().
  2. Introducing a new helper page_is_fake_head() to make code more readable.
  3. Update commit log of patch 3 to add more judgements.
  4. Add some comments in check_page_flags() in the patch 4.

  Thanks Barry for his suggestions and reviews.

Changlogs in v2:
  1. Drop two patches of introducing PAGEFLAGS_MASK from this series.
  2. Let page_head_if_fake() return page instead of NULL.
  3. Add a selftest to check if PageHead or PageTail work well.

Muchun Song (5):
  mm: hugetlb: free the 2nd vmemmap page associated with each HugeTLB
    page
  mm: hugetlb: replace hugetlb_free_vmemmap_enabled with a static_key
  mm: sparsemem: use page table lock to protect kernel pmd operations
  selftests: vm: add a hugetlb test case
  mm: sparsemem: move vmemmap related to HugeTLB to
    CONFIG_HUGETLB_PAGE_FREE_VMEMMAP

 Documentation/admin-guide/kernel-parameters.txt |   2 +-
 include/linux/hugetlb.h                         |   6 -
 include/linux/mm.h                              |   2 +
 include/linux/page-flags.h                      |  90 ++++++++++++++-
 mm/hugetlb_vmemmap.c                            |  66 ++++++-----
 mm/memory_hotplug.c                             |   2 +-
 mm/ptdump.c                                     |  16 ++-
 mm/sparse-vmemmap.c                             |  72 +++++++++---
 tools/testing/selftests/vm/vmemmap_hugetlb.c    | 144 ++++++++++++++++++++++++
 9 files changed, 339 insertions(+), 61 deletions(-)
 create mode 100644 tools/testing/selftests/vm/vmemmap_hugetlb.c

-- 
2.11.0

