Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C16A4315FB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 12:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhJRK1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 06:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhJRK1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:27:34 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D125AC061714
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:25:23 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t184so2669080pgd.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5hJn0tv/F/sL1RuQjVyX8qRGIEQO8ATZ5/GOtF8kpVA=;
        b=l2NO6x5eM9wLywlxnSerCAgsD5jECSbuwWbvmAFt4JDEq/bk3MZIIfPLZ9J9LDkSeP
         J3reA8F6aOrYVqcryC67lgrjNezRjloVhkxyPOeJ81KgsJq/1KyMnk2GfIqpXBNKNIy/
         PNGZnujYEaDAxv7RAPhtjIfCdpz/8sB5Dh0Rr016aOe6K3n6OmLXOiN1+yui/o00/LLn
         ePXGjbrwNNFlDBYwVu+OM2oJJoUcpZoUKEruWPcu2q5Tsp0zF6mdKfwfewi1/xWuNJyi
         asJyEPiTpBKIkQ765pXbRHtjgGjOP9mVTu4MtygppUob3e9vO3aWz1jFz/KO19MCp6I8
         Dh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5hJn0tv/F/sL1RuQjVyX8qRGIEQO8ATZ5/GOtF8kpVA=;
        b=qDS86Fp6nK+cKaMNuEwKqMxCrfTiKJ3PUpkhYMKwUPh+s8E/HMqk/8PQmw2HNxW5Ab
         jisOloYF0UiwXwLhH5Qr6iUg6dbGCWgMer2+jfmsLSxLc1MCD+mWuf4DuYld512wQjXb
         yRMrXyEXjC4QUFGrJcw2EdTkUTzP17RxCR4AU5mhyBcSRap7jI2QJUUyFlFy0O7OpLKY
         G3oQPMDBKDS6UPzYceKXIeNu5TrWt9088HrmWJe2M6a5tflCfXcgcQu9r5KJHyRGr6kZ
         S9dE/Gp2TfyoCDYaIlFN9hhlexnIyfbIAeNTIhj9PWRN2Uq8DvPbcsKwa18G/aHmOeKt
         Y8nA==
X-Gm-Message-State: AOAM5304Z/Qm4m4YfFVrJWKFVTStag8y5p7RRqw7JVn5w9IixQ4AwJ4o
        a6WNME19OIdQACFGiMGhfEVX3A==
X-Google-Smtp-Source: ABdhPJzzKT7TTsX32cSWNDr4cq0BkhbHPkjGlD/9X2eT0kWw4s+Fpr7VuB057mDIH/syreRqhcw9jg==
X-Received: by 2002:a63:7:: with SMTP id 7mr23068169pga.127.1634552723108;
        Mon, 18 Oct 2021 03:25:23 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id nn14sm12762232pjb.27.2021.10.18.03.25.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Oct 2021 03:25:22 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net, willy@infradead.org, 21cnbao@gmail.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 0/5] Free the 2nd vmemmap page associated with each HugeTLB page
Date:   Mon, 18 Oct 2021 18:20:38 +0800
Message-Id: <20211018102043.78685-1-songmuchun@bytedance.com>
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

Changlogs in v6:
  1. Add test case to tools/testing/selftests/vm/run_vmtests.sh.

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
 mm/sparse-vmemmap.c                             |  70 +++++++++---
 tools/testing/selftests/vm/.gitignore           |   1 +
 tools/testing/selftests/vm/Makefile             |   1 +
 tools/testing/selftests/vm/hugepage-vmemmap.c   | 144 ++++++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests.sh       |  11 ++
 12 files changed, 349 insertions(+), 62 deletions(-)
 create mode 100644 tools/testing/selftests/vm/hugepage-vmemmap.c

-- 
2.11.0

