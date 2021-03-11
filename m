Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC93337FC5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 22:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhCKViU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 16:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhCKVht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:37:49 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71561C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:37:49 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id e17so4790347qkg.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=d9MD7r+sgefmh6olz506jW43mtPrrCIc3sAEHbrSzj8=;
        b=ax/rWBbWgfFBi82AU51k9wa1iavqd4Vuv9RUjEWuwWfeWHXtSnX5LFRCyJqlXJfA+W
         hm1ViC5eQNv6WM0R5WEHJWm1s+Ffj+2G2yuaPXOQny71MI+E7RKHxtVS3De7jyJgvPb1
         zBCFJM8tCCXPX/qoWnKZ6FsBO/dnl6Bhc4xLB6jKSvLRtzrTs4djQiwD/8TUzNKrG3j8
         gTgtdYh83bQOReTyQLwntQqCzVCikVRaETyy20dw1nOiXapJ5sD0BVRrRr1sCoM+5KVH
         A5y9ja1C+hbayglpaYIVouChO09VKiH6xoX3Anq/06nYhdxGkt+Xc1XAlrRDvWfHct3N
         P/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=d9MD7r+sgefmh6olz506jW43mtPrrCIc3sAEHbrSzj8=;
        b=Ep1CtDfjjp2xRVP4Jeq362KllzqMFK39/YuO7ugj4cZei5PgsSjh+0X6gcxe4Sdikm
         54R45QCRJ0h+rXxr+8cPA15LnFHG7BnEBp/nJPcLltrrh3GqXn1MDAM//N8AA71dc/Tm
         nzhHIGZI2q6jWryy74RDFODdo8DHuODFKKCWCZxr3/9sF/PvsAd1mXDYyu/FCCM2nnyb
         v/xz0s55zWTrwgII4i71fHQh0qxKXzfwpbfvosUZlFS0cxSq+GE3IgGJXxbIrHTZWYef
         vDupPcx8VazsU1zGc6JI1nEwWfKmNftAOKMUuGfsHSNMCFX5chUY2+N1DO9hSCvLTI3D
         jasw==
X-Gm-Message-State: AOAM533nH/8VeEgm4h+0KpK9xRhr8ggVNm8c5FC3nuzZcMWFvlEwf46a
        zyv6Le2yLCHFqcdTrzIwD022m6/bWMj1SUFy
X-Google-Smtp-Source: ABdhPJzpQZgOsi+fHQ89WFEZlxVp3IMtBdkjlpY0sJb25JmmNWaJDjP0pxKw0uMn7urnS6/1TroiVIGrltIjMgy0
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:95a:d8a8:4925:42be])
 (user=andreyknvl job=sendgmr) by 2002:a0c:9cc2:: with SMTP id
 j2mr6061470qvf.2.1615498668637; Thu, 11 Mar 2021 13:37:48 -0800 (PST)
Date:   Thu, 11 Mar 2021 22:37:22 +0100
In-Reply-To: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
Message-Id: <c0f6a95b0fa59ce0ef502f4ea11522141e3c8faf.1615498565.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 10/11] kasan: docs: update ignoring accesses section
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

Update the "Ignoring accesses" section in KASAN documentation:

- Mention kasan_disable/enable_current().
- Mention kasan_reset_tag()/page_kasan_tag_reset().
- A punctuation clean-up.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/dev-tools/kasan.rst | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 2b61d90e136f..6628b133c9ad 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -368,7 +368,7 @@ Ignoring accesses
 ~~~~~~~~~~~~~~~~~
 
 Software KASAN modes use compiler instrumentation to insert validity checks.
-Such instrumentation might be incompatible with some part of the kernel, and
+Such instrumentation might be incompatible with some parts of the kernel, and
 therefore needs to be disabled. To disable instrumentation for specific files
 or directories, add a line similar to the following to the respective kernel
 Makefile:
@@ -381,6 +381,19 @@ Makefile:
 
     KASAN_SANITIZE := n
 
+Other parts of the kernel might access metadata for allocated objects. Normally,
+KASAN detects and reports such accesses, but in certain cases (e.g., in memory
+allocators) these accesses are valid. Disabling instrumentation for memory
+allocators files helps with accesses that happen directly in that code for
+software KASAN modes. But it does not help when the accesses happen indirectly
+(through generic function calls) or with the hardware tag-based mode that does
+not use compiler instrumentation.
+
+To disable KASAN reports in a certain part of the kernel code:
+
+- For software modes, add a
+  ``kasan_disable_current()``/``kasan_enable_current()`` critical section.
+- For tag-based modes, use ``kasan_reset_tag()`` or ``page_kasan_tag_reset()``.
 
 Tests
 ~~~~~
-- 
2.31.0.rc2.261.g7f71774620-goog

