Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D05E338FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhCLOY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbhCLOYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:24:43 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7942EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:24:43 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id u5so18214816qkj.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UIn9R6iWNTpuninm8yzAqfvqLsQ1Z3TszvORzjzD33U=;
        b=BfEhzme8NfucFms3TKi7BojlgEWJYM76BAeBCWDV2onmk63nYw8AWfe/XU1X7ifiQ7
         5uRMoXe9Ikc/W7RI035b0qscpd8roWNpxeMSEllp4YO1FTC2sFGr0BNbtY3+TufVBmt/
         URK7CrQbV13rwXPEi+EwDf+xXnFlQJ0hVrt51LE+sMH9dZK/nUoXS+mbn2uf68Km+Yoo
         HU/UnO6E+lqMkw2TTcN1WKvT7fpLpVUGpg+S1m6SkcMuU3agedBTSxKNxBQIWlL4VTBi
         m8230PNbLFrfbIk4DV3yRw4fPuYGAAuXZbdB09lBg8+JNxKYV75kfWkwLZyOu24KMBIj
         n+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UIn9R6iWNTpuninm8yzAqfvqLsQ1Z3TszvORzjzD33U=;
        b=qGrY36oN+uRyor3FBsqB3rioYYt5d/bMPVVmJTzP03X0v6gD0Px6+WswVuNF+mVh6H
         g40sI4KGE3Zebrjof8+tzYvtLZ65lsLaiW7lYd2l9v/ohPpd4ENOgb9Qsc4qn6+ACk/Y
         63glS4nqWawFzS9bLRxroL4XNOW50yfVxlHj72uAK4/+wJXiLEvKuA6mGrefJJL8COQk
         isVB0m8M34QcjCCe0APQrh0BgEFbSXumFZ4ARXaOPd9ZRnoBeFEgOMxruCYZQ+jHUylB
         uV799Y/+5O2jtTeJfbj3M9r74iFHrrvfNTSrDJyvSE2DcAaHJQ9teRVARvEwDeZuSVyP
         gQ2A==
X-Gm-Message-State: AOAM532cp2e8JIuilS2k/ib9mrwXKq8DKyW4NlelhzKwe1SkDYb9qdGo
        jyekkrKRzwbRE2RXeesRfoxq/rptvKOy9yAR
X-Google-Smtp-Source: ABdhPJxhhQrSrGA1QsOqnoYKLh4lvDwtbCsjqjKI4lZ1uccEccLCH1TKhzag8wYYWyL8wB6MDNjfjq9i8g2TZq7N
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:95a:d8a8:4925:42be])
 (user=andreyknvl job=sendgmr) by 2002:a0c:aa45:: with SMTP id
 e5mr1897790qvb.44.1615559082706; Fri, 12 Mar 2021 06:24:42 -0800 (PST)
Date:   Fri, 12 Mar 2021 15:24:26 +0100
In-Reply-To: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
Message-Id: <48427809cd4b8b5d6bc00926cbe87e2b5081df17.1615559068.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2 03/11] kasan: docs: update usage section
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

Update the "Usage" section in KASAN documentation:

- Add inline code snippet markers.
- Reword the part about stack traces for clarity.
- Other minor clean-ups.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/dev-tools/kasan.rst | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 2f2697b290d5..46f4e9680805 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -41,22 +41,21 @@ and riscv architectures, and tag-based KASAN modes are supported only for arm64.
 Usage
 -----
 
-To enable KASAN configure kernel with::
+To enable KASAN, configure the kernel with::
 
-	  CONFIG_KASAN = y
+	  CONFIG_KASAN=y
 
-and choose between CONFIG_KASAN_GENERIC (to enable generic KASAN),
-CONFIG_KASAN_SW_TAGS (to enable software tag-based KASAN), and
-CONFIG_KASAN_HW_TAGS (to enable hardware tag-based KASAN).
+and choose between ``CONFIG_KASAN_GENERIC`` (to enable generic KASAN),
+``CONFIG_KASAN_SW_TAGS`` (to enable software tag-based KASAN), and
+``CONFIG_KASAN_HW_TAGS`` (to enable hardware tag-based KASAN).
 
-For software modes, you also need to choose between CONFIG_KASAN_OUTLINE and
-CONFIG_KASAN_INLINE. Outline and inline are compiler instrumentation types.
-The former produces smaller binary while the latter is 1.1 - 2 times faster.
+For software modes, also choose between ``CONFIG_KASAN_OUTLINE`` and
+``CONFIG_KASAN_INLINE``. Outline and inline are compiler instrumentation types.
+The former produces a smaller binary while the latter is 1.1-2 times faster.
 
-For better error reports that include stack traces, enable CONFIG_STACKTRACE.
-
-To augment reports with last allocation and freeing stack of the physical page,
-it is recommended to enable also CONFIG_PAGE_OWNER and boot with page_owner=on.
+To include alloc and free stack traces of affected slab objects into reports,
+enable ``CONFIG_STACKTRACE``. To include alloc and free stack traces of affected
+physical pages, enable ``CONFIG_PAGE_OWNER`` and boot with ``page_owner=on``.
 
 Error reports
 ~~~~~~~~~~~~~
-- 
2.31.0.rc2.261.g7f71774620-goog

