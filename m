Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241754186A0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 07:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhIZGAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 02:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhIZF77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 01:59:59 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09651C061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 22:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=NesuuJY3vozxbCQASUdwIUQuhXe+PrX0BhoDdriym0Q=; b=tPC96cXqNSgFvj1cvcFOq7H+6U
        J97M7rXnVxNhBVbv5tTuP5LRduDKmsYW0PgXHBZNQDdq2HT+IxBhYbzGa/YKTHyDdeFnWcgNpHJbH
        IyZq/wpZj5O6rag5q/pBUtvJ5v+AG2k9MkoYFZNaXLl19uPfMxvz+UUVrcSCRLfjgXsjm00uVeTJD
        LFtgC7J7Y2s1Hez14IHF3HVgQmaZmBmRiri4FT8XZtplhWTGVurFLRB7XLUas2S1j1/6l8h8d+Qz0
        4tyNJWxdgFr+JgSyI8acVh37M3DvKJ4wiiEKmgtXFRjIJw4Ct0cT7VTdMr1mjZ7FZ8vIhO26NMe3x
        xbsmgfbA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUNB4-0003XG-Ga; Sun, 26 Sep 2021 05:58:18 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Nickhu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Subject: [PATCH] NDS32: perf_event_cpu: fix 2 build errors
Date:   Sat, 25 Sep 2021 22:58:17 -0700
Message-Id: <20210926055817.24352-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

../arch/nds32/kernel/perf_event_cpu.c: In function 'unwind_frame_kernel':
../arch/nds32/include/asm/current.h:10:13: error: '$r25' undeclared (first use in this function)
   10 | #define tsk $r25
../arch/nds32/kernel/perf_event_cpu.c:1255:50: note: in expansion of macro 'tsk'
 1255 |                                                 (tsk, &graph, frame->lp, NULL);

../arch/nds32/kernel/perf_event_cpu.c:1257:27: error: assignment to 'long unsigned int' from 'long unsigned int *' makes integer from pointer without a cast [-Werror=int-conversion]
 1257 |                 frame->sp = ((unsigned long *)frame->sp) + 1;

For $r25, use the register function for current() instead.

Fixes: c8b34461705e ("nds32: Add perf call-graph support.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Nickhu <nickhu@andestech.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
---
Please check the frame->sp cast/arithmetic.

 arch/nds32/kernel/perf_event_cpu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20210917.orig/arch/nds32/kernel/perf_event_cpu.c
+++ linux-next-20210917/arch/nds32/kernel/perf_event_cpu.c
@@ -1252,9 +1252,9 @@ static int unwind_frame_kernel(struct st
 		 */
 		if (__kernel_text_address(frame->lp))
 			frame->lp = ftrace_graph_ret_addr
-						(tsk, &graph, frame->lp, NULL);
+					(current, &graph, frame->lp, NULL);
 
-		frame->sp = ((unsigned long *)frame->sp) + 1;
+		frame->sp = (unsigned long)(((unsigned long *)frame->sp)) + 1;
 
 		return 0;
 	} else {
