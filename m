Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10858308CC8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 19:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhA2SvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 13:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhA2SvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 13:51:08 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7583C061573
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 10:50:27 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id s66so7814674qkh.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 10:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=edlz3XbCYDia7c2gqKzN5FK6RAL7HO75a2b9pwPLi9o=;
        b=p0cuGC6uFFNLHjWlQLakZAxQQJgRk6G0D6LX6qzjT5dK2fs9fixJJw+zgdSaB+EhKs
         Px5erEn2BL7CG39x2R3gCVyh93v+p/hdyYTQAMIpOz3b9A13p0kObVGTYT8JzFCpi0x9
         FUSCtI4eKNB6D49gcHsJuKTCRvSkmwqlF09dTPYtgWampxxSAdNkfSLYZnVB8LDnbBIG
         AGbMZDLOKwTMOe1ZAb17RrFjWoKBYMtQpBiBhmMtdMLd52qY3WGLWiGLAWfj5l/LLHOz
         Pm+X5DPJMB2mp/jbTFnXPiBYe46zKz8scT4jMiZCa8tCGr5pE2DwZV74gFm10EzkN85h
         M9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=edlz3XbCYDia7c2gqKzN5FK6RAL7HO75a2b9pwPLi9o=;
        b=n/oLfPzesnxV0wrh4te6Bv/4NHEarNTMD6zAp9dHqbSOiK1FjQXBPJqZfi3OYBKUgi
         S6k43O5c1lAjrGk9a4JbpmC0O4yUuvYVmicIzCSeDkmZo4BtL1oq7yuOh5Yf+udDNjzF
         VXaYlEQN4Smca9BceCM9kXrtu1lq+efw1gwSvvwDJ6zD1Za0IXnep/b43PXq10iaould
         +gMragdp8K1yTlSd/p6udpfHXtnLVfFuD5PAA7xLjWTViTn3V/rAwl0zX3UlkTWTCPOB
         paZY9AhvFMErvKiEIiv2aic5ajmfhFmewr83BJKAeFGPGrsjzPWYHJGHbFaAsu3C51I6
         aDBg==
X-Gm-Message-State: AOAM531tCDWk7ea4j8vCrN2deVqDhtweYO5w7VjAYtP+NzTGSGXAs92+
        7DMCR1tqwMF2KRzcbqgrlmfaKWqMm0jAGhC9
X-Google-Smtp-Source: ABdhPJznVMEKJWnqt/qcGVZ2IAaYJgoTFuP2I61TJJuJQfaSosdBi1z/YCkiVbXLxyxaZ6roHV0PpgUbEkdPs13D
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:b59a:: with SMTP id
 g26mr5014944qve.26.1611946226898; Fri, 29 Jan 2021 10:50:26 -0800 (PST)
Date:   Fri, 29 Jan 2021 19:50:22 +0100
Message-Id: <9dc196006921b191d25d10f6e611316db7da2efc.1611946152.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH mm] kasan: untag addresses for KFENCE
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KFENCE annotations operate on untagged addresses.

Untag addresses in KASAN runtime where they might be tagged.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

This can be squashed into:

revert kasan-remove-kfence-leftovers
kfence, kasan: make KFENCE compatible with KASA

---
 mm/kasan/common.c |  2 +-
 mm/kasan/kasan.h  | 12 +++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index a390fae9d64b..fe852f3cfa42 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -416,7 +416,7 @@ static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
 	if (unlikely(object == NULL))
 		return NULL;
 
-	if (is_kfence_address(object))
+	if (is_kfence_address(kasan_reset_tag(object)))
 		return (void *)object;
 
 	redzone_start = round_up((unsigned long)(object + size),
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 11c6e3650468..4fb8106f8e31 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -320,22 +320,28 @@ static inline u8 kasan_random_tag(void) { return 0; }
 
 static inline void kasan_poison(const void *address, size_t size, u8 value)
 {
+	address = kasan_reset_tag(address);
+
 	/* Skip KFENCE memory if called explicitly outside of sl*b. */
 	if (is_kfence_address(address))
 		return;
 
-	hw_set_mem_tag_range(kasan_reset_tag(address),
+	hw_set_mem_tag_range((void *)address,
 			round_up(size, KASAN_GRANULE_SIZE), value);
 }
 
 static inline void kasan_unpoison(const void *address, size_t size)
 {
+	u8 tag = get_tag(address);
+
+	address = kasan_reset_tag(address);
+
 	/* Skip KFENCE memory if called explicitly outside of sl*b. */
 	if (is_kfence_address(address))
 		return;
 
-	hw_set_mem_tag_range(kasan_reset_tag(address),
-			round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
+	hw_set_mem_tag_range((void *)address,
+			round_up(size, KASAN_GRANULE_SIZE), tag);
 }
 
 static inline bool kasan_byte_accessible(const void *addr)
-- 
2.30.0.365.g02bc693789-goog

