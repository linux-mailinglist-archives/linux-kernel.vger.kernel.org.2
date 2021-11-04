Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3938A4457D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 18:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhKDREH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 13:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbhKDRDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:03:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F2BC06120C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 10:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=kVMOqUFd8zhddZKtKxfw+bZhetOcDaUD8823IFBPVTs=; b=Y+n7C3swOWYzDGRMlyLnkCLnnY
        W1Ys4LTqEmDJ9IriKXTJOKM9BeeShdx4QBBC33UAw54DW4gqw4dLIqdESr0S+yfFh5nd/F+0k6YIJ
        IekRsC8Pcxh5+Sw9PM6hkWnBswHAzrNS/qZlkP4b6MxuZbg3aA0I/eh4pgvgLJ6FxP6nTh1rhr+Qc
        s5wGjJurIcH4cRAq4NvmsDWBFcQBxKoVoSxEyVSJhKhDZ1kxQvqS9FCVc3icLEhEXJGJurQ7diUm/
        oEIRqutC5ZXzd8aWA2B7mOrOpwwJ1LsEur/On8GSh+lfF1LzNe5wDx2nr/zrTcBleWjtPhrdeTEvB
        ffDRStdQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mig2Z-0060Fw-Pv; Thu, 04 Nov 2021 16:57:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C26E302A1F;
        Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6A0E52DD49FB3; Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Message-ID: <20211104165525.827837876@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Nov 2021 17:47:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [RFC][PATCH 22/22] x86: Remove .fixup section
References: <20211104164729.226550532@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No moar user, kill it dead.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/vdso/vdso-layout.lds.S |    1 -
 arch/x86/kernel/vmlinux.lds.S         |    1 -
 2 files changed, 2 deletions(-)

--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -77,7 +77,6 @@ SECTIONS
 
 	.text		: {
 		*(.text*)
-		*(.fixup)
 	}						:text	=0x90909090,
 
 
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -137,7 +137,6 @@ SECTIONS
 		ALIGN_ENTRY_TEXT_END
 		SOFTIRQENTRY_TEXT
 		STATIC_CALL_TEXT
-		*(.fixup)
 		*(.gnu.warning)
 
 #ifdef CONFIG_RETPOLINE


