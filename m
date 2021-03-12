Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49F1338FED
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhCLOYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbhCLOYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:24:39 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4115C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:24:38 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id t18so17597582qva.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iXUBccT1s/Tpz0xpM0wAfa/pMQuz7eoXMXGou1E4nY8=;
        b=nXGX3uu1DMoAwGMzh6ZF3gsPGgxXAloDpF10xlKbClV0eN/txB0mPw/MO61bESnYPT
         O3eBA7dXz9prhNZzsetEN2ZQGjvCLoYEu4JFwYiPAUgLsDKEBLDW2HdeogZB6H/8/jlC
         +3rUnQnIi+sVzOY9L9AgXOxd+I4xNMIVZQBArHnJJ5BHjT0kCarwVSpWrf6sMPAFZZK7
         xGujlM8ClMOuEZjK+cJTGGDUDXenoZphVsSac6CId3FGYGrd5nJ4tigA11sKhYU9AU2d
         KMVNImLe8WH9EM0IZY/K0PYPUudSmeB5CgLTOW6vKnZTsxsEoF6tx37zkTQ1wF7ebK3f
         MRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iXUBccT1s/Tpz0xpM0wAfa/pMQuz7eoXMXGou1E4nY8=;
        b=eoEeKNr88WCP8A26Kh5RQSCBTSCP4D76gOdEaM+ATuS5NwYnpguMYp8XSVGnB4YXDb
         kKjwrQZlTXqMcCP0p4ZG5doKtM08QzjQHifjxh+f8yYnrJqAM4Cm8MrdqzqR5PHR+uKl
         E6p9/0f9kJ+buqMKKu7jZqCOS8FdYkGsMFpN+n3bgEkCiODA1PV8sUatB/GYIQtS9RoJ
         NFDuAVv1BjP+LO87bTlQnSt51/lmnopD+LvIzTULDaysjCOMJX+RHhDi9jEJowChL5me
         l/W2ls84WI7wBEFcesu+Ag3Q3OHUrFqH46XcCMtGZF2Xb1pBYQwmvNSMZgp4Nro1n819
         G1Pg==
X-Gm-Message-State: AOAM530mi+WRj7grCUoxLt9U0fLZT734G8m4CL0Ru79AomfA2uX94KHK
        JNsxwI9rKoiQhPlA5QxB/jK/vRQfdsdW/HLw
X-Google-Smtp-Source: ABdhPJz9mDUjTU99hjsECwi+EVDjFSiRUu2Cbxnw2RJk16AhnoByPHfMDcrVC6QGLFbIw0tfj/qLuVL6uKemhBfp
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:95a:d8a8:4925:42be])
 (user=andreyknvl job=sendgmr) by 2002:a0c:8f1a:: with SMTP id
 z26mr11991825qvd.51.1615559078072; Fri, 12 Mar 2021 06:24:38 -0800 (PST)
Date:   Fri, 12 Mar 2021 15:24:24 +0100
Message-Id: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2 01/11] kasan: docs: clean up sections
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

Changes v1->v2:
- Rename "By default" section to "Default behaviour".
---
 Documentation/dev-tools/kasan.rst | 54 +++++++++++++++----------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index ddf4239a5890..b3b2c517db55 100644
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
@@ -311,8 +293,8 @@ The range of kernel virtual addresses is large: there is not enough
 real memory to support a real shadow region for every address that
 could be accessed by the kernel.
 
-By default
-~~~~~~~~~~
+Default behaviour
+~~~~~~~~~~~~~~~~~
 
 By default, architectures only map real memory over the shadow region
 for the linear mapping (and potentially other small areas). For all
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

