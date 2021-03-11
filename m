Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF18337FC3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 22:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhCKViR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 16:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhCKVhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:37:45 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D65FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:37:45 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id h30so10153442wrh.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jCUwUXSRYRP2LJ367pVG9mu783jEZOVPApZYYYorTcY=;
        b=Plz1xq3SLytyAFVQRIdDqpfeMoVJQVQnjL8v5eLWlHpRU3ZXHwZ7nNYQwGHB8jkEl0
         oec/CqXdexSMPCB/xEQc8lqn+4mP/LOkm0oqY//jnkP3wzYEtNThi7FOfPPphX4RmoFE
         ao0BmeAMJqqGLTJkM09Ht/ur6e2pTnhYW0cyFZmYZTeP54Hg1c8nULI2bpOngYV9skI4
         nlX9Ks5TI8iw8G6P5wTshuA2NBNFjML5xjZ2/0seUMwzVpI2lSb/a5NuFtLu1Z6COWrK
         /Zj1Uzg5xBCAF7rntkf4bj4+xzxSqLYPE/b+KjqGXV1+z3P9U99E669EFLETrkPaiJWQ
         MQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jCUwUXSRYRP2LJ367pVG9mu783jEZOVPApZYYYorTcY=;
        b=NfnNbEh2Qnzg2vZTe4LFyDNM7XwM2d1iYshhiiIQXPMOEDYJY6k/AlgVp7rMqNyMrD
         hCvwjBhxapTuXwUuterRdZ3zjnqdAQsDRjlRRAGtNmLD1a7m4DLEP7kJwOeL7NpH2u85
         a8wcVOwp2474Ad4WlzoHtd96eGGQr/CZJ+X7Wu4Xi2YfyvNm02/quPaxN+jJJT0C3iAD
         75M3QLr0kFJGCV0/ARP5bd22NHIF6UXfZR0ffd827ek+EtohITZn63gn8EcnZGezgBc7
         p0ibleDfXhYatXnmhsQxx1LIcSopxgtVulCigU+iJhyyBsTa27np6Zu/QL2673Og4GJR
         DhmQ==
X-Gm-Message-State: AOAM531gE3lQBeUeKuRpVCU6BgJFe7oOP7aJr+JpnLTsJS+8HZhk4dcX
        x+BcHniCKVQHudd+dVFuKJpa9hEp8ZTEgkcv
X-Google-Smtp-Source: ABdhPJy84LzHn4mR19rjSQ67/EMk7xl1CZfA7JzaPJm1mLIqYkbPLMRC4CDyeZ6DR1cH6gpwHsKjcZ2idgfZSv0y
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:95a:d8a8:4925:42be])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c0c4:: with SMTP id
 s4mr10327657wmh.9.1615498664022; Thu, 11 Mar 2021 13:37:44 -0800 (PST)
Date:   Thu, 11 Mar 2021 22:37:20 +0100
In-Reply-To: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
Message-Id: <318ca25e3e3d32482c0155b662ce4057e436f9cd.1615498565.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 08/11] kasan: docs: update HW_TAGS implementation details section
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

Update the "Implementation details" section for HW_TAGS KASAN:

- Punctuation, readability, and other minor clean-ups.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/dev-tools/kasan.rst | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index dff18e180120..f5c746a475c1 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -270,35 +270,35 @@ memory.
 Hardware tag-based KASAN
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
-Hardware tag-based KASAN is similar to the software mode in concept, but uses
+Hardware tag-based KASAN is similar to the software mode in concept but uses
 hardware memory tagging support instead of compiler instrumentation and
 shadow memory.
 
 Hardware tag-based KASAN is currently only implemented for arm64 architecture
 and based on both arm64 Memory Tagging Extension (MTE) introduced in ARMv8.5
-Instruction Set Architecture, and Top Byte Ignore (TBI).
+Instruction Set Architecture and Top Byte Ignore (TBI).
 
 Special arm64 instructions are used to assign memory tags for each allocation.
 Same tags are assigned to pointers to those allocations. On every memory
-access, hardware makes sure that tag of the memory that is being accessed is
-equal to tag of the pointer that is used to access this memory. In case of a
-tag mismatch a fault is generated and a report is printed.
+access, hardware makes sure that the tag of the memory that is being accessed is
+equal to the tag of the pointer that is used to access this memory. In case of a
+tag mismatch, a fault is generated, and a report is printed.
 
 Hardware tag-based KASAN uses 0xFF as a match-all pointer tag (accesses through
-pointers with 0xFF pointer tag aren't checked). The value 0xFE is currently
+pointers with the 0xFF pointer tag are not checked). The value 0xFE is currently
 reserved to tag freed memory regions.
 
-Hardware tag-based KASAN currently only supports tagging of
-kmem_cache_alloc/kmalloc and page_alloc memory.
+Hardware tag-based KASAN currently only supports tagging of slab and page_alloc
+memory.
 
-If the hardware doesn't support MTE (pre ARMv8.5), hardware tag-based KASAN
-won't be enabled. In this case all boot parameters are ignored.
+If the hardware does not support MTE (pre ARMv8.5), hardware tag-based KASAN
+will not be enabled. In this case, all KASAN boot parameters are ignored.
 
-Note, that enabling CONFIG_KASAN_HW_TAGS always results in in-kernel TBI being
-enabled. Even when kasan.mode=off is provided, or when the hardware doesn't
+Note that enabling CONFIG_KASAN_HW_TAGS always results in in-kernel TBI being
+enabled. Even when ``kasan.mode=off`` is provided or when the hardware does not
 support MTE (but supports TBI).
 
-Hardware tag-based KASAN only reports the first found bug. After that MTE tag
+Hardware tag-based KASAN only reports the first found bug. After that, MTE tag
 checking gets disabled.
 
 Shadow memory
-- 
2.31.0.rc2.261.g7f71774620-goog

