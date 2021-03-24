Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447E7347939
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbhCXNF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbhCXNEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:04:40 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B82C0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:04:40 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id g24so17414286qts.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j0CqnAVsF9iIq72FSY5/2tgqqV4XECVUv8SK3zE7CTY=;
        b=JMn20Exhn5AF9iVbHFihX0Do2+gE1wVc/NYqqeIDXCp162ejYRW5lNKJVKUKqEA4le
         KnruIw0K0LVHu04dpMNDEKOXX3KDrf1gk8niODEsLXDxEPcsziJDZlcSPI1wSPKwIKTI
         a3U4hc1TBHJdqImCMPeqlkT68jGM7D2prbyl4swtp5b3CO0vcRLt2HtA3WhH4YB379HB
         dzgrq73d08KJbyLOvPPVKUsvNtjsIVl/C5zenj7OeCCf/2SQV3zS554zBMWZkGUXXIBT
         0+s0nMwG31Nbq2SjMnVyJp8b8/eAPU3bE+uwTKY3kZdI78wKs2xPp1bz6iYWZ44j8yUs
         VEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j0CqnAVsF9iIq72FSY5/2tgqqV4XECVUv8SK3zE7CTY=;
        b=Sr88bZsLO0KnJ2j0isfVpYu9Vp7CAeCvop+rVL0r6xg4TNhOscjpyFg8/YRr6YKiMk
         5JZYLlOHWBJnyF0m03kuF1rOTqkuwwNxK1wBq428PcEi8A4a5u7Nq1yFcZj+XOSZoJdG
         XZr0OVkwY+NAmHxME0fqaCmS6x4Yk7aGsWB32fuW5NPoukQWoKVurrWqDQbwOW5OIM2d
         +UaKEKjPn5vKQwgDKpks9oLVuwIYNPz/Yt1QSgFz6+HKfoO33eZ6DY8dEHNbv8y1zde/
         IQt0GCgO1Ima6AzWNxmA0jemNkNjKpKpk4jdZsPE9s50psFW8A7wY9/NeWoRT24unaYp
         DRyw==
X-Gm-Message-State: AOAM533ykxl0DMFajYFz/RhLCr+z3pcSEdwEBMjo3VvjfZZkUszs8QGA
        i93O20bv6Ut6RC7jQzAssQM=
X-Google-Smtp-Source: ABdhPJzvSDWcdG84lomgGb6w6kdk1ML22JHRCIILtxuVx/FBiJCnuNNnY2Osfp2pmAb6X8O77pnI9Q==
X-Received: by 2002:ac8:660f:: with SMTP id c15mr2712873qtp.278.1616591079576;
        Wed, 24 Mar 2021 06:04:39 -0700 (PDT)
Received: from Slackware.localdomain ([156.146.36.138])
        by smtp.gmail.com with ESMTPSA id d84sm1627313qke.53.2021.03.24.06.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 06:04:38 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] mm/slub.c: Trivial typo fixes
Date:   Wed, 24 Mar 2021 18:36:19 +0530
Message-Id: <20210324130619.16872-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/operatios/operation/
s/Mininum/Minimum/
s/mininum/minimum/  ......two different places.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 mm/slub.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 3021ce9bf1b3..cd3c7be33f69 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3,7 +3,7 @@
  * SLUB: A slab allocator that limits cache line use instead of queuing
  * objects in per cpu and per node lists.
  *
- * The allocator synchronizes using per slab locks or atomic operatios
+ * The allocator synchronizes using per slab locks or atomic operation
  * and only uses a centralized lock to manage a pool of partial slabs.
  *
  * (C) 2007 SGI, Christoph Lameter
@@ -160,7 +160,7 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
 #undef SLUB_DEBUG_CMPXCHG

 /*
- * Mininum number of partial slabs. These will be left on the partial
+ * Minimum number of partial slabs. These will be left on the partial
  * lists even if they are empty. kmem_cache_shrink may reclaim them.
  */
 #define MIN_PARTIAL 5
@@ -832,7 +832,7 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
  *
  * 	A. Free pointer (if we cannot overwrite object on free)
  * 	B. Tracking data for SLAB_STORE_USER
- * 	C. Padding to reach required alignment boundary or at mininum
+ * 	C. Padding to reach required alignment boundary or at minimum
  * 		one word if debugging is on to be able to detect writes
  * 		before the word boundary.
  *
@@ -3421,7 +3421,7 @@ static unsigned int slub_min_objects;
  *
  * Higher order allocations also allow the placement of more objects in a
  * slab and thereby reduce object handling overhead. If the user has
- * requested a higher mininum order then we start with that one instead of
+ * requested a higher minimum order then we start with that one instead of
  * the smallest order which will fit the object.
  */
 static inline unsigned int slab_order(unsigned int size,
--
2.30.1

