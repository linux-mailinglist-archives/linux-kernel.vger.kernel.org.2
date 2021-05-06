Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B339D375BEA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbhEFTpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235713AbhEFTox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:44:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC4BC06138A
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 12:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=rlYMRZGazuFxOBC6DEC/CW1aZdoxBofpz85ptrnldiM=; b=MUzkI2cnL+zcwziKK+s3VV2aNB
        AeClJPt5r458zOCoeT1BAPlvAR0Wniq1TJiS5Ulqd+YFW7eHK24PLPmWo+tTsk4ZDMRGAzX+59L68
        s/xLB2EcbI4ORXxaREGro57GXvcancyu+W+5/GctbnH1n9zh9Mw78mHc/eUvh/c3Jn/H4kOzOFUyL
        MUpMa5xUoppuMU9YpsS/l7lAo5DKw1QDgxf4ohxwsW2y6EQjbRZ5UcX2ajwXVaT8bwfg6UafLDj4f
        gHsTongUpuPkg6mORNOLow9NmeUhP4+gqKpgsT0ue3kwd2AQipT5c/pD/Kh7t4806+yo6S0oWQOhd
        J+lGZ0wQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lejtT-002ADG-5P; Thu, 06 May 2021 19:42:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 18A6730035A;
        Thu,  6 May 2021 21:42:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BA99C20B96F8D; Thu,  6 May 2021 21:42:38 +0200 (CEST)
Message-ID: <20210506194157.906893264@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 06 May 2021 21:34:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 08/13] jump_label: Free jump_entry::key bit1 for build use
References: <20210506193352.719596001@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Have jump_label_init() set jump_entry::key bit1 to either 0 ot 1
unconditionally. This makes it available for build-time games.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/jump_label.h |    7 +++++--
 kernel/jump_label.c        |   10 ++++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -171,9 +171,12 @@ static inline bool jump_entry_is_init(co
 	return (unsigned long)entry->key & 2UL;
 }
 
-static inline void jump_entry_set_init(struct jump_entry *entry)
+static inline void jump_entry_set_init(struct jump_entry *entry, bool set)
 {
-	entry->key |= 2;
+	if (set)
+		entry->key |= 2;
+	else
+		entry->key &= ~2;
 }
 
 static inline int jump_entry_size(struct jump_entry *entry)
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -475,13 +475,14 @@ void __init jump_label_init(void)
 
 	for (iter = iter_start; iter < iter_stop; iter++) {
 		struct static_key *iterk;
+		bool in_init;
 
 		/* rewrite NOPs */
 		if (jump_label_type(iter) == JUMP_LABEL_NOP)
 			arch_jump_label_transform_static(iter, JUMP_LABEL_NOP);
 
-		if (init_section_contains((void *)jump_entry_code(iter), 1))
-			jump_entry_set_init(iter);
+		in_init = init_section_contains((void *)jump_entry_code(iter), 1);
+		jump_entry_set_init(iter, in_init);
 
 		iterk = jump_entry_key(iter);
 		if (iterk == key)
@@ -626,9 +627,10 @@ static int jump_label_add_module(struct
 
 	for (iter = iter_start; iter < iter_stop; iter++) {
 		struct static_key *iterk;
+		bool in_init;
 
-		if (within_module_init(jump_entry_code(iter), mod))
-			jump_entry_set_init(iter);
+		in_init = within_module_init(jump_entry_code(iter), mod);
+		jump_entry_set_init(iter, in_init);
 
 		iterk = jump_entry_key(iter);
 		if (iterk == key)


