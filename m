Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7D435BBB9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 10:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbhDLIJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 04:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237097AbhDLIJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 04:09:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4812AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 01:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=hnyJIpIgRwAiJphlWTzrQr9Y8jq97hs5NNvLYyocx0A=; b=WuNlZCexSZVXcdYaTJVvOhXT9y
        qzdukRmwjcgFaeguHENlqyTcuk2bJ3MUCGWFlCxuf0f52RWB1pCzoojZuCCdb5XjLonouEScQE4Un
        LAhRDouBPENjjQU5eFcl5UHIAUWJdWmn2jm4OK1sxw8FBoRR65DyvL+vms4hOa8fu2g7oyraEPPTq
        +7uU/o3K5eLwaaI1bVdOEOOOk7PPzPOkEz6CnrW1234yv56YAMOrYAVDLgQBxOr/xOhjd1AbArjjo
        UtD1OTVBuGaEQavMSq1vySIpcQS0I1ULwGRMWLotd3SB0wXe/ZjCGlka96oQi1OAt88cYboBfA2Y3
        t3Yb19hA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVrcm-0063yS-8C; Mon, 12 Apr 2021 08:08:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E5B1C3002C4;
        Mon, 12 Apr 2021 10:08:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5075325F21534; Mon, 12 Apr 2021 10:08:44 +0200 (CEST)
Message-ID: <20210412080611.969415860@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Apr 2021 10:00:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, x86@kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, chris@chris-wilson.co.uk,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
        keescook@chromium.org, hch@lst.de
Subject: [PATCH 7/7] mm: Unexport apply_to_page_range()
References: <20210412080012.357146277@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all module users of apply_to_page_range() have been removed,
unexport this function.

This is an unsafe function in that it gives direct access to the
page-tables.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 mm/memory.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2544,13 +2544,14 @@ static int __apply_to_page_range(struct
 /*
  * Scan a region of virtual memory, filling in page tables as necessary
  * and calling a provided function on each leaf page table.
+ *
+ * DO NOT EXPORT; this hands out our page-tables on a platter.
  */
 int apply_to_page_range(struct mm_struct *mm, unsigned long addr,
 			unsigned long size, pte_fn_t fn, void *data)
 {
 	return __apply_to_page_range(mm, addr, size, fn, data, true);
 }
-EXPORT_SYMBOL_GPL(apply_to_page_range);
 
 /*
  * Scan a region of virtual memory, calling a provided function on
@@ -2558,6 +2559,8 @@ EXPORT_SYMBOL_GPL(apply_to_page_range);
  *
  * Unlike apply_to_page_range, this does _not_ fill in page tables
  * where they are absent.
+ *
+ * DO NOT EXPORT; this hands out our page-tables on a platter.
  */
 int apply_to_existing_page_range(struct mm_struct *mm, unsigned long addr,
 				 unsigned long size, pte_fn_t fn, void *data)


