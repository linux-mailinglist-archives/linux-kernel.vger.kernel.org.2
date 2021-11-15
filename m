Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF0844FCDE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 03:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbhKOCMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 21:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236259AbhKOCMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 21:12:12 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AB6C0613B9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 18:09:16 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u17so13108957plg.9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 18:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B9nY7cWKAIhZGQnOhoXi5S1L7WhmbmRLPB1yc4lvRQA=;
        b=Pyvh5FPNF3sjKEXjyhnlXyoBDFGRCx7Tu4hzLTI+I5pPFA9W7Tl0zMbYSav03oIYz/
         26OtdtCvyeML/LRj4LACoOAt6LNUlqDhym1DFcZStqiaZ8G+yodZ0I+8HgitKBFxJhWt
         x+gt13EZX+x0nrYE3gatvMYgxY9+R4hsUxrUFiPK7d5v9VUYXDpa3wLunf3QQdWZppD5
         LcDdD5Ko+STHIMMN02IrPsLlaQclOWV6qXyqudNgcfqH5UD5GpsLzUBvk65UkJ9oC1Lw
         qzuKVBEjHWvI1KtfDShTaIRHN3NpICSwnoUDMuKYl5sCkaQ+ChIwBART4awIxBSUjn3S
         3WHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B9nY7cWKAIhZGQnOhoXi5S1L7WhmbmRLPB1yc4lvRQA=;
        b=nG/beummtvROL0hZI1lp8X7SSm9WJ/I8r484wfkt6bpPeRXSAwgkG64rO1Bs2qMj/e
         Thzr45WvuwIsgTxLWg21mJry2ljlPfJlr1j21qW0EJf7NzKniNk5CcosT70T45rbWuvB
         0IOKNVuBcRvLgLHVmltwT9tTEf92c0HhYkNZQSi4djCIc75ykgveJJkfhEIXj8qFvdXt
         6utW5eZDdbwW4EyPJJ8SD0Jt0nn0X4PlXs7bA9gnwlqdWJRoTjtHW1owUhWgDDE0zpML
         ytpHUB0WyV7MUXOzBSWG1cjkUQDYUIaFFRazYqnRKqvxln2e3GsWxgrKI5GySb0OHA61
         u80A==
X-Gm-Message-State: AOAM5324Jn2IJs+13ivehmMGx+gvb6XaZzRZPzgAAzVXAy3s6qLqkP/W
        3tsqoFwwXa+6axRWJIxqX5vcX1Ucp6nK0w==
X-Google-Smtp-Source: ABdhPJzf56Xg78TaAdHf7Q5OuVI0h1WZDh06v4x4iik2haMhze2vUBe/zyJC9+RukAVSuMlyTv96xw==
X-Received: by 2002:a17:90b:1b4b:: with SMTP id nv11mr60425618pjb.131.1636942155385;
        Sun, 14 Nov 2021 18:09:15 -0800 (PST)
Received: from nuc10.amust.local (d50-92-229-34.bchsia.telus.net. [50.92.229.34])
        by smtp.gmail.com with ESMTPSA id mv22sm10501306pjb.36.2021.11.14.18.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 18:09:15 -0800 (PST)
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, catalin.marinas@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        gregkh@linuxfoundation.org, Rustam Kovhaev <rkovhaev@gmail.com>
Subject: [PATCH] mm: kmemleak: slob: respect SLAB_NOLEAKTRACE flag
Date:   Sun, 14 Nov 2021 18:08:50 -0800
Message-Id: <20211115020850.3154366-1-rkovhaev@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kmemleak is enabled for SLOB, system does not boot and does not
print anything to the console. At the very early stage in the boot
process we hit infinite recursion from kmemleak_init() and eventually
kernel crashes.
kmemleak_init() specifies SLAB_NOLEAKTRACE for KMEM_CACHE(), but
kmem_cache_create_usercopy() removes it because CACHE_CREATE_MASK is not
valid for SLOB.
Let's fix CACHE_CREATE_MASK and make kmemleak work with SLOB

Fixes: d8843922fba4 ("slab: Ignore internal flags in cache creation")
Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
---
 mm/slab.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab.h b/mm/slab.h
index 58c01a34e5b8..56ad7eea3ddf 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -147,7 +147,7 @@ static inline slab_flags_t kmem_cache_flags(unsigned int object_size,
 #define SLAB_CACHE_FLAGS (SLAB_NOLEAKTRACE | SLAB_RECLAIM_ACCOUNT | \
 			  SLAB_TEMPORARY | SLAB_ACCOUNT)
 #else
-#define SLAB_CACHE_FLAGS (0)
+#define SLAB_CACHE_FLAGS (SLAB_NOLEAKTRACE)
 #endif
 
 /* Common flags available with current configuration */
-- 
2.30.2

