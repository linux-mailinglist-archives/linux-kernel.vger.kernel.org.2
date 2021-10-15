Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85CE42FDED
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 00:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243317AbhJOWN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 18:13:56 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:41370 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243322AbhJOWNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 18:13:48 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:44566)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mbVQR-002qU4-4e; Fri, 15 Oct 2021 16:11:39 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47268 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mbVQO-00Gjfh-QR; Fri, 15 Oct 2021 16:11:38 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Rune Kleveland <rune.kleveland@infomedia.dk>
Cc:     Yu Zhao <yuzhao@google.com>, Alexey Gladkov <legion@kernel.org>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        containers@lists.linux-foundation.org
References: <1M9_d6wrcu6rdPe1ON0_k0lOxJMyyot3KAb1gdyuwzDPC777XVUWPHoTCEVmcK3fYfgu7sIo3PSaLe9KulUdm4TWVuqlbKyYGxRAjsf_Cpk=@protonmail.ch>
        <87ee9pa6xw.fsf@disp2133>
        <OJK-F2NSBlem52GqvCQYzaVxs2x9Csq3qO4QbTG4A4UUNaQpebpAQmyyKzUd70CIo27C4K7CL3bhIzcxulIzYMu067QOMXCFz8ejh3ZtFhE=@protonmail.ch>
        <U6ByMUZ9LgvxXX6eb0M9aBx8cw8GpgE1qU22LaxaJ_2bOdnGLLJHDgnLL-6cJT7dKdcG_Ms37APSutc3EIMmtpgpP_2kotVLCNRoUq-wTJ8=@protonmail.ch>
        <878rzw77i3.fsf@disp2133>
        <o3tuBB58KUQjyQsALqWi0s1tSPlgVPST4PNNjHewIgRB7CUOOVyFSFxSBLCOJdUH3ly21cIjBthNyqQGnDgJD7fjU8NiVHq7i0JcMvYuzUA=@protonmail.ch>
        <20210929173611.fo5traia77o63gpw@example.org>
        <hPgvCJ2KbKeauk78uWJEsuKJ5VfMqknPJ_oyOZe6M78-6eG7qnj0t0UKC-joPVowo_nOikIsEWP-ZDioARfI-Cl6zrHjCHPJST3drpi5ALE=@protonmail.ch>
        <20210930130640.wudkpmn3cmah2cjz@example.org>
        <CAOUHufZmAjuKyRcmq6GH8dfdZxchykS=BTZDsk-gDAh3LJTe1Q@mail.gmail.com>
        <878rz8wwb6.fsf@disp2133> <87v92cvhbf.fsf@disp2133>
        <ccbccf82-dc50-00b2-1cfd-3da5e2c81dbf@infomedia.dk>
Date:   Fri, 15 Oct 2021 17:10:58 -0500
In-Reply-To: <ccbccf82-dc50-00b2-1cfd-3da5e2c81dbf@infomedia.dk> (Rune
        Kleveland's message of "Sun, 10 Oct 2021 10:59:10 +0200")
Message-ID: <87mtnavszx.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mbVQO-00Gjfh-QR;;;mid=<87mtnavszx.fsf_-_@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/UyOiU0KmRrKw/e3bqzd52ydXHDbwubbA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Rune Kleveland <rune.kleveland@infomedia.dk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1634 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 10 (0.6%), b_tie_ro: 8 (0.5%), parse: 2.0 (0.1%),
        extract_message_metadata: 22 (1.3%), get_uri_detail_list: 5 (0.3%),
        tests_pri_-1000: 14 (0.9%), tests_pri_-950: 1.49 (0.1%),
        tests_pri_-900: 1.12 (0.1%), tests_pri_-90: 64 (3.9%), check_bayes: 63
        (3.8%), b_tokenize: 11 (0.7%), b_tok_get_all: 9 (0.6%), b_comp_prob:
        2.6 (0.2%), b_tok_touch_all: 36 (2.2%), b_finish: 0.87 (0.1%),
        tests_pri_0: 1500 (91.8%), check_dkim_signature: 0.74 (0.0%),
        check_dkim_adsp: 3.0 (0.2%), poll_dns_idle: 1.21 (0.1%), tests_pri_10:
        2.3 (0.1%), tests_pri_500: 11 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: [CFT][PATCH] ucounts: Fix signal ucount refcounting
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In commit fda31c50292a ("signal: avoid double atomic counter
increments for user accounting") Linus made a clever optimization to
how rlimits and the struct user_struct.  Unfortunately that
optimization does not work in the obvious way when moved to nested
rlimits.  The problem is that the last decrement of the per user
namespace per user sigpending counter might also be the last decrement
of the sigpending counter in the parent user namespace as well.  Which
means that simply freeing the leaf ucount in __free_sigqueue is not
enough.

Maintain the optimization and handle the tricky cases by introducing
inc_rlimit_get_ucounts and dec_rlimit_put_ucounts.

By moving the entire optimization into functions that perform all of
the work it becomes possible to ensure that every level is handled
properly.

I wish we had a single user across all of the threads whose rlimit
could be charged so we did not need this complexity.

Cc: stable@vger.kernel.org
Fixes: d64696905554 ("Reimplement RLIMIT_SIGPENDING on top of ucounts")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

With a lot of help from Alex who found a way I could reproduce this
I believe I have found the issue.

Could people who are seeing this issue test and verify this solves the
problem for them?

 include/linux/user_namespace.h |  2 ++
 kernel/signal.c                | 25 +++++----------------
 kernel/ucount.c                | 41 ++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index eb70cabe6e7f..33a4240e6a6f 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -127,6 +127,8 @@ static inline long get_ucounts_value(struct ucounts *ucounts, enum ucount_type t
 
 long inc_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v);
 bool dec_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v);
+long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type);
+void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum ucount_type type);
 bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsigned long max);
 
 static inline void set_rlimit_ucount_max(struct user_namespace *ns,
diff --git a/kernel/signal.c b/kernel/signal.c
index a3229add4455..762de58c6e76 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -425,22 +425,10 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
 	 */
 	rcu_read_lock();
 	ucounts = task_ucounts(t);
-	sigpending = inc_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING, 1);
-	switch (sigpending) {
-	case 1:
-		if (likely(get_ucounts(ucounts)))
-			break;
-		fallthrough;
-	case LONG_MAX:
-		/*
-		 * we need to decrease the ucount in the userns tree on any
-		 * failure to avoid counts leaking.
-		 */
-		dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING, 1);
-		rcu_read_unlock();
-		return NULL;
-	}
+	sigpending = inc_rlimit_get_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING);
 	rcu_read_unlock();
