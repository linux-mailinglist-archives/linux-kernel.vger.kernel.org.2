Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D8A44BE5F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhKJKTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhKJKTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:19:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D133C061205
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=CRXhttQTOv7PvgiQpm3Snc6ja8BMJtrNq+oyhbTQOCA=; b=wS+boQNgXU8iXZ/2uFl10RGGGt
        QDg0jOpiSdjilvKRPFhswSdzBGuae/jTVigbYWct5tOCqN9YGdX1PbB26ivXARqXDuy2J9YGZbWol
        /dRh8roEK1UAGMfy7JoOZpSdNYNLX6Kw2h8n6hiSFLPbrf1NLTn+0TfnxwijPfARHSuWFwP9IqrSq
        6Q6cHPjJML9TUns0xyrnS/GdPZCEdvz+i9RmvavB4Wvfvn+rKcoORRSfCziUVbrMRGYKtJmu13KH3
        K43AE4VNMnNbzz4kc6C+2wLSjmxENfu8eqDL7kCMl9fGquTZRBb/igN1O3Z7s/gH966pDogzta+IX
        K+K8Yv2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkkeH-001lkh-5a; Wed, 10 Nov 2021 10:16:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CC255302A17;
        Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B9FAF203BF7FB; Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Message-ID: <20211110101326.201590122@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Nov 2021 11:01:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH v2 22/23] x86: Remove .fixup section
References: <20211110100102.250793167@infradead.org>
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


