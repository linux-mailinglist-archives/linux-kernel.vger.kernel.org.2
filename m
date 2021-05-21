Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506E438CF37
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 22:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhEUUpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 16:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhEUUpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 16:45:34 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7BCC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 13:44:10 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id f12so25469596ljp.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 13:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HBeodYY2Z6u1fLnq0vAjJboMG5Q47PXwcvj3JybNYOE=;
        b=tDdOpNSUHvr8Gn6//uRLY42Rg35jF49VOuwoGXQ8cWeWks3VAmvx52Jb7Bdj/74uIG
         VeuP92MB7Iyf9PEkj7kTZuJlyOtmjCEj+bO0R4dMTSAOvimiQlhg1PIkxB59M2XyXzc1
         vIE9Pei2bmRVCIfwJJ+rJwrmc0sCJZl/lcSWH+qlzTkv2JYFDRIt0CO7XBaX+ZDfLBWj
         AJdSBO3mLQhK3ZImPNwGO+fh0WToEcocIWpOsnyrNniktggla6NxnqUGlnvk75MCtHWS
         rQ5SWfCPqg3CUuS4PdplD2IXSsYjiZlnStbcKTZAy16+7PxnFHPHLPMfpKUw2it7hocz
         THSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HBeodYY2Z6u1fLnq0vAjJboMG5Q47PXwcvj3JybNYOE=;
        b=ARU8ss8bXU9JFkjxYxQ5T1/CMpPrY+S3tV8TaqLJLgCzlOhPImThTk5BFgqR2gBubj
         QAuIhufnSUsQvyGlRTI3D2pdGirtxzHYCjPcVIJygb/9gSP/3nTvJt6ziaJDGjoCYKVx
         +8xg2+CK2Dw0mL2USBy8REDMjZYPyFhyauDHWpKSxSHCKYXNmmLMMkUXMhchSuEY7D6K
         pkhKUbC+DogkWNtN5p+0grt9vkFukNzWebFbG1yxTLQmLqNY4clZPBVLFdF+2AnTVPPk
         c8+pcrvxUfZMt9WKD4Nr49MdvbWYBUEAjfKDlg/XyWg1+oaGqHt8HR18XSmosDrVOeJf
         KSOA==
X-Gm-Message-State: AOAM53339J6DYC11JzCDx+XHj+Jg/92I8n8eSoGMHiR6rIsDmFKZAUN5
        ZJ0VR+cR/z3ztfHtRniscHE=
X-Google-Smtp-Source: ABdhPJxhcvvA7AVABrYgNxrl7zZ6WFCjRoasT4fWxfJpiD1S7okt8GMdq1kV65u1D8WGsWzQFi+05Q==
X-Received: by 2002:a2e:9605:: with SMTP id v5mr5153141ljh.501.1621629847871;
        Fri, 21 May 2021 13:44:07 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id v25sm734768lfe.60.2021.05.21.13.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 13:44:07 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] mm/vmalloc: Remove quoted string split across lines
Date:   Fri, 21 May 2021 22:43:59 +0200
Message-Id: <20210521204359.19943-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A checkpatch.pl script complains on splitting a text across
lines. It is because if a user wants to find an entire string
he or she will not succeeded.

<snip>
WARNING: quoted string split across lines
+               "vmalloc size %lu allocation failure: "
+               "page order %u allocation failed",

total: 0 errors, 1 warnings, 10 lines checked
<snip>

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 7765af7b1e9c..5749fa7b991f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2830,9 +2830,8 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 
 	if (!area->pages) {
 		warn_alloc(gfp_mask, NULL,
-			   "vmalloc size %lu allocation failure: "
-			   "page array size %lu allocation failed",
-			   nr_small_pages * PAGE_SIZE, array_size);
+			"vmalloc error: size %lu, failed to allocated page array size %lu",
+			nr_small_pages * PAGE_SIZE, array_size);
 		free_vm_area(area);
 		return NULL;
 	}
@@ -2851,8 +2850,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	 */
 	if (area->nr_pages != nr_small_pages) {
 		warn_alloc(gfp_mask, NULL,
-			"vmalloc size %lu allocation failure: "
-			"page order %u allocation failed",
+			"vmalloc error: size %lu, page order %u, failed to allocate pages",
 			area->nr_pages * PAGE_SIZE, page_order);
 		goto fail;
 	}
@@ -2860,9 +2858,8 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	if (vmap_pages_range(addr, addr + size, prot, area->pages,
 			page_shift) < 0) {
 		warn_alloc(gfp_mask, NULL,
-			   "vmalloc size %lu allocation failure: "
-			   "failed to map pages",
-			   area->nr_pages * PAGE_SIZE);
+			"vmalloc error: size %lu, failed to map pages",
+			area->nr_pages * PAGE_SIZE);
 		goto fail;
 	}
 
@@ -2907,8 +2904,8 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 
 	if ((size >> PAGE_SHIFT) > totalram_pages()) {
 		warn_alloc(gfp_mask, NULL,
-			   "vmalloc size %lu allocation failure: "
-			   "exceeds total pages", real_size);
+			"vmalloc error: size %lu, exceeds total pages",
+			real_size);
 		return NULL;
 	}
 
@@ -2939,8 +2936,8 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 				vm_flags, start, end, node, gfp_mask, caller);
 	if (!area) {
 		warn_alloc(gfp_mask, NULL,
-			   "vmalloc size %lu allocation failure: "
-			   "vm_struct allocation failed", real_size);
+			"vmalloc error: size %lu, vm_struct allocation failed",
+			real_size);
 		goto fail;
 	}
 
-- 
2.20.1

