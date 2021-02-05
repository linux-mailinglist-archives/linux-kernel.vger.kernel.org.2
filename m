Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF6C311129
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbhBERpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 12:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbhBEPzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:55:20 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983CAC0617A7
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 09:35:18 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id h17so5774799wrv.15
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 09:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=r9X5DpdR9qKQzOGqj5YPMHvNzUxwchyNv1XRoONrpMQ=;
        b=rhZcOisXxajZRSH31J6t5x8y7U35XbWt39APfdQTAyFPG0HF5mjWJSCOgw16eIMOMa
         FxjsONeMdcvEksZXk6bC9GsFOfyYtiJJVVxykiWoVQthkFCZ+7JIWakX1YKqLh2Hfnsw
         UHhGojbmi5DGaKkXKVb9OuWCEYr4RB6K9hJP+CP2j/YOxjaS7vNIFnSlhUYQR2/KU0oU
         ooZpFMWOGqErYIXA8pyt+sZSi7z6vjp1Cx9mo0rM+ADEMLxumJNs73rI/ZV+psV71+ij
         0yCJp9ep/i82xgHJH7EhvCF5jIIaWuoWZ9xoBRvQpbg8jUeOxTCIZpjL2b4jXvijo6zj
         rsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r9X5DpdR9qKQzOGqj5YPMHvNzUxwchyNv1XRoONrpMQ=;
        b=XNZayD867ICRAgceIvrE5HyrrJIwd8rkgmhmAeYYdkuEJ4I1LXN/prmStjBLodVq8u
         zHfCZPHIkEEnJhD4XxR9tHwpUhhCMlagew6CYFAk2Fc2pWPRJQXHs8/S2W9Y6V3633Si
         XCFuY7iW8Lmfczjid7XKLfap8nOujz3DOu5V/A3z9ixB/ZclTuNIV9ONUZylzIP69DTy
         nKEIUey5F2VekADn96MUwPrpJ3pt47fEAyanQ2fU7Tutno7VEGPMYmTzt6KX83HzV+OR
         ak4Yao+mZY7rnKXRsnp2PHwF6R3desiKLYt0syG0qaZI5LHPVlHhuWuX4N/WYsj4KQzx
         1ruQ==
X-Gm-Message-State: AOAM530FIwlxehu3rNS2y5PldNfT6m1OQnjaCwR352LiIQ/j/3l9HIrg
        CpNPTCej44xvBO0RfHOmmv6fKXdwyFtnKVJ8
X-Google-Smtp-Source: ABdhPJwTAziAbVGPOhm/GCfHuY7Nxua8uArDaBNKr1jq6WV9vgAgwxgQ1kegmyvTxo5ASrnPr8xSaEmusHPD5Qp2
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:edb8:b79c:2e20:e531])
 (user=andreyknvl job=sendgmr) by 2002:adf:f149:: with SMTP id
 y9mr6216013wro.144.1612546517387; Fri, 05 Feb 2021 09:35:17 -0800 (PST)
Date:   Fri,  5 Feb 2021 18:34:45 +0100
In-Reply-To: <cover.1612546384.git.andreyknvl@google.com>
Message-Id: <2c94a2af0657f2b95b9337232339ff5ffa643ab5.1612546384.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612546384.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v3 mm 11/13] kasan: inline HW_TAGS helper functions
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark all static functions in common.c and kasan.h that are used for
hardware tag-based KASAN as inline to avoid unnecessary function calls.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 7ffb1e6de2ef..7b53291dafa1 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -279,7 +279,8 @@ void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
  *    based on objects indexes, so that objects that are next to each other
  *    get different tags.
  */
-static u8 assign_tag(struct kmem_cache *cache, const void *object, bool init)
+static inline u8 assign_tag(struct kmem_cache *cache,
+					const void *object, bool init)
 {
 	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
 		return 0xff;
@@ -321,8 +322,8 @@ void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
 	return (void *)object;
 }
 
-static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
-			      unsigned long ip, bool quarantine)
+static inline bool ____kasan_slab_free(struct kmem_cache *cache,
+				void *object, unsigned long ip, bool quarantine)
 {
 	u8 tag;
 	void *tagged_object;
@@ -366,7 +367,7 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
 	return ____kasan_slab_free(cache, object, ip, true);
 }
 
-static bool ____kasan_kfree_large(void *ptr, unsigned long ip)
+static inline bool ____kasan_kfree_large(void *ptr, unsigned long ip)
 {
 	if (ptr != page_address(virt_to_head_page(ptr))) {
 		kasan_report_invalid_free(ptr, ip);
@@ -461,8 +462,8 @@ void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
 	return tagged_object;
 }
 
-static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
-					size_t size, gfp_t flags)
+static inline void *____kasan_kmalloc(struct kmem_cache *cache,
+				const void *object, size_t size, gfp_t flags)
 {
 	unsigned long redzone_start;
 	unsigned long redzone_end;
-- 
2.30.0.365.g02bc693789-goog

