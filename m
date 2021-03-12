Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C035338FF6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhCLOZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhCLOY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:24:59 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9115C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:24:58 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id y5so11222425wrp.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hsoBR6E8KwmiptK80mQJVFHGCa6Vkbo97hvfJKQe5xQ=;
        b=nXr9UV9/9WyaC3EuPXvNItYFgOiSTCllvCD62KSIp5FuIWKW2sehJhoVxOzJHwG0nM
         HBvRceqCBfxy5QZQ8RhSJZStHtOCO5xFbRirjQD5la/YLw9YNoyHYoX/5RHAcnnB05i8
         hwoJG4k8syFN3DX6r9GGeUdwDKgBTVIjZFQfXSdsmKouxKEm2gt3/p1VDjKC2n5/PaKi
         peeT2zCt8NU8nDHv/SQm83n2z0M7vI7igfgOfh3DP0nSJbcsjocnofOhglvTKhu/puwI
         e2SS3RL7DKdVfWtlWlRLg3SXrDzNN2sLem82/rAYCCNcIAJjbtLJr6Hp6OWM0to4U5E9
         Y5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hsoBR6E8KwmiptK80mQJVFHGCa6Vkbo97hvfJKQe5xQ=;
        b=QW+vmF6LJbiB2Kcv0/lw/D8pULs/I4ayA4CVxckb8olph20P7f3Z5z+vElCVrrXEXR
         CP1jgvpeenbxHU0T46ZrsQ8p2y+cRUBXLUyPgl8JE/CKv9qTN4QD6WLdzMN+2nM5+WAe
         P8neTyJao3kB+1yTxkpneFVbwvcA5OoD8vC21RbIq+3+j0G+QRD1G3LJpkycPsFF9TrG
         B5Nq6AgSpx74hVZ0cfB6EaBs2bCs3BrIPgOAV0zMV2gcx4FUvPdP3/DRAhU6Quc9O9yV
         +xK9mWuF6c8IY5/DpcgYdElsmsqN+G/CtkjYikOA75hD9oLQUG2aMkBhwwtY2CD86qOr
         blDQ==
X-Gm-Message-State: AOAM531Ku6cgi544aHNNK5Gc1QCq/4fW1oFAlwrJ37A31gSDki1FioxS
        W4ul3bVbIUIvg5R7FOeCYGDz99yF/pjT/uUY
X-Google-Smtp-Source: ABdhPJyEhPq1Wz4x+ftqnbQ2CgJ1RQOONDh7PhI/3hzsY1YVuFsBuC/M2n6BPRMzRPBwd+DmE1BUthENEHm+4VyD
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:95a:d8a8:4925:42be])
 (user=andreyknvl job=sendgmr) by 2002:a1c:6243:: with SMTP id
 w64mr2250680wmb.0.1615559097271; Fri, 12 Mar 2021 06:24:57 -0800 (PST)
Date:   Fri, 12 Mar 2021 15:24:32 +0100
In-Reply-To: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
Message-Id: <00f8c38b0fd5290a3f4dced04eaba41383e67e14.1615559068.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2 09/11] kasan: docs: update shadow memory section
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
index 2744ae6347c6..d0c1796122df 100644
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
 
 Default behaviour
 ~~~~~~~~~~~~~~~~~
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

