Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B153404C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhCRLix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhCRLih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:38:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7F8C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 04:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=B6pDy1MhJrDJ348LIIfTk47eT8mFDOWozuiEPckQahU=; b=jaB53aOvlgoCbTedDN5hhhLwxg
        ImC+IN+Njx9ybEjgIXkGFfHKZkpn242qJxYj/7zu7c2Fp9t/UshujJrSN0Q+5MGGlYAKILWnF1rOr
        CZ+TtUf5C+RW1PHF4SHl4hXJJ2sGa4ISH/9wULAFl3P+kLPhjglnc+mQcn4zgrmRz9KtTFYHkkEws
        NyTdMgJxFIVzBO7tZTcrShHsRZ2YK0dOGVISOpUdCwQ6YCNPZRDKmWEk8vPIkP5MuqZv5dqUYkTBC
        W/k1ZSkn/p1NCIT5uYucUNDq5zQivw+ZJO7TJzRsToT93Oc2qt4isuuS6yRyRTIhV7g2XJy6ufQ6H
        DywdfB2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMqyp-005774-CK; Thu, 18 Mar 2021 11:38:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E61983060F3;
        Thu, 18 Mar 2021 12:38:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C960C201960CD; Thu, 18 Mar 2021 12:38:17 +0100 (CET)
Message-ID: <20210318113610.636651340@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Mar 2021 12:31:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        sumit.garg@linaro.org, oliver.sang@intel.com, jarkko@kernel.org
Subject: [PATCH 2/3] static_call: Align static_call_is_init() patching condition
References: <20210318113156.407406787@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intent is to avoid writing init code after init (because the text
might have been freed). The code is needlessly different between
jump_label and static_call and not obviously correct.

The existing code relies on the fact that the module loader clears the
init layout, such that within_module_init() always fails, while
jump_label relies on the module state which is more obvious and
matches the kernel logic.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/static_call.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -149,6 +149,7 @@ void __static_call_update(struct static_
 	};
 
 	for (site_mod = &first; site_mod; site_mod = site_mod->next) {
+		bool init = system_state < SYSTEM_RUNNING;
 		struct module *mod = site_mod->mod;
 
 		if (!site_mod->sites) {
@@ -168,6 +169,7 @@ void __static_call_update(struct static_
 		if (mod) {
 			stop = mod->static_call_sites +
 			       mod->num_static_call_sites;
+			init = mod->state == MODULE_STATE_COMING;
 		}
 #endif
 
@@ -175,16 +177,8 @@ void __static_call_update(struct static_
 		     site < stop && static_call_key(site) == key; site++) {
 			void *site_addr = static_call_addr(site);
 
-			if (static_call_is_init(site)) {
-				/*
-				 * Don't write to call sites which were in
-				 * initmem and have since been freed.
-				 */
-				if (!mod && system_state >= SYSTEM_RUNNING)
-					continue;
-				if (mod && !within_module_init((unsigned long)site_addr, mod))
-					continue;
-			}
+			if (!init && static_call_is_init(site))
+				continue;
 
 			if (!kernel_text_address((unsigned long)site_addr)) {
 				WARN_ONCE(1, "can't patch static call site at %pS",


