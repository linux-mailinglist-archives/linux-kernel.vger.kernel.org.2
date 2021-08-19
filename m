Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648453F13F1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 09:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhHSHB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 03:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbhHSHBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 03:01:54 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF59C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 00:01:18 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id k14so4984148pga.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 00:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=COyVX7DGswoLsT07bE7693Is9lpdbptkw7XZJq06dVE=;
        b=mbMCyhird95qS+Yla1yXzpOlmZrRUMQ71pWPpfzmMopuQKJvRINFP/i47lYrDp/uAs
         T7mgM7lTYPbqV9o9fN29nmg9nOo+Qb94iLBjQpSJA2hFDzloeoeOU7XhOdnr8Je4gyOM
         dShHm47W8pdOJvS9EytUQzkcR/CW5SV1UOvK1k8kHDz0F7pcZ9JZSP+t0vuEd6XMUDCO
         GA55e06bVgTC839A0JCWtfzNgpw8lfbAxGXBNSN38dnNAhT3c/vVVCTUOzA2X1qEOhhI
         mTXJ/DuszuE43W7eAfUeylslFj8cgYhZfOt6pYs2rQXC/ve40/yRb5nAr0Rw88zgQbhr
         Xhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=COyVX7DGswoLsT07bE7693Is9lpdbptkw7XZJq06dVE=;
        b=q69FYiJChKjU4A2FDsSSX4D34fAvxg0ghhXmYriqEMb/bke6xRNH18TGaDaUaGjkc2
         h6IDIRv4rNzDsDX8bDoYl57wCyTHz5yp4SEa+9CrU3fksxobILPvPRHlIuXnRwhjHZ9W
         /UiFPbN3p/+3xqJYA+DT+qtpIWrCUvjNPf0H7u2ioPrzKQp9NkdgPlwEYGPhG6mEl7vn
         G6JCyOdJnJVmyhXRzSFr8Ki6uB9kn+ELuEh5clkeriK8AT/4l8HIZBE736qcWpXWAYAl
         MUfER/73f3AxNXdiaREJZ3mBujXQcc4h2mKw0U3cIUWsN6fHafJ+YodrTTgOp1R4CTNK
         3G4Q==
X-Gm-Message-State: AOAM530Sm4EshCTD3Bp8Zkdl9cNX3Sa4svzziTTUJRzgSwxy1y+ZRykk
        Jsh+/HrCfXiHwu3ysdnUdgEpjw==
X-Google-Smtp-Source: ABdhPJx2xyVqZmF+texY3vtwLaBS7RZT8T4ghFi9Ki5m8/cAxmOqX5mlxtewEl+7oTvNcjN1iz8mog==
X-Received: by 2002:a63:25c7:: with SMTP id l190mr12592795pgl.165.1629356477276;
        Thu, 19 Aug 2021 00:01:17 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id t30sm2490395pgl.47.2021.08.19.00.01.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Aug 2021 00:01:16 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net, willy@infradead.org
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 0/4] Free the 2nd vmemmap page associated with each HugeTLB page
Date:   Thu, 19 Aug 2021 14:58:27 +0800
Message-Id: <20210819065831.43186-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 include/linux/hugetlb.h                         |   6 +-
 include/linux/page-flags.h                      |  77 ++++++++++++-
 mm/hugetlb_vmemmap.c                            |  64 ++++++-----
 mm/ptdump.c                                     |  16 ++-
 mm/sparse-vmemmap.c                             |  70 +++++++++---
 tools/testing/selftests/vm/vmemmap_hugetlb.c    | 139 ++++++++++++++++++++++++
 7 files changed, 320 insertions(+), 54 deletions(-)
 create mode 100644 tools/testing/selftests/vm/vmemmap_hugetlb.c

-- 
2.11.0

