Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B9543730A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 09:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhJVHsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 03:48:41 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:41730
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231872AbhJVHsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 03:48:39 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D95F940019
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 07:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634888781;
        bh=tMGBs3Q7Msg13w5KnwdFpAd5cjXtVbTIuZqu2bUUbL0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=UNImwhghIHXBY78zc7Bcbyp8owK2ZaTRwDqnfhLhsg2L6K3It41OznPQAy/bwr10O
         PK3byU/9JT1KoiG4NKzvc8SlPraX+xONbFyW8LZf8L/Hs3EogeFxVvD/sPngamL9Hd
         oafMXnzE07V2jAxK+LB7z3889IGfFAPCGBnoR4XzJP9zb+4+QcCxiI26+QjASrPy7w
         lmTE4TXmgQqIhh4SFPMdgtmbdhFRpWYY6qOoEkgL5nWaWgUwI7wxPBL98IFSFZvKh3
         9Uo6LTD7QNHYrTsez/H36GhqqpTPovsdjAkb8IFzLgNCl4zVHhIM4iugjGgOoVPWoT
         Nh105SLzPmlRQ==
Received: by mail-ed1-f71.google.com with SMTP id d3-20020a056402516300b003db863a248eso2844411ede.16
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 00:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tMGBs3Q7Msg13w5KnwdFpAd5cjXtVbTIuZqu2bUUbL0=;
        b=QEzXK4kj0x1Ai+g1kvfwCtmPZqh0iOoG9vqLyO4ZdbgAsTv/ze47xZ6oCFOWvBu/Cf
         AK53ILXHFQfVC6PlbNtgQ5HqBQrvw2p8egl1H/brvSRj+Dm/jhbq33yVoWHLh4Zbm1mR
         O9XrGC7VQrxBU087uaFw32tOOALSbG7tpbgn+lp8NdRG73mvxObTxdacp1dgNOPu8w+f
         tS6PSx32cIdXRufLo3V8oNHH7Q1S1QMhx0F36BwsBOIvC6owGw7s2h/Y6evCwoKl2vXs
         TMC1AoNDakapsfwTdi3l/ll33Wbm45IFj+dAeseYNmas9l+J+THHZTUfVbL+W8CWuR9Q
         RM7Q==
X-Gm-Message-State: AOAM533EgUr8hp7kvwdZvd63z6wq1ZzgW5KAdZUjvKcnG9us8AGItZHU
        bh20KH72Z98D/utvGb4khgCerz0NZw/YSvT2OtTbfF5c+Be4xXe1QdugAl0kDCemXINflMs4lZu
        D2AaczX34639a16NaCGeOF8pS5kFhfsmh4AgGSJQfQg==
X-Received: by 2002:a05:6402:1cc1:: with SMTP id ds1mr15201639edb.386.1634888781590;
        Fri, 22 Oct 2021 00:46:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsMGdyxEI18ry4mlV7UKPzT2Qwm7WaiAz+upO29NRGJNXeAJ59goeQTmP+3dA193OgV29ZPg==
X-Received: by 2002:a05:6402:1cc1:: with SMTP id ds1mr15201625edb.386.1634888781402;
        Fri, 22 Oct 2021 00:46:21 -0700 (PDT)
Received: from arighi-desktop.homenet.telecomitalia.it ([2001:67c:1560:8007::aac:c1b6])
        by smtp.gmail.com with ESMTPSA id i15sm4099112edk.2.2021.10.22.00.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 00:46:21 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm: fix sleeping copy_huge_page called from atomic context
Date:   Fri, 22 Oct 2021 09:46:19 +0200
Message-Id: <20211022074619.57355-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

copy_huge_page() can be called with mapping->private_lock held from
__buffer_migrate_page() -> migrate_page_copy(), so it is not safe to
do a cond_resched() in this context.

Introduce migrate_page_copy_nowait() and copy_huge_page_nowait()
variants that can be used from an atomic context.

