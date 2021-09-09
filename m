Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B394048E3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 13:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhIILGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 07:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbhIILGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 07:06:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2EAC061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 04:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=n7MfvQfkc8IHK2SZtJyQnXd+yYxaPfJ2/OdEDsKm340=; b=IKMS6WLg3BsXaPf6lWGKO3lJeE
        18gZ1uA1IuMJ1ZjISfYkcoeNDVetI0hHNGImuNCxCHtC3waNokglzWXgNpAYrjqkF2sJEx4XgG7H1
        ukAnTR8rOOSIHGrdn2H1CadZYkcixpr6rLV8NLoAGlPxofww6SCxvYMSUFVPsAVZs4XMU5n3DsUjb
        OSJAOGI1YBgio/QRF6h1rRlYmPfz3xCQZRkcw0cEBy+cklrxps4Nu1QnooWTuTFdaM/yoR3Mt/ail
        TiH/6eQ6syVivK5lUkfxdLGUfXr5g3y6dwavMnsB46VtxsbOZvI2CnpFVmPF6FFXBJNL0/xroyH4Z
        3/NuQxng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOHqF-009kDQ-DS; Thu, 09 Sep 2021 11:03:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CFEA83000DD;
        Thu,  9 Sep 2021 13:03:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B396D2C3CBEEF; Thu,  9 Sep 2021 13:03:37 +0200 (CEST)
Message-ID: <20210909110203.828203010@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 09 Sep 2021 12:59:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 2/4] locking/rwbase: Properly match set_and_save_state() to restore_state()
References: <20210909105915.757320973@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed while looking at the readers race.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/rwbase_rt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -220,7 +220,7 @@ static int __sched rwbase_write_lock(str
 	for (; atomic_read(&rwb->readers);) {
 		/* Optimized out for rwlocks */
 		if (rwbase_signal_pending_state(state, current)) {
-			__set_current_state(TASK_RUNNING);
+			rwbase_restore_current_state();
 			__rwbase_write_unlock(rwb, 0, flags);
 			return -EINTR;
 		}


