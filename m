Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B3E3B5D32
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 13:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbhF1LhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 07:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbhF1Lgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 07:36:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E134AC061766
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 04:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=/cZW2yZw4slar2amYClsB7WH31HhkARRf0c+bV/nFt4=; b=eZAupclcW7sVYsJeJCu+JCDNuT
        0rBvwmZWiDFRWMjSaomlfoYoVFfnJO/vBXbckdQ0MQ/ScBAyGWgKaccuZmRjdIaUktLr34bTe3E5X
        5bIeMo5cIE3Gfp0zu54I/YuT89R+ta3akNrbNgF8ehS3G2J47ofh7bgSfrtWJk+fyr6ZkUHvfDBL9
        NXJw29xQVXXJhraMBnZVryUWhDKbKIfwiN6kkz0e7imO5hbAScIrGbN5kvbluNhleMGYz8cJjLFVE
        PZWcu6FdCRGW4mvAoHh+Vsbd2jFUyEXa2ND/8ZpNw9iCcqFSKBztW9ACjzCd1CHy+UMh9zp2hU9Ox
        x4CWoLFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxpUD-002uXp-52; Mon, 28 Jun 2021 11:31:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7189D3002D7;
        Mon, 28 Jun 2021 13:31:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 44A872BF0CB34; Mon, 28 Jun 2021 13:31:29 +0200 (CEST)
Message-ID: <20210628113045.106211657@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 28 Jun 2021 13:24:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, mhiramat@kernel.org,
        davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 2/3] static_call: Fix static_call_text_reserved() vs __init
References: <20210628112409.233121975@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that static_call_text_reserved() was reporting __init
text as being reserved past the time when the __init text was freed
and re-used.

This is mostly harmless and will at worst result in refusing a kprobe.

Fixes: 6333e8f73b83 ("static_call: Avoid kprobes on inline static_call()s")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/static_call.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -292,13 +292,15 @@ static int addr_conflict(struct static_c
 
 static int __static_call_text_reserved(struct static_call_site *iter_start,
 				       struct static_call_site *iter_stop,
-				       void *start, void *end)
+				       void *start, void *end, bool init)
 {
 	struct static_call_site *iter = iter_start;
 
 	while (iter < iter_stop) {
-		if (addr_conflict(iter, start, end))
-			return 1;
+		if (init || !static_call_is_init(iter)) {
+			if (addr_conflict(iter, start, end))
+				return 1;
+		}
 		iter++;
 	}
 
@@ -324,7 +326,7 @@ static int __static_call_mod_text_reserv
 
 	ret = __static_call_text_reserved(mod->static_call_sites,
 			mod->static_call_sites + mod->num_static_call_sites,
-			start, end);
+			start, end, mod->state == MODULE_STATE_COMING);
 
 	module_put(mod);
 
@@ -459,8 +461,9 @@ static inline int __static_call_mod_text
 
 int static_call_text_reserved(void *start, void *end)
 {
+	bool init = system_state < SYSTEM_RUNNING;
 	int ret = __static_call_text_reserved(__start_static_call_sites,
-			__stop_static_call_sites, start, end);
+			__stop_static_call_sites, start, end, init);
 
 	if (ret)
 		return ret;


