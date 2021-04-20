Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B75E365E73
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 19:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbhDTRZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 13:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbhDTRZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 13:25:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E5DC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=zCxTkutdwyOxu0wuqOhdUR3tApRYoORPLDIdB78sc9k=; b=QM6uZMU5YdM5DjGzJQhdeM3pv1
        buG8WwmUrUJNsBuLqit6NqlnwHAmc+d3keBcejm7UHxHI+F5+XT+C2PbqMc6t2HsRprGOil4dLINr
        X+cAlvF7p2vK9jlU1/KsfiyiRkQBH4wChvW4MonH/aqZ+m4+t1cfVlW+IPEnkmtnwSASPJtTjygNZ
        Z20u5l38xJaHZyUfpjGn7XBrEKHObYPJ6sFJomJ475sSZtFUoOrvVbwIVMGx/gL9ZXLw3mjjQ/0Pu
        WP50QCPqMWkR/i4rTIo5L80qAGL0sY1MLPKHA0uEKTmCk/FhlewqOjOqiK6Y0E4wBTNxFjI8cthF0
        wD3xhtDQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lYu5H-00FR6u-Or; Tue, 20 Apr 2021 17:23:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: Show three registers per line
Date:   Tue, 20 Apr 2021 18:22:45 +0100
Message-Id: <20210420172245.3679077-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Displaying two registers per line takes 15 lines.  That improves to just
10 lines if we display three registers per line, which reduces the amount
of information lost when oopses are cut off.  It stays within 80 columns
and matches x86-64.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/arm64/kernel/process.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 6e60aa3b5ea9..aff5a2c12297 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -294,13 +294,10 @@ void __show_regs(struct pt_regs *regs)
 	i = top_reg;
 
 	while (i >= 0) {
-		printk("x%-2d: %016llx ", i, regs->regs[i]);
-		i--;
+		printk("x%-2d: %016llx", i, regs->regs[i]);
 
-		if (i % 2 == 0) {
-			pr_cont("x%-2d: %016llx ", i, regs->regs[i]);
-			i--;
-		}
+		while (i-- % 3)
+			pr_cont(" x%-2d: %016llx", i, regs->regs[i]);
 
 		pr_cont("\n");
 	}
-- 
2.30.2

