Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80ACC30ABB4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhBAPlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbhBAPkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:40:09 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E89EC061353
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 07:38:41 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id z22so12520891qto.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 07:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/AUhcfgz8BqXY0TY4shngd6CAaVvD3HDn/nwJr6Nrs4=;
        b=J0xGVvXRyRtWX7IJwY7ZVHBmI78Fn3Ltd6jNbFmk9+dfXXJO1bTfqrksEDtYyC8qxU
         ZJzAGy4HJiS86t8LsCTsVl3a2dU95OYloMArtE9XuPAO6Yt6+7iZAU1pt3pfhKlD/4AO
         t5NeXpJqcv+Hve1c4YUVibNCo7wqE5BnYCs4gWjDkOv+k72xPpDjyJyzEu6yeZwgSxQe
         0lmHt6hNL2dS4Qp/2/7MB7Psif9ftncTO4GZd5Jpe0pSuQ1RoiY/5MsP6DuopYkU0PIj
         4jz3acq+c78oe/mCq3DLO8hufZxqyzBRviBCSIDgGISsaTHEQ99bkdp6kJfrtijZB4cj
         HcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/AUhcfgz8BqXY0TY4shngd6CAaVvD3HDn/nwJr6Nrs4=;
        b=CK8idpoGFqM35cOXbScu7lv+jZRovOnFpYlk9g0PFNpbRsbLksx+H508a5gETJrfpR
         yIaigCkUm66upk9s3nfH/LfkQj+zUWhU4jKGpgPx9N+0mCryVJNvGgeGMVkkQCT7/y6i
         nZL12TNaZFfPBx2vGPq1UgKDUYCQdd0fOOU3ia0ca7Wag6+9zsYvp58OE1yuRb1ioLFS
         dp8cDsHtjjcczo0gRc6q5K8PL11KxNxcDDdt3RNoz2YjX6SkCL+cxGgw6VIEkHlxGOlL
         xlw12GO6N9llk4pxzYWTrxwIAKN0TLmsdhQIAX5LuZn0AHa/Q2qPb3t0jsYnbEjgMXl6
         XQQA==
X-Gm-Message-State: AOAM530JKrBjW/1irwWbvgsoXGNL3x+EycIAUnkykG6byb8h4+0lykg+
        K52mHfhaZB4NYsUEKMH7QwydJw==
X-Google-Smtp-Source: ABdhPJzyB0sy//43549QIh7s23fE77NugVMuru2y9cW+ShcV76N4UEQl0bPFelNsWeHZ+WSihm3pIw==
X-Received: by 2002:aed:20a8:: with SMTP id 37mr15938278qtb.362.1612193920386;
        Mon, 01 Feb 2021 07:38:40 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 22sm14853307qke.123.2021.02.01.07.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 07:38:39 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com,
        linux-doc@vger.kernel.org, ira.weiny@intel.com,
        linux-kselftest@vger.kernel.org, jmorris@namei.org
Subject: [PATCH v9 06/14] mm: apply per-task gfp constraints in fast path
Date:   Mon,  1 Feb 2021 10:38:19 -0500
Message-Id: <20210201153827.444374-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201153827.444374-1-pasha.tatashin@soleen.com>
References: <20210201153827.444374-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function current_gfp_context() is called after fast path. However, soon we
will add more constraints which will also limit zones based on context.
Move this call into fast path, and apply the correct constraints for all
allocations.

Also update .reclaim_idx based on value returned by current_gfp_context()
because it soon will modify the allowed zones.

Note:
With this patch we will do one extra current->flags load during fast path,
but we already load current->flags in fast-path:

__alloc_pages_nodemask()
 prepare_alloc_pages()
  current_alloc_flags(gfp_mask, *alloc_flags);

Later, when we add the zone constrain logic to current_gfp_context() we
will be able to remove current->flags load from current_alloc_flags, and
therefore return fast-path to the current performance level.

Suggested-by: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/page_alloc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 39f46fe122b7..a068e8295931 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4982,6 +4982,13 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 	}
 
 	gfp_mask &= gfp_allowed_mask;
+	/*
+	 * Apply scoped allocation constraints. This is mainly about GFP_NOFS
+	 * resp. GFP_NOIO which has to be inherited for all allocation requests
+	 * from a particular context which has been marked by
+	 * memalloc_no{fs,io}_{save,restore}.
+	 */
+	gfp_mask = current_gfp_context(gfp_mask);
 	alloc_mask = gfp_mask;
 	if (!prepare_alloc_pages(gfp_mask, order, preferred_nid, nodemask, &ac, &alloc_mask, &alloc_flags))
 		return NULL;
@@ -4997,13 +5004,7 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 	if (likely(page))
 		goto out;
 
-	/*
-	 * Apply scoped allocation constraints. This is mainly about GFP_NOFS
-	 * resp. GFP_NOIO which has to be inherited for all allocation requests
-	 * from a particular context which has been marked by
-	 * memalloc_no{fs,io}_{save,restore}.
-	 */
-	alloc_mask = current_gfp_context(gfp_mask);
+	alloc_mask = gfp_mask;
 	ac.spread_dirty_pages = false;
 
 	/*
-- 
2.25.1

