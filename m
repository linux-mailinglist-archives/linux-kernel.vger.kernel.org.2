Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC68364A0C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 20:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241096AbhDSSrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 14:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhDSSrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 14:47:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E865C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 11:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fibG0vpbii9Ivs6Gs0ea/QNMyUGprQ7QSnQOApj2WM4=; b=B/Uw02MbJTvidnKFUVyQWsfnKf
        aE8oG91QWy1H33PISIlh505qdyIO66rXCGTJmpHBOEOjX5dz5tpwttokIWVTGTOCOddEjA4a77Dkx
        rIxvduTZZjz059dWOGdpH7SIC1uEJileuizQ4jvX0wzrjPK5tDU4eYBROyHm7N9w9jw//GOvTskRD
        qC46r/Rr4ksUWfwZrBMZ9ruyfZzPtYnrCpIsWlmqILanu67kfG743irro840jsNkDO6e2jw0Bze3M
        6MfvWDTxT/He6nwGIIn1+vcZfJmau3fVZXdWovvgQ/8nbeQqmyqVxPEIbzMG9yqQa+4lY/tZg8s89
        QcBsGhFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYYuA-00E9Uz-Kk; Mon, 19 Apr 2021 18:46:06 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5EE9B980D8D; Mon, 19 Apr 2021 20:45:53 +0200 (CEST)
Date:   Mon, 19 Apr 2021 20:45:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     syzbot <syzbot+9362b31a2e0cad8b749d@syzkaller.appspotmail.com>,
        bp@alien8.de, dwmw@amazon.co.uk, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [syzbot] WARNING in kthread_is_per_cpu
Message-ID: <20210419184553.GA26214@worktop.programming.kicks-ass.net>
References: <000000000000a61f7705c050e601@google.com>
 <87im4ilddh.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87im4ilddh.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 12:31:22PM +0100, Valentin Schneider wrote:

>   if ((p->flags & PF_KTHREAD) && kthread_is_per_cpu(p))
>                                  `\
>                                    to_kthread(p);
>                                     `\
>                                       WARN_ON(!(p->flags & PF_KTHREAD));
> 
> ... Huh?

Something like so perhaps?

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 1578973c5740..eeba40df61ac 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -78,6 +78,14 @@ static inline void set_kthread_struct(void *kthread)
 	current->set_child_tid = (__force void __user *)kthread;
 }
 
+static inline struct kthread *__to_kthread(struct task_struct *k)
+{
+	void *kthread = (__force void *)k->set_child_tid;
+	if (kthread && !(k->flags & PF_KTHREAD))
+		kthread = NULL;
+	return kthread;
+}
+
 static inline struct kthread *to_kthread(struct task_struct *k)
 {
 	WARN_ON(!(k->flags & PF_KTHREAD));
@@ -516,7 +524,7 @@ void kthread_set_per_cpu(struct task_struct *k, int cpu)
 
 bool kthread_is_per_cpu(struct task_struct *k)
 {
-	struct kthread *kthread = to_kthread(k);
+	struct kthread *kthread = __to_kthread(k);
 	if (!kthread)
 		return false;
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3384ea74cad4..dc6311bd6986 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7658,7 +7658,7 @@ static void balance_push(struct rq *rq)
 	 * histerical raisins.
 	 */
 	if (rq->idle == push_task ||
-	    ((push_task->flags & PF_KTHREAD) && kthread_is_per_cpu(push_task)) ||
+	    kthread_is_per_cpu(push_task) ||
 	    is_migration_disabled(push_task)) {
 
 		/*
