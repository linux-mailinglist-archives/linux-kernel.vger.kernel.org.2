Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E96738FBD2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 09:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhEYHfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 03:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhEYHfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 03:35:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6559DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 00:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=LqDlpX41HCnaSZllOvNSp8OtPBYskOfcLpEU/08pELY=; b=WakfMAcm5z0nAkj7kUdp6h4Vz1
        8zMmRobR4R5jKWfQcTp8vlGPkDf+d2XfEJVmZ5WX1MWT6Ze1do00FUbQoGLI9Qm2/4O5t9AMN35+Z
        4RFZeaM2V9I8aGTD7Qvd0X3P0Ko85hkQ1K9cPO2/ATyZvLz+u0hERIeRuBDXRHMGSVlBYx6ZjfIv/
        W3PQhC5t2CxBiW1NRNLaXlwrLIIH3ZZ6b7KPugvXB6q8tByTLMkuBqV+SfnZgc2lsbvuCsmdp9ldA
        cEaN95fDLAtlVzRwzIB5cs0S/JloPRbCnaWP+ahfJwuSnmKXiT39vgyfN2Th6+rm5TmDljj/RgWXz
        4GGbcFmA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1llRYi-003Eiv-3H; Tue, 25 May 2021 07:33:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 30DFC300258;
        Tue, 25 May 2021 09:32:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D88D530A65B79; Tue, 25 May 2021 09:32:57 +0200 (CEST)
Message-ID: <20210525073213.660594073@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 25 May 2021 09:25:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, rostedt@goodmis.org,
        naveen.n.rao@linux.vnet.ibm.com, ananth@linux.ibm.com,
        x86@kernel.org
Subject: [PATCH 2/2] x86,kprobes: WARN if kprobes tries to handle a fault
References: <20210525072518.791889911@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the removal of kprobe::handle_fault there is no reason left that
kprobe_page_fault() would ever return true on x86, make sure it
doesn't happen by accident.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/fault.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1186,7 +1186,7 @@ do_kern_addr_fault(struct pt_regs *regs,
 		return;
 
 	/* kprobes don't want to hook the spurious faults: */
-	if (kprobe_page_fault(regs, X86_TRAP_PF))
+	if (WARN_ON_ONCE(kprobe_page_fault(regs, X86_TRAP_PF)))
 		return;
 
 	/*
@@ -1239,7 +1239,7 @@ void do_user_addr_fault(struct pt_regs *
 	}
 
 	/* kprobes don't want to hook the spurious faults: */
-	if (unlikely(kprobe_page_fault(regs, X86_TRAP_PF)))
+	if (WARN_ON_ONCE(kprobe_page_fault(regs, X86_TRAP_PF)))
 		return;
 
 	/*


