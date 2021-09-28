Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83AA741AACF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 10:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239644AbhI1IpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 04:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239663AbhI1Ioy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 04:44:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3A2C06176A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 01:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=eTC41Dciw+atEx2D/mtSX7+EA6/J/qz+ZjxjLSahKMU=; b=K066j2D+nXndqq8N5exOgmtQN6
        VEY5KhA/5GaQLfK20vmTnu6kK/E6FthMbXRTMvT342wh5ohTGRqeOywIQ7wKxS9x47norImwmVv2M
        F/1QFdoykAarZFTgdyrQt5WHHh0W3qWFkQRC9wYxO//LN0QxJLWvWVimk82/rbKOC9hHOp2SDlkz+
        mRyUo4CqKUFiSJCnYyR/mE3HEnxjbfPZNVkaz8baRa+y4al/USToXCVO9N/znjojO0KCcrjIRo+vU
        kNU5Vsj1HKvSWVbRqvwIbqe7z+EzMeyQaNe1iqri/+OBNSH4uhR0kVODqcqAV9lbVTXCpbjFKJYY4
        ZzQ8WGTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mV8hW-006S9k-0N; Tue, 28 Sep 2021 08:42:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 400F030087D;
        Tue, 28 Sep 2021 10:42:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CCBA92C2FF133; Tue, 28 Sep 2021 10:42:55 +0200 (CEST)
Message-ID: <20210928084218.063371959@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 28 Sep 2021 10:40:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     paulmck@kernel.org, tglx@linutronix.de, sfr@canb.auug.org.au
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 3/3] sched: Always inline is_percpu_thread()
References: <20210928084020.819856223@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  vmlinux.o: warning: objtool: check_preemption_disabled()+0x81: call to is_percpu_thread() leaves .noinstr.text section

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1730,7 +1730,7 @@ extern struct pid *cad_pid;
 #define tsk_used_math(p)			((p)->flags & PF_USED_MATH)
 #define used_math()				tsk_used_math(current)
 
-static inline bool is_percpu_thread(void)
+static __always_inline bool is_percpu_thread(void)
 {
 #ifdef CONFIG_SMP
 	return (current->flags & PF_NO_SETAFFINITY) &&


