Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14888377452
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 00:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhEHWOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 18:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhEHWOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 18:14:40 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079C3C061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 15:13:37 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c17so11018473pfn.6
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 15:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qGCed4gUBN513MLlFTQfnZ++HePkXg12kWCkIjUGDr8=;
        b=ushxYnpoe8orY5ZKdkAudx/MBL/PPVsYM/L9Bfug3g+tTyy3bJKdiVr+BgXJBl1KiM
         Oa18GbopI31rmulhYJpF0mStOSwJbn2BcWCxQ6a2bNtBXRFDAX7TeH+gnOTsBXJInGLw
         4DQaFNRtj0aOforUt0qKboIEndTM96mW/iPYwkGPgQ8cdeg0pcPxth3Sley0Gs+C24+j
         9RdrkBH2x6vJ3GcJbnsLRyrWOsQ//fliezAPivWQQ1D8oiW8KxoENvte7kY2U8hQBYAw
         YFVaUBPwYlxo3uGBoIO8YqsifD6qeeuDAF0EL29fjjNp6Uz0Q0Hki5NVLa3nJg+7KIyv
         8GzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qGCed4gUBN513MLlFTQfnZ++HePkXg12kWCkIjUGDr8=;
        b=UQ7kqicEE7fmDxehuy75oJ5bKfs+uOFbqgX6h1SHHz00mThm4t3udhwdQcaPzbv6Ee
         lOAUYWRmsgFoSh7MeEC8euz0U6ns4y5YptVc1sSryReOGPDWwWsbNOwY88eLUtRJwixR
         v2gFubml7ogOx4niA9JNpsOky+qTwAqODrDgNyyMSxB8fFH3+BI38po6CwIh9Z6oF7sE
         rApqiSRXovqnJrnAT6ifxhbO3ZC8+Ldr8rk1CUwf3aXGgJbvRd+sd7O5aq+trCVHXHVT
         LEYVNxgKRD/z1PzJq5eRwqtgzXAY2gHPzc+9GzHrUCfv77jHKTBMWklgQgFUYi1gL1wv
         NdTQ==
X-Gm-Message-State: AOAM530Xlbv6tytNX887lKzbf/8dKLcjBUyUcI7fd1VEoeVwuAdaD7Zg
        glcy8HmJUrOLZEAiNgMRgz6Zr/qnvjM=
X-Google-Smtp-Source: ABdhPJzFVPJC9sdqVYbiNZjxJE38MxaAI0xXpBZiGJvG5gNM1NU2qQjIho2g8xGXHSVSKx2R3JJM4w==
X-Received: by 2002:a63:f242:: with SMTP id d2mr17272437pgk.167.1620512016514;
        Sat, 08 May 2021 15:13:36 -0700 (PDT)
Received: from hyeyoo.42seoul.kr ([121.135.181.35])
        by smtp.gmail.com with ESMTPSA id r18sm15295303pjo.30.2021.05.08.15.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 15:13:36 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH] mm: kmalloc_index: remove case when size is more than 32MB
Date:   Sun,  9 May 2021 07:13:28 +0900
Message-Id: <20210508221328.7338-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the return value of kmalloc_index is used as index of kmalloc_caches,
which is defined as:
  struct kmem_cache *
  kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1]

and KMALLOC_SHIFT_HIGH is defined as:
  #define KMALLOC_SHIFT_HIGH    ((MAX_ORDER + PAGE_SHIFT - 1) <= 25 ? \
                              (MAX_ORDER + PAGE_SHIFT - 1) : 25)

KMALLOC_SHIFT_HIGH is maximum 25 by its definition. thus index of
kmalloc_caches cannot be 26. so this case should be removed.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 0c97d788762c..4694b1db4cb2 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -382,7 +382,6 @@ static __always_inline unsigned int kmalloc_index(size_t size)
 	if (size <=  8 * 1024 * 1024) return 23;
 	if (size <=  16 * 1024 * 1024) return 24;
 	if (size <=  32 * 1024 * 1024) return 25;
-	if (size <=  64 * 1024 * 1024) return 26;
 	BUG();
 
 	/* Will never be reached. Needed because the compiler may complain */
-- 
2.25.1

