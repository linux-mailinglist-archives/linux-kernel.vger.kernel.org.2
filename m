Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78223B5D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 13:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbhF1Lej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 07:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbhF1Le3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 07:34:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64016C061766
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 04:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=eMn5ewLI9ee9sMPezdA+L/fHdGlfjVosI/DXGMmKHAY=; b=QCSnxA32IxIKdipsWQmTDgGAtS
        OJqW/Pj5fopdWy/7hYkHd8xAJHbV826E+ZJi3G3VdY6VmwUuIBylDJrO6gQselmttgJh16FAq+bxI
        pPf7HvLDNr67gx+FzN7YrymblXArmBT+T6tvh7IbOi0yBxm+OTTQh9xlJHSE5X/9AgLi+TvpkRqTO
        QoOYM6G0WLO2L8nRqyTwbmfoVbPEwpAeGNXmkGpFehKlAhz4GJRq4LzHqJnZJ96tlK5UsC3yEV7I5
        Pu5cXUy3RDJa3Oveqd1QsMCd3u6Oys6sZqgYBjjrHIZXG3fXJOxvjKL2+GmR/RK58LY+24a9DX8DU
        jo1lhNLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxpUD-00CXql-4P; Mon, 28 Jun 2021 11:31:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 73C533002EC;
        Mon, 28 Jun 2021 13:31:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 41C3F2059E78F; Mon, 28 Jun 2021 13:31:29 +0200 (CEST)
Message-ID: <20210628113045.045141693@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 28 Jun 2021 13:24:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, mhiramat@kernel.org,
        davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH 1/3] jump_label: Fix jump_label_text_reserved() vs __init
References: <20210628112409.233121975@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that jump_label_text_reserved() was reporting __init text
as being reserved past the time when the __init text was freed and
re-used.

For a long time, this resulted in, at worst, not being able to kprobe
text that happened to land at the re-used address. However a recent
commit e7bf1ba97afd ("jump_label, x86: Emit short JMP") made it a
fatal mistake because it now needs to read the instruction in order to
determine the conflict -- an instruction that's no longer there.

Fixes: 4c3ef6d79328 ("jump label: Add jump_label_text_reserved() to reserve jump points")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/jump_label.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -316,14 +316,16 @@ static int addr_conflict(struct jump_ent
 }
 
 static int __jump_label_text_reserved(struct jump_entry *iter_start,
-		struct jump_entry *iter_stop, void *start, void *end)
+		struct jump_entry *iter_stop, void *start, void *end, bool init)
 {
 	struct jump_entry *iter;
 
 	iter = iter_start;
 	while (iter < iter_stop) {
-		if (addr_conflict(iter, start, end))
-			return 1;
+		if (init || !jump_entry_is_init(iter)) {
+			if (addr_conflict(iter, start, end))
+				return 1;
+		}
 		iter++;
 	}
 
@@ -561,7 +563,7 @@ static int __jump_label_mod_text_reserve
 
 	ret = __jump_label_text_reserved(mod->jump_entries,
 				mod->jump_entries + mod->num_jump_entries,
-				start, end);
+				start, end, mod->state == MODULE_STATE_COMING);
 
 	module_put(mod);
 
@@ -786,8 +788,9 @@ early_initcall(jump_label_init_module);
  */
 int jump_label_text_reserved(void *start, void *end)
 {
+	bool init = system_state < SYSTEM_RUNNING;
 	int ret = __jump_label_text_reserved(__start___jump_table,
-			__stop___jump_table, start, end);
+			__stop___jump_table, start, end, init);
 
 	if (ret)
 		return ret;


