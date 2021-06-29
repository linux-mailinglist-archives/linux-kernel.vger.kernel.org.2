Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80353B72DD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 15:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbhF2NDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 09:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbhF2NDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 09:03:21 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CDBC061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 06:00:54 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id k1-20020adfe8c10000b0290124c5f1d4dbso3078508wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 06:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0IVNVT0H+De0puoAJBu62LSXzyrEpBUiY4mqrAvY4dE=;
        b=UYCFZfkFY9abM3KQrsH/NI0o1Ot3LsTG0Alt/uBHrMwW9XZaYMXjL/HUH7hO2HbO1L
         qg+OSb4RiO6lq4aA7qZFKoAqp1IzHX9TE6Bvxhmqd9rNCAC3E/aU34t4JL8aCP47dv7J
         XwbVI45J1OeA/hV8SvQWgpt7sJbhUGdIakxdJAc9U6NJfyWxEkW8iCdhPyTQgQOOIM6t
         NEyNPy1WY9k0yHMmQsmkkrMM29+1XBNly+M+aiNIDBowcE5a6bM4JWmVIwg5aXrU3Puo
         xZQUGNoom0f4SkkU3f5IBLcyMOcYaMWzauTcJydg6GpuVXZHJ6H/GNO3GFIDh5lgdDrV
         lZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0IVNVT0H+De0puoAJBu62LSXzyrEpBUiY4mqrAvY4dE=;
        b=ckRK9s5URxTY5kJIHSgxB3RZcxtzLO29KxFjwnoTY2UapbUzk1VEtbIntZnhicJC9H
         w6hG7flSTCaCvU/31BingKHPHlUaHs0IyVUmQ/390vwv0Y3MTcxA3FFq8Qj6nfTYoLEK
         ts6GQ52JvbwpGfhBgEfAp3uqLgVS1cgqJbM3yC6rqvcLj+6gB+Z7HxvQd05IW5lGLdbF
         DQ9zJBSHHdYsppmnqwBL1VZ8vWkmt8X8IgWvbmC4kzxW0+XIhoOXSnjxmoPFsJAIy3dJ
         y7fMAy+QPY9GsYRkiWmW782Dkv5ZcsPdCXbFO+vtxki227yrexi8VGpkNvnnpFjKDh9F
         iTjg==
X-Gm-Message-State: AOAM532ZJmc75+y6aa6aInIEiVIl4JNFhB47XVmPJeOHuWSlchx5mayS
        sTX3j4pITmNg8DlXWiR/7nv+Kjm7Pwo=
X-Google-Smtp-Source: ABdhPJwrWBFLqA2Zs7EwV8w8yjtDNp89/QNXlX2C+TXKPZ3ikeT7ZMi6/ITMVs5DekMzWQ5qNGvYPFziZo8=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:b4f8:c933:870a:c31d])
 (user=glider job=sendgmr) by 2002:a7b:c0d4:: with SMTP id s20mr381932wmh.0.1624971652470;
 Tue, 29 Jun 2021 06:00:52 -0700 (PDT)
Date:   Tue, 29 Jun 2021 15:00:48 +0200
Message-Id: <20210629130048.820142-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH] kfence: skip DMA allocations
From:   Alexander Potapenko <glider@google.com>
To:     akpm@linux-foundation.org
Cc:     dvyukov@google.com, elver@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocation requests with __GFP_DMA/__GFP_DMA32 or
SLAB_CACHE_DMA/SLAB_CACHE_DMA32 cannot be fulfilled by KFENCE, because
they must reside in low memory, whereas KFENCE memory pool is located in
high memory.

Skip such allocations to avoid crashes where DMAable memory is expected.

Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Cc: stable@vger.kernel.org # 5.12+
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 mm/kfence/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 4d21ac44d5d35..fd70089bd2808 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -760,6 +760,14 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
 	if (size > PAGE_SIZE)
 		return NULL;
 
+	/*
+	 * Skip DMA allocations. These must reside in the low memory, which we
+	 * cannot guarantee.
+	 */
+	if (flags & (__GFP_DMA | __GFP_DMA32) ||
+	    (s->flags & (SLAB_CACHE_DMA | SLAB_CACHE_DMA32)))
+		return NULL;
+
 	return kfence_guarded_alloc(s, size, flags);
 }
 
-- 
2.32.0.93.g670b81a890-goog

