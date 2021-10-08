Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13186426BC9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 15:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbhJHNiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 09:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240366AbhJHNiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 09:38:14 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E2BC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 06:36:19 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id k26so8287382pfi.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 06:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lAa9I0nj7yA9YxZJQiDgv3qskMPgBaJlC94AloAQu6s=;
        b=SH/zWictbgR+u23oYMfUZA3ANPrWTpNhSxXfQKUxGULjXHqWglu9B0FDgIId8kmoX2
         O0saEhkGXtupWgHlW4k5hMXNWZJxQSQk8wSeuvFTzEPd01O6hMh1dTrqDj5q6A4oJH3o
         GGlREyXWZMO8ZS5iXEfOn673L7wsBBHmlU8Mpgsqw7hdLnAATqf2G6uOZh/UhurllwCd
         22d/RJ+vk8ibxJ1DC4uWl2QvtMb5LD8x1ua9EEmjEJ69XQa+FQ0sNsDKn2RgwE+GFSZL
         I1EZlKBeYyN3rc8b39U2tkQ6jAh2UZhWpeD72QDbqoMqspc24tIIIONun+m6pkPQXSEH
         wG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lAa9I0nj7yA9YxZJQiDgv3qskMPgBaJlC94AloAQu6s=;
        b=ExlFX65nex+hLLaXxnJ54j9yHXJ/3cWQUoPRekatDGy56TVcvg6MJ8lLd/Mp8N8i0r
         NZ7uuuhPo8axro9Hse3jV1hY6UxOiEd74TUkHYU7dCktmikSVmZj4+lxnCTrF75kx5gz
         t6Tb+WVabAZamImkg4TwOtsg4ysL82YT2r+D4ZQt3RGKjV1vSeVOzrdZhUYY01mCBUgN
         utR5AI1xhr5LkLksaK71BHvt0nsthmfU8s87XrwHT0nqgv+KB6bjN3U4zOzlEur2ELWn
         9JtO/pSo9tOHKDk8AJNSdfxK1SN7QPjOPdaR2D6jNQ8QhsHyy+rcTgC4hipgTAOgzOk7
         qUQQ==
X-Gm-Message-State: AOAM530uXmZeERoVYCB8tkweVSPPA7oHK0UTvySupNwzCmPFpUTIGe26
        JWYZ3WA3xbgZ655DcdS61Ew=
X-Google-Smtp-Source: ABdhPJwddVi2Idj4D1PKq2S3bOtrf8TL0aEdfBhVPeA8LLSxyTn/oxku4KZqxAE6LBgNmHbbKTZa1g==
X-Received: by 2002:a05:6a00:181c:b0:44c:bf17:e8ad with SMTP id y28-20020a056a00181c00b0044cbf17e8admr9332555pfa.67.1633700178624;
        Fri, 08 Oct 2021 06:36:18 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (24.151.64.34.bc.googleusercontent.com. [34.64.151.24])
        by smtp.gmail.com with ESMTPSA id x7sm2944985pfj.164.2021.10.08.06.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 06:36:17 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH] mm, slub: Use prefetchw instead of prefetch
Date:   Fri,  8 Oct 2021 13:36:02 +0000
Message-Id: <20211008133602.4963-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's certain that an object will be not only read, but also
written after allocation.

Use prefetchw instead of prefetchw. On supported architecture
like x86, it helps to invalidate cache line when the object exists
in other processors' cache.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slub.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 3d2025f7163b..2aca7523165e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -352,9 +352,9 @@ static inline void *get_freepointer(struct kmem_cache *s, void *object)
 	return freelist_dereference(s, object + s->offset);
 }
 
-static void prefetch_freepointer(const struct kmem_cache *s, void *object)
+static void prefetchw_freepointer(const struct kmem_cache *s, void *object)
 {
-	prefetch(object + s->offset);
+	prefetchw(object + s->offset);
 }
 
 static inline void *get_freepointer_safe(struct kmem_cache *s, void *object)
@@ -3195,10 +3195,9 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 			note_cmpxchg_failure("slab_alloc", s, tid);
 			goto redo;
 		}
-		prefetch_freepointer(s, next_object);
+		prefetchw_freepointer(s, next_object);
 		stat(s, ALLOC_FASTPATH);
 	}
-
 	maybe_wipe_obj_freeptr(s, object);
 	init = slab_want_init_on_alloc(gfpflags, s);
 
-- 
2.27.0

