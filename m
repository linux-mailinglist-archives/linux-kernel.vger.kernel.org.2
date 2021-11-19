Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E6945708A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 15:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbhKSOZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 09:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbhKSOZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 09:25:38 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02BFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 06:22:36 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id o10-20020a05600c4fca00b0033312e1ed8bso4818852wmq.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 06:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=X7iq6ptC+Z8R2N/iJA3x0lSwxpZSVZxJX+z9qBEEm6o=;
        b=kyZ4PLG/XYsiyQbRGghuZw+BAVravwngY/VRQtxVLKLZZvzcaWvS4E8novlr+MaNPI
         TRjoSAUN/Hmf6Gy82UOkIZc2u8aByAYf2Oh9xVQVpdMi0yZIXeHg1w0xYvUixbp05XcE
         Rzu7/vDnOtTfG58KRt0bmgW3MaUK/0UATmTPCRosCmRPtHO2JD/xpJwOMtwianRLuARC
         VDQHa2z8445T116+IPcdscTplzNaR7NOhaaaYZZ0o3q5+4tYiqjcTogH6nXZv6d0jDhC
         f0V79MDUnzP9eu6qw0V/sG0LvqNUHUnkP8Otejo7chXrcDJhZoC/K1nko32Y36+cWz0i
         rjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=X7iq6ptC+Z8R2N/iJA3x0lSwxpZSVZxJX+z9qBEEm6o=;
        b=jIHqBoSeA4FjEljk8faX9houDdQzcac+geIVtnQJAortodQEP85h+n26bGwdPVf3Aj
         99TB5ij7rXU8pihPHV3dFNkPLcyZBZqcJSInzbZkiWn39056zDE7RlJJv2xX/4hQRj/k
         45yPhI4PYiKvkv/LOd6GMc1CvlrylpP9nTN2o4Nr1SK8jHe+WI4DIa7QwdjUbb3FVJfl
         lJQIWrTEgHHAtO9n3WTdF/mVJHsC9AP05yzSCeIBROfqv1JL7+2ZR37QCBQ8Si2/1HLi
         6CKbVJVeFwUF1+p+hTg2x53aWoy1+zd9Mmmpw7LckBP2+jci0A0MLeiO7WUND5LbpPFN
         3lUw==
X-Gm-Message-State: AOAM530zrH29MSTfzY1b0rsna+4A9Zh2mMk8zt4CqWg3BQpvfoaNdSA0
        XmUKdBz/bPitxl2tI1OW2j1EF4Gzug==
X-Google-Smtp-Source: ABdhPJyutIT3rm9nEOyXN9YN3OjryYyPQtrUVjbpIa6PH4X20PBXJKWvLP+impTG/0LVMRqNVnrr+AkhDg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:24a0:cdec:f386:83d0])
 (user=elver job=sendgmr) by 2002:a1c:9d48:: with SMTP id g69mr3458wme.188.1637331754628;
 Fri, 19 Nov 2021 06:22:34 -0800 (PST)
Date:   Fri, 19 Nov 2021 15:22:18 +0100
Message-Id: <20211119142219.1519617-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH 1/2] kasan: add ability to detect double-kmem_cache_destroy()
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because mm/slab_common.c is not instrumented with software KASAN modes,
it is not possible to detect use-after-free of the kmem_cache passed
into kmem_cache_destroy(). In particular, because of the s->refcount--
and subsequent early return if non-zero, KASAN would never be able to
see the double-free via kmem_cache_free(kmem_cache, s). To be able to
detect a double-kmem_cache_destroy(), check accessibility of the
kmem_cache, and in case of failure return early.

While KASAN_HW_TAGS is able to detect such bugs, by checking
accessibility and returning early we fail more gracefully and also
avoid corrupting reused objects (where tags mismatch).

A recent case of a double-kmem_cache_destroy() was detected by KFENCE:
https://lkml.kernel.org/r/0000000000003f654905c168b09d@google.com
, which was not detectable by software KASAN modes.

Signed-off-by: Marco Elver <elver@google.com>
---
 mm/slab_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index e5d080a93009..4bef4b6a2c76 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -491,7 +491,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
 {
 	int err;
 
-	if (unlikely(!s))
+	if (unlikely(!s || !kasan_check_byte(s)))
 		return;
 
 	cpus_read_lock();
-- 
2.34.0.rc2.393.gf8c9666880-goog

