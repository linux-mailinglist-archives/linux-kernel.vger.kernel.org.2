Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E3E3B765C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 18:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhF2QVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 12:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbhF2QUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 12:20:55 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DB3C061766
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 09:17:45 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id q207-20020a3743d80000b02903ab34f7ef76so21184757qka.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 09:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0F7hMZHCIK+7v4XQf0d2VY6BLy6L3ZoxZU11ibykN9g=;
        b=B7xyVqn1vrbzkQJ6kBNJL7fDADQ/1pWXqIy1hGlkPun62lYL9b3Y3oczyOZtu3/N3W
         O+gYGvyqL70jMCAOQhJ51MPhsqJduW0z0m4q9118ZzRPxUlZ+HmyzDjz9kkrqUkaoTxO
         jePjiVM6SizeP2G0SnOwLsTNKbNJGJSiX9uU2iqCaa6+q75SEJOBHcNiHJTzE7InP8d0
         EiAISPOa6pv8LEhXJ6HnZmqbVVlO787ozJ1X2DVJp/8n7rfD1zmZvwNS+GsXj6bV81V3
         4xua1fSjMGaN+Co8+70OXxk7WHtAX4+O+CgMEvQn8OwAOgjvkZFRy3Y/ThEwS+Dg/UFn
         wKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0F7hMZHCIK+7v4XQf0d2VY6BLy6L3ZoxZU11ibykN9g=;
        b=OYiXeJ6Nis0HNPzoSAMPn+AjN3daXFktQbqYG5Qy8XXjZr//qEWOYBMeHRyyqcrhFy
         lNlnq+pyIwK+UcQWQRKJsVHE936035SMU/SOwunks9QNLSq05GHFOhwoy43aF2UnaxXS
         WL1pmJB4vk4Xf3s4tX8EShE4+A1iog3uu4Hy6TD4lCPjW9Cp2cv3VnyhK8BSeSowGVBk
         HxRV0u2es17aIAUc35PmZ5N0TKQO3tRiTqAtujUqm+uKDE6IQu8ek1+GYgKzc5iw0pPp
         jLflEWElKqCqIF/Zn6FxkgQDjxzvqTTboaA7k9JOh+2MMr3DRTkz07hRffF6z6Oopu0V
         IysQ==
X-Gm-Message-State: AOAM530CKP3v0wQS4hIkv0kq0IrttNi3eyed+YCojHvngVm+6QinYQVq
        Em+rWjT+eeCnKm2G0oJx2ResC3KApqs=
X-Google-Smtp-Source: ABdhPJwuv+f1T/wt98yyV150j1MTUMjtZxdEp86M+9xIWeVtiNpwXJghmBwm5VThdjvcChZFgXs7V4K55zc=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:b4f8:c933:870a:c31d])
 (user=glider job=sendgmr) by 2002:a05:6214:9c6:: with SMTP id
 dp6mr32184504qvb.30.1624983464121; Tue, 29 Jun 2021 09:17:44 -0700 (PDT)
Date:   Tue, 29 Jun 2021 18:17:38 +0200
Message-Id: <20210629161738.936790-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2] kfence: skip DMA allocations
From:   Alexander Potapenko <glider@google.com>
To:     akpm@linux-foundation.org
Cc:     dvyukov@google.com, elver@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org,
        gregkh@linuxfoundation.org, Alexander Potapenko <glider@google.com>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org # 5.12+
Signed-off-by: Alexander Potapenko <glider@google.com>

---

v2:
 - added parentheses around the GFP clause, as requested by Marco
---
 mm/kfence/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 4d21ac44d5d35..f7ce3d876bc9e 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -760,6 +760,14 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
 	if (size > PAGE_SIZE)
 		return NULL;
 
+	/*
+	 * Skip DMA allocations. These must reside in the low memory, which we
+	 * cannot guarantee.
+	 */
+	if ((flags & (__GFP_DMA | __GFP_DMA32)) ||
+	    (s->flags & (SLAB_CACHE_DMA | SLAB_CACHE_DMA32)))
+		return NULL;
+
 	return kfence_guarded_alloc(s, size, flags);
 }
 
-- 
2.32.0.93.g670b81a890-goog

