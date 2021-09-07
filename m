Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA523402A8E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237759AbhIGOQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237256AbhIGOPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:15:19 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0BDC0613D9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 07:14:12 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id r126-20020a1c4484000000b002e8858850abso3457522wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 07:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+Rc+8EwMgZeFDUhTR7EsEOP4LhinEf5yz1jFhEz7Lys=;
        b=C+fu87GoZkKgIPoEvuCyV89//ZnQ2k/l0TxbqWn0XEyAUEP7eZBz2sQEtKAoLtfAPo
         i4LUEghiCtacFi/u4ZPEyOr9w+StX0mLitUoVCMJrqQv26+ON3iTipxat+SJB8Z4OWpj
         Rjz/abmjaqw+fhtK2VgNo5/xLy2Bj8tBR17vDoq2moBJSp0TqEYKtCs4bEiiPYdPpcNa
         zmBkQP95QLt2XqYlZbVycFi+CRCBDXubJIy0o7OrzSw6+xm+W9cElegagvtA2UzKNxCV
         R72bRGrU0M/WoCET7xXJt4z286/MhTPWFbyAS4LNDW1YWWBcJfHejyx1DKCTIoVzuCZo
         4Pyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+Rc+8EwMgZeFDUhTR7EsEOP4LhinEf5yz1jFhEz7Lys=;
        b=I+mMozXuHpEY3F0XWgyJwL5krS9EO6JlcI77EuSOizVpzGXzCFAH392PX0mWn67hxz
         SnlSR2L+Se0lFd3Ob1ywlin6B4+Rh6P3Anxp0DzcS7RkmuW6Lgs9+VyfG1PYeNb9ZQap
         YUvIDvsLo4yNnhEYKJwBREXDTgmaZ/sCgD1Ya6mQrUGdhqT1c99q7LL6sZlB6CAlYepi
         kdWmpjKSQnDRAzvI81jVF0ZwqkCEIeXtS3y01Vz2qI/8b3oX5RyrUXqbDxvP2Q/XyBIY
         UU1DwAvVMPD0Kd57K96V0jvm8MOUo0IB/hoShmoqQtyrpwuzicL+gWq0r5aHjHttqHK3
         CK9Q==
X-Gm-Message-State: AOAM533i8u0Qz553DNVr+LxfCwBO66ResndbiKkgScsmo/KlT4NlSgai
        4B6k2VteQqL/KdOenJxoph4/POY+UA==
X-Google-Smtp-Source: ABdhPJy5j8OSOmcWadIfuPxP8jPndBqUduiq6MfhVDnHUz5ko0W2/iEvw7OfLAojWDgpFpRc1AZPp+GF2w==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:6800:c1ea:4271:5898])
 (user=elver job=sendgmr) by 2002:a05:600c:4106:: with SMTP id
 j6mr4288917wmi.102.1631024050593; Tue, 07 Sep 2021 07:14:10 -0700 (PDT)
Date:   Tue,  7 Sep 2021 16:13:05 +0200
In-Reply-To: <20210907141307.1437816-1-elver@google.com>
Message-Id: <20210907141307.1437816-5-elver@google.com>
Mime-Version: 1.0
References: <20210907141307.1437816-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH 4/6] kasan: common: provide can_alloc in kasan_save_stack()
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add another argument, can_alloc, to kasan_save_stack() which is passed
as-is to __stack_depot_save().

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
---
 mm/kasan/common.c  | 6 +++---
 mm/kasan/generic.c | 2 +-
 mm/kasan/kasan.h   | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 2baf121fb8c5..3e0999892c36 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -30,20 +30,20 @@
 #include "kasan.h"
 #include "../slab.h"
 
-depot_stack_handle_t kasan_save_stack(gfp_t flags)
+depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc)
 {
 	unsigned long entries[KASAN_STACK_DEPTH];
 	unsigned int nr_entries;
 
 	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
 	nr_entries = filter_irq_stacks(entries, nr_entries);
-	return stack_depot_save(entries, nr_entries, flags);
+	return __stack_depot_save(entries, nr_entries, flags, can_alloc);
 }
 
 void kasan_set_track(struct kasan_track *track, gfp_t flags)
 {
 	track->pid = current->pid;
-	track->stack = kasan_save_stack(flags);
+	track->stack = kasan_save_stack(flags, true);
 }
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index c3f5ba7a294a..2a8e59e6326d 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -345,7 +345,7 @@ void kasan_record_aux_stack(void *addr)
 		return;
 
 	alloc_meta->aux_stack[1] = alloc_meta->aux_stack[0];
-	alloc_meta->aux_stack[0] = kasan_save_stack(GFP_NOWAIT);
+	alloc_meta->aux_stack[0] = kasan_save_stack(GFP_NOWAIT, true);
 }
 
 void kasan_set_free_info(struct kmem_cache *cache,
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index fa02c88b6948..e442d94a8f6e 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -260,7 +260,7 @@ void kasan_report_invalid_free(void *object, unsigned long ip);
 
 struct page *kasan_addr_to_page(const void *addr);
 
-depot_stack_handle_t kasan_save_stack(gfp_t flags);
+depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc);
 void kasan_set_track(struct kasan_track *track, gfp_t flags);
 void kasan_set_free_info(struct kmem_cache *cache, void *object, u8 tag);
 struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
-- 
2.33.0.153.gba50c8fa24-goog

