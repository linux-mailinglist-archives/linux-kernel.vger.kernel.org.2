Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18129337FC2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 22:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhCKViQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 16:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhCKVhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:37:43 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D9FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:37:43 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id g5so10083765wrd.22
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gThu0TE1qL9hnbQQaxSk/qxvpsDDtC1CzspsMmD08OE=;
        b=SwiE2He5npvJprt4/ga+llX7ojAaiSnGKufJo3KbwrKI0MdyKm/xmoaT5N75+/BdU9
         WC+y1cqw+sVbpHcx5n4ctV0zVSX/DIrtsaYoLK/pm2iQV5lB693Aar8uRhFpxZx++ik9
         S7aCiEApckhoJfIMNlPJHjiigMU46WdgOGiIV1p6qPCXW3IhaBGLhblGHqAdyKqxZxYQ
         aOJH1yCva5uRQHxKvUrRU2yBMEdW1LYdohvTOnq9dkdphiaIGN7RJjNkH0Vc7q4hposB
         +GXH4NSOCvv2pOX1uJGUVZR4gmWDyxxMYbd5ip6L0RcVRrWEwcdfG+Z4XsdOv9fBFg7n
         29BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gThu0TE1qL9hnbQQaxSk/qxvpsDDtC1CzspsMmD08OE=;
        b=C5d57c6d7iLeYi4QqcNcPpbrZvP3+R9YzJSlkuK0JGT/mH+L/PCy8RyOWzlQZBMopT
         nD6WZubX05Ofr+9/ilkDqUwou0yCZ1U+axaqMTuqOrNQNxXdYTaLXuOJ3s591jKIVJpT
         Z1VvzLaBiVxG+CyS7sAJwh04kwE8O9qp2PRuJ9BUC4q43zoT5Ha1chYNjb+gc9PI+lUg
         egvjc3SgBXzqU1kl+IwvizTQEoela1u5+ERlDUuQsZitID85eFApN6uiIpNLOZ5CgNFa
         1zCFzyPfLoie2GJyolfd5R+UNJwr14SYtQCdrL6MQPy0oU9WzcRuSder+b2ofhxpRTd8
         NyOA==
X-Gm-Message-State: AOAM531lf6p8JKLsfT+VXmvyq1ScB7aJyxkZmB0mJm8yiuQglBrHs8gY
        DDTF6WCu1ke+Fl/Ghukynmcmx62Ba9yKeP9f
X-Google-Smtp-Source: ABdhPJzT6Acki3u676PB0Tv/dBARyH8t1RaPBLvxeQVuHtvcC5rv/V0863W+inBzbIKsqJ8x8rC70h3o60/IqeXf
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:95a:d8a8:4925:42be])
 (user=andreyknvl job=sendgmr) by 2002:a1c:f614:: with SMTP id
 w20mr9884303wmc.70.1615498661923; Thu, 11 Mar 2021 13:37:41 -0800 (PST)
Date:   Thu, 11 Mar 2021 22:37:19 +0100
In-Reply-To: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
Message-Id: <3ec89a4e0783ff3d345310343d7ef10d46c8adb2.1615498565.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 07/11] kasan: docs: update SW_TAGS implementation details section
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

Update the "Implementation details" section for SW_TAGS KASAN:

- Clarify the introduction sentence.
- Punctuation, readability, and other minor clean-ups.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/dev-tools/kasan.rst | 39 +++++++++++++++----------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 1fb4b715a3ce..dff18e180120 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -235,38 +235,37 @@ quarantine (see mm/kasan/quarantine.c for implementation).
 Software tag-based KASAN
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
-Software tag-based KASAN requires software memory tagging support in the form
-of HWASan-like compiler instrumentation (see HWASan documentation for details).
-
-Software tag-based KASAN is currently only implemented for arm64 architecture.
+Software tag-based KASAN uses a software memory tagging approach to checking
+access validity. It is currently only implemented for the arm64 architecture.
 
 Software tag-based KASAN uses the Top Byte Ignore (TBI) feature of arm64 CPUs
-to store a pointer tag in the top byte of kernel pointers. Like generic KASAN
-it uses shadow memory to store memory tags associated with each 16-byte memory
-cell (therefore it dedicates 1/16th of the kernel memory for shadow memory).
+to store a pointer tag in the top byte of kernel pointers. It uses shadow memory
+to store memory tags associated with each 16-byte memory cell (therefore, it
+dedicates 1/16th of the kernel memory for shadow memory).
 
-On each memory allocation software tag-based KASAN generates a random tag, tags
-the allocated memory with this tag, and embeds this tag into the returned
+On each memory allocation, software tag-based KASAN generates a random tag, tags
+the allocated memory with this tag, and embeds the same tag into the returned
 pointer.
 
 Software tag-based KASAN uses compile-time instrumentation to insert checks
-before each memory access. These checks make sure that tag of the memory that
-is being accessed is equal to tag of the pointer that is used to access this
-memory. In case of a tag mismatch software tag-based KASAN prints a bug report.
+before each memory access. These checks make sure that the tag of the memory
+that is being accessed is equal to the tag of the pointer that is used to access
+this memory. In case of a tag mismatch, software tag-based KASAN prints a bug
+report.
 
-Software tag-based KASAN also has two instrumentation modes (outline, that
-emits callbacks to check memory accesses; and inline, that performs the shadow
+Software tag-based KASAN also has two instrumentation modes (outline, which
+emits callbacks to check memory accesses; and inline, which performs the shadow
 memory checks inline). With outline instrumentation mode, a bug report is
-simply printed from the function that performs the access check. With inline
-instrumentation a brk instruction is emitted by the compiler, and a dedicated
-brk handler is used to print bug reports.
+printed from the function that performs the access check. With inline
+instrumentation, a ``brk`` instruction is emitted by the compiler, and a
+dedicated ``brk`` handler is used to print bug reports.
 
 Software tag-based KASAN uses 0xFF as a match-all pointer tag (accesses through
-pointers with 0xFF pointer tag aren't checked). The value 0xFE is currently
+pointers with the 0xFF pointer tag are not checked). The value 0xFE is currently
 reserved to tag freed memory regions.
 
-Software tag-based KASAN currently only supports tagging of
-kmem_cache_alloc/kmalloc and page_alloc memory.
+Software tag-based KASAN currently only supports tagging of slab and page_alloc
+memory.
 
 Hardware tag-based KASAN
 ~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.31.0.rc2.261.g7f71774620-goog