+	if (sigpending == LONG_MAX)
+		return NULL;
 
 	if (override_rlimit || likely(sigpending <= task_rlimit(t, RLIMIT_SIGPENDING))) {
 		q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
@@ -449,8 +437,7 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
 	}
 
 	if (unlikely(q == NULL)) {
-		if (dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING, 1))
-			put_ucounts(ucounts);
+		dec_rlimit_put_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING);
 	} else {
 		INIT_LIST_HEAD(&q->list);
 		q->flags = sigqueue_flags;
@@ -463,8 +450,8 @@ static void __sigqueue_free(struct sigqueue *q)
 {
 	if (q->flags & SIGQUEUE_PREALLOC)
 		return;
-	if (q->ucounts && dec_rlimit_ucounts(q->ucounts, UCOUNT_RLIMIT_SIGPENDING, 1)) {
-		put_ucounts(q->ucounts);
+	if (q->ucounts) {
+		dec_rlimit_put_ucounts(q->ucounts, UCOUNT_RLIMIT_SIGPENDING);
 		q->ucounts = NULL;
 	}
 	kmem_cache_free(sigqueue_cachep, q);
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 3b7e176cf7a2..687d77aa66bb 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -285,6 +285,47 @@ bool dec_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v)
 	return (new == 0);
 }
 
+static void do_dec_rlimit_put_ucounts(struct ucounts *ucounts,
+				struct ucounts *last, enum ucount_type type)
+{
+	struct ucounts *iter;
+	for (iter = ucounts; iter != last; iter = iter->ns->ucounts) {
+		long dec = atomic_long_add_return(-1, &iter->ucount[type]);
+		WARN_ON_ONCE(dec < 0);
+		if (dec == 0)
+			put_ucounts(iter);
+	}
+}
+
+void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum ucount_type type)
+{
+	do_dec_rlimit_put_ucounts(ucounts, NULL, type);
+}
+
+long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type)
+{
+	struct ucounts *iter;
+	long dec, ret = 0;
+
+	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
+		long max = READ_ONCE(iter->ns->ucount_max[type]);
+		long new = atomic_long_add_return(1, &iter->ucount[type]);
+		if (new < 0 || new > max)
+			goto unwind;
+		else if (iter == ucounts)
+			ret = new;
+		if ((new == 1) && (get_ucounts(iter) != iter))
+			goto dec_unwind;
+	}
+	return ret;
+dec_unwind:
+	dec = atomic_long_add_return(1, &iter->ucount[type]);
+	WARN_ON_ONCE(dec < 0);
+unwind:
+	do_dec_rlimit_put_ucounts(ucounts, iter, type);
+	return LONG_MAX;
+}
+
 bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsigned long max)
 {
 	struct ucounts *iter;
-- 
2.20.1

