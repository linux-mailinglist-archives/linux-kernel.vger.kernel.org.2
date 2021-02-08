Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C5431401A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbhBHUOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbhBHSlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:41:22 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D1AC06178A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 10:40:41 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id t18so11227846qva.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 10:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=H9qB3jddJUOiem40qnE4VNfE96DiVHMNVUIiz3DWDnA=;
        b=OSxYfK3dabPv8tJszQgtCOZqGIaOISBkbN3FDZhJ6HWrPpAOOVAQhHEY6THhas9pV/
         F5A627x9q/0IJzaIDgwVPS035Gw88VxW8YyDmjkYuOG7r8KIaTvPzGNGsnCzo483hRVe
         t4gBMsqE+1ceWYYEioSzIHHmL7KpeVl+E6TNKPFeUl5ZyxzUs7v3LYt/NOKJ8IIV+gdv
         YH9DPbS546+/GdwOo2/8PBrzjPENUp2LA2L54+82eYdBEOILHNiIZ/gc1X4lr5u3DZ/F
         4ErPQ451EuWbWegvetp3oUqWqxqf8U1mogspr4ZibqSaWZyV9V4TtB6mao1Pc1aBvcjd
         34sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=H9qB3jddJUOiem40qnE4VNfE96DiVHMNVUIiz3DWDnA=;
        b=ATtqmEo+WJRZLF7+XgAo14QoQadpqq8+segt7EwaBB/A8+SCtIM5SXW5Jhc2J8bQ2z
         zBwCctCwTeZ94WuqrvknU4Zhwcv6PLStmAatHVWIC5fcoKmz85dE6wQVRLPU8sMJDR8X
         +r1UOmmn3K9FXZeXNfCzUSuDZckt1p6070C5dP3J8xB6Ol1LuFJSSxSwf6nEq7OKPkNz
         Y1h6StxfoM6awaKL+SzLMMUowys171gRAu++kHc+2zFV497xYTls973U3YreDZv9hvBH
         c7pdS8Nv5o/fj7Cw9xrmiVTHIPf7Jo8HBuKwJdHcI4c+2FlJKu5dPFFrqVuWgYzJRc1d
         6wnQ==
X-Gm-Message-State: AOAM531rwmtcvTwZgizJMcWzyVl+RwPM7MYK3GctFajPPtcXpaz0E+vO
        oKciGtPy7fk/6Mg56UaUW32HjIk3hLlmsJiJ
X-Google-Smtp-Source: ABdhPJzSTUaCTxZYjBF058uNJK2c/itP+NEV/iFWV4Mxc/d/k+Ag8gL3Dm65t7OaKUMhS1Maikf9IX68CyO4ri5A
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:55a0:b27b:af1c:327])
 (user=andreyknvl job=sendgmr) by 2002:a0c:c1cb:: with SMTP id
 v11mr13766499qvh.59.1612809640525; Mon, 08 Feb 2021 10:40:40 -0800 (PST)
Date:   Mon,  8 Feb 2021 19:40:36 +0100
Message-Id: <6678d77ceffb71f1cff2cf61560e2ffe7bb6bfe9.1612808820.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH] kasan: fix stack traces dependency for HW_TAGS
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

Currently, whether the alloc/free stack traces collection is enabled by
default for hardware tag-based KASAN depends on CONFIG_DEBUG_KERNEL.
The intention for this dependency was to only enable collection on slow
debug kernels due to a significant perf and memory impact.

As it turns out, CONFIG_DEBUG_KERNEL is not considered a debug option
and is enabled on many productions kernels including Android and Ubuntu.
As the result, this dependency is pointless and only complicates the code
and documentation.

Having stack traces collection disabled by default would make the hardware
mode work differently to to the software ones, which is confusing.

This change removes the dependency and enables stack traces collection
by default.

Looking into the future, this default might makes sense for production
kernels, assuming we implement a fast stack trace collection approach.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/dev-tools/kasan.rst | 3 +--
 mm/kasan/hw_tags.c                | 8 ++------
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 1651d961f06a..a248ac3941be 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -163,8 +163,7 @@ particular KASAN features.
 - ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
 
 - ``kasan.stacktrace=off`` or ``=on`` disables or enables alloc and free stack
-  traces collection (default: ``on`` for ``CONFIG_DEBUG_KERNEL=y``, otherwise
-  ``off``).
+  traces collection (default: ``on``).
 
 - ``kasan.fault=report`` or ``=panic`` controls whether to only print a KASAN
   report or also panic the kernel (default: ``report``).
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index e529428e7a11..d558799b25b3 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -134,12 +134,8 @@ void __init kasan_init_hw_tags(void)
 
 	switch (kasan_arg_stacktrace) {
 	case KASAN_ARG_STACKTRACE_DEFAULT:
-		/*
-		 * Default to enabling stack trace collection for
-		 * debug kernels.
-		 */
-		if (IS_ENABLED(CONFIG_DEBUG_KERNEL))
-			static_branch_enable(&kasan_flag_stacktrace);
+		/* Default to enabling stack trace collection. */
+		static_branch_enable(&kasan_flag_stacktrace);
 		break;
 	case KASAN_ARG_STACKTRACE_OFF:
 		/* Do nothing, kasan_flag_stacktrace keeps its default value. */
-- 
2.30.0.478.g8a0d178c01-goog

