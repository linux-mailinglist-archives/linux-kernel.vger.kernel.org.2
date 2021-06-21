Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9373AE8A6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFUMGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhFUMGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:06:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A28AC061760
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=eJiAzP30aADyzX71NczWiAy4jG/zjICZ+p7+/n1+rRM=; b=QAH3ayxuScdewNS8gFvU7F4vhE
        v4u/ErYaEn09Y+yREG8iWW/8KjS7ARqinQvoMn3OA/isDZoCTbstPauzkF5CZP6B6BbBryokpUcZr
        CfnOsmvb6cj2UwXVxeH3SCQpfcTaTdxK1H2MSKYHtgCE0OLYC1CNNcP0khRrrTvE6qwR/85D8YrFc
        U0N1asJNBEluzfjr5XjzLebTy7hvhdZa01kudLEayMYvQTw4ZeIQq7QFjSoIBaDVwjm4xMxT2qHhp
        w+JeM2smgSP1lNpVruDV5TOlBoh0SBAjWersEaaZfQ66FUZ1wcpwrH+ywJUgTSdouSDbxZEDspPrM
        88eMOcPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvIdV-00D3hv-Fp; Mon, 21 Jun 2021 12:02:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A62B0300597;
        Mon, 21 Jun 2021 14:02:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 01A50235EE380; Mon, 21 Jun 2021 14:02:38 +0200 (CEST)
Message-ID: <20210621120120.784404944@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Jun 2021 13:12:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com
Subject: [PATCH 05/18] locking/lockdep: Improve noinstr vs errors
References: <20210621111233.344964031@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Better handle the failure paths.

vmlinux.o: warning: objtool: debug_locks_off()+0x23: call to console_verbose() leaves .noinstr.text section
vmlinux.o: warning: objtool: debug_locks_off()+0x19: call to __kasan_check_write() leaves .noinstr.text section

debug_locks_off+0x19/0x40:
instrument_atomic_write at include/linux/instrumented.h:86
(inlined by) __debug_locks_off at include/linux/debug_locks.h:17
(inlined by) debug_locks_off at lib/debug_locks.c:41

Fixes: 6eebad1ad303 ("lockdep: __always_inline more for noinstr")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
diff --git a/include/linux/debug_locks.h b/include/linux/debug_locks.h
index 2915f56ad421..edb5c186b0b7 100644
--- a/include/linux/debug_locks.h
+++ b/include/linux/debug_locks.h
@@ -27,8 +27,10 @@ extern int debug_locks_off(void);
 	int __ret = 0;							\
 									\
 	if (!oops_in_progress && unlikely(c)) {				\
+		instrumentation_begin();				\
 		if (debug_locks_off() && !debug_locks_silent)		\
 			WARN(1, "DEBUG_LOCKS_WARN_ON(%s)", #c);		\
+		instrumentation_end();					\
 		__ret = 1;						\
 	}								\
 	__ret;								\
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index cb8af6a3e154..6fc60d363d26 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -843,7 +843,7 @@ static int count_matching_names(struct lock_class *new_class)
 }
 
 /* used from NMI context -- must be lockless */
-static __always_inline struct lock_class *
+static noinstr struct lock_class *
 look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
 {
 	struct lockdep_subclass_key *key;
@@ -851,12 +851,14 @@ look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
 	struct lock_class *class;
 
 	if (unlikely(subclass >= MAX_LOCKDEP_SUBCLASSES)) {
+		instrumentation_begin();
 		debug_locks_off();
 		printk(KERN_ERR
 			"BUG: looking up invalid subclass: %u\n", subclass);
 		printk(KERN_ERR
 			"turning off the locking correctness validator.\n");
 		dump_stack();
+		instrumentation_end();
 		return NULL;
 	}
 
diff --git a/lib/debug_locks.c b/lib/debug_locks.c
index 06d3135bd184..a75ee30b77cb 100644
--- a/lib/debug_locks.c
+++ b/lib/debug_locks.c
@@ -36,7 +36,7 @@ EXPORT_SYMBOL_GPL(debug_locks_silent);
 /*
  * Generic 'turn off all lock debugging' function:
  */
-noinstr int debug_locks_off(void)
+int debug_locks_off(void)
 {
 	if (debug_locks && __debug_locks_off()) {
 		if (!debug_locks_silent) {


