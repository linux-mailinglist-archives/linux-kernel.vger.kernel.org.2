Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BDE337FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 22:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhCKVhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 16:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhCKVh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:37:29 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A85C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:37:28 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id z26so4571937wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+0bSxqm3N16pi4DLzYVkzAZIIL0GOgjjdGwFbbf/d6g=;
        b=nG+j8ZjKWJHc0pWl0HEWnV5szaRgEoGqQZAqlugEgOCqWeoxKf+eOEgQ7GtX9f3rpG
         i//Khh4s46yYKi9ia+gYNZnqaWCjtHpXqxy/ZcUTMQyVTt3GLlVqcEy8qglz3lMxMaIS
         fsiAaKa9PfdRoR2qpcmZ0kfyN0MgY6/pecoPIhdtnPqgaTrImvBJT87toUBYiWZm7oB5
         tmR62qDRAGWhmkVheLXp7x+2VIZisul9o/bh/MKFtt3SJqp4vBQP+PQoayaPchChtdSW
         aMlD3xxQiT23Etg6lerRBN4cuqOtH7J3Z2AY8K2aUCgdBr7iuUGwBE7S1OZ6QTyL4KL8
         Talw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+0bSxqm3N16pi4DLzYVkzAZIIL0GOgjjdGwFbbf/d6g=;
        b=sR8p39Whs6HY0SU8MulYhfQZe4dYrJqXkfeo6BSrRCzfbnUjmCFyzY2eiuxMbMjmeX
         yrlHKsl7F6McXQ+slHwdR/QQ1Gqu1VtwrOqshdCAWyiar9yUOl2KsFLePMrFlDYSQhsY
         7R0Cw0s29Y1zZgIvNj6Q8op0lzUp824q7VlaGVV2HoNTltyW79OTmDFrpgRP81g7WhVG
         mCAC9wcwuOO9eNmXcqhg63hOA5YgcQRqeoJ4c73WgJUFOI8YHnCDyyGDZpxFjxedk7lB
         y99su93cZpcmxovBrP5E1J6fJ9aaQlYwK3lmRbGcJjfYp8dZvmmcLfOL2/5EIx/TqYLu
         pl6Q==
X-Gm-Message-State: AOAM532JdwClVChxrFcj6QNSXiLskwL7xHkNQURzGnS+wgs96kcbb16Y
        C43APTeL1etDaQ/Zg+LymgcDeTqyp+EOUum2
X-Google-Smtp-Source: ABdhPJzpngoBsnxjuh5T3WV1Q4rDy2G/NhYnnXiurKZVByyvDTixZR0+zyVt3uiDvASjAsjfW6bZLh3MxsQqfiap
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:95a:d8a8:4925:42be])
 (user=andreyknvl job=sendgmr) by 2002:a5d:638f:: with SMTP id
 p15mr10637565wru.220.1615498647343; Thu, 11 Mar 2021 13:37:27 -0800 (PST)
Date:   Thu, 11 Mar 2021 22:37:13 +0100
Message-Id: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 01/11] kasan: docs: clean up sections
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

Update KASAN documentation:

- Give some sections clearer names.
- Remove unneeded subsections in the "Tests" section.
- Move the "For developers" section and split into subsections.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/dev-tools/kasan.rst | 50 +++++++++++++++----------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index ddf4239a5890..c9484f34da2a 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -168,24 +168,6 @@ particular KASAN features.
   report or also panic the kernel (default: ``report``). Note, that tag
   checking gets disabled after the first reported bug.
 
-For developers
-~~~~~~~~~~~~~~
-
-Software KASAN modes use compiler instrumentation to insert validity checks.
-Such instrumentation might be incompatible with some part of the kernel, and
-therefore needs to be disabled. To disable instrumentation for specific files
-or directories, add a line similar to the following to the respective kernel
-Makefile:
-
-- For a single file (e.g. main.o)::
-
-    KASAN_SANITIZE_main.o := n
-
-- For all files in one directory::
-
-    KASAN_SANITIZE := n
-
-
 Implementation details
 ----------------------
 
@@ -299,8 +281,8 @@ support MTE (but supports TBI).
 Hardware tag-based KASAN only reports the first found bug. After that MTE tag
 checking gets disabled.
 
-What memory accesses are sanitised by KASAN?
---------------------------------------------
+Shadow memory
+-------------
 
 The kernel maps memory in a number of different parts of the address
 space. This poses something of a problem for KASAN, which requires
@@ -362,8 +344,29 @@ unmapped. This will require changes in arch-specific code.
 This allows ``VMAP_STACK`` support on x86, and can simplify support of
 architectures that do not have a fixed module region.
 
-CONFIG_KASAN_KUNIT_TEST and CONFIG_KASAN_MODULE_TEST
-----------------------------------------------------
+For developers
+--------------
+
+Ignoring accesses
+~~~~~~~~~~~~~~~~~
+
+Software KASAN modes use compiler instrumentation to insert validity checks.
+Such instrumentation might be incompatible with some part of the kernel, and
+therefore needs to be disabled. To disable instrumentation for specific files
+or directories, add a line similar to the following to the respective kernel
+Makefile:
+
+- For a single file (e.g. main.o)::
+
+    KASAN_SANITIZE_main.o := n
+
+- For all files in one directory::
+
+    KASAN_SANITIZE := n
+
+
+Tests
+~~~~~
 
 KASAN tests consist of two parts:
 
@@ -409,21 +412,18 @@ Or, if one of the tests failed::
 There are a few ways to run KUnit-compatible KASAN tests.
 
 1. Loadable module
-~~~~~~~~~~~~~~~~~~
 
 With ``CONFIG_KUNIT`` enabled, ``CONFIG_KASAN_KUNIT_TEST`` can be built as
 a loadable module and run on any architecture that supports KASAN by loading
 the module with insmod or modprobe. The module is called ``test_kasan``.
 
 2. Built-In
-~~~~~~~~~~~
 
 With ``CONFIG_KUNIT`` built-in, ``CONFIG_KASAN_KUNIT_TEST`` can be built-in
 on any architecure that supports KASAN. These and any other KUnit tests enabled
 will run and print the results at boot as a late-init call.
 
 3. Using kunit_tool
-~~~~~~~~~~~~~~~~~~~
 
 With ``CONFIG_KUNIT`` and ``CONFIG_KASAN_KUNIT_TEST`` built-in, it's also
 possible use ``kunit_tool`` to see the results of these and other KUnit tests
-- 
2.31.0.rc2.261.g7f71774620-goog

