Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB083C8179
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238813AbhGNJZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238804AbhGNJZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:25:26 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABAEC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:22:34 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id z6-20020a5d4c860000b029013a10564614so1176096wrs.15
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=j81w1peEP7UvtOh9scTpnrf58uB+d+GVhtisHm569kE=;
        b=Wn+sU3hYqyY2DRBVayRYqUr+uoLeQFtStUDyB49M23dTRIE5Mb+56ZuVjVaXSIeA3T
         LgeGB5AfACS2L4xSVSmhwGg156jyL/c7dX799ifeGP7wM47pdfxX2SJI8gLcYgdXWfxS
         A3BySvNVrKmQeApKE1wzKsnk8qa5mJDHtoUm1WAUydYSGsk+1x3TOD0ySDi0l2EUYmfG
         F/qhjFpEliRF1u684yCgoh+4JFNaJj3vHjfpjmyzDbL49faelRqIv+s/akebcJb8MGVD
         egg+LvPuxaCmQ3fFpqVp1B4xzvvXlNLIP2dVvmobUWnBmCRp/Xh44rQ7865/+Ygo/mOY
         xN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=j81w1peEP7UvtOh9scTpnrf58uB+d+GVhtisHm569kE=;
        b=rEu+fev0Oq4X21JgmTiYogQgD+KI5DLzMhZNr3XKGDL7IUNZyDfUxSCxKCeDs6yFNP
         /qA+m3vwfQBesYyT9CF2qzhLyI3T7bIx2hTwdyWuoB8ru/xuLfksPIdsriqRuahZ8q/n
         IHnWlgGU7kNQHc7j9jkIQDlklZMGnidwxgCDVS2CC/4Vh8oTfnmRvdAmdyntbOR1kCu0
         r/VfN5z2cvNQKOYHx+dIoSsogcV4t2wcseqzE6GcB7jV+lFWZzfcTpyJIThzJ+yMTO3U
         IHum2RheiPK2/SucT7bc6ZDeRhgrJ5JDapyXUK3oeEyppHRcqxzESuUAao09C8e/3xXZ
         MDTg==
X-Gm-Message-State: AOAM532Cag/fU3kmnyM8bM5KWVVHE3DebOqY7YcNQTWdEdYk76Mp6CVN
        mFbOSw6rpGgKNbWyWNkACpTj3sv3MiI=
X-Google-Smtp-Source: ABdhPJz9BdeMwe2nrBQhJv0JCr7x/yTJ76W/xvJREEaino26Mi/Ya2NpWI0J3DfFVbsmC1bKxZHHDP1FrlI=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:89ec:cd11:7e8b:63fe])
 (user=glider job=sendgmr) by 2002:a7b:c052:: with SMTP id u18mr3009546wmc.105.1626254552678;
 Wed, 14 Jul 2021 02:22:32 -0700 (PDT)
Date:   Wed, 14 Jul 2021 11:22:22 +0200
In-Reply-To: <20210714092222.1890268-1-glider@google.com>
Message-Id: <20210714092222.1890268-2-glider@google.com>
Mime-Version: 1.0
References: <20210714092222.1890268-1-glider@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH mm v5 2/2] kfence: skip all GFP_ZONEMASK allocations
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

Allocation requests outside ZONE_NORMAL (MOVABLE, HIGHMEM or DMA) cannot
be fulfilled by KFENCE, because KFENCE memory pool is located in a
zone different from the requested one.

Because callers of kmem_cache_alloc() may actually rely on the
allocation to reside in the requested zone (e.g. memory allocations done
with __GFP_DMA must be DMAable), skip all allocations done with
GFP_ZONEMASK and/or respective SLAB flags (SLAB_CACHE_DMA and
SLAB_CACHE_DMA32).

Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: stable@vger.kernel.org # 5.12+
Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

---

v2:
 - added parentheses around the GFP clause, as requested by Marco
v3:
 - ignore GFP_ZONEMASK, which also covers __GFP_HIGHMEM and __GFP_MOVABLE
 - move the flag check at the beginning of the function, as requested by
   Souptick Joarder
v4:
 - minor fixes to description and comment formatting
v5:
 - pick Acked-by:, rebase
---
 mm/kfence/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 2623ff401a104..575c685aa6422 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -740,6 +740,15 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
 	if (size > PAGE_SIZE)
 		return NULL;
 
+	/*
+	 * Skip allocations from non-default zones, including DMA. We cannot
+	 * guarantee that pages in the KFENCE pool will have the requested
+	 * properties (e.g. reside in DMAable memory).
+	 */
+	if ((flags & GFP_ZONEMASK) ||
+	    (s->flags & (SLAB_CACHE_DMA | SLAB_CACHE_DMA32)))
+		return NULL;
+
 	/*
 	 * allocation_gate only needs to become non-zero, so it doesn't make
 	 * sense to continue writing to it and pay the associated contention
-- 
2.32.0.93.g670b81a890-goog

