Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334F73B2BF4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhFXJ6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbhFXJ6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:58:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B6EC061760
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 02:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=lWitDlOwT7TwEtlRfTSmEbmNIFqsCtGGGoDvr+aC42c=; b=fUeBPI8cs+k2itPLzQsaBxk8Pj
        f64I7fnjzDUvkRP01+m8uRDgy09L4n4e4ftUg8ODyFP8L1f2pctilZszzuIREYZz9jbHPgTxoTWsZ
        9F5OvD1ulAsdVNXhXRQv/mKqstGzXY8YLiVHF94CYSH8lWjE+AA79OIl71vwibePORofiA8WxUw4a
        qLI1XPfGkIHpujrpzb/FOMTWKduC+qu0sM6QiF3pIXUWZpTi0ozyOwspw5Ff2MN+8mCc9hXo/owU4
        j1/IszxclqShTx0F3V/NkYyWTq9RIs2aW+50ZIxTSF4JdozCPmCaYbBqKgKQH79hj0d8tprU2+h24
        U0JjfArg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwM43-00GQOf-AO; Thu, 24 Jun 2021 09:54:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9E7243005B9;
        Thu, 24 Jun 2021 11:54:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EDE022BC05F3A; Thu, 24 Jun 2021 11:54:23 +0200 (CEST)
Message-ID: <20210624095148.437720419@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Jun 2021 11:41:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com, rostedt@goodmis.org,
        dvyukov@google.com, elver@google.com
Subject: [PATCH v2 13/24] x86/paravirt: Use PVOP_* for paravirt calls
References: <20210624094059.886075998@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doing unconditional indirect calls through the pv_ops vector is weird.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/paravirt.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -52,11 +52,11 @@ void __init paravirt_set_cap(void);
 /* The paravirtualized I/O functions */
 static inline void slow_down_io(void)
 {
-	pv_ops.cpu.io_delay();
+	PVOP_VCALL0(cpu.io_delay);
 #ifdef REALLY_SLOW_IO
-	pv_ops.cpu.io_delay();
-	pv_ops.cpu.io_delay();
-	pv_ops.cpu.io_delay();
+	PVOP_VCALL0(cpu.io_delay);
+	PVOP_VCALL0(cpu.io_delay);
+	PVOP_VCALL0(cpu.io_delay);
 #endif
 }
 


