Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E45337FBF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 22:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhCKViK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 16:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhCKVhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:37:35 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2FDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:37:35 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id v19so16585425qtw.19
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Z5eOirVQs3kFMVVYLPwNbYTFfp7Ms1nJ3eBbZNg7oSE=;
        b=ss9oJe0pM2ElU/I3jSTTIlzmBUFKVJwse1lMSmfbJC3heqvzN6V6cu3CVowDOoIys7
         rHMW8ZRVxkgSQlriCc4puO8sQCLF4m52Eo7IvUY49QDarKLJYOtK6OA4Ulvgcrs5jMLJ
         0frkrdx99oF6gVY8/+c6aadOP0Sm5IPEodDeKW00DgiskPb06OwXLLcaGoFCFAFb02We
         4RaGm9dQxKxdpEJ5Smlg67KHtZJ4/ZGTU/9xSWGC5mt8nD8ct0o6fNh5RoUkDWOBFMxZ
         4HacTXoIMjA7mgORYCvPh35ywI0iWSlVW8T1j1N8iEmg+PCR69tuDedRH8+TrZPo3mMi
         Z8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z5eOirVQs3kFMVVYLPwNbYTFfp7Ms1nJ3eBbZNg7oSE=;
        b=IKKVeZZKL3ANRGSFi3AY7/fmdAlF61JpT19WKXmYpmayLlqiYdZ3+OZkn4Kpp/wdVP
         nY9oeTlyiwZC78sZ5ZVFVuPusLWH2CC6F3x6hUkzp5ggI4XGBRTEMQRCrSZe5EdXqJK5
         7OwjtUshoCnOLT89DP7TObvnj8gA9hsAsaI3ojPieApU6UkiRS8qqmkj5j/Lf6V4rGuk
         CHW2nHpgpl3e4QiDWdwJxrTXCQyVgfT1awr49W8ThqIqGMXpIZyAUifvsQIUi/WjWIPs
         8hilLCACxdv2KKCDbnFkLo6Xpr5SSpKfhJC24u1s8Bct46MebrhrbiFL/JPxsy+NEPo7
         iQ3w==
X-Gm-Message-State: AOAM532TDJqa91mhv0HsUiqrBaHMhZxJoR7f8hJ/RHHvUW+OYOL2blgy
        1KiQfB03+0T3TjJagqbyz67UApvqjnaldyKa
X-Google-Smtp-Source: ABdhPJwtC+4faGTKQmjBS8T6FlPpbYJS3wpQopaKe7j5nNJcKaN9acXfERXOjuleqJBSaw58Zbaz0cv45QLzR4Fs
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:95a:d8a8:4925:42be])
 (user=andreyknvl job=sendgmr) by 2002:a0c:c248:: with SMTP id
 w8mr9669098qvh.58.1615498654537; Thu, 11 Mar 2021 13:37:34 -0800 (PST)
Date:   Thu, 11 Mar 2021 22:37:16 +0100
In-Reply-To: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
Message-Id: <fb4c4c963a8f35df5d42706cf3384a1a1e36554b.1615498565.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 04/11] kasan: docs: update error reports section
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

Update the "Error reports" section in KASAN documentation:

- Mention that bug titles are best-effort.
- Move and reword the part about auxiliary stacks from
  "Implementation details".
- Punctuation, readability, and other minor clean-ups.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/dev-tools/kasan.rst | 46 +++++++++++++++++--------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index f21c0cbebcb3..5fe43489e94e 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -60,7 +60,7 @@ physical pages, enable ``CONFIG_PAGE_OWNER`` and boot with ``page_owner=on``.
 Error reports
 ~~~~~~~~~~~~~
 
-A typical out-of-bounds access generic KASAN report looks like this::
+A typical KASAN report looks like this::
 
     ==================================================================
     BUG: KASAN: slab-out-of-bounds in kmalloc_oob_right+0xa8/0xbc [test_kasan]
@@ -133,33 +133,43 @@ A typical out-of-bounds access generic KASAN report looks like this::
      ffff8801f44ec400: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
     ==================================================================
 
-The header of the report provides a short summary of what kind of bug happened
-and what kind of access caused it. It's followed by a stack trace of the bad
-access, a stack trace of where the accessed memory was allocated (in case bad
-access happens on a slab object), and a stack trace of where the object was
-freed (in case of a use-after-free bug report). Next comes a description of
-the accessed slab object and information about the accessed memory page.
+The report header summarizes what kind of bug happened and what kind of access
+caused it. It is followed by a stack trace of the bad access, a stack trace of
+where the accessed memory was allocated (in case a slab object was accessed),
+and a stack trace of where the object was freed (in case of a use-after-free
+bug report). Next comes a description of the accessed slab object and the
+information about the accessed memory page.
 
-In the last section the report shows memory state around the accessed address.
-Internally KASAN tracks memory state separately for each memory granule, which
+In the end, the report shows the memory state around the accessed address.
+Internally, KASAN tracks memory state separately for each memory granule, which
 is either 8 or 16 aligned bytes depending on KASAN mode. Each number in the
 memory state section of the report shows the state of one of the memory
 granules that surround the accessed address.
 
-For generic KASAN the size of each memory granule is 8. The state of each
+For generic KASAN, the size of each memory granule is 8. The state of each
 granule is encoded in one shadow byte. Those 8 bytes can be accessible,
-partially accessible, freed or be a part of a redzone. KASAN uses the following
-encoding for each shadow byte: 0 means that all 8 bytes of the corresponding
+partially accessible, freed, or be a part of a redzone. KASAN uses the following
+encoding for each shadow byte: 00 means that all 8 bytes of the corresponding
 memory region are accessible; number N (1 <= N <= 7) means that the first N
 bytes are accessible, and other (8 - N) bytes are not; any negative value
 indicates that the entire 8-byte word is inaccessible. KASAN uses different
 negative values to distinguish between different kinds of inaccessible memory
 like redzones or freed memory (see mm/kasan/kasan.h).
 
-In the report above the arrows point to the shadow byte 03, which means that
-the accessed address is partially accessible. For tag-based KASAN modes this
-last report section shows the memory tags around the accessed address
-(see the `Implementation details`_ section).
+In the report above, the arrow points to the shadow byte ``03``, which means
+that the accessed address is partially accessible.
+
+For tag-based KASAN modes, this last report section shows the memory tags around
+the accessed address (see the `Implementation details`_ section).
+
+Note that KASAN bug titles (like ``slab-out-of-bounds`` or ``use-after-free``)
+are best-effort: KASAN prints the most probable bug type based on the limited
+information it has. The actual type of the bug might be different.
+
+Generic KASAN also reports up to two auxiliary call stack traces. These stack
+traces point to places in code that interacted with the object but that are not
+directly present in the bad access stack trace. Currently, this includes
+call_rcu() and workqueue queuing.
 
 Boot parameters
 ~~~~~~~~~~~~~~~
@@ -214,10 +224,6 @@ function calls GCC directly inserts the code to check the shadow memory.
 This option significantly enlarges kernel but it gives x1.1-x2 performance
 boost over outline instrumented kernel.
 
-Generic KASAN also reports the last 2 call stacks to creation of work that
-potentially has access to an object. Call stacks for the following are shown:
-call_rcu() and workqueue queuing.
-
 Generic KASAN is the only mode that delays the reuse of freed object via
 quarantine (see mm/kasan/quarantine.c for implementation).
 
-- 
2.31.0.rc2.261.g7f71774620-goog

