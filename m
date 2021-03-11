Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBC8337FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 22:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhCKVhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 16:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhCKVhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:37:34 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D046C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:37:33 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id 73so4568644wma.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DMCAKfggtb6XfOnfwXa7RpunfAY3u5vebHv4cftZQZg=;
        b=lAknWDT57GMBZODmPOA3/KuMa4ZkSrhXnTUgJ6a06+kB7RCuX7vEyP/HYTI2iFEHYr
         tRYwSAWB4gOUKYIkZjpFVMAxvyQHnGrFeRjhb2MUfkjqEoOoTTLxwgPOTVpqGk1L/5Wb
         Z+7W3Rg/ud0G75onwXNeU+rNZVbJh5RlKsUt/zwT16LQ8Vsek1D4dmkjrjZuUlL9lRPz
         kl9IYW3uS5g89A3Yjomce78lVVpH/iqzycard8tq6M45iR4xktsUyqy2UfGCLNETFG7U
         x1HeQsm29MO4UDAzqzb+RkgfN4C5w/00mhJXSZ26HFHLWwiN2cadZx02FIWTmOg8y9Ym
         A21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DMCAKfggtb6XfOnfwXa7RpunfAY3u5vebHv4cftZQZg=;
        b=J5EA7mmxGsg1Gz1FW+v0fhixbOyOPV7zTiP/IlKptLKTAtMPiOgGyUk3oPOYs97yTU
         gbbXDj5qHkQvUwaq0557FQEgGK1Yc2zwlCJGqE/E0o7Pd/bHe8kGjBxnZs8rJ9alTuwv
         S5HGWSKUoYFdbLMpsPAXf2BDHej3tzBYetmA4kvS5PMIqSGHyCqbfXe4F7NWhceIQgnb
         EcnT/fofmH6vxDZsiHE+lNJY/7taG/KDMYOA4d7Yu/NK9LGodFYJ9iqaQZqmfwzZpK4V
         nEAr8fDux6kbG0pXe5+UDksaAoXO8J3Zm5VY8bWwsUlYBjV0tKd1Gt1kE0igJt6lAhXk
         9puw==
X-Gm-Message-State: AOAM531CMCKgoxnVcycZ2n6BrF7C8DEFJbtN1KriVjo41aqELcVrs1vM
        1TUoIphpvEJfJlmZTA5caRyECK91IV9dDzwP
X-Google-Smtp-Source: ABdhPJyWd3HUCuSoQo0Mxee3WuZNPsz7ZPqsHHWGnOpmKuhO+0BOfpBqFvna4ZwLsNDHoBx5JOpGD8EZcQoaaFD9
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:95a:d8a8:4925:42be])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:35cd:: with SMTP id
 r13mr10155047wmq.186.1615498652153; Thu, 11 Mar 2021 13:37:32 -0800 (PST)
Date:   Thu, 11 Mar 2021 22:37:15 +0100
In-Reply-To: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
Message-Id: <ffe645426d4d9f6de97dcacebb2ff698cfa47a43.1615498565.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 03/11] kasan: docs: update usage section
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
index 343a683d0520..f21c0cbebcb3 100644
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

