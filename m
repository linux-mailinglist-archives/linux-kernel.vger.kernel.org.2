Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6270338FF5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhCLOZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbhCLOY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:24:56 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FF5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:24:56 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id s10so11223380wre.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AADxbeoNuphnMvdgMWHUkUamhVrmAjoCfQWWs7Kvkug=;
        b=jCrEWQlY9zh5WxZDht/sPXYdkvCCWmhovQqVcz4wxPAIINp3noeg/Ihbr62XzpFxFx
         9TYtNPkjrHs7tvLdJ3y5I9Vrob6rePF0RDb9H9nE4TPYRuvSClb1iifQL88/87f7bIb5
         ggwioZgT6VUHk45puUhqCYPW4UDzSrQbxaj0YeCQUghMA9v4C0XLY76L1+lre1JkSqWF
         nB1rQ1XmQBC3/zjODsXnoVRLrXlsxQiNrqdUZ0hQu2bom5QIj76rhRFPTqzBNPbn/Kpa
         uzVxicMes2Yq9IIU0ovEugsTH2BRhouJbMjo7aw+hgmXAoxp+pEdOFd8RVeD3RLTJKyu
         pYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AADxbeoNuphnMvdgMWHUkUamhVrmAjoCfQWWs7Kvkug=;
        b=f7B0NcBnUGlNBxbO/c8QbHFDL5+RUhSZzCMM/M9Yb61MYazEKeJc0RCuz3NAQSXyQ0
         fxWqqRu919z3noJB+4c3NDFrfRYyjXctRkaUhfz3IGEvKUclxqtpCx5nFBolrs2wqrwy
         THAIEdsVpJQ/tRIBM67m5D/cETGjubxdlNMkPM5jUSmDw82creQUCL4jQXp2bBJLCjmj
         X7l6HRDSVwo113Zi5An5ES7oAZUmJ+AsCAIJIYxOVKRsFv2kWZkeADSUGNjCwjekrpLJ
         NXoFniR2hrNYWTaJ2gnyuXnlPZHm55VJ0xItlHruCeBuStTyydt2hKHnise4ptuR75M+
         bsuw==
X-Gm-Message-State: AOAM5318Dh+/w1QCogzFTfCvGx/QVdq9jE9Sa0HuiHSfE7tmnHJAb6cv
        djeD0yEMiYkEvL8lheOPVwz91PZ4kOcqcCYU
X-Google-Smtp-Source: ABdhPJyexprf1NyGf3J69SnjE5FHdNd0neUkuvSB9iYVeSIHY/h0QFTzjgPmZ58G1l053wwEm4PTcv2OZl8ePB9E
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:95a:d8a8:4925:42be])
 (user=andreyknvl job=sendgmr) by 2002:a5d:4688:: with SMTP id
 u8mr14154024wrq.39.1615559094829; Fri, 12 Mar 2021 06:24:54 -0800 (PST)
Date:   Fri, 12 Mar 2021 15:24:31 +0100
In-Reply-To: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
Message-Id: <ee2caf4c138cc1fd239822c2abefd5af6c057744.1615559068.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2 08/11] kasan: docs: update HW_TAGS implementation details section
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
index 5873d80cc1fd..2744ae6347c6 100644
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

