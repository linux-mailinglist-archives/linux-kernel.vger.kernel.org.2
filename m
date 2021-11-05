Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9089C4467BA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbhKERXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbhKERWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:22:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78086C06120F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=CRXhttQTOv7PvgiQpm3Snc6ja8BMJtrNq+oyhbTQOCA=; b=ANMQiNPVrUJCI93mnuZxnxRl7T
        YFYG0AeweoW39G2pjk2Je1M/eszyzPKweCi6rgmXZ5UytHiFtd02AyeLV3/4c4YyOHsZK5Koefogc
        UvHCuByTWiYoffyuLh2orCG3l560hj0Ij4bsiYjWybhBhcfd3aiqfuqjsmHot0CfncUpkEZeyLXig
        002SimGwRGAT2hmZcWib7GwkdL63K0qHVazj5AT92dPDa0yXIZhysvRWIr3hvCcu3Oh4L0bf7jHEQ
        jeaZ86kfJzKMzqFLceH55Ka+1OSjVSeEMYO2A2Yv4PhRRcPrGGFpo4QDsZLlz+axM2HYbIavTXez8
        9Rip/OAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj2sb-00ENBG-01; Fri, 05 Nov 2021 17:19:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DB585302AD4;
        Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9714B203C008A; Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Message-ID: <20211105171821.714042588@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 05 Nov 2021 18:10:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH 21/22] x86: Remove .fixup section
References: <20211105171023.989862879@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No moar users, kill it dead.

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


