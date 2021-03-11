Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC55337FC6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 22:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbhCKViV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 16:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhCKVhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:37:52 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3A1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:37:52 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id f9so4580319wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KqyiEXFZVlJ5WAkVIpzRsNvJDBTABYowTYxavN0wmPI=;
        b=vUKUWADTysn9YczPlnO53jYKYuLAG9pNDM0DXT3f6YdB5w4mlKOmJqqd/tGTFSDvdz
         FmsShTL8D6d0ayHAepOJQVXj6AG/O2j0fCohJgEu2atXg3/J7rnfGbzdfZsoaBK3bZxi
         z5M3Ow0kLuVo2gzEXn+ojysuZqAr8xxsoV2+0IBsNpSKpkaX2/LXzYoZmELq3zE/kcDI
         5O0eoEngZSfqEs8uWMaNzHom/AdhnIyjGWxB05yQPbAUUauSNqVHffFtOZ82AOwuXlPj
         uCOuEZkmUGrmqVaQDNPBWHyTL/ZYjJzMyeWMp3VVc0ywHL5DEVEM8Z1FYSOtQBykGMlU
         HZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KqyiEXFZVlJ5WAkVIpzRsNvJDBTABYowTYxavN0wmPI=;
        b=O1kw4n+M7AfwvspyJyzdXNPmNTj8a7EHzJq89AZX7bi1rP6fysd69UIPzOK1tLymsn
         w/SXNPTnjrO3Y8GJu6AC4Hu6BPw2Tn9dTUkysw6ew35BzXcDRKPtUShh4gjI54wbdRBD
         GQFm1UoYBNcT3DawM/PF1ustRgaMGOQNGJ+Ec8YALFBZpCv8y6x00UN/bHIdfTAiiS9L
         J44hEia6m7Ymn/OYDuAerPb8JMCzBxHwidTwdz7CiXCfszdCiulEoAOH6L0c1jSolJs9
         xBkzDF9i7R4SMBMljb3vdpJfgxJjEbe2Dzy2Y3NOUvK1usJPXigQ3Wrg7glTfQKcTVrg
         ZECw==
X-Gm-Message-State: AOAM530aQmZ7URGwkblW7qaSjORMV8wIOgFt2j8Y/AIcRGOBmReI6JVd
        offi66WgMhrcPne6MnqEMBhab7qNOZNZImyz
X-Google-Smtp-Source: ABdhPJwPI7MXwIggsu0PIhpFTdjlAk8f4pD+e/W64RlEyitc321VCJDbT5aPSUC15RhN1r5iSJ07BSbs/d8EUiHp
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:95a:d8a8:4925:42be])
 (user=andreyknvl job=sendgmr) by 2002:a7b:cc84:: with SMTP id
 p4mr10172254wma.10.1615498671258; Thu, 11 Mar 2021 13:37:51 -0800 (PST)
Date:   Thu, 11 Mar 2021 22:37:23 +0100
In-Reply-To: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
Message-Id: <f9e2d81b65dac1c51a8109f039a5adbc5798d169.1615498565.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 11/11] kasan: docs: update tests section
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

Update the "Tests" section in KASAN documentation:

- Add an introductory sentence.
- Add proper indentation for the list of ways to run KUnit tests.
- Punctuation, readability, and other minor clean-ups.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/dev-tools/kasan.rst | 33 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 6628b133c9ad..c4a3c8a9fe71 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -398,19 +398,20 @@ To disable KASAN reports in a certain part of the kernel code:
 Tests
 ~~~~~
 
-KASAN tests consist of two parts:
+There are KASAN tests that allow verifying that KASAN works and can detect
+certain types of memory corruptions. The tests consist of two parts:
 
 1. Tests that are integrated with the KUnit Test Framework. Enabled with
 ``CONFIG_KASAN_KUNIT_TEST``. These tests can be run and partially verified
-automatically in a few different ways, see the instructions below.
+automatically in a few different ways; see the instructions below.
 
 2. Tests that are currently incompatible with KUnit. Enabled with
 ``CONFIG_KASAN_MODULE_TEST`` and can only be run as a module. These tests can
-only be verified manually, by loading the kernel module and inspecting the
+only be verified manually by loading the kernel module and inspecting the
 kernel log for KASAN reports.
 
-Each KUnit-compatible KASAN test prints a KASAN report if an error is detected.
-Then the test prints its number and status.
+Each KUnit-compatible KASAN test prints one of multiple KASAN reports if an
+error is detected. Then the test prints its number and status.
 
 When a test passes::
 
@@ -438,27 +439,25 @@ Or, if one of the tests failed::
 
         not ok 1 - kasan
 
-
 There are a few ways to run KUnit-compatible KASAN tests.
 
 1. Loadable module
 
-With ``CONFIG_KUNIT`` enabled, ``CONFIG_KASAN_KUNIT_TEST`` can be built as
-a loadable module and run on any architecture that supports KASAN by loading
-the module with insmod or modprobe. The module is called ``test_kasan``.
+   With ``CONFIG_KUNIT`` enabled, KASAN-KUnit tests can be built as a loadable
+   module and run by loading the `test_kasan.ko`` with ``insmod`` or
+   ``modprobe``.
 
 2. Built-In
 
-With ``CONFIG_KUNIT`` built-in, ``CONFIG_KASAN_KUNIT_TEST`` can be built-in
-on any architecure that supports KASAN. These and any other KUnit tests enabled
-will run and print the results at boot as a late-init call.
+   With ``CONFIG_KUNIT`` built-in, KASAN-KUnit tests can be built-in as well.
+   In this case, the tests will run at boot as a late-init call.
 
 3. Using kunit_tool
 
-With ``CONFIG_KUNIT`` and ``CONFIG_KASAN_KUNIT_TEST`` built-in, it's also
-possible use ``kunit_tool`` to see the results of these and other KUnit tests
-in a more readable way. This will not print the KASAN reports of the tests that
-passed. Use `KUnit documentation <https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html>`_
-for more up-to-date information on ``kunit_tool``.
+   With ``CONFIG_KUNIT`` and ``CONFIG_KASAN_KUNIT_TEST`` built-in, it is also
+   possible to use ``kunit_tool`` to see the results of KUnit tests in a more
+   readable way. This will not print the KASAN reports of the tests that passed.
+   See `KUnit documentation <https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html>`_
+   for more up-to-date information on ``kunit_tool``.
 
 .. _KUnit: https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html
-- 
2.31.0.rc2.261.g7f71774620-goog

