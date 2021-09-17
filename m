Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D792640F08A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 05:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244126AbhIQDyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 23:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbhIQDyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 23:54:35 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAD5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 20:53:14 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id u18so8382874pgf.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 20:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rm6EeUoCRYmJ2BdDG5kCPIFNAlwopyz51pLT6akvkNs=;
        b=ejhvN83Mj4jeSAGtZSif1926Y2NfXIKdkI7XrxE5gs9OyvJP/HlQlIHr0lUgpdzq/v
         Lc7BOVm38k26e40TSb6qkkBcf4lv35xueCeuLcQn1phkzDng+9cvEMsRif6r2HrvoxiD
         6ecchTfTXEs3fwoZld8sX+zy602OTWq/wLQkyzd8uOX+9WZyNfMR2YAS3r2qq7PW7+RS
         m8vUIQvasFFBRqLi1xUuoOnNgjU5FGtab3dxSR+EYIxxjapoD03sFpfA7IASS6TXXxt8
         egKVm7RAfA6JWLc17SzTZ6ISNtX1opP3MZyDFQBPxDlcVAkxPPS3Qq3GwvdUaf57ODxq
         hv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rm6EeUoCRYmJ2BdDG5kCPIFNAlwopyz51pLT6akvkNs=;
        b=X44SAcbVfRqlQ6VreEQewuxRM9byiv5n9z94B1jhgBAscsZaTxpNjFXWqvnRWjhT4V
         KZBZUyNB+qkiYuBSoBFh4v71rBmrcuUo/tJo3LvwZgxPdd4279y9Y1netyDxK4JMn40B
         LwLAzT8+Q1m8noCatUHu/QSJHJ8GsNyqNkkBZPpg0JHLx5pxW8ZvNJEdPoY14FNywqlX
         UbCuMfT1lJuleCK1K90kIKuV3DOr32JuPC2RCiFdxD0eSp6ma1p6LdKg04Se9nCh07/P
         tv3ZMTuMttT1xu85ZHbALvdmcvsLd+iVdIU5JVt2x9NoUjZE5qK3A2SvPvfGQa6xahDA
         gAMw==
X-Gm-Message-State: AOAM531uN9klJKEAPODLPCYZrpLbfvdcvk2F+7d8PPEsndwf4Hl9+6n0
        vzU7kd5vwq33+bvz/LaDgT1IyQ==
X-Google-Smtp-Source: ABdhPJzK2WcooZDsrz+zDAKN+gV+tuKiNDR/DIVcULJ/CzeToKbWvZf1d06bfKOFxFYg+/+TAt3VYw==
X-Received: by 2002:a63:1358:: with SMTP id 24mr7880907pgt.327.1631850793936;
        Thu, 16 Sep 2021 20:53:13 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id g12sm8997704pja.28.2021.09.16.20.53.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 20:53:13 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net, willy@infradead.org
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH RESEND v2 0/4] Free the 2nd vmemmap page associated with each HugeTLB page
Date:   Fri, 17 Sep 2021 11:48:11 +0800
Message-Id: <20210917034815.80264-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series can minimize the overhead of struct page for 2MB HugeTLB pages
significantly, I'd like to get some review input. Thanks.

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

