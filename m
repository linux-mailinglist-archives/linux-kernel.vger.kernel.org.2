Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DFC337FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 22:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhCKViT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 16:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhCKVhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:37:47 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C984C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:37:47 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id x11so13474478qki.22
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ftjCjXXHVhB6VMD5t3OFCFAtHdmXgYbSUPbbr/Gj6M0=;
        b=ESbdDH1dGDyJVOngrIaGau1OqUj/sBoi5iMhooMRu0pkICXzAdcFpDb2Ul/KLNFn99
         lZofYcZStifebLYgoQqfyIDIDZPygmK4tKz809cgrrLgeaEFORYIMtasnVGJEyJjHkEa
         E/K8ivFsvqiyEa4HwIB6Mh9BfTO+xCkQwFnZciD1y6y3RDdaejO3SsIpy7ww3zplxkd+
         4Wgy/It2jaGw6T7SoFg+2X2fAIar9JEXkV+lEzvZvRf/69TJ2BhSbH7NeIqQD0PmVu7j
         M7miv5kkKHtosvttGtJ9aFfUacFCA102qbBPhQO2Ciwz4rvUYeRTH2j682GaHq76n11H
         IwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ftjCjXXHVhB6VMD5t3OFCFAtHdmXgYbSUPbbr/Gj6M0=;
        b=nCoOKmOWyCChivf8DyhEd2gMem18zdEHKJV9u5hyJ35QrLNkH5fKG8UiLQHoNr+aOf
         1AmhDguetvZqV9jDggK+jsZbHRxj4U9pMZ6kkBg5lG5n48S1hZS/LLoyUgLddJlVxKSN
         bWbY56hn1aKMIc/2AqGvqGFB5d0VPXTJMQ0588LYLKGpNTc3xI+q2y5eggyntQXaJ6SQ
         HaOgPSa1zXdchmkSwDfdubW/jnXoMN64riq/1spxUyt+TdN0NfbvpLNxghfjddPa9UiD
         apAM0VNOTNgbfGyzIjZdOV0ZbTOPJZm0sGDxTf+Mg/QqG8aFohQzOIBoUZneAEfful2d
         vaaQ==
X-Gm-Message-State: AOAM531JUlidyVCgd8HQtRXhVKJ62Ztjq2WIAFqS9Ei0e8+bmpSiEobl
        cGuDDoh8gwLzrWcy11yqAX3yfygwMbyY2vsM
X-Google-Smtp-Source: ABdhPJwFsJ/N2kQI02XbYli6/SkAk6ET46Rz0VOBGBv3Tz8ry16DmHWricMbKll1+JUskKpcAbZIV5B73rdZviTd
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:95a:d8a8:4925:42be])
 (user=andreyknvl job=sendgmr) by 2002:a0c:f541:: with SMTP id
 p1mr9682518qvm.14.1615498666324; Thu, 11 Mar 2021 13:37:46 -0800 (PST)
Date:   Thu, 11 Mar 2021 22:37:21 +0100
In-Reply-To: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
Message-Id: <6cb4988a241f086be7e7df3eea79416a53377ade.1615498565.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 09/11] kasan: docs: update shadow memory section
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

Update the "Shadow memory" section in KASAN documentation:

- Rearrange the introduction paragraph do it doesn't give a
  "KASAN has an issue" impression.
- Update the list of architectures with vmalloc support.
- Punctuation, readability, and other minor clean-ups.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/dev-tools/kasan.rst | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index f5c746a475c1..2b61d90e136f 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -304,14 +304,11 @@ checking gets disabled.
 Shadow memory
 -------------
 
-The kernel maps memory in a number of different parts of the address
-space. This poses something of a problem for KASAN, which requires
-that all addresses accessed by instrumented code have a valid shadow
-region.
-
-The range of kernel virtual addresses is large: there is not enough
-real memory to support a real shadow region for every address that
-could be accessed by the kernel.
+The kernel maps memory in several different parts of the address space.
+The range of kernel virtual addresses is large: there is not enough real
+memory to support a real shadow region for every address that could be
+accessed by the kernel. Therefore, KASAN only maps real shadow for certain
+parts of the address space.
 
 By default
 ~~~~~~~~~~
@@ -323,10 +320,9 @@ page is mapped over the shadow area. This read-only shadow page
 declares all memory accesses as permitted.
 
 This presents a problem for modules: they do not live in the linear
-mapping, but in a dedicated module space. By hooking in to the module
-allocator, KASAN can temporarily map real shadow memory to cover
-them. This allows detection of invalid accesses to module globals, for
-example.
+mapping but in a dedicated module space. By hooking into the module
+allocator, KASAN temporarily maps real shadow memory to cover them.
+This allows detection of invalid accesses to module globals, for example.
 
 This also creates an incompatibility with ``VMAP_STACK``: if the stack
 lives in vmalloc space, it will be shadowed by the read-only page, and
@@ -337,9 +333,10 @@ CONFIG_KASAN_VMALLOC
 ~~~~~~~~~~~~~~~~~~~~
 
 With ``CONFIG_KASAN_VMALLOC``, KASAN can cover vmalloc space at the
-cost of greater memory usage. Currently this is only supported on x86.
+cost of greater memory usage. Currently, this is supported on x86,
+riscv, s390, and powerpc.
 
-This works by hooking into vmalloc and vmap, and dynamically
+This works by hooking into vmalloc and vmap and dynamically
 allocating real shadow memory to back the mappings.
 
 Most mappings in vmalloc space are small, requiring less than a full
@@ -358,10 +355,10 @@ memory.
 
 To avoid the difficulties around swapping mappings around, KASAN expects
 that the part of the shadow region that covers the vmalloc space will
-not be covered by the early shadow page, but will be left
-unmapped. This will require changes in arch-specific code.
+not be covered by the early shadow page but will be left unmapped.
+This will require changes in arch-specific code.
 
-This allows ``VMAP_STACK`` support on x86, and can simplify support of
+This allows ``VMAP_STACK`` support on x86 and can simplify support of
 architectures that do not have a fixed module region.
 
 For developers
-- 
2.31.0.rc2.261.g7f71774620-goog

