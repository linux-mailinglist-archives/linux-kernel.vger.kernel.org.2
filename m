Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0396E453D97
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 02:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbhKQBYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 20:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhKQBYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 20:24:02 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAC9C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 17:21:05 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id jo22so829453qvb.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 17:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=m0gNmNzkZWVRv6w7da8Aeqi7F4kIW5gL+hhpZ/Xzv/o=;
        b=Oml9J9TSmBupcaKreQn7f7AaxiWOab9NqOgMSRpCdwFjKq1vRO8SFVw0xCjUWh36fK
         ID7GeDWAFEyp6QTjWUO6Qd6yhs7maVhCTbEkQe6x5surd5bOuYo77KnXiy/Xwxb1lsGo
         QBoQjhym9uLxUbMyJyD3SH3A0aYwk3aPdoJjF8EL25b60dEtFQPVSAr6dLSkjZ5VhW6m
         1FnrlUSLA8LCLK2ltFKulS1YGN8F3gb0rxE5DTlo8s4UERjVa9RBGHcEuN9Nu5SY9yas
         1WrwtxT5KJY5a3AJFmMBjRLZ+WUZdGwRoyWgkVqHWyXCO2OZLxghzqSw7oxBkjQJCnDV
         jZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m0gNmNzkZWVRv6w7da8Aeqi7F4kIW5gL+hhpZ/Xzv/o=;
        b=DOKPdp8RWHjngZ0XfR7eq8soXtL6RValDYB5BCW5/CWrMQy5WNE1rHwhkWOUMlPveP
         xVsep1QpgfIigEvJ5CXVxcfRqsJODR6frO+xNRnyE0TsnmZQetNvraUC+skW7D/0A1qS
         Qevxto64i7HajmKzaWBOzGlp1B49g2iiqha4Ij89+FD6Fp83FLUpz601SVyrRskCcXCu
         zJW/Q1JZfp1/H9/yxzniKN0nksvRvwAZve6KPZj0H7POg4+kmlFvTlU338Fi/N8TA9U+
         I/rekL3VEcZjISsHMrLS+udcT71nRtj0J+NPnd0+jBDmTqEl33dgjP53y4CAyKTVY/Mk
         trEg==
X-Gm-Message-State: AOAM533CFGN6oUDOTuvXHE7ntNu4RFK/2VeRHvFvecgQ+DPgjApf/ZB0
        e3si24faEBAm/LZW0hNk9yjJmw==
X-Google-Smtp-Source: ABdhPJw0PBEl5FXxtC6aW72AUuzKgaD7PgHuWSgRVC63Pfy75/BltIYhkTIJgkOC+07BHxbZsDURzg==
X-Received: by 2002:ad4:54ca:: with SMTP id j10mr50057319qvx.2.1637112064465;
        Tue, 16 Nov 2021 17:21:04 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id i6sm3482289qti.40.2021.11.16.17.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 17:21:04 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org,
        anshuman.khandual@arm.com, willy@infradead.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        mike.kravetz@oracle.com, vbabka@suse.cz, geert@linux-m68k.org,
        schmitzmic@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
        hannes@cmpxchg.org, guro@fb.com, songmuchun@bytedance.com,
        weixugc@google.com, gthelen@google.com, rientjes@google.com,
        pjt@google.com
Subject: [RFC v2 03/10] mm: Avoid using set_page_count() in set_page_recounted()
Date:   Wed, 17 Nov 2021 01:20:52 +0000
Message-Id: <20211117012059.141450-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
In-Reply-To: <20211117012059.141450-1-pasha.tatashin@soleen.com>
References: <20211117012059.141450-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_page_refcounted() converts a non-refcounted page that has
(page->_refcount == 0) into a refcounted page by setting _refcount to
1.

The current apporach uses the following logic:

VM_BUG_ON_PAGE(page_ref_count(page), page);
set_page_count(page, 1);

However, if _refcount changes from 0 to 1 between the VM_BUG_ON_PAGE()
and set_page_count() we can break _refcount, which can cause other
problems such as memory corruptions.

Instead, use a safer method: increment _refcount first and verify
that at increment time it was indeed 1.

refcnt = page_ref_inc_return(page);
VM_BUG_ON_PAGE(refcnt != 1, page);

Use page_ref_inc_return() to avoid unconditionally overwriting
the _refcount value with set_page_count(), and check the return value.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/internal.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 3b79a5c9427a..f601575b7e5a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -132,9 +132,11 @@ static inline bool page_evictable(struct page *page)
  */
 static inline void set_page_refcounted(struct page *page)
 {
+	int refcnt;
+
 	VM_BUG_ON_PAGE(PageTail(page), page);
-	VM_BUG_ON_PAGE(page_ref_count(page), page);
-	set_page_count(page, 1);
+	refcnt = page_ref_inc_return(page);
+	VM_BUG_ON_PAGE(refcnt != 1, page);
 }
 
 extern unsigned long highest_memmap_pfn;
-- 
2.34.0.rc1.387.gb447b232ab-goog

