Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4D9338FF7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhCLOZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbhCLOZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:25:01 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F194DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:25:00 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id r12so11240515wro.15
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ygfy34R30Ir5P43bAuVWD7PsEpaVeYrJUsfKdxJOhKs=;
        b=rC5oeVOtwW4j37sI8e0pI6DstMXXrDhg66shdjo/HdwFQuJql7l9XihT1b74K7zfvu
         +LMZjin/QNQW1inNez0NvU7o976i056UEY83jBhxXulKZh6DQMsHam+O+rTQLzLGCzmr
         tN3mgw7nzkn9DE5HZ+CQpqrDn1rVhghN3essH34emvOhlYdE9vQ115ZaFgV0UC7h4urG
         39CWaz23zdSYXKZZzs7gNqzSk1aKHKyw1XCLtRuu/NJeiNRw/SEJDhBh0MZ5Vxp+J0GM
         JZnpHWL8trHR2Z8bs3OeGJoXIJqxcVqem5ARckJOk1XY3jW1rOk0XuSPTY++Y+xTm5+P
         J3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ygfy34R30Ir5P43bAuVWD7PsEpaVeYrJUsfKdxJOhKs=;
        b=MMZEswrZYMMsg1OHR6ExJHi6E0+EhdbXJJ1m7cltfXk4p68WTaaMGZtdWzO8ofGQ1h
         Oag8HbHAMFJDWmAQ/a6ATxPoGgJtwnQBd176a+NixdGoqoQNJdfWiSF/WVjf2LnNZ1uG
         3h0AGswokycPZz1Tm3mU/FO0nC7H1bUCO97t1y5PJzJwC1yZSltdQaankPjO3p+RIqUG
         XeA8YhaVmOG5VLIEklByWBWcwQiUm8lMowBe9daFnu6z4YWH1bxuZtdQ7XCHXrCu+2jT
         nS+/HaszPxhbCobgZeWc88oSX2r8se+4JbHYhJMSY8X7LT0B9nsBV9mhx9cvfhuAc/Zo
         ZXcQ==
X-Gm-Message-State: AOAM530eQn5zPyJsuo9mTiaDw2kmSCxs5Jcxe7hCWHIOk8spU+syPSYa
        rl3t0WrAK7seAifqEuTkiL1vT50rmjy1V4/C
X-Google-Smtp-Source: ABdhPJzH5ceh4zLI0fc9g5fS021UsKjJ3ZXNJjpWRuf5c3Y6bxgUMjDEdZwoLCR2U8J2ymtATr4A6hag3hjCMNcT
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:95a:d8a8:4925:42be])
 (user=andreyknvl job=sendgmr) by 2002:a1c:5416:: with SMTP id
 i22mr13379263wmb.146.1615559099696; Fri, 12 Mar 2021 06:24:59 -0800 (PST)
Date:   Fri, 12 Mar 2021 15:24:33 +0100
In-Reply-To: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
Message-Id: <4531ba5f3eca61f6aade863c136778cc8c807a64.1615559068.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2 10/11] kasan: docs: update ignoring accesses section
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

Update the "Ignoring accesses" section in KASAN documentation:

- Mention __no_sanitize_address/noinstr.
- Mention kasan_disable/enable_current().
- Mention kasan_reset_tag()/page_kasan_tag_reset().
- Readability and punctuation clean-ups.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes in v1->v2:
- Mention __no_sanitize_address/noinstr.
- Reword the whole section to make it clear which method works for which
  mode.
---
 Documentation/dev-tools/kasan.rst | 34 +++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index d0c1796122df..5749c14b38d0 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -368,12 +368,18 @@ Ignoring accesses
 ~~~~~~~~~~~~~~~~~
 
 Software KASAN modes use compiler instrumentation to insert validity checks.
-Such instrumentation might be incompatible with some part of the kernel, and
-therefore needs to be disabled. To disable instrumentation for specific files
-or directories, add a line similar to the following to the respective kernel
+Such instrumentation might be incompatible with some parts of the kernel, and
+therefore needs to be disabled.
+
+Other parts of the kernel might access metadata for allocated objects.
+Normally, KASAN detects and reports such accesses, but in some cases (e.g.,
+in memory allocators), these accesses are valid.
+
+For software KASAN modes, to disable instrumentation for a specific file or
+directory, add a ``KASAN_SANITIZE`` annotation to the respective kernel
 Makefile:
 
-- For a single file (e.g. main.o)::
+- For a single file (e.g., main.o)::
 
     KASAN_SANITIZE_main.o := n
 
@@ -381,6 +387,26 @@ Makefile:
 
     KASAN_SANITIZE := n
 
+For software KASAN modes, to disable instrumentation on a per-function basis,
+use the KASAN-specific ``__no_sanitize_address`` function attribute or the
+generic ``noinstr`` one.
+
+Note that disabling compiler instrumentation (either on a per-file or a
+per-function basis) makes KASAN ignore the accesses that happen directly in
+that code for software KASAN modes. It does not help when the accesses happen
+indirectly (through calls to instrumented functions) or with the hardware
+tag-based mode that does not use compiler instrumentation.
+
+For software KASAN modes, to disable KASAN reports in a part of the kernel code
+for the current task, annotate this part of the code with a
+``kasan_disable_current()``/``kasan_enable_current()`` section. This also
+disables the reports for indirect accesses that happen through function calls.
+
+For tag-based KASAN modes (include the hardware one), to disable access
+checking, use ``kasan_reset_tag()`` or ``page_kasan_tag_reset()``. Note that
+temporarily disabling access checking via ``page_kasan_tag_reset()`` requires
+saving and restoring the per-page KASAN tag via
+``page_kasan_tag``/``page_kasan_tag_set``.
 
 Tests
 ~~~~~
-- 
2.31.0.rc2.261.g7f71774620-goog

