Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461DE3C8164
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238359AbhGNJXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238147AbhGNJXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:23:43 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716E1C061760
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:20:52 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v14so1187318plg.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6+1Zi925Y3jPcRtbAKIcVV1fKTrsYAIlXF0kFmPpmxQ=;
        b=FvwWysAqaTK/8OoCr2rcrbgk8UIkYwN62kiGJOH1QSeJmvGlGaOsEwcfAJPNcnS1np
         BRTqw0hikwNjpkY6GexEqx9l0LOpOtC/IvLwsX75QDKxid+isjHlxaj04dgCYvDAOyRb
         vGJiiboAWUqCvUqJ6ql8uB4m087UrhwS6l3KJMa49e0CCpxpjvfRL44KiqldRcdJQRJX
         jWps8MTWlDFyNHg9lrISjLChE2CF999UbzU5mYNuxGQHW4md8cirwvCuiRs8+TuNcoOt
         ZbbDEd8uohJBWcOl8jxjWR3lPCwOmLYMqJRPbKAj5Kz5hnrz7Vv2mQqzVCr92cP791wI
         13/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6+1Zi925Y3jPcRtbAKIcVV1fKTrsYAIlXF0kFmPpmxQ=;
        b=C2rFz+s2Dk/1iIdzZiK/GecKUGRJoQkS1jPnILTn80hr2AAGSPGz0hdcyQV/aSC92E
         0zd7wgpOZ5muVeWEritInMTvWF4WK2TnAP63qzc2ohdkgiPhUjRgKxwvqJkVR5rspM3N
         IaI5puJjtSRp5eCwuZl5O+6aSpM1WLp4EP4OeLoJmEcXdDs/9w+VLBbgz5kITNWV+P0h
         UEoByKCvjm42GUSPJKyd8aJmFeLGXoDFw/Kl8ypiRM2tm2YwoUK3pDj/qluBZ0DjsMtq
         RMT8VY/AQJhs1Y77xKp97MJ/OYz4l411dlNNREPcpiAK1GTlRK8rBzQZaL6cIR5dcJPT
         6KdA==
X-Gm-Message-State: AOAM530cYG3hSBiogysRip00lhKq3lRkCIHcqRRd3yDFsINpCtWimuqc
        IwSBmtzeWfG+izD9fbf81QPQtA==
X-Google-Smtp-Source: ABdhPJzlFEfeANIpePsNfcifpvtfVZ7BKkvkdB69fY8s3YLkJ5V8SsI5wTMABLZPOXw/Z8jgOP4bPA==
X-Received: by 2002:a17:902:848e:b029:12b:57b:7f3e with SMTP id c14-20020a170902848eb029012b057b7f3emr7145216plo.61.1626254451873;
        Wed, 14 Jul 2021 02:20:51 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id k19sm1742540pji.32.2021.07.14.02.20.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Jul 2021 02:20:51 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 0/5] Free the 2nd vmemmap page associated with each HugeTLB page
Date:   Wed, 14 Jul 2021 17:17:55 +0800
Message-Id: <20210714091800.42645-1-songmuchun@bytedance.com>
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
implementation is in the patch 3.

In our server, we can save extra 2GB memory with this patchset applied if there
are 1 TB HugeTLB (2 MB) pages. If the size of the HugeTLB page is 1 GB, it only
can save 4MB. For 2 MB HugeTLB page, it is a nice gain.

Muchun Song (5):
  mm: introduce PAGEFLAGS_MASK to replace ((1UL << NR_PAGEFLAGS) - 1)
  mm: introduce save_page_flags to cooperate with show_page_flags
  mm: hugetlb: free the 2nd vmemmap page associated with each HugeTLB
    page
  mm: hugetlb: replace hugetlb_free_vmemmap_enabled with a static_key
  mm: sparsemem: use page table lock to protect kernel pmd operations

 Documentation/admin-guide/kernel-parameters.txt |   2 +-
 include/linux/hugetlb.h                         |   6 +-
 include/linux/page-flags.h                      | 103 ++++++++++++++++++++++--
 include/trace/events/mmflags.h                  |   4 +
 include/trace/events/page_ref.h                 |   8 +-
 lib/test_printf.c                               |   2 +-
 lib/vsprintf.c                                  |   2 +-
 mm/hugetlb_vmemmap.c                            |  67 ++++++++-------
 mm/ptdump.c                                     |  16 +++-
 mm/sparse-vmemmap.c                             |  70 ++++++++++++----
 10 files changed, 218 insertions(+), 62 deletions(-)

-- 
2.11.0

