Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3969337FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 22:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhCKVhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 16:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhCKVhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:37:31 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F090C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:37:31 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id k16so9235075ejg.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bDwYzUcq1HRoRYrIwl703QQ3e7+1Dgb9ijuIXOFbJHo=;
        b=AN4kaYWMwgLyNq9/I2+MxoRvyGdu5wrRA0oy9puCLntFIfitARVxBAREcjxAZTPB6G
         ILX8K3mtmmvfngnASSchXJ7vleDurUCocGbi4ou5uRB8sBewWhKoQmwU4l723uGTwv0i
         IOYQNbSuPtJupX70JfyQzfetrlZbE91wTbGJD3QCvuI8cqtl2BAtd9bpnEactwFhZEwm
         Y3BsGpb4rA5jPvbVKm1Q62RZF7uTg2jxPjqvDirsJGKliWAZ91n1rHUiNBi32ImW3IIP
         jYwQnl13fF1UnBnX5lD+DmCoHYVwhur1LzpCYfKjcHZGVn44dUBo8N4ElCCtQlI4ovce
         STng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bDwYzUcq1HRoRYrIwl703QQ3e7+1Dgb9ijuIXOFbJHo=;
        b=PAWXsGtYAj0OUWfgFGGc7sVto5Ri6ezL4AwDT+zh1RgTjZpB3RKNeisfIyZ/m6HSl5
         LZfbho0qLDhuvZGqXGxUZP7rzWcKUuC1PLSg8s7AZf63ps4DlVCcjsDkGOAES3zMxods
         K/r9qZ7YpoLTVQ6/fX2ppxSNGhQpD+eieq03JUtmxa31pm3UlIjtLOOJ+OVSddNDbYFx
         NcQ+MRI/wr0vVNmArfbaFor9MEtPY/NLPdhyxuTlx9YVUkyD62YYiRgi6J3InBOWSssw
         bW6bmbWrOm1aKcPkwEdMeX0crszLCkBouwSQXY5oNJZq10DcjXZrX79mQpY83Qg5BBrU
         BsKg==
X-Gm-Message-State: AOAM532bZmr9jdhJEfPkin9gVLXCahMUl+Hmq88PQtrBD6fie0SgJOT4
        A+kl0qpBcgJ0e/RUohYdFr1W2PbSqlefNBuX
X-Google-Smtp-Source: ABdhPJzMo+eA7a6fuh+dXZsnTOZaNB7TB8P9v/TP9gl7+G9QurdFlRfLnemsNIzMnIgQfGWArKpJYiTpxeF0yhpH
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:95a:d8a8:4925:42be])
 (user=andreyknvl job=sendgmr) by 2002:a17:906:bccc:: with SMTP id
 lw12mr5043065ejb.268.1615498649994; Thu, 11 Mar 2021 13:37:29 -0800 (PST)
Date:   Thu, 11 Mar 2021 22:37:14 +0100
In-Reply-To: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
Message-Id: <da296c4fe645f724922b691019e9e578e1834557.1615498565.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 02/11] kasan: docs: update overview section
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

Update the "Overview" section in KASAN documentation:

- Outline main use cases for each mode.
- Mention that HW_TAGS mode need compiler support too.
- Move the part about SLUB/SLAB support from "Usage" to "Overview".
- Punctuation, readability, and other minor clean-ups.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/dev-tools/kasan.rst | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index c9484f34da2a..343a683d0520 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -11,17 +11,31 @@ designed to find out-of-bound and use-after-free bugs. KASAN has three modes:
 2. software tag-based KASAN (similar to userspace HWASan),
 3. hardware tag-based KASAN (based on hardware memory tagging).
 
-Software KASAN modes (1 and 2) use compile-time instrumentation to insert
-validity checks before every memory access, and therefore require a compiler
+Generic KASAN is mainly used for debugging due to a large memory overhead.
+Software tag-based KASAN can be used for dogfood testing as it has a lower
+memory overhead that allows using it with real workloads. Hardware tag-based
+KASAN comes with low memory and performance overheads and, therefore, can be
+used in production. Either as an in-field memory bug detector or as a security
+mitigation.
+
+Software KASAN modes (#1 and #2) use compile-time instrumentation to insert
+validity checks before every memory access and, therefore, require a compiler
 version that supports that.
 
-Generic KASAN is supported in both GCC and Clang. With GCC it requires version
+Generic KASAN is supported in GCC and Clang. With GCC, it requires version
 8.3.0 or later. Any supported Clang version is compatible, but detection of
 out-of-bounds accesses for global variables is only supported since Clang 11.
 
-Tag-based KASAN is only supported in Clang.
+Software tag-based KASAN mode is only supported in Clang.
 
-Currently generic KASAN is supported for the x86_64, arm, arm64, xtensa, s390
+The hardware KASAN mode (#3) relies on hardware to perform the checks but
+still requires a compiler version that supports memory tagging instructions.
+This mode is supported in Clang 11+.
+
+Both software KASAN modes work with SLUB and SLAB memory allocators,
+while the hardware tag-based KASAN currently only supports SLUB.
+
+Currently, generic KASAN is supported for the x86_64, arm, arm64, xtensa, s390,
 and riscv architectures, and tag-based KASAN modes are supported only for arm64.
 
 Usage
@@ -39,9 +53,6 @@ For software modes, you also need to choose between CONFIG_KASAN_OUTLINE and
 CONFIG_KASAN_INLINE. Outline and inline are compiler instrumentation types.
 The former produces smaller binary while the latter is 1.1 - 2 times faster.
 
-Both software KASAN modes work with both SLUB and SLAB memory allocators,
-while the hardware tag-based KASAN currently only support SLUB.
-
 For better error reports that include stack traces, enable CONFIG_STACKTRACE.
 
 To augment reports with last allocation and freeing stack of the physical page,
-- 
2.31.0.rc2.261.g7f71774620-goog

