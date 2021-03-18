Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAE73404C8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhCRLiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhCRLii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:38:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F91C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 04:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=YuvG3cz05uZSMPUFps50wo3S++lE7MTbfn9IxuG7nTg=; b=Hy1BTWa6+m1k2bVkAwwt7piOKe
        Uwr28Lrf6Dktt4CQ6dPFORGPLE5wxnLM9YP/8Tm5k5DG/nJG3iehD3Tx2m1wG+GX7t7Nj/DGYNq7z
        lpsuambn5wHvoougZYHpM38lejrRslIj/RQOtoXrvAumheQXTGwZ9bN9cQ30yfwjIuxbXdoxIQSYp
        6QtijkdTcrR/ztLgGeJenJvZ6KOpPYbgNvildPlx3FV30RUCZllJoXjKZgSJkA3a1xu9lMzSAFFpt
        1Nq41GDtqEPZvfuNrWhAYj83Zv/VdobnqVohQEtUN8EMLapo7xHjpt+BHP0c6HzPu58JqlFfDAo9k
        3KMXGqig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMqyp-005775-CY; Thu, 18 Mar 2021 11:38:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DDB3E3012DF;
        Thu, 18 Mar 2021 12:38:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C1FC520283BA9; Thu, 18 Mar 2021 12:38:17 +0100 (CET)
Message-ID: <20210318113610.519406371@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Mar 2021 12:31:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        sumit.garg@linaro.org, oliver.sang@intel.com, jarkko@kernel.org
Subject: [PATCH 1/3] static_call: Fix static_call_set_init()
References: <20210318113156.407406787@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that static_call_set_init() does not preserve the other
flags; IOW. it clears TAIL if it was set.

Fixes: 9183c3f9ed710 ("static_call: Add inline static call infrastructure")
Reported-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/static_call.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -35,27 +35,30 @@ static inline void *static_call_addr(str
 	return (void *)((long)site->addr + (long)&site->addr);
 }
 
+static inline unsigned long __static_call_key(const struct static_call_site *site)
+{
+	return (long)site->key + (long)&site->key;
+}
 
 static inline struct static_call_key *static_call_key(const struct static_call_site *site)
 {
-	return (struct static_call_key *)
-		(((long)site->key + (long)&site->key) & ~STATIC_CALL_SITE_FLAGS);
+	return (void *)(__static_call_key(site) & ~STATIC_CALL_SITE_FLAGS);
 }
 
 /* These assume the key is word-aligned. */
 static inline bool static_call_is_init(struct static_call_site *site)
 {
-	return ((long)site->key + (long)&site->key) & STATIC_CALL_SITE_INIT;
+	return __static_call_key(site) & STATIC_CALL_SITE_INIT;
 }
 
 static inline bool static_call_is_tail(struct static_call_site *site)
 {
-	return ((long)site->key + (long)&site->key) & STATIC_CALL_SITE_TAIL;
+	return __static_call_key(site) & STATIC_CALL_SITE_TAIL;
 }
 
 static inline void static_call_set_init(struct static_call_site *site)
 {
-	site->key = ((long)static_call_key(site) | STATIC_CALL_SITE_INIT) -
+	site->key = (__static_call_key(site) | STATIC_CALL_SITE_INIT) -
 		    (long)&site->key;
 }
 
@@ -190,7 +193,7 @@ void __static_call_update(struct static_
 			}
 
 			arch_static_call_transform(site_addr, NULL, func,
-				static_call_is_tail(site));
+						   static_call_is_tail(site));
 		}
 	}
 
@@ -349,7 +352,7 @@ static int static_call_add_module(struct
 	struct static_call_site *site;
 
 	for (site = start; site != stop; site++) {
-		unsigned long s_key = (long)site->key + (long)&site->key;
+		unsigned long s_key = __static_call_key(site);
 		unsigned long addr = s_key & ~STATIC_CALL_SITE_FLAGS;
 		unsigned long key;
 


