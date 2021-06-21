Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7C93AE8AD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhFUMG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhFUMGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:06:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD4AC061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=lQfFlCgkE6l1bv3XTjlrWHnVfGWhQN5K3kqRQldXYvU=; b=amdk0GQLA/2MNrrDEdKoyUg6rY
        C+UdBwEDNa9KrhGMmqvofVs03ufeAoL0/WYvb6h45e6ggDA3WFZ8Tu+C3YDA2POTXW/mpQ4dsoPH4
        XBd3Vi81ksLx5g9NE6KoWwoZOZ3L+20nOjrWxQ7OeI0mNzhtQ5n7iGTA350bFtLS1EyThz3B0LXeV
        mbqTniQaqZ3QtymqAaDrKJF5UrdcbiJVKQvOiKjMVkgWD9bnOnPM8jk8Zr9lMy2fPrypDpY3eAu0t
        +pS74QbuevRaorzQuhNZALYvBrCveTvox/397kgIpioo+Db+0Y+xRtZgmxxwp3VbkZkOXn34g/EYB
        FCyNwBAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvIdY-00D3i1-Vn; Mon, 21 Jun 2021 12:02:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B897D3005C1;
        Mon, 21 Jun 2021 14:02:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3B973235EE38B; Mon, 21 Jun 2021 14:02:39 +0200 (CEST)
Message-ID: <20210621120121.420715682@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Jun 2021 13:12:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com
Subject: [RFC][PATCH 13/18] x86/xen: Make hypercall_page noinstr
References: <20210621111233.344964031@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: xen_set_debugreg()+0x3: call to hypercall_page() leaves .noinstr.text section
vmlinux.o: warning: objtool: xen_get_debugreg()+0x3: call to hypercall_page() leaves .noinstr.text section
vmlinux.o: warning: objtool: xen_irq_enable()+0x24: call to hypercall_page() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/xen/xen-head.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -64,7 +64,7 @@ SYM_CODE_END(asm_cpu_bringup_and_idle)
 #endif
 #endif
 
-.pushsection .text
+.pushsection .noinstr.text, "ax"
 	.balign PAGE_SIZE
 SYM_CODE_START(hypercall_page)
 	.rept (PAGE_SIZE / 32)


