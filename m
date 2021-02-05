Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7144310F02
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 18:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbhBEQDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbhBEPzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:55:40 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B89C0617AA
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 09:35:22 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id 22so5766119qty.14
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 09:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=qTEJ0ZFBO6HUy56kVKTkSwNvhkuevt789FDycYnAlaw=;
        b=G68KUqp3HFLcXYHG+bANujiKTjP1H7aOPDJCFa1RkVjgdbj5cMzKLUYhQ88IOigD2m
         g5wDAziPJ9/f2dbpwetUHkPJSL+aI/MWcTpGdaiivZgXRAc1C7nVA8lhLw49A9oP0xKP
         YkRx4Li9ZnC0Fp2IsX/EdfVi5nLsxTLigRBe9oKmV5ex/G9k44wbWqIs5s5fsPBc6OK1
         UhA4HiSIlJg20l5gKCGg1nOsKB7YDjIwiGT0etN2p6CDP2nZon8XJQMGeGLgUOz+VcNi
         bc8djrtRbaTCpDbTXiogPshowtlILUAlRK7BVS1XEzHo35Yv9MrTtxK4e+3RPZe4PG7Z
         jBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qTEJ0ZFBO6HUy56kVKTkSwNvhkuevt789FDycYnAlaw=;
        b=qdtoWBjVy/q/SljEb9sHrDO6PwIPHAhfRzrTRNucb5cG8o3R3vdTsS/uq7EDYhV2f9
         Hm1rNIkG1qq7Nk/nqAqRxSgqjyCxZ3T6eYrjbWcp18WlSYgY2XFobG7HC2XVmTsClRoT
         /+oxaiFtIXpTgxuO12vPsX4CvTXGcz5z9I+QacQ5MZaP4GYuAHBmMXi+xIZsv8YfRFKP
         M4P8D69xWIyNsW7Wo/lQ1jm7r13fqSei0MqQ1dWo6/yuww2hAOyvj7TaSqpz4gE2bB6c
         N6VIsLuJy0wvBTqa+Xg3RD36LGirhXDODW7+yHYMY9nbreLObCPRoe9thNZ64+eGO2Sk
         337A==
X-Gm-Message-State: AOAM532YspHhCbIonBDDAhYuGA2z6i6Vm7/uvKthkkYF8wZksJ0UUW/e
        ExLyC4TLMxaFG0LQaXdd8NFQ59CsjDVJyZvc
X-Google-Smtp-Source: ABdhPJyrCz7kXUmcNbcxCdKw5jsfPhQUKg97pR36HY1rcIJSHaA7CzMpo0ImY3xsQ8HCnIvFo9TLiGVZ7iEPqvw/
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:edb8:b79c:2e20:e531])
 (user=andreyknvl job=sendgmr) by 2002:ad4:4f41:: with SMTP id
 eu1mr5346273qvb.34.1612546521952; Fri, 05 Feb 2021 09:35:21 -0800 (PST)
Date:   Fri,  5 Feb 2021 18:34:47 +0100
In-Reply-To: <cover.1612546384.git.andreyknvl@google.com>
Message-Id: <00383ba88a47c3f8342d12263c24bdf95527b07d.1612546384.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612546384.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v3 mm 13/13] kasan: clarify that only first bug is reported in HW_TAGS
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

Hwardware tag-based KASAN only reports the first found bug. After that MTE
tag checking gets disabled. Clarify this in comments and documentation.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/dev-tools/kasan.rst | 8 ++++++--
 mm/kasan/hw_tags.c                | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index e022b7506e37..1faabbe23e09 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -155,7 +155,7 @@ Boot parameters
 ~~~~~~~~~~~~~~~
 
 Hardware tag-based KASAN mode (see the section about various modes below) is
-intended for use in production as a security mitigation. Therefore it supports
+intended for use in production as a security mitigation. Therefore, it supports
 boot parameters that allow to disable KASAN competely or otherwise control
 particular KASAN features.
 
@@ -166,7 +166,8 @@ particular KASAN features.
   ``off``).
 
 - ``kasan.fault=report`` or ``=panic`` controls whether to only print a KASAN
-  report or also panic the kernel (default: ``report``).
+  report or also panic the kernel (default: ``report``). Note, that tag
+  checking gets disabled after the first reported bug.
 
 For developers
 ~~~~~~~~~~~~~~
@@ -296,6 +297,9 @@ Note, that enabling CONFIG_KASAN_HW_TAGS always results in in-kernel TBI being
 enabled. Even when kasan.mode=off is provided, or when the hardware doesn't
 support MTE (but supports TBI).
 
+Hardware tag-based KASAN only reports the first found bug. After that MTE tag
+checking gets disabled.
+
 What memory accesses are sanitised by KASAN?
 --------------------------------------------
 
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index e529428e7a11..6c9285c906b8 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -48,7 +48,7 @@ EXPORT_SYMBOL(kasan_flag_enabled);
 /* Whether to collect alloc/free stack traces. */
 DEFINE_STATIC_KEY_FALSE(kasan_flag_stacktrace);
 
-/* Whether panic or disable tag checking on fault. */
+/* Whether to panic or print a report and disable tag checking on fault. */
 bool kasan_flag_panic __ro_after_init;
 
 /* kasan=off/on */
-- 
2.30.0.365.g02bc693789-goog

