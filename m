Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085783AE8A5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhFUMGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFUMGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:06:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F2DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=jTa88yqAc+6LB1sKPlALXf8zTQjs2C8ooyyGUxBbOG0=; b=pLw9OvUdjrk7fRznMtMgGvfrBZ
        96E6Vj3fSNfLzB3EV1bo57R3IlA8WMeJhGSq6xgQ7bzcRFESvWGk4Xjo0hKK1K4cH5zIcqivez5IO
        g9c/G3qnT3P1LLMd4y81cZp5KPGMCN9OYDH+FsZfsdb7G4ZIYiksB0oj4LA3lJcNCEzROK7saYQmD
        jTfvxRJGROvkArsHO1qwwhK40v7jgDRHnQ6Jp7YZCO9eEekfuH/59P3SvwROZzxalBVyplDaseT+z
        IZ38LEV5BPNwwvNDMmXZhOnEGYDQfjgBB87+cx/w5IQGqSwBwbZkqHQeFaaH7UQy+E0fifqrwYcga
        un75Xn4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvIdV-00D3hr-23; Mon, 21 Jun 2021 12:02:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3517E3002EC;
        Mon, 21 Jun 2021 14:02:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E9D34235EE365; Mon, 21 Jun 2021 14:02:38 +0200 (CEST)
Message-ID: <20210621120120.532960208@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Jun 2021 13:12:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com
Subject: [PATCH 02/18] x86/xen: Fix noinstr fail in xen_pv_evtchn_do_upcall()
References: <20210621111233.344964031@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: xen_pv_evtchn_do_upcall()+0x23: call to irq_enter_rcu() leaves .noinstr.text section

Fixes: 359f01d1816f ("x86/entry: Use run_sysvec_on_irqstack_cond() for XEN upcall")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/common.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -304,15 +304,16 @@ __visible noinstr void xen_pv_evtchn_do_
 	irqentry_state_t state = irqentry_enter(regs);
 	bool inhcall;
 
+	instrumentation_begin();
 	run_sysvec_on_irqstack_cond(__xen_pv_evtchn_do_upcall, regs);
 
 	inhcall = get_and_clear_inhcall();
 	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
-		instrumentation_begin();
 		irqentry_exit_cond_resched();
 		instrumentation_end();
 		restore_inhcall(inhcall);
 	} else {
+		instrumentation_end();
 		irqentry_exit(regs, state);
 	}
 }


