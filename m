Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68ACC348537
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 00:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239032AbhCXXUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 19:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239041AbhCXXTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 19:19:55 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12540C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:19:55 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id y2so358660qtw.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pwqp4woCEM/8lkZdfdADrpPJtfyqEYwcyiw1y1Z2UXo=;
        b=BlD7Buk9Y+AzuOUep782IAd8wo1KZFUJVVfIubRgq41To90R1iWqse5RlihObYj0kH
         j+qQ+ZUXi/bPzIhC+ZTo1Xph3IEDLsK4ZwOF6Jxlvzi+92cQuVI3O9fRvxrGGuufQ7UJ
         I7NQnDecy5L8ZxFa20fY0Ndzd8ah8HR21Ufy2Dd6k5x0avW6LKJgk549GxptXNe3l0Rw
         suJB7WghFX7yui45HzyK9a/PLGMQj4fIA7cPwypVSYOoLXYsXK/f4X6TBNxf9uLhmU84
         cmoqvb9pPQZVhc9bK+64ITKvRMrZHCGU4KizbH/vdDo0KpWZuXkwYfWRHHDvab5+MIRn
         OabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pwqp4woCEM/8lkZdfdADrpPJtfyqEYwcyiw1y1Z2UXo=;
        b=R+QyVHwXsYWNfkR0bxqlOeChsgnvPKdW6mseNDbFkDbCxanJA9pH+451o2D8v3wo4O
         X3poxHOPWisD/Wuvlitu2SiCWml5qF+rh8Xp7rr/tU+UAHfAyc03v/Pmd4y9aiftz5t3
         lZUxP8vNwwANkl/sKe7iBvuYOLNB5gE97qBiKidJwypC7UTqkjSqhZOLkMp9P85HrUiS
         m8v0QK65ETDo04a1jUxr3pmSTnBjbrn6rD3lLsirVUx5LD5+S/gynucwmaD4hu1Uu02g
         R7NBqTfFx4p64IxHH9/a2LUQEeWJFxIgl+7QpkRxx+u8lAmk4OSElHisQ8BkI7dS9gQA
         HmwA==
X-Gm-Message-State: AOAM533Yn34BJ79YjX1a8gpWfAUUIwlJ8F67lkP5snolkMvto6ABW3NB
        WSNllo84Bm2fXJlcHGir7F0=
X-Google-Smtp-Source: ABdhPJziZ8mCry71FBaEfUaQWrt+PfkhXsYOFfv1qsNM0L6QD9aLqQT/Sy8Ruw4tUuX93Wd0Sy0RDA==
X-Received: by 2002:ac8:44b2:: with SMTP id a18mr5092462qto.285.1616627994380;
        Wed, 24 Mar 2021 16:19:54 -0700 (PDT)
Received: from Slackware.localdomain ([156.146.55.193])
        by smtp.gmail.com with ESMTPSA id v137sm2947861qkb.109.2021.03.24.16.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 16:19:53 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V2] mm/slub.c: Trivial typo fixes
Date:   Thu, 25 Mar 2021 10:19:40 +0530
Message-Id: <20210325044940.14516-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/operatios/operations/
s/Mininum/Minimum/
s/mininum/minimum/  ......two different places.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Changes from V1:
  David's finding incorporated.i.e operation->operations
 mm/slub.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 3021ce9bf1b3..75d103ad5d2e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3,7 +3,7 @@
  * SLUB: A slab allocator that limits cache line use instead of queuing
  * objects in per cpu and per node lists.
  *
- * The allocator synchronizes using per slab locks or atomic operatios
+ * The allocator synchronizes using per slab locks or atomic operations
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

