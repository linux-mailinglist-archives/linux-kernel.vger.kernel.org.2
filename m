Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B59F3B866B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 17:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbhF3Po6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 11:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbhF3Pon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 11:44:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85605C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 08:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=MJgJNvNqGCzim5/Tk7aIo218dDBsf3wkEZBk55hE7vg=; b=RTYFE6XpmKkPzMq1n+tqPi0hHm
        QQEDeIEL550i3pDtaCitx/gwabunnRfLad0raw8EpXXglydN5d2QYQ8Ojf5sOkF9yKEQbYa1eMWAZ
        LNdJQY7XtaRcyXXeZzu2RQVoHM0bKXcN6ySIwwJ4i1DjFAF6yy34ErZUbMMd6fGT3hM3wgT39DKh4
        uhTYPSR8AbxOICBK+/simzVzmkGNuF1heYUeXoYqWcIoU4wA+F/E+oKkOn0IJ+e5BV8xxCQ/kNT8l
        NZ//ugQIeh8vzPuTtqPdU7+hc6SE0f+jF9T2YBSJkg0HcIPXBuerkAisPwaF9SSElb81oxQHDRM/I
        YxRVRvww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lycLn-00DD5a-6N; Wed, 30 Jun 2021 15:42:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4BEC83002D7;
        Wed, 30 Jun 2021 17:42:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3357F2C66CABC; Wed, 30 Jun 2021 17:42:06 +0200 (CEST)
Message-ID: <20210630154114.896786297@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 30 Jun 2021 17:35:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com, longman@redhat.com, boqun.feng@gmail.com,
        will@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        yanfei.xu@windriver.com
Subject: [RFC][PATCH 2/4] locking/mutex: Fix HANDOFF condition
References: <20210630153516.832731403@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yanfei reported that setting HANDOFF should not depend on recomputing
@first, only on @first state. Which would then give:

  if (ww_ctx || !first)
    first = __mutex_waiter_is_first(lock, &waiter);
  if (first)
    __mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);

But because 'ww_ctx || !first' is basically 'always' and the test for
first is relatively cheap, omit that first branch entirely.

Reported-by: Yanfei Xu <yanfei.xu@windriver.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/mutex.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -919,7 +919,6 @@ __mutex_lock_common(struct mutex *lock,
 		    struct ww_acquire_ctx *ww_ctx, const bool use_ww_ctx)
 {
 	struct mutex_waiter waiter;
-	bool first = false;
 	struct ww_mutex *ww;
 	int ret;
 
@@ -998,6 +997,8 @@ __mutex_lock_common(struct mutex *lock,
 
 	set_current_state(state);
 	for (;;) {
+		bool first;
+
 		/*
 		 * Once we hold wait_lock, we're serialized against
 		 * mutex_unlock() handing the lock off to us, do a trylock
@@ -1026,15 +1027,9 @@ __mutex_lock_common(struct mutex *lock,
 		spin_unlock(&lock->wait_lock);
 		schedule_preempt_disabled();
 
-		/*
-		 * ww_mutex needs to always recheck its position since its waiter
-		 * list is not FIFO ordered.
-		 */
-		if (ww_ctx || !first) {
-			first = __mutex_waiter_is_first(lock, &waiter);
-			if (first)
-				__mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
-		}
+		first = __mutex_waiter_is_first(lock, &waiter);
+		if (first)
+			__mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
 
 		set_current_state(state);
 		/*


