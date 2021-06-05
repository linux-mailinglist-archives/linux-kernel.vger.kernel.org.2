Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8119439C4B8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 03:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhFEBJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 21:09:31 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:36396 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhFEBJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 21:09:29 -0400
Received: by mail-qk1-f201.google.com with SMTP id k125-20020a3788830000b02903a65618d46cso7716361qkd.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 18:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=Fa0p5kaxCg9ESS+YbH/RbZiup0gha0dysH3j0Zhy1+U=;
        b=TzMnsIeD/funOD+ByHCZiSMl5ZeNWCfLkbqjRlNbd6w6sxMN5KX2AkgK5t/RS+ESEt
         EhyPXJkAQ0Xz06gvwKq1lRb7do3OCOplUgAeb08l/ec74HprXY3/hCGCvtStY73+7drA
         7JjcWI2c+nENkux7kJr+WAl0xjomMwcB813RWOYqzhLpwdGsim0b9zgwvZYHUFDfL4hq
         chwwjSX0ZWJ6dMwBX5fHaiFOW6gTPR81MqY86ir4174QMb6aYLxYpoNTJHVrLGBMVxrz
         Exl9Np4r6qYyEWyBmUO93d5dInjsdm7rUsXE5+dmgRrsXZWDKAVprnj0K0JkV6scOvRW
         ahnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=Fa0p5kaxCg9ESS+YbH/RbZiup0gha0dysH3j0Zhy1+U=;
        b=ru/XHYUWZ00amhtiq8VM6xOwvmm1OAWOORWw4smxXX9EvYY7dwXbDKq6/u2szefDL3
         poW6WTWRrFhTNTQgYJQNmixCVochqqp7YcSva9sH4h9dUjr6GR5fgY9BuZn91G3uGoTh
         sZEzWy7Ucvbj8HU5Xl8HLeiTXWm5gLa3XdcvXh+KlLpv+0GEfZTBG60lrmQSLx2IGnfs
         Uj61fb1z76W/B1ka/b+VTJG8wUkvSxKpOnrprZT8FhbQpqEILhrVsZldaDalZK+5mW/V
         2oKN2oia+MEE6tbQRIXB207g/el5uHdL74RvEfLgKXRKOWEQEvG64BGedYSxUYsuX5ZS
         kqzw==
X-Gm-Message-State: AOAM532m6lZCqep965ilkYWwLvYL7bUvuv7U5FzaYzT3LPORhKkSGUup
        Cr1k3VTizhdgLMp0TTfdia/39PmoCFIuGneTPQ==
X-Google-Smtp-Source: ABdhPJz228fTUBbe5ZDRR6Veq2+4ZrCZpbbLd3fuEIYo9zK1E4n/k0W+KuCqxm/+k81Owl0e1bweqFiw+6M9D8SMMA==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:f57f:1ac2:dde3:a713])
 (user=almasrymina job=sendgmr) by 2002:ad4:566f:: with SMTP id
 bm15mr7233221qvb.54.1622855190002; Fri, 04 Jun 2021 18:06:30 -0700 (PDT)
Date:   Fri,  4 Jun 2021 18:06:26 -0700
In-Reply-To: <1fd32aad-c99d-e89a-cdb1-05843f568f0c@oracle.com>
Message-Id: <20210605010626.1459873-1-almasrymina@google.com>
Mime-Version: 1.0
References: <1fd32aad-c99d-e89a-cdb1-05843f568f0c@oracle.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH] mm, hugetlb: fix allocation error check and copy func name
From:   Mina Almasry <almasrymina@google.com>
Cc:     Mina Almasry <almasrymina@google.com>, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alloc_huge_page_vma() doesn't return error pointers, it returns
NULL.

There is an existing migrate_page_copy() which not only copies the page
contents, but also page state/metadata.  People could get confused that
'migrate_page_copy' and 'migrate_copy_huge_page' do not have the same
functionality.  Rename to 'copy_huge_page()' to make it less likely
folks get confused.

Fixes: 6a0badc266df ("mm, hugetlb: fix racy resv_huge_pages underflow on
UFFDIO_COPY")

Signed-off-by: Mina Almasry <almasrymina@google.com>
Cc: linux-mm@kvack.org
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org

---
 include/linux/migrate.h | 4 ++--
 mm/hugetlb.c            | 4 ++--
 mm/migrate.c            | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index e0b98876a52e..9b7b7cd3bae9 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -51,7 +51,7 @@ extern int migrate_huge_page_move_mapping(struct address_space *mapping,
 				  struct page *newpage, struct page *page);
 extern int migrate_page_move_mapping(struct address_space *mapping,
 		struct page *newpage, struct page *page, int extra_count);
-extern void migrate_copy_huge_page(struct page *dst, struct page *src);
+extern void copy_huge_page(struct page *dst, struct page *src);
 #else

 static inline void putback_movable_pages(struct list_head *l) {}
@@ -78,7 +78,7 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
 	return -ENOSYS;
 }

-static inline void migrate_copy_huge_page(struct page *dst, struct page *src)
+static inline void copy_huge_page(struct page *dst, struct page *src)
 {
 }
 #endif /* CONFIG_MIGRATION */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 64a460ff2d5b..637395907908 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5130,7 +5130,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			 * contents.
 			 */
 			page = alloc_huge_page_vma(h, dst_vma, dst_addr);
-			if (IS_ERR(page)) {
+			if (!page) {
 				ret = -ENOMEM;
 				goto out;
 			}
@@ -5156,7 +5156,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			*pagep = NULL;
 			goto out;
 		}
-		migrate_copy_huge_page(page, *pagep);
+		copy_huge_page(page, *pagep);
 		put_page(*pagep);
 		*pagep = NULL;
 	}
diff --git a/mm/migrate.c b/mm/migrate.c
index 2515210a9747..51f355757490 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -557,7 +557,7 @@ static void __copy_gigantic_page(struct page *dst, struct page *src,
 	}
 }

-void migrate_copy_huge_page(struct page *dst, struct page *src)
+void copy_huge_page(struct page *dst, struct page *src)
 {
 	int i;
 	int nr_pages;
@@ -662,7 +662,7 @@ EXPORT_SYMBOL(migrate_page_states);
 void migrate_page_copy(struct page *newpage, struct page *page)
 {
 	if (PageHuge(page) || PageTransHuge(page))
-		migrate_copy_huge_page(newpage, page);
+		copy_huge_page(newpage, page);
 	else
 		copy_highpage(newpage, page);

--
2.32.0.rc1.229.g3e70b5a671-goog
