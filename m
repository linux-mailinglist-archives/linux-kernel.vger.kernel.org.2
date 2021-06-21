Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8A13AE89B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhFUMFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhFUMFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:05:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DD3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=lWitDlOwT7TwEtlRfTSmEbmNIFqsCtGGGoDvr+aC42c=; b=anrekTQGh6QsirbC4aZIlXFrND
        0+11OOvKJaRzpeSX50VrgK+xzJ79s+LCc5eFBvJs2gTdk6PiLBfv9FSbWpCYnsUx9RW6BMO0FeUnE
        0hBTJvnacoopHOhfYZlgX6w7HdrnE7sr78iZvw04IxC3JKdoR7/CSDAxLgHG0UoFw5y0kLuUSHBTx
        BpEx8PbrYpxQwQNZ2rJcXleW6Nl42QoFlxgf38I6SHI0zgtD1pVXXmizmG/eu2NjpAgQ0EARyyrii
        b3YLTnH49libGMiQCeVy99zaHmBU2DYhxUKVg41N7t3dyb9NiwqeJLmrGEpaxmnpC3kjqaWuTTZcL
        zbUsQsEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvIdO-00AEJb-Ne; Mon, 21 Jun 2021 12:02:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A6FF33005B6;
        Mon, 21 Jun 2021 14:02:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0FEEF235EE385; Mon, 21 Jun 2021 14:02:39 +0200 (CEST)
Message-ID: <20210621120120.951672655@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Jun 2021 13:12:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com
Subject: [RFC][PATCH 07/18] x86/paravirt: Use PVOP_* for paravirt calls
References: <20210621111233.344964031@infradead.org>
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
 


