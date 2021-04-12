Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F0735BBBD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 10:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237213AbhDLIJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 04:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237194AbhDLIJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 04:09:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B791C06138C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 01:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=di4C6bbSl7iLJMkDo7XO8ZICGg5xRWGqLb1m8Rukv20=; b=YbnF5/GCNEslzNuBs5qK0QChkY
        4uR2tlI+pJM2mlI4nY0EYfLtOv2DaYf8ETEJq1eLyxCAxq9TGczM8rCp5BGd+Pp07cRAxuXEjm3MH
        d511RbZdsZe/RF4L6N3ZM5JcGlgKNmsxldb1Ha6aZQlpgGBPRANGEpj5sE2FBpCGyvwTtpMzZqkAu
        TtunDAx5SH1+UnF7hGsF/IcAodYOGskfZE8U6c2QauhaJGYKoIil9rdGy+alOdxpfNZvDuVLiCUkw
        kAxBpkAmmy3G1hS15fLPpSpz9pVJj0TFx1VACeorabu44in+T0zAp4K5PJOEAV7dZYkdWPeoJ/9DV
        FT+b42rw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVrcl-003yd5-5N; Mon, 12 Apr 2021 08:08:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7766E3001FF;
        Mon, 12 Apr 2021 10:08:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3F6B025F21531; Mon, 12 Apr 2021 10:08:44 +0200 (CEST)
Message-ID: <20210412080611.769864829@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Apr 2021 10:00:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, x86@kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, chris@chris-wilson.co.uk,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
        keescook@chromium.org, hch@lst.de
Subject: [PATCH 4/7] mm: Introduce verify_page_range()
References: <20210412080012.357146277@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce and EXPORT a read-only counterpart to apply_to_page_range().

It only exposes the PTE value, not a pointer to the pagetables itself
and is thus quite a bit safer to export. A number of
apply_to_page_range() users can be converted to this primitive.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/mm.h |    4 ++++
 mm/memory.c        |   24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2876,6 +2876,10 @@ extern int apply_to_page_range(struct mm
 extern int apply_to_existing_page_range(struct mm_struct *mm,
 				   unsigned long address, unsigned long size,
 				   pte_fn_t fn, void *data);
+extern int verify_page_range(struct mm_struct *mm,
+			     unsigned long addr, unsigned long size,
+			     int (*fn)(pte_t pte, unsigned long addr, void *data),
+			     void *data);
 
 extern void init_mem_debugging_and_hardening(void);
 #ifdef CONFIG_PAGE_POISONING
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2559,6 +2559,30 @@ int apply_to_existing_page_range(struct
 	return __apply_to_page_range(mm, addr, size, fn, data, false);
 }
 
+struct vpr_data {
+	int (*fn)(pte_t pte, unsigned long addr, void *data);
+	void *data;
+};
+
+static int vpr_fn(pte_t *pte, unsigned long addr, void *data)
+{
+	struct vpr_data *vpr = data;
+	return vpr->fn(*pte, addr, vpr->data);
+}
+
+int verify_page_range(struct mm_struct *mm,
+		      unsigned long addr, unsigned long size,
+		      int (*fn)(pte_t pte, unsigned long addr, void *data),
+		      void *data)
+{
+	struct vpr_data vpr = {
+		.fn = fn,
+		.data = data,
+	};
+	return apply_to_page_range(mm, addr, size, vpr_fn, &vpr);
+}
+EXPORT_SYMBOL_GPL(verify_page_range);
+
 /*
  * handle_pte_fault chooses page fault handler according to an entry which was
  * read non-atomically.  Before making any commitment, on those architectures


