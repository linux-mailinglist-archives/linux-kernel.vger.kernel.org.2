Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36903414620
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 12:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbhIVK2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 06:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhIVK2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 06:28:31 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB6FC061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 03:27:02 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id j15so23012plh.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 03:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+oUB7HAoD4wBiJlrX27jdtnkAUYacWVBdRBc24wDAnY=;
        b=109xe3JMexjuDNZFOZnCjwRHqec3HiXUEKhmCTXbeoo/oUzyMyd7pesufk7AL+bJGz
         kfMeNnEvW6uI81FcpdMlI9JEiCVdaBFo6GoEWaOEnBQs8Md/qdC1O+QRPvFA6oKv3MlC
         2wA8FLCLr6BH90WmxryCX4QGPu9sevwBxkiwdoyFwTQsh+ly4cHyLqa7YlZUU4N1XDc+
         iUZrRGmDjuOpEWhx7UVGgifZ3fDPxty9zNMdwxAzU8T5Ts3oouD9TJim7CLl3RVze3bF
         GEyvSrBQEcx1fDw+Kzgb/59/oQISeBmtQdB9XGMHySStP9FajRTl76GMO6O0E7jFVQen
         rBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+oUB7HAoD4wBiJlrX27jdtnkAUYacWVBdRBc24wDAnY=;
        b=QU0bXoN9aOHdoJSzpH1xfdyq63VdsJOFky3TDyDKkoUClQ1ReSI3yOuO2i6/f69fwA
         RzbClfYkHmeF9V+P5Us9b9HgR3vqDM6HfTObY3ta7/sKSSI+fIL0giYNzPXN3Oy2XKnA
         zeGZTJTsIACfx9FuUReNI6slfkHQ2vBmT5KnGFxKeoOLOOPavb3La68MyiorhkLGybhv
         eGTaALrXhSbR5SlYqJH5W2pBgkMyWTFyC2y7TZ0KJ4eUlhQD+ejvRkWaBjdqdmbNxx0/
         drHlxEt54s5GPWG/o9iCeaXcuNXH1+hY/vz8Khrq24qe0YdPWq9BmCfG1mN/k/zvuUQm
         jEGA==
X-Gm-Message-State: AOAM5337pJB4bQPFDcLfbIvzRXZYXIjdm/IKqhpR4uRRPH4LaRGM4QCZ
        nl6B48L9b5kJsrGeVbXS+ezd3Q==
X-Google-Smtp-Source: ABdhPJyYI4JmmPfcSXxDKV5iqZ0hKywDYyp4wSBjwQizG5ozLGDpSom6m2tA19h2Ve43QA6xwsk3Rw==
X-Received: by 2002:a17:90a:193:: with SMTP id 19mr10372052pjc.164.1632306421592;
        Wed, 22 Sep 2021 03:27:01 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id s89sm1821929pjj.43.2021.09.22.03.26.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Sep 2021 03:27:01 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net, willy@infradead.org, 21cnbao@gmail.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 0/4] Free the 2nd vmemmap page associated with each HugeTLB page
Date:   Wed, 22 Sep 2021 18:24:07 +0800
Message-Id: <20210922102411.34494-1-songmuchun@bytedance.com>
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

Muchun Song (4):
  mm: hugetlb: free the 2nd vmemmap page associated with each HugeTLB
    page
  mm: hugetlb: replace hugetlb_free_vmemmap_enabled with a static_key
  mm: sparsemem: use page table lock to protect kernel pmd operations
  selftests: vm: add a hugetlb test case

 Documentation/admin-guide/kernel-parameters.txt |   2 +-
 include/linux/hugetlb.h                         |  10 +-
 include/linux/page-flags.h                      |  79 ++++++++++++-
 mm/hugetlb_vmemmap.c                            |  66 ++++++-----
 mm/memory_hotplug.c                             |   2 +-
 mm/ptdump.c                                     |  16 ++-
 mm/sparse-vmemmap.c                             |  70 +++++++++---
 tools/testing/selftests/vm/vmemmap_hugetlb.c    | 144 ++++++++++++++++++++++++
 8 files changed, 332 insertions(+), 57 deletions(-)
 create mode 100644 tools/testing/selftests/vm/vmemmap_hugetlb.c

-- 
2.11.0

