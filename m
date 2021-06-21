Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900073AE8A4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhFUMGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhFUMGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:06:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A65C061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=KhIc2e99tHvIbNnDwwgdvZLwaAH6ewfxrq0jzF3rx9U=; b=r6BwQdvQyEx6DlNcVOv+tLs94M
        jye/8Ph+NECVQrWWZAFRYufReyuEh+E4UEusIuVAn3wvzXzYmzpNYdjUJElmI0ge/9xGPXeEzd+0Y
        NSCTcs/4yvBFEspNPDiF+uWtdtMHshpxuWnlRdrk1aYeYQRIafuodmBGqIb0Xa5xG2Fl9C5kVe91r
        fwHlMG6Q6blFQ+MBmJi1NZvE4bJAK3klt/yPFmGFqX+KFuptFnZN0N22NRB+RTWQXSLmli4pAPhAV
        Z33g9uhZwBq0f2bQEjFyQ9JIn53pGElX1CttDsMYeEvcF67TcKpUzdqDYFB76zF920IFbfFJwd/j/
        t7DAIN9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvIdV-00D3hs-24; Mon, 21 Jun 2021 12:02:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3728830031C;
        Mon, 21 Jun 2021 14:02:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E7D7D20111E09; Mon, 21 Jun 2021 14:02:38 +0200 (CEST)
Message-ID: <20210621120120.467898710@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Jun 2021 13:12:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com
Subject: [PATCH 01/18] x86/entry: Fix noinstr fail in __do_fast_syscall_32()
References: <20210621111233.344964031@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: __do_fast_syscall_32()+0xf5: call to trace_hardirqs_off() leaves .noinstr.text section

Fixes: 5d5675df792f ("x86/entry: Fix entry/exit mismatch on failed fast 32-bit syscalls")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -166,8 +166,8 @@ static noinstr bool __do_fast_syscall_32
 		/* User code screwed up. */
 		regs->ax = -EFAULT;
 
-		instrumentation_end();
 		local_irq_disable();
+		instrumentation_end();
 		irqentry_exit_to_user_mode(regs);
 		return false;
 	}


