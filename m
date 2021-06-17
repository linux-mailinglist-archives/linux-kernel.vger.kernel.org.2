Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1896E3ABC52
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 21:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbhFQTIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 15:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbhFQTIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 15:08:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79105C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=TDctpxhIDTye5ML+0Sif9pc0x6wB1j40OGlRV0Psy70=; b=wBmGDYIUxBqXqNUUnXvng606o+
        Op1SoSCTEmCfVjJ8VUZNJT5W2U33W0ZtBtCI2+LRCyn+nTyQ4Sm5X/VSXLt5pcHAsAiTGYwm5Qbu9
        gk9jm5wUvhLJsG77E7ABr6tVjvnlFiTV9yycgSv+yetPaKB9NrZ3/6ImkIMERV/EkShS4URhPLQ/d
        VqeC54ukRRsPU7wgSVbZpwSqtA4DLTi9dbv+833jGBwl84EpjPrXINsQSCmOiSLUSPcH7yc+ygPFn
        uNAsaJsI1OzmDdWOt0ueLDjHl2CSWo6X4qKl5ySLzbPLCtFFkQRXutX2u4GJKKor25tpZrlQlMAPI
        f03cPnKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltxIh-009ThU-1a; Thu, 17 Jun 2021 19:03:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 721003002C4;
        Thu, 17 Jun 2021 21:03:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 58B94202434C3; Thu, 17 Jun 2021 21:03:37 +0200 (CEST)
Message-ID: <20210617190313.322096283@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 17 Jun 2021 20:57:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, bp@alien8.de, tglx@linutronix.de,
        bigeasy@linutronix.de
Subject: [PATCH 2/3] lockdep/selftests: Fix selftests vs PROVE_RAW_LOCK_NESTING
References: <20210617185717.486456641@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When PROVE_RAW_LOCK_NESTING=y many of the selftests FAILED because
HARDIRQ context is out-of-bounds for spinlocks. Instead make the
default hardware context the threaded hardirq context, which preserves
the old locking rules.

The wait-type specific locking selftests will have a non-threaded
HARDIRQ variant.

Fixes: de8f5e4f2dc1 ("lockdep: Introduce wait-type checks")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 lib/locking-selftest.c |    1 +
 1 file changed, 1 insertion(+)

--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -194,6 +194,7 @@ static void init_shared_classes(void)
 #define HARDIRQ_ENTER()				\
 	local_irq_disable();			\
 	__irq_enter();				\
+	lockdep_hardirq_threaded();		\
 	WARN_ON(!in_irq());
 
 #define HARDIRQ_EXIT()				\


