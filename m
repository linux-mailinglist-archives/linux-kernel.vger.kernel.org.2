Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD7A3F0428
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbhHRNDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbhHRNDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:03:42 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596BEC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 06:03:07 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id 5-20020a1c00050000b02902e67111d9f0so619417wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 06:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RrG3CyO9Gjt37gk9O8igCLRvqsHUd/YOk6xR8PM41xQ=;
        b=mUuxo16hVJ+iZgyLxC/SaVrM1114EX1QQ8bF2KypKKGX1JQEyAfvoujkSpT0sGjXTh
         MmG7VHJVTVnSrFHhgY0E8Xr0I7tz+ZAMbyqFV312p3CuLzmNv/iH1Rjv/ge2Oe426hqh
         pup5K/Ou0j9iqKQLgX+OxbxI8iAoZyYbSleEejVKg5aDm+a0zwEyEkD6QzV7IEUCMxs8
         jaydHwdr9D2u1R3P9aAmXFZ/SavvdP9B7wfMP3mRTX1DjzGLo5XGcaZD6GGDueu7ehZe
         nqpdtyOxPLHHmPgYQUVC1EMuERPjPRKxHlidRCzvKDJKXzywaY5qkAhb2zSu0pifJh3g
         1C8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RrG3CyO9Gjt37gk9O8igCLRvqsHUd/YOk6xR8PM41xQ=;
        b=O5otmZm/BjrawoFjCObWHhMSxsjp1adpz9sDhXbiBPI5LGJEvENlKcOn6K+mAlkkxt
         aQgXIYpoS/PXxcvE/LvGJivMdI36iloHjw4YD9myjCMXcmKD2PxeqBA4ZILYldj4DJMM
         VGGk6gz7ehs8aP4XiGlrM4sYgj/8gTzl9cc+0Zfrf2aVt5UMwFP8b1fMs4G81Uyu1Fny
         R+KBBP7VgwQF+wsAesD0weqZW5yUk/w9GpdeuEHgVbNgVuFkwJSKqQEJpM7t07t+J99A
         OtlViI8NSIVOjjHp3+XoL4GHSBpQuQpAfIbO70ufRiN5ugl1n9E0gdOCR5L8mwSQfgOS
         UnSQ==
X-Gm-Message-State: AOAM531aTpEon2peTL+E8eY0ZS81RKIAlt0vA3EWnQo5+e9NfTWINbXD
        WLVy9FygLNcjBvXwVRilZ8iYzzen7Q==
X-Google-Smtp-Source: ABdhPJzbSbjgQk5lmEa3hM+PK3vcJ+Jbea7iM+3mGTQTNzNWuNnofg3TzKJCoftHPaHYa4/ctrMFY6/l4Q==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:52dc:2f6d:34df:96a5])
 (user=elver job=sendgmr) by 2002:a05:600c:35d3:: with SMTP id
 r19mr574288wmq.1.1629291785265; Wed, 18 Aug 2021 06:03:05 -0700 (PDT)
Date:   Wed, 18 Aug 2021 15:03:00 +0200
Message-Id: <20210818130300.2482437-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH] kfence: fix is_kfence_address() for addresses below KFENCE_POOL_SIZE
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally the addr != NULL check was meant to take care of the case
where __kfence_pool == NULL (KFENCE is disabled). However, this does not
work for addresses where addr > 0 && addr < KFENCE_POOL_SIZE.

This can be the case on NULL-deref where addr > 0 && addr < PAGE_SIZE or
any other faulting access with addr < KFENCE_POOL_SIZE. While the kernel
would likely crash, the stack traces and report might be confusing due
to double faults upon KFENCE's attempt to unprotect such an address.

Fix it by just checking that __kfence_pool != NULL instead.

Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
Reported-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Signed-off-by: Marco Elver <elver@google.com>
Cc: <stable@vger.kernel.org>    [5.12+]
---
 include/linux/kfence.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/kfence.h b/include/linux/kfence.h
index a70d1ea03532..3fe6dd8a18c1 100644
--- a/include/linux/kfence.h
+++ b/include/linux/kfence.h
@@ -51,10 +51,11 @@ extern atomic_t kfence_allocation_gate;
 static __always_inline bool is_kfence_address(const void *addr)
 {
 	/*
-	 * The non-NULL check is required in case the __kfence_pool pointer was
-	 * never initialized; keep it in the slow-path after the range-check.
+	 * The __kfence_pool != NULL check is required to deal with the case
+	 * where __kfence_pool == NULL && addr < KFENCE_POOL_SIZE. Keep it in
+	 * the slow-path after the range-check!
 	 */
-	return unlikely((unsigned long)((char *)addr - __kfence_pool) < KFENCE_POOL_SIZE && addr);
+	return unlikely((unsigned long)((char *)addr - __kfence_pool) < KFENCE_POOL_SIZE && __kfence_pool);
 }
 
 /**
-- 
2.33.0.rc1.237.g0d66db33f3-goog

