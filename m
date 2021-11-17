Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B8F453D98
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 02:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhKQBYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 20:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbhKQBYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 20:24:03 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB6EC061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 17:21:06 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id a24so865037qvb.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 17:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Uxu9jRtxw4HfsqmOsn2OoknK/KseQaLw1cgxWnJ0WVI=;
        b=FAWaBWJRTtgyJuy6C8oDxJdNSGUWKTCxi5HYaaEvXAoe/HLLS1aP7503u4sKh5FI9M
         J4Y93zdlrjP/qmcrupDpO6//AXqwkPYrY66wUrX8NJ6VnkhuV0yam8tPuKfeRw1zAMNl
         8ozhTvBfQOVvkzKS71CMNN3HzFGsB0HeVLTETeJBuwettGcSYeXZK2dBprIigt2Oeih9
         yNQH80ovRYcWT9kPXeCWCvozLy3yrA4R4y2WSeeIB0gd2G6OsDqdG2pKEhcCBkHvfmIf
         Z8mpSeNy/D8NeNBD8qnp46ccxcXqNM3CYsg4DH4/O8yb2qrj+R9VoD5aJuh0+xH+D1Xn
         yQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uxu9jRtxw4HfsqmOsn2OoknK/KseQaLw1cgxWnJ0WVI=;
        b=fbNcuRIB6xKQCSYHdbZIhnOab7rnVOKmwvN7X/5Xu8TcNoLLeg6xi8dH+P8A3IJ297
         LlTq6OhoG53P63axUo03SQWS3+1AOHDWQg9Xt/FTQ5aT61PkZk5a7eU/xr74QlDacgUH
         7L9cNpbx2wOUOY13g6fgioatPavD3be8EAmA2m5+z8l7dLt6t2Vd6iFSFpd0oJbvMieP
         3ojF8OwtzUnelH79oEUKCpkn9VocsTKm/uI5Kvws0YBU2mdGcfmQi3dqSe88fT+5kC6d
         aSYIb+B614+t+tkxBVnlsZWL2siW7gDaHJ9F+i9ftFKbwSNYxI8OPPkTUK6q8hC8w1oF
         ktqA==
X-Gm-Message-State: AOAM531zov70BDNLr+iCQzPRPxI8hJJJrRqs6z2tCuUO8j6UT5Tk3yKQ
        DWfjQ9/Fe1ucvBlNM4BV4oYnGw==
X-Google-Smtp-Source: ABdhPJz+3QFjrUicdH92hbNUAeG2NY1ye5tA6FEG0dT0KUu0X9r4bLKsd2TFebc82z8FnQQFd6IqTQ==
X-Received: by 2002:a0c:df0c:: with SMTP id g12mr50307969qvl.24.1637112065186;
        Tue, 16 Nov 2021 17:21:05 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id i6sm3482289qti.40.2021.11.16.17.21.04
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
Subject: [RFC v2 04/10] mm: remove set_page_count() from page_frag_alloc_align
Date:   Wed, 17 Nov 2021 01:20:53 +0000
Message-Id: <20211117012059.141450-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
In-Reply-To: <20211117012059.141450-1-pasha.tatashin@soleen.com>
References: <20211117012059.141450-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_page_count() unconditionally resets the value of _ref_count and that
is dangerous, as it is not programmatically verified. Instead we rely on
comments like: "OK, page count is 0, we can safely set it".

Add a new refcount function: page_ref_add_return() to return the new
refcount value after adding to it. Use the return value to verify that
the _ref_count was indeed the expected one.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/page_ref.h | 11 +++++++++++
 mm/page_alloc.c          |  6 ++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index f3c61dc6344a..27880aca2e2f 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -115,6 +115,17 @@ static inline void init_page_count(struct page *page)
 	set_page_count(page, 1);
 }
 
+static inline int page_ref_add_return(struct page *page, int nr)
+{
+	int old_val = atomic_fetch_add(nr, &page->_refcount);
+	int new_val = old_val + nr;
+
+	VM_BUG_ON_PAGE((unsigned int)new_val < (unsigned int)old_val, page);
+	if (page_ref_tracepoint_active(page_ref_mod_and_return))
+		__page_ref_mod_and_return(page, nr, new_val);
+	return new_val;
+}
+
 static inline void page_ref_add(struct page *page, int nr)
 {
 	int old_val = atomic_fetch_add(nr, &page->_refcount);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c5952749ad40..e8e88111028a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5516,6 +5516,7 @@ void *page_frag_alloc_align(struct page_frag_cache *nc,
 	unsigned int size = PAGE_SIZE;
 	struct page *page;
 	int offset;
+	int refcnt;
 
 	if (unlikely(!nc->va)) {
 refill:
@@ -5554,8 +5555,9 @@ void *page_frag_alloc_align(struct page_frag_cache *nc,
 		/* if size can vary use size else just use PAGE_SIZE */
 		size = nc->size;
 #endif
-		/* OK, page count is 0, we can safely set it */
-		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
+		/* page count is 0, set it to PAGE_FRAG_CACHE_MAX_SIZE + 1 */
+		refcnt = page_ref_add_return(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
+		VM_BUG_ON_PAGE(refcnt != PAGE_FRAG_CACHE_MAX_SIZE + 1, page);
 
 		/* reset page count bias and offset to start of new frag */
 		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-- 
2.34.0.rc1.387.gb447b232ab-goog