The downside of this change is that we may experience temporary soft
lockups when copying large huge pages in very slow systems, but this
allows to prevent potential deadlocks.

Link: https://syzkaller.appspot.com/bug?id=683b472eb7539d56da69de85f4bfb4b9af67f7ec
Fixes: 79789db03fdd ("mm: Make copy_huge_page() always available")
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 include/linux/migrate.h | 10 +++++++++-
 include/linux/mm.h      | 10 +++++++++-
 mm/migrate.c            |  8 ++++----
 mm/util.c               |  5 +++--
 4 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index c8077e936691..3dc6dab9a3f7 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -52,7 +52,15 @@ extern struct page *alloc_migration_target(struct page *page, unsigned long priv
 extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
 
 extern void migrate_page_states(struct page *newpage, struct page *page);
-extern void migrate_page_copy(struct page *newpage, struct page *page);
+extern void __migrate_page_copy(struct page *newpage, struct page *page, bool atomic);
+static inline void migrate_page_copy(struct page *newpage, struct page *page)
+{
+	return __migrate_page_copy(newpage, page, false);
+}
+static inline void migrate_page_copy_nowait(struct page *newpage, struct page *page)
+{
+	return __migrate_page_copy(newpage, page, true);
+}
 extern int migrate_huge_page_move_mapping(struct address_space *mapping,
 				  struct page *newpage, struct page *page);
 extern int migrate_page_move_mapping(struct address_space *mapping,
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 73a52aba448f..1c96bb084366 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -907,7 +907,15 @@ void __put_page(struct page *page);
 void put_pages_list(struct list_head *pages);
 
 void split_page(struct page *page, unsigned int order);
-void copy_huge_page(struct page *dst, struct page *src);
+void __copy_huge_page(struct page *dst, struct page *src, bool atomic);
+static inline void copy_huge_page(struct page *dst, struct page *src)
+{
+	__copy_huge_page(dst, src, false);
+}
+static inline void copy_huge_page_nowait(struct page *dst, struct page *src)
+{
+	__copy_huge_page(dst, src, true);
+}
 
 /*
  * Compound pages have a destructor function.  Provide a
diff --git a/mm/migrate.c b/mm/migrate.c
index 1852d787e6ab..d8bc0586d157 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -613,16 +613,16 @@ void migrate_page_states(struct page *newpage, struct page *page)
 }
 EXPORT_SYMBOL(migrate_page_states);
 
-void migrate_page_copy(struct page *newpage, struct page *page)
+void __migrate_page_copy(struct page *newpage, struct page *page, bool atomic)
 {
 	if (PageHuge(page) || PageTransHuge(page))
-		copy_huge_page(newpage, page);
+		__copy_huge_page(newpage, page, atomic);
 	else
 		copy_highpage(newpage, page);
 
 	migrate_page_states(newpage, page);
 }
-EXPORT_SYMBOL(migrate_page_copy);
+EXPORT_SYMBOL(__migrate_page_copy);
 
 /************************************************************
  *                    Migration functions
@@ -755,7 +755,7 @@ static int __buffer_migrate_page(struct address_space *mapping,
 	} while (bh != head);
 
 	if (mode != MIGRATE_SYNC_NO_COPY)
-		migrate_page_copy(newpage, page);
+		migrate_page_copy_nowait(newpage, page);
 	else
 		migrate_page_states(newpage, page);
 
diff --git a/mm/util.c b/mm/util.c
index bacabe446906..f84e65643d1d 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -750,12 +750,13 @@ int __page_mapcount(struct page *page)
 }
 EXPORT_SYMBOL_GPL(__page_mapcount);
 
-void copy_huge_page(struct page *dst, struct page *src)
+void __copy_huge_page(struct page *dst, struct page *src, bool atomic)
 {
 	unsigned i, nr = compound_nr(src);
 
 	for (i = 0; i < nr; i++) {
-		cond_resched();
+		if (!atomic)
+			cond_resched();
 		copy_highpage(nth_page(dst, i), nth_page(src, i));
 	}
 }
-- 
2.32.0

