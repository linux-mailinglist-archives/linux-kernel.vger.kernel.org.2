Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8AD3B849C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 16:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbhF3OEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 10:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236413AbhF3OEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 10:04:31 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A728AC09B094
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 06:53:22 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id n11-20020a05600c3b8bb02901ec5ef98aa0so548052wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 06:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dtH0IQ32mjHBoYzYQxUVAIZ8CYFo4XITSUGYSoSmvuA=;
        b=n8OrDYvB4lu0VQjvPLvwRPRKVdXxpGavb6OmQT8FlcNgMfasGdem5Xe1GYKcQwQLjF
         eqsZ/j6Bbhjo4RwvKBjlIA3938u9XJL5kaLuPE+AemK9oldlEH9n/O7jYcK/nQm3nGC/
         Nodeu3rbuP4Y585s02N0WHsbJ2x4Ya5xzJ+LCr23nVTYRDU3lUUHASCch1pHLLVWRqzx
         qK2MpDY+sFqPLYhBmtHXEGpiDV69xYuYF+iyRSt6NjSv0Iz7u/pnaDM80+VLCjkUWrmC
         MpK9GM8HVUwec7+08q8yLbjtgq8yh5ljCYRIegMIXTR9+YZw73NAB/ZVV8kyVtmNYwC6
         MRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dtH0IQ32mjHBoYzYQxUVAIZ8CYFo4XITSUGYSoSmvuA=;
        b=Be6xiCglaHdZgQMbhOJg/bmspIN+LzXgaaVGPrmOqERMdpv/TB/XYVQBm4ElaAQ4cV
         mXGLQ/aH6Bik79gw0AdgtRHW/9ho4aqjKr+p8k9xt7I2LOrkOIkjtztkiQEZd5XoUi1y
         kxyzkIBGkuFMz84mfb+Bo+51f96PK42JLXDb3r7eea+p0pSx3EwM9s/r7RZlf0YFXtMd
         WcgSiUF2VBqizB/X84odAOV7fPj8I1okh8zGhIhG+l3vt61zjRSLXoGMeKaMV5D1znZ+
         EPWwNbr/P5+lnhYd7Sp0rzkjn0yOMjnPvHYBytgHonbRGwY/d4cX2HOsnO4BofuXa5zf
         D+9w==
X-Gm-Message-State: AOAM5304+BpswndDKrujBKUUgpcRJZaDfJ+ieJjmS4c3mcWrFFYnmxPp
        aXNN2MYWzAiPN1BoRqnmFM9+MydyIuM=
X-Google-Smtp-Source: ABdhPJxEOOWrV1qY5ZQLKAMR0q+wxV55Lm0/JLt5nQqznaRHf1ul1AN8gIWXEvsyC132NIT7onyLV9XuHP4=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:a3fc:e8:8089:1013])
 (user=glider job=sendgmr) by 2002:a1c:638a:: with SMTP id x132mr4681717wmb.90.1625061200569;
 Wed, 30 Jun 2021 06:53:20 -0700 (PDT)
Date:   Wed, 30 Jun 2021 15:53:12 +0200
Message-Id: <20210630135313.1072577-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v3 1/2] kfence: move the size check to the beginning of __kfence_alloc()
From:   Alexander Potapenko <glider@google.com>
To:     akpm@linux-foundation.org
Cc:     dvyukov@google.com, elver@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org,
        gregkh@linuxfoundation.org, jrdr.linux@gmail.com,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check the allocation size before toggling kfence_allocation_gate.
This way allocations that can't be served by KFENCE will not result in
waiting for another CONFIG_KFENCE_SAMPLE_INTERVAL without allocating
anything.

Suggested-by: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org # 5.12+
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 mm/kfence/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 4d21ac44d5d35..33bb20d91bf6a 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -733,6 +733,13 @@ void kfence_shutdown_cache(struct kmem_cache *s)
 
 void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
 {
+	/*
+	 * Perform size check before switching kfence_allocation_gate, so that
+	 * we don't disable KFENCE without making an allocation.
+	 */
+	if (size > PAGE_SIZE)
+		return NULL;
+
 	/*
 	 * allocation_gate only needs to become non-zero, so it doesn't make
 	 * sense to continue writing to it and pay the associated contention
@@ -757,9 +764,6 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
 	if (!READ_ONCE(kfence_enabled))
 		return NULL;
 
-	if (size > PAGE_SIZE)
-		return NULL;
-
 	return kfence_guarded_alloc(s, size, flags);
 }
 
-- 
2.32.0.93.g670b81a890-goog

