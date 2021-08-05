Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE6E3E18B7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242639AbhHEPvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhHEPvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:51:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B130BC061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 08:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=GA9Wl8XAnaVZWe79XE56zBQj2c2DUmDhEABlAFwx8aw=; b=FqwAqcH/fUfn+5Xm46zKZW5e/T
        HorbSikRPxEUVUVXhuhNYRDydbAxAFJfF4s9cP4+d6rncokBwrhn6owajcd7dObkwmsIaHVEEwHBq
        D60Rly3y5Kk+xBqnmLMAC3XH+pc78jn1WxwSdJd65HoyV7Va2gPCR31Qp5x1hUTtTuNklrsL9pJXV
        iEnwru9MtMVW4L2p8BpcG0/ao0V190/dieLm20vMg9JyiCIinZJ7E0/qkw+7t8KQ+vJxKfBu0E09F
        SyGBFvtmmDkhLj3b/OUdXQ8WjIuPl64M7ifj68egZE0iMfYsiyrc/LieJ1yjJ0C9ju16CN80bigTt
        GIFdjBCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBfd5-007FNA-6C; Thu, 05 Aug 2021 15:50:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 72698300084;
        Thu,  5 Aug 2021 17:49:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2F4F52040A33A; Thu,  5 Aug 2021 17:49:54 +0200 (CEST)
Date:   Thu, 5 Aug 2021 17:49:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org, ltykernel@gmail.com
Subject: [PATCH] static_call: Update comment
Message-ID: <YQwIorQBHEq+s73b@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Update the comment with the new features.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/static_call.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index fc94faa53b5b..35d28261b12b 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -17,11 +17,17 @@
  *   DECLARE_STATIC_CALL(name, func);
  *   DEFINE_STATIC_CALL(name, func);
  *   DEFINE_STATIC_CALL_NULL(name, typename);
+ *   DEFINE_STATIC_CALL_RET0(name, typename);
+ *
+ *   __static_call_return0;
+ *
  *   static_call(name)(args...);
  *   static_call_cond(name)(args...);
  *   static_call_update(name, func);
  *   static_call_query(name);
  *
+ *   EXPORT_STATIC_CALL{,_TRAMP}{,_GPL}()
+ *
  * Usage example:
  *
  *   # Start with the following functions (with identical prototypes):
@@ -96,6 +102,33 @@
  *   To query which function is currently set to be called, use:
  *
  *   func = static_call_query(name);
+ *
+ *
+ * DEFINE_STATIC_CALL_RET0 / __static_call_return0:
+ *
+ *   Just like how DEFINE_STATIC_CALL_NULL() / static_call_cond() optimize the
+ *   conditional void function call, DEFINE_STAT_CALL_RET0 /
+ *   __static_call_return0 optimize the do nothing return 0 function.
+ *
+ *   This feature is strictly UB per the C standard (since it casts a function
+ *   pointer to a different signature) and relies on the architecture ABI to
+ *   make things work. In particular it relies on Caller Stack cleanup and the
+ *   whole return register being clobbered for short return values. All normal
+ *   CDECL style ABIs conform.
+ *
+ *   In particular the x86_64 implementation replaces the 5 byte CALL
+ *   instruction at the callsite with a 5 byte clear of the RAX register,
+ *   completely eliding any function call overhead.
+ *
+ *   Notably argument setup is unconditional.
+ *
+ *
+ * EXPORT_STATIC_CALL() vs EXPORT_STATIC_CALL_TRAMP():
+ *
+ *   The difference is that the _TRAMP variant tries to only export the
+ *   trampoline with the result that a module can use static_call{,_cond}() but
+ *   not static_call_update().
+ *
  */
 
 #include <linux/types.h>
