Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C21741AF2F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240731AbhI1MoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240592AbhI1MoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:44:11 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC33CC061604
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 05:42:32 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id j14so14111352plx.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 05:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=To3y7HtgYsL7Rpxh5SAGxzE+EsS01iqLlMZsdJ4HpF4=;
        b=bVROHrCG1cgR4fnPhzWHBdKLjrMzdrTT2Nl5kQFyozSCh3sBIVtokC//8KRhMw+Ztw
         4M7jzX0yb0tu3aU1ERqZG/dSZN4HW42CjSk5qdcxH5Afujv+Ec2Dv6xS+3gBkz532sBr
         U+5CcxJtV/BepeGIMkQgD1Ab4dTE4z2S4CvGS4hJUT9kvp8lmmxmbeuCey6CpZ4defcO
         Nx9TUSgruOLd7NDIBru+K112k8SbKXmlEsy4b2zzuQEwTnW4k5UgqG7uNzcj+Pif+2Gg
         FsUHyM23PuGCLysFD8vzQuzlKJv+Wq4zsOD57zq4YOHjQI35oDVqYKaEpcdiuPD38UK9
         Otdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=To3y7HtgYsL7Rpxh5SAGxzE+EsS01iqLlMZsdJ4HpF4=;
        b=Tex3nvH7LQw5UdvzYeExdCtO05pCt6peph3AZ2iPpSOhd5ldbEzOkCOdN72iKemvgL
         J+F5zgiIwr3Tp07HCCK8sTVC5DTZbRv5/UWDuN4OGpImizBvjP6YagzmKo6MClW1Pdnx
         z1nZ/7dJzS/zu8XyFeXeKjEqFCQKsoY7crETkI0YdrKqrplVgaf4mY1AuxnDQ8VY61kU
         ZhVlgMBKKU1CknP5jI79QSRbZBMoG4MzLtbtS6dVw2KUYBjz1DrH6T6UufL/zyNh1bnz
         LLh2a+kuNBeKXGnxVVaM/qswQXquRLXMI3UFCsrQZLx5m5qRT+/hbe5xoQplRxLYVfAY
         wXBw==
X-Gm-Message-State: AOAM531oy8yYAbBZxXpxY/9Wlr++wmB5qQkUfEPVRI89AuPqlWpr9KFq
        yJYLBQ6Sofi5nV1ruRQKeJp+xw==
X-Google-Smtp-Source: ABdhPJzW1+QNaQa05V415nL0fyGMUOcs8iH9fYrngQQVuIbM1UT/pf0j/qLf8Veewseh9p0deXDYbA==
X-Received: by 2002:a17:90a:19c2:: with SMTP id 2mr5358344pjj.227.1632832952187;
        Tue, 28 Sep 2021 05:42:32 -0700 (PDT)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id s17sm10055287pge.50.2021.09.28.05.42.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Sep 2021 05:42:31 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net, willy@infradead.org, 21cnbao@gmail.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 0/5] Free the 2nd vmemmap page associated with each HugeTLB page
Date:   Tue, 28 Sep 2021 20:41:47 +0800
Message-Id: <20210928124152.33634-1-songmuchun@bytedance.com>
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

Changlogs in v5:
  1. Move NR_RESET_STRUCT_PAGE to the front of reset_struct_pages().
  2. Collect Reviewed-by tags.

  Thanks Barry for his suggestions and reviews.

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

