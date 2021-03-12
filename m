Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771CE338FF2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhCLOZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbhCLOYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:24:51 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A847C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:24:51 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id j8so2103526wmq.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ma9yDdtcKZ7wj/wPd+7FYcq2cw0HWN/l0auDvo6fPoI=;
        b=JVujzVqwjIYG5j1fOwr25Xh074MUoX63HHSyCm4wfG799oatexCqqAEE2xXAea9aKV
         Sjra9aPL3ppOOBgD48RZymsvzU9nFwGbIzQLilkW1cfVorxpDqi0v7/8Odj/B6raoZCe
         Scw/ef0F/cvt2H5lL+6GV463RBcGceF6rjhHt7rF54QQGq0Kk7/drKuZW58sz4h9DO7S
         V0enC41jV+KCMwRg7y1Sp9HhExnZsVSWQgstR99ieSIHLgg3+KoyRngQTkQNfet5LrtD
         WzrSev9UUXZRVjf4Xsf4sh0x01A29B6HUcXQD6dui2WloqW/laJ5aDsrP3yYaH8LJMmH
         UnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ma9yDdtcKZ7wj/wPd+7FYcq2cw0HWN/l0auDvo6fPoI=;
        b=JDq1sJHxQETOxlWbWquMMoS5rRnCbUJwmpakyz/T/WuG1VHfe7i4WLndFVH6fzKDfB
         Su2WjWxqIKIGTYE849s+gxqN9hkPXjbhUDIKRwdxEpfP7tI7wYwjrEWFd32h3+nJL9YD
         pe2AiewImlU0DmxAcjFeGPyg9LwINJoGeCDM2Z5TkKsPANvylomi1WC6SHhlA8UfJUeu
         8zBjZqxlJaPxex8LuJXYX3dfe34lENAoMW37sjg+vaeQw4PiCNJ0ExfR7uwrpssZT3Kz
         zQsLciGnTr3AHgL8PzluLsA+9/hcYB+QuAyQFrgFZAyY/lrdB7aUx8GslyszQttzjmTp
         MjsQ==
X-Gm-Message-State: AOAM533P72yXh7GCw1GWS0sw8WqjSVYgigknLdvGo5fAz18x+NlkSyfW
        uuZlT5aOxjTcBugLiECt7TLDogH5Ipfg+5dp
X-Google-Smtp-Source: ABdhPJwaKyRxEHXnKrGDm4FLh1hRB4szO2CA0EyxO4FBmwgHO0zof9NcJRq+qtcFPr9FhhMMmwpZJhu4/UhptLB9
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:95a:d8a8:4925:42be])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c18e:: with SMTP id
 y14mr2248623wmi.1.1615559089958; Fri, 12 Mar 2021 06:24:49 -0800 (PST)
Date:   Fri, 12 Mar 2021 15:24:29 +0100
In-Reply-To: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
Message-Id: <f2f35fdab701f8c709f63d328f98aec2982c8acc.1615559068.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2 06/11] kasan: docs: update GENERIC implementation details section
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
index 1189be9b4cb5..986410bf269f 100644
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

