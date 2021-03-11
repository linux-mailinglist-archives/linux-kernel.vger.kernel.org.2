Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91255337FC1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 22:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhCKViO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 16:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhCKVhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:37:41 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FA6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:37:41 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id f9so4580121wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ftGAVPrWTX9D2SBgeD8/b0SYzBSEeTxAmVx9TpiZW0k=;
        b=uBQHfFhzm2iDu+GWPgLOfKqLJ0KYNn8BgixPIYHzI+DCU3dW9BounceIQ1AFuguIOG
         SU+Ya+w1ZMyLFw1BxUOqpkZySUt9tCHLZn2II04xfYxr8r2HdGMIspLfJskm0QdbDlM1
         Wj4fJOVOZ10KEpQCSbm2eM0tdwjzEQZjL6Ej20gZuP2cDLbrVaPafbhkDCEzV+ffkFTv
         tY63gum3mg0FZWDmjjVpY2OXKIITHddpc5oaimHtaDHmtGF9phxr3mBX42ms5o/WgHe+
         jw1J6o2/MR1IVhKBsMRH6m1qOMFU2g8pe+MW3OtT3diOUng1hMU8AOTpY51qZp8AYhJF
         Hgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ftGAVPrWTX9D2SBgeD8/b0SYzBSEeTxAmVx9TpiZW0k=;
        b=aa1fGoTmO1EQ2j775pfepcc9tWKBlE5ON1VuOorrP80LQEDNTe/g/gdi5iy3rVAWO8
         kXmSn/ZSk4aqlAY2HIdQ4ssFc2NXoOiI9TJRaGVy79ds1N+GQ+Hp0Qnf5J67aM7wGnlJ
         7963ZX2NeGGZKOrdd6uLhP5Yisre1x0mAv5dZj3uQ5Mq2Z9xZzefKdqFr7GgFH1Nxy+t
         jQBUWPQr9p1eqvA9fTL8p+nZkAMIJsOu2y6C/DryaXUmRtMNEhLda6nah2dPQqWJt2qI
         9hRvCHbwIezNn1uWLMRa0smEjt/vtc416SCdNrq06ErxvaA5/S7PIlNqQJlJHpp9rd3y
         yLHg==
X-Gm-Message-State: AOAM532gQ9gS7sWMxndhz0blywz2cJDkLNXH4gfXEyZmk1rHRELgbBcW
        Wcf3ezBg/pqDxrHW6cipOyck7yGiA6z21xFo
X-Google-Smtp-Source: ABdhPJzw9BhfuLqjp9sF6FO9Ynb/tSWRnTFWIgUse0QUUiQD+MKS1Qw68XULVhuXxVxKD/fDwHS6rNaFDv13AAFT
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:95a:d8a8:4925:42be])
 (user=andreyknvl job=sendgmr) by 2002:a1c:6243:: with SMTP id
 w64mr1904993wmb.0.1615498659400; Thu, 11 Mar 2021 13:37:39 -0800 (PST)
Date:   Thu, 11 Mar 2021 22:37:18 +0100
In-Reply-To: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
Message-Id: <dd89dd245fe6fe0e66680a9ccd135f6778fc2c60.1615498565.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 06/11] kasan: docs: update GENERIC implementation details section
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the "Implementation details" section for generic KASAN:

- Don't mention kmemcheck, it's not present in the kernel anymore.
- Don't mention GCC as the only supported compiler.
- Update kasan_mem_to_shadow() definition to match actual code.
- Punctuation, readability, and other minor clean-ups.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/dev-tools/kasan.rst | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 2f939241349d..1fb4b715a3ce 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -200,12 +200,11 @@ Implementation details
 Generic KASAN
 ~~~~~~~~~~~~~
 
-From a high level perspective, KASAN's approach to memory error detection is
-similar to that of kmemcheck: use shadow memory to record whether each byte of
-memory is safe to access, and use compile-time instrumentation to insert checks
-of shadow memory on each memory access.
+Software KASAN modes use shadow memory to record whether each byte of memory is
+safe to access and use compile-time instrumentation to insert shadow memory
+checks before each memory access.
 
-Generic KASAN dedicates 1/8th of kernel memory to its shadow memory (e.g. 16TB
+Generic KASAN dedicates 1/8th of kernel memory to its shadow memory (16TB
 to cover 128TB on x86_64) and uses direct mapping with a scale and offset to
 translate a memory address to its corresponding shadow address.
 
@@ -214,23 +213,23 @@ address::
 
     static inline void *kasan_mem_to_shadow(const void *addr)
     {
-	return ((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
+	return (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
 		+ KASAN_SHADOW_OFFSET;
     }
 
 where ``KASAN_SHADOW_SCALE_SHIFT = 3``.
 
 Compile-time instrumentation is used to insert memory access checks. Compiler
-inserts function calls (__asan_load*(addr), __asan_store*(addr)) before each
-memory access of size 1, 2, 4, 8 or 16. These functions check whether memory
-access is valid or not by checking corresponding shadow memory.
+inserts function calls (``__asan_load*(addr)``, ``__asan_store*(addr)``) before
+each memory access of size 1, 2, 4, 8, or 16. These functions check whether
+memory accesses are valid or not by checking corresponding shadow memory.
 
-GCC 5.0 has possibility to perform inline instrumentation. Instead of making
-function calls GCC directly inserts the code to check the shadow memory.
-This option significantly enlarges kernel but it gives x1.1-x2 performance
-boost over outline instrumented kernel.
+With inline instrumentation, instead of making function calls, the compiler
+directly inserts the code to check shadow memory. This option significantly
+enlarges the kernel, but it gives an x1.1-x2 performance boost over the
+outline-instrumented kernel.
 
-Generic KASAN is the only mode that delays the reuse of freed object via
+Generic KASAN is the only mode that delays the reuse of freed objects via
 quarantine (see mm/kasan/quarantine.c for implementation).
 
 Software tag-based KASAN
-- 
2.31.0.rc2.261.g7f71774620-goog

