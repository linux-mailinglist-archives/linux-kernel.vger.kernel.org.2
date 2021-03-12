Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD7F338FF4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhCLOZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhCLOYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:24:53 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30736C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:24:53 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id e10so17574737qvr.17
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VB+ZOM8lapdi+RHL0OEgOVW/Ip9OH5XFkGtr1r4Q8HI=;
        b=uWDK3QcUxzcXn0PrMjJgoILZW+lLMhmo2tzHSZsYKl2ch8lC3FXnh/zZ351EHfhY1s
         P87pKmZ1eifIqPh7Vi7zhmDDqxk9gXvznG8RIWGenKV8k71VCASv3jQjfwfwksjODLpv
         5+vKtJOikS1lNVbKK3wAR4tu0Qg0pyjuR/FWVfTUAIi2TiTulnphGS4+vOVNaEKNWpbh
         Biocc2dbahtqtsgd5kADS2ZCApKGYUMoj5Q53ueOuyXTrlBcwuISU6Np4OlUq1ghLK06
         kru5vo0RbxesE3Riq6FEUaklKg/oUV0hb6PdggzkEZbO6+Am/TeaVY55Uu+LHD606kLl
         AiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VB+ZOM8lapdi+RHL0OEgOVW/Ip9OH5XFkGtr1r4Q8HI=;
        b=t1lyhiaD/anEbRigsapcaDVt4fNsbdzlOGy178GqaJpSIhD7k2GxsZzxRVKx/Bfbf2
         JwQMBndRu9bA4a8+BDmp//K4S3Xqp7OTqrKg+lSbbdmdjylcx9xCdiOUxHWzfmoywzxr
         SBtvvL1O1ScIGDpWFsCHQSmixCiq753vsZYcEOFwVhXwStcWz0y10UAHhKCcYnHH2aFA
         PL8UqZdm+wIjPzY+HCX5tjp4kpQf5ZtmhjA3wF+dvbEVgRx/dVvaLo4jvxXnWHXREBW8
         yb8KEyLv0IpcfKBMoftm70xvh6QAruW63BNq35+c+ScQ5ED25/RpEvXFlqxoPHPbgX5v
         GS8A==
X-Gm-Message-State: AOAM531CH1Wn6zGxAyPH7Im2Pm4/w/1/iTNd7mnkzOz29a1/w104an6M
        g47sixV/W4AxOoy0AvE+Jo6fN+re+QEvs+um
X-Google-Smtp-Source: ABdhPJyBtbAk8TcFiX/VIGUhKGiXocxsQgpKLyfaMJwJYGYH+w9IqoQu0ZX31MySwZtsbV34QLPP6DkszPW0GkxK
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:95a:d8a8:4925:42be])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:c8a:: with SMTP id
 r10mr12774809qvr.13.1615559092223; Fri, 12 Mar 2021 06:24:52 -0800 (PST)
Date:   Fri, 12 Mar 2021 15:24:30 +0100
In-Reply-To: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
Message-Id: <69b9b2e49d8cf789358fa24558be3fc0ce4ee32c.1615559068.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2 07/11] kasan: docs: update SW_TAGS implementation details section
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
index 986410bf269f..5873d80cc1fd 100644
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

