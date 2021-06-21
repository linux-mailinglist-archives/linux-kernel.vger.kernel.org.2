Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2AF3AE8A7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhFUMGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhFUMGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:06:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C15BC061766
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=xrFuY8evywfNJjK/DRoe4JxiXmVMBnrT/SwOJnngIWg=; b=K3PhyRQaUszfkoH+CQVI0gLGVT
        pm/PKw71sOrG/I8dUsRyzFabElI9P6oTb9pRfE1+2cW7Z7KhWplIf7xayJRasAv0xIqUFGAiVfw8k
        hTXjTWKXHEFncrcmUCg53qm+9zfQCt3PRNUVxl1iF30/0pBPlzl6/z22f8UQQZf6zlKrkXAzCmphu
        B/KU1nitGx104qBWgwN1VxEjQcR43JrXdNZY7lx0ogkjZOazuDQ0vBTXG6neWuGlGykm2v3gBeuIb
        1bUK/G+WFmX0m16YwN0CMTTuqAvnMuMrkYZh9PbOyRrr3m/fVDDeaDVf6Cn/gs+TwtQDaEvQZfAr1
        G8Um8SkA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvIdV-00D3hq-21; Mon, 21 Jun 2021 12:02:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2E489300204;
        Mon, 21 Jun 2021 14:02:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F3108235EE382; Mon, 21 Jun 2021 14:02:38 +0200 (CEST)
Message-ID: <20210621120120.682468274@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Jun 2021 13:12:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com
Subject: [PATCH 04/18] x86: Always inline task_size_max()
References: <20210621111233.344964031@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: handle_bug()+0x10: call to task_size_max() leaves .noinstr.text section

When #UD isn't a BUG, we shouldn't violate noinstr (we'll still
probably die, but that's another story).

Fixes: 025768a966a3 ("x86/cpu: Use alternative to generate the TASK_SIZE_MAX constant")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/page_64.h |    2 +-
 arch/x86/kernel/traps.c        |    9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -75,7 +75,7 @@ void copy_page(void *to, void *from);
  *
  * With page table isolation enabled, we map the LDT in ... [stay tuned]
  */
-static inline unsigned long task_size_max(void)
+static __always_inline unsigned long task_size_max(void)
 {
 	unsigned long ret;
 


