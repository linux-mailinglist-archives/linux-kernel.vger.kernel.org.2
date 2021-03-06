Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1311632F711
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 01:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhCFAF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 19:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhCFAEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 19:04:54 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60805C061760
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 16:04:54 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id h30so1767421wrh.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 16:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=EHP7VMOyCMZT7G8oJ44o5p67301sGJyRfDw3NYRjics=;
        b=syUBlHO1kOWFJOodIyb4YI4jlXgoEwyj8rfVCJ66iyJRSRQan1JHjGV5TtfCIvDilv
         53aCs4VLDLghGgTGm1fWWVgudz4f58/2a2I409FcCZL1W2DlN5fL+0E9kz+ONZO3O2WX
         +JwMhkjc4whUPCGt8B2ntE5NLY/oiVaj2TslvXEwhDvJnPWJQYxXlegwU0+Vk6MlLgAl
         sioVT/9tShnXE+d/R11L0gthxG/OI+q9v98seYdn2W2D03Xwu03q0FYzhNwJPnEWZkjS
         mtlH6DOtJTVYt9LLNwj/LCNDgs621glZiXh/oldA95SAcV/IEDnfR/40AVbKJEGNbUtO
         y6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=EHP7VMOyCMZT7G8oJ44o5p67301sGJyRfDw3NYRjics=;
        b=J44gLUKlgz/Gz5w1cEGU/u7b1IziT3CKb3MNyldHSJ5Wktf6RX3oHl2GvF2UOnVe8l
         0Mg3PujhlZaTQnBBFtiAgRYTAqhsF1b7R3oV40NcFI2zcDtnlUer8gRkoocQLsMzUqBZ
         10clbwhGwQg6e57QOm+HasMkYkOBDdM/KJ33HoLJuSecgJxtorRGyg0sNW/0HduaZe8b
         jz0QBWC1no1gIEcOdiuGxpAg3WVw7MskVkXDou9KtfapsbMnlJYada2XZ5OnUi1fRJaK
         zWKttlMgUlHcz6YbTI0mRlAsQwQAIy0uqphWgppspTu72kImuEgwZRdGG3ul6u4MlHmX
         Zhzw==
X-Gm-Message-State: AOAM5335D49XehZSeLwo3tqfc5AW/KW4GzqXcwBReaeHIfOLeoiYhjhq
        W4BOhIxrMIBaL8vJpo+erFxaP4lCphPiggYm
X-Google-Smtp-Source: ABdhPJylKFVLWhT8oIe4NsKiK01/zxowgX06hrCCcstO7kGSRbQ/IustDFMRaegK6r+on3Lv24iapLiGLHiyX3Wi
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:953b:d7cf:2b01:f178])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:4292:: with SMTP id
 v18mr10970532wmc.23.1614989092621; Fri, 05 Mar 2021 16:04:52 -0800 (PST)
Date:   Sat,  6 Mar 2021 01:04:49 +0100
Message-Id: <803741293885a20aa5fddb28172ce0a378b7d793.1614989073.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3] kasan, mm: fix crash with HW_TAGS and DEBUG_PAGEALLOC
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kasan_free_nondeferred_pages()->kasan_free_pages() is called
after debug_pagealloc_unmap_pages(). This causes a crash when
debug_pagealloc is enabled, as HW_TAGS KASAN can't set tags on an
unmapped page.

This patch puts kasan_free_nondeferred_pages() before
debug_pagealloc_unmap_pages() and arch_free_page(), which can also make
the page unavailable.

Fixes: 94ab5b61ee16 ("kasan, arm64: enable CONFIG_KASAN_HW_TAGS")
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v2->v3:
- Rebase onto mainline.

---
 mm/page_alloc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3e4b29ee2b1e..c89ee1ba7034 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1281,6 +1281,12 @@ static __always_inline bool free_pages_prepare(struct page *page,
 
 	kernel_poison_pages(page, 1 << order);
 
+	/*
+	 * With hardware tag-based KASAN, memory tags must be set before the
+	 * page becomes unavailable via debug_pagealloc or arch_free_page.
+	 */
+	kasan_free_nondeferred_pages(page, order);
+
 	/*
 	 * arch_free_page() can make the page's contents inaccessible.  s390
 	 * does this.  So nothing which can access the page's contents should
@@ -1290,8 +1296,6 @@ static __always_inline bool free_pages_prepare(struct page *page,
 
 	debug_pagealloc_unmap_pages(page, 1 << order);
 
-	kasan_free_nondeferred_pages(page, order);
-
 	return true;
 }
 
-- 
2.30.1.766.gb4fecdf3b7-goog

