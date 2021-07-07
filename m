Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1143BE241
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 06:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhGGE6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 00:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhGGE6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 00:58:49 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D2FC061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 21:56:10 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1625633768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8m+HNzVq0gzAYARME3oTYtiO24eMnzxPfdq9z6WDvVY=;
        b=BS2cpujjXcxcQM/8jKe/Ly7M0+wg8SlEMO91M2i6vErlvqcA0xhIHVXSRQUIF0Jw8aC3/W
        MSDYWWMQ4aEVXcrFaVukADMvYyYxH54G1bPu6XAsJZcXiduWrWKoRuX39UuGEJnmcVwyCl
        bM6pOavQAX1QMRfUvDW+nmvhmt3WDpo=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Wang Wensheng <wangwensheng4@huawei.com>, rui.xiang@huawei.com,
        k-hagio-ab@nec.com, Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/sparse: set SECTION_NID_SHIFT to 6
Date:   Wed,  7 Jul 2021 13:55:48 +0900
Message-Id: <20210707045548.810271-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Currently SECTION_NID_SHIFT is set to 3, which is incorrect because
bit 3 and 4 can be overlapped by sub-field for early NID, and can be
unexpectedly set on NUMA systems.  There are a few non-critical issues
related to this:

  - Having SECTION_TAINT_ZONE_DEVICE set for wrong sections forces
    pfn_to_online_page() through the slow path, but doesn't actually
    break the kernel.

  - A kdump generation tool like makedumpfile uses this field to
    calculate the physical address to read.  So wrong bits can make
    the tool access to wrong address and fail to create kdump.
    This can be avoided by the tool, so it's not critical.

To fix it, set SECTION_NID_SHIFT to 6 which is the minimum number of
available bits of section flag field.

Fixes: 1f90a3477df3 ("mm: teach pfn_to_online_page() about ZONE_DEVICE section collisions")
Reported-by: Kazuhito Hagio <k-hagio-ab@nec.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mmzone.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git v5.13/include/linux/mmzone.h v5.13_patched/include/linux/mmzone.h
index 0d53eba1c383..a6829b652d79 100644
--- v5.13/include/linux/mmzone.h
+++ v5.13_patched/include/linux/mmzone.h
@@ -1344,7 +1344,7 @@ extern size_t mem_section_usage_size(void);
 #define SECTION_TAINT_ZONE_DEVICE	(1UL<<4)
 #define SECTION_MAP_LAST_BIT		(1UL<<5)
 #define SECTION_MAP_MASK		(~(SECTION_MAP_LAST_BIT-1))
-#define SECTION_NID_SHIFT		3
+#define SECTION_NID_SHIFT		6
 
 static inline struct page *__section_mem_map_addr(struct mem_section *section)
 {
-- 
2.25.1

