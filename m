Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAF643B84A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 19:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237882AbhJZRlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 13:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237801AbhJZRkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 13:40:53 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C860BC061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:38:28 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id d10so5685357qvl.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RTaUD2RUm6/em+jvQTkh6ivxttGsmNn09ntigKewekQ=;
        b=GIGS37Qoa3iQ9XGqYkImLqW64mhHkHZqcAdTsvWcZapxSea6btQvnnY5RgjopRu6dq
         PcqIvjD2ChFH0Bik2yOsB25Qz/PRL4pLDZpduH15i+44oAsfKQzQy77CjbE3RvfjtQ9w
         pZD5mtvVpkN0conJO3+cVJmm6e0g6QBh0b7JZ3psQzlo68/P7mTjqOozTJL5OLMSa12D
         El3xALwir4fVBu8/IaMqnBCrpXu/TCuTT4CVHK5gJIQlfjOXwvc5RvN1E6NEfnqYIuxj
         i4mmV1jV2cHm3QBFvK4uF/aAthF+7j6Tn/8+IW1HmzQ968lQ+O3l+yzPZYkM8cudcmV0
         oRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RTaUD2RUm6/em+jvQTkh6ivxttGsmNn09ntigKewekQ=;
        b=nsek8ZU4YH79T1/VrWNJHe6UlrGN3KpRfG673JgLWDUMn8N/R1Us4CXoFJqi9IOwFI
         KFzfIg6Lr0wWzGUHKFkUJh9kQx+vigwz+X3NJhXgd3Rnvxrv8+oImUn0k3DV/2573ugJ
         n8oo2pE/3dtx9NrWqlMvKOY7juy4l281A4Uo0CtanlDparuzul/avyd5ewTm4o84RplJ
         kB6MDocychMxD5ZkvKLpOuDKvgJ/fBwp54dq0/8YA/aDbesdRkz8NGIKCxrnfyWyoeYQ
         XudhKmzuPM1eJJ+FSretLiIWUC9UGu02JrDkPnigmtiRJzS/S9vri2i499VT8lZccDpl
         1OYw==
X-Gm-Message-State: AOAM533Hf5TUDOd7clkkbihhyXLTYn6/NTLywNIFLJg0AFKqxr2JFAS/
        DHkimhDvx0t28yM0b9UolM5zyQ==
X-Google-Smtp-Source: ABdhPJx51qUHPL7MosY+ccdW2v8AQS7qpS2Lf6x9DSO9D0SE6bk4w8h6c+6o+lQ+QoMcJjSYsK+17A==
X-Received: by 2002:a05:6214:23c5:: with SMTP id hr5mr24631556qvb.59.1635269907919;
        Tue, 26 Oct 2021 10:38:27 -0700 (PDT)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id bj37sm11001939qkb.49.2021.10.26.10.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 10:38:27 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org,
        anshuman.khandual@arm.com, willy@infradead.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        mike.kravetz@oracle.com, vbabka@suse.cz, geert@linux-m68k.org,
        schmitzmic@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
        hannes@cmpxchg.org, guro@fb.com, songmuchun@bytedance.com,
        weixugc@google.com, gthelen@google.com
Subject: [RFC 3/8] mm: Avoid using set_page_count() in set_page_recounted()
Date:   Tue, 26 Oct 2021 17:38:17 +0000
Message-Id: <20211026173822.502506-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
In-Reply-To: <20211026173822.502506-1-pasha.tatashin@soleen.com>
References: <20211026173822.502506-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_page_refcounted() converts a non-refcounted page that has
(page->_refcount == 0) into a refcounted page by setting _refcount to 1,

Use page_ref_inc_return() instead to avoid unconditionally overwriting
the _refcount value.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/internal.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/internal.h b/mm/internal.h
index cf3cb933eba3..cf345fac6894 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -91,9 +91,12 @@ static inline bool page_evictable(struct page *page)
  */
 static inline void set_page_refcounted(struct page *page)
 {
+	int refcnt;
+
 	VM_BUG_ON_PAGE(PageTail(page), page);
 	VM_BUG_ON_PAGE(page_ref_count(page), page);
-	set_page_count(page, 1);
+	refcnt = page_ref_inc_return(page);
+	VM_BUG_ON_PAGE(refcnt != 1, page);
 }
 
 extern unsigned long highest_memmap_pfn;
-- 
2.33.0.1079.g6e70778dc9-goog

