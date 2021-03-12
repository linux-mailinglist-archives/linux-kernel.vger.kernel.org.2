Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238F7338FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhCLOZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbhCLOZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:25:04 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17BFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:25:03 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id g2so11227480wrx.20
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Bw5uCei/catF+EzOEmfCcRCFyREJER0Q0h8plWDwOtQ=;
        b=Xnhtd3gvW2K8u2WiuCaZNvtsoyWO9DSXU+9u6yVJZ4RbQh7xRFDPPX1TkZXDu2ZUGc
         vBkGtX3S8Jq5LetjXUH0b+2csT0PMYHsU2T0hLUWe5RLQ67/II10RAKEsIGTO9Rg5nj5
         uyQPdUribEsObu00cvEGjydTSBi2d2qvyX1zkl+7Us81ZrgAbZUQVj17EMzIMQuiGmEa
         Wai+muui+UNGInCH5JrDeQWuus39Oez87A9DPVxkdClfs2Z6MS0mhRNl8dMnlLXappbW
         yXYhJ1d21mG1S90SgjQx9wBSLQ/VsQhFTo0iyj1XWheORUnb1eGCiEa7GIUA//kZ2DO3
         RkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Bw5uCei/catF+EzOEmfCcRCFyREJER0Q0h8plWDwOtQ=;
        b=dyGr74G38Dypyc3xWzoZxineYChSib0irqJYcsmCHGBs2VlAERhXtAJMNICrTJis4G
         3kH8e0A3EcuJXsq0Ol2Taap9Lb72nsESy8uHVEopTV53EIsGiw71tD93Fpwf0Dj7PcNW
         RMzaH4ZzOyr7aafQOvs5NtDUQKBfqvm+PDbltyGM2tCD6h9OxUiTFFoqbH/VbYOulJpY
         HIgjH6szo9fQRvYhxh+h7MMu4/SGdp7PjMbpBtB9u3fcRbb+IVelGY42MP7GAnHnn23q
         dhPS5uog6X64HIijIjh4sCOj1AvpF52nklbwc0hws0bwtyOLWVZNP/OEEkBFP0Dak3JQ
         nxZA==
X-Gm-Message-State: AOAM530gVx3bsnpuvWLmzOKt68XY450hOIYRQSIb7PmEanJs2X5G0YP6
        RT3gxVXl5+R8r6kcyLc9Y+ARWj+rTOapE6OD
X-Google-Smtp-Source: ABdhPJzx/wOW6+gWN/8am6G2R3KojRCf27zV3DUYoC42P07d36RS26M31dlU0mkAElkJQD/Bs1CkPM2pjAu6wwFv
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:95a:d8a8:4925:42be])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c18e:: with SMTP id
 y14mr2248712wmi.1.1615559101927; Fri, 12 Mar 2021 06:25:01 -0800 (PST)
Date:   Fri, 12 Mar 2021 15:24:34 +0100
In-Reply-To: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
Message-Id: <fb08845e25c8847ffda271fa19cda2621c04a65b.1615559068.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2 11/11] kasan: docs: update tests section
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

Changes v1->v2:
- Fix missing snippet delimeter around "test_kasan.ko".
- Drop "the" before "test_kasan.ko".
---
 Documentation/dev-tools/kasan.rst | 32 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 5749c14b38d0..a8c3e0cff88d 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -411,19 +411,20 @@ saving and restoring the per-page KASAN tag via
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
 
@@ -451,27 +452,24 @@ Or, if one of the tests failed::
 
         not ok 1 - kasan
 
-
 There are a few ways to run KUnit-compatible KASAN tests.
 
 1. Loadable module
 
-With ``CONFIG_KUNIT`` enabled, ``CONFIG_KASAN_KUNIT_TEST`` can be built as
-a loadable module and run on any architecture that supports KASAN by loading
-the module with insmod or modprobe. The module is called ``test_kasan``.
+   With ``CONFIG_KUNIT`` enabled, KASAN-KUnit tests can be built as a loadable
+   module and run by loading ``test_kasan.ko`` with ``insmod`` or ``modprobe``.
 
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

