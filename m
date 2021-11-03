Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2485C4445EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 17:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbhKCQc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 12:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbhKCQc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 12:32:56 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CFCC061203
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 09:30:19 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y1so2805225plk.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 09:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1309DD9m7lVFlAokjmQ5wR38yr90FaUfH5dJfga5E8k=;
        b=MTpl8NYa0OigCkZd3G3OT+yQ3wPJIsxU6qon0mMsBA/QV4FIJBTCkZdLVI8Qbzn3X9
         6yFUrlpdiE6gbpV8veXY1h1SeSfeZMS8dQodDpExVD+dfP8M/O+s4N88VRmOl2dx57Xo
         PxtL7oZcKZpiIzcHIh9SxS5cqsOh5t1JAGo/fZf7enDjWAAtayAhtZvSYxwqS8pl8mFK
         8rfp8fVeRMh4dHsiIUgjBE97mkkY5en/j2NlZcOzbeE5bcVIynI60yxM+shvo4wWYAhN
         pCD5MZSwwJQzabGiz0Y2LzYcMzq6CN+OV+dGpRKkVOg7HgZ9L3Lwj1TlQAQaWRpB/hDs
         hc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1309DD9m7lVFlAokjmQ5wR38yr90FaUfH5dJfga5E8k=;
        b=39Z66lleQiy2kIhf2hPAHl19spxN8Scn9ZRWS1TMvjfWKI2owNs+p3CSxv0rPXgQDY
         IaAayxBV0ROIHXVaRPLP/+q327s8lf5KEKp5fjSDIdA3qo9ktyFgapsgNpljPt2iCJ4F
         JL10r0SAsXNi1vdWUj50joseXmnV7jIut5+NYUQS+k5kYBTE0OmRtQ4vaUhx2+F2XUVN
         peAXGywOhB9+rmDVP16D9onB9jQxP1u+4v1PAJVxqjEJgxW+14J3VWm9Oxr2NPt+rpFS
         O1cyuZsYpiCxr+GkPY7zmD01eBe9LShItnK1jcaFAs0u0ktqKxGqIw8sDOGJjdlMSlcn
         4gCA==
X-Gm-Message-State: AOAM532PsMQj86mj12TBEXseW/xJm7JBMuW++6F+5DcJE0WMrlJyLXbr
        gZ3F4bH/iQvs9Ss1Kmf4zCVCw4PSxtE=
X-Google-Smtp-Source: ABdhPJzPzaCSl8qeB5jrIxlw00n8uDjvvSxjP9rkubrah+UlEHm81hB7+NUk7a5W10xi4i7yvHMCkw==
X-Received: by 2002:a17:90b:357:: with SMTP id fh23mr15817319pjb.238.1635957019155;
        Wed, 03 Nov 2021 09:30:19 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id p14sm2250083pjb.9.2021.11.03.09.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 09:30:18 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] lib/bitmap: drop unneeded small_const_nbits() calls
Date:   Wed,  3 Nov 2021 09:30:05 -0700
Message-Id: <20211103163005.991003-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since recently, find_bit() functions have their own optimizations for a
small_const_nbits() case. Therefore drop this check in relevant bitmap
functions.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitmap.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 7dba0847510c..f4b47cc185fa 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -382,17 +382,11 @@ static inline int bitmap_subset(const unsigned long *src1,
 
 static inline bool bitmap_empty(const unsigned long *src, unsigned nbits)
 {
-	if (small_const_nbits(nbits))
-		return ! (*src & BITMAP_LAST_WORD_MASK(nbits));
-
 	return find_first_bit(src, nbits) == nbits;
 }
 
 static inline bool bitmap_full(const unsigned long *src, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
-		return ! (~(*src) & BITMAP_LAST_WORD_MASK(nbits));
-
 	return find_first_zero_bit(src, nbits) == nbits;
 }
 
-- 
2.30.2

