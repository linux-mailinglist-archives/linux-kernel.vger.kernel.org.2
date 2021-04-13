Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D08E35DAC0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 11:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245253AbhDMJKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 05:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245225AbhDMJKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 05:10:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA703C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 02:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TpSegu5ukV9h/7OusCI/ddyVjJ+hBkJODpF1DL5nw+E=; b=qlidBnat5haGVHnoazCvaY1G9u
        ikK2WuM83R5BKZiRBMtPDF7K8S9QEk1K69xSZTvlCnl45pu38BwfYxUnkwx9z3gInFdCIkoda230z
        Ny0YlvOM2T6okfzdSixI5lNKvLM9uCu+SoA5nC1f6FQjZcPX3nbwev4fYIiwrPQMC10bzzm1qH43E
        mylLOYBWFe6Y4g1Q6cm7hu/mWdCua1TrHyQyNt2/o8d9VsFK9D0nSUc3nIj5Boy/wu022HmsuBSYb
        SHMo7BjvTHSGLviPGUYQ+Eut780QO77CMMA3Y+UgZCxbPqgQNYWATPRwK6KSMxBJGKbgXAJ9VRK6k
        VeHclMQQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWF3p-008f7v-LG; Tue, 13 Apr 2021 09:10:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8C09A3001F6;
        Tue, 13 Apr 2021 11:10:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D9022C4C6406; Tue, 13 Apr 2021 11:10:16 +0200 (CEST)
Date:   Tue, 13 Apr 2021 11:10:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arjun Roy <arjunroy@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH 3/3] rseq: optimise for 64bit arches
Message-ID: <YHVf+F3sKlWyZags@hirez.programming.kicks-ass.net>
References: <20210413073657.2308450-1-eric.dumazet@gmail.com>
 <20210413073657.2308450-4-eric.dumazet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413073657.2308450-4-eric.dumazet@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 12:36:57AM -0700, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> Commit ec9c82e03a74 ("rseq: uapi: Declare rseq_cs field as union,
> update includes") added regressions for our servers.
> 
> Using copy_from_user() and clear_user() for 64bit values
> on 64bit arches is suboptimal.
> 
> We might revisit this patch once all 32bit arches support
> get_user() and/or put_user() for 8 bytes values.

Argh, what a mess :/ afaict only nios32 lacks put_user_8, but get_user_8
is missing in a fair number of archs.

That said; 32bit archs never have to actually set the top bits in that
word, so they _could_ only set the low 32 bits. That works provided
userspace itself keeps the high bits clear.

So I suppose that if we're going to #ifdef this, we might as well do the
whole thing.

Mathieu; did I forget a reason why this cannot work?

diff --git a/kernel/rseq.c b/kernel/rseq.c
index a4f86a9d6937..94006190b8eb 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -115,20 +115,25 @@ static int rseq_reset_rseq_cpu_id(struct task_struct *t)
 static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 {
 	struct rseq_cs __user *urseq_cs;
-	u64 ptr;
+	unsigned long ptr;
 	u32 __user *usig;
 	u32 sig;
 	int ret;
 
-	if (copy_from_user(&ptr, &t->rseq->rseq_cs.ptr64, sizeof(ptr)))
+#ifdef CONFIG_64BIT
+	if (get_user(ptr, &t->rseq->rseq_cs.ptr64))
 		return -EFAULT;
+#else
+	if (get_user(ptr, &t->rseq->rseq_cs.ptr32))
+		return -EFAULT;
+#endif
 	if (!ptr) {
 		memset(rseq_cs, 0, sizeof(*rseq_cs));
 		return 0;
 	}
 	if (ptr >= TASK_SIZE)
 		return -EINVAL;
-	urseq_cs = (struct rseq_cs __user *)(unsigned long)ptr;
+	urseq_cs = (struct rseq_cs __user *)ptr;
 	if (copy_from_user(rseq_cs, urseq_cs, sizeof(*rseq_cs)))
 		return -EFAULT;
 
