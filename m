Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604AF332A18
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhCIPRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhCIPR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:17:27 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57FFC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 07:17:26 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id b7so20863183edz.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 07:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v+C1g9uPMgIIdVMg7QtuOPo09UD6WnikpExus2Zkdn8=;
        b=I+DQafEaKTAvvtQt9tDhpSFt5UtHs23BytaOkeo1/UQZKbu6CwixjMQbwDVMPUY0Q5
         Rv18G4hjODjobu0s2W/2eYd89qrAJ7LjgfynX+Ws+/q/SawyvaNJ2MUD3x00LHF/TfRe
         dwoAjx3WonMY9K/BtwcBAE6l/yy0zDwRRVY2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v+C1g9uPMgIIdVMg7QtuOPo09UD6WnikpExus2Zkdn8=;
        b=G7Mv09Ed8MwofAKq6CtNBykarhigmNvY51pXo41gLiGaCZdJDsuFTUlURBK1VOAsbS
         w2Z5M2Pu3yCf8RIPGOOtU2YWu7LGjvTsOA5CqVQttEo7yyjTgt86BksXooaf18TEMQPB
         DAWv7cSrltRkKTTfU2TJsYSUCCRSAtjOfOahkgPeO0jCk0NcIT0oGvjZcNnldtw3mdPU
         UWJvI3pr56V0d9DY92r0dHUYdQeF+u2r4plM+xc1oqivQ0FXywb4+Z+RiQHOP1HbGX6a
         CbwywRpVM8fjz4W+m33klzliFjJQKQRD/fOh5RNBoXeyQvzAWGG+nOKb+Qo8YBwKsEW0
         Pp7Q==
X-Gm-Message-State: AOAM533p1qvm8khfnkxJcCiE2rIgunSjynXBG2LTsr063vCuVl46rtam
        V+LLXywxyQfqEiiZ6AvJoLNdOw==
X-Google-Smtp-Source: ABdhPJyeqAgVsR6NsefKlNtEuuXvo7VwDP3mIUlslsB+4ueCpPg5X77Ey3rmcrmyLf2n5YFLKOk/Xg==
X-Received: by 2002:aa7:cc03:: with SMTP id q3mr4746267edt.366.1615303045621;
        Tue, 09 Mar 2021 07:17:25 -0800 (PST)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id v12sm8732217ejh.94.2021.03.09.07.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 07:17:25 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kernel/async.c: stop guarding pr_debug() statements
Date:   Tue,  9 Mar 2021 16:17:22 +0100
Message-Id: <20210309151723.1907838-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's currently nigh impossible to get these pr_debug()s to print
something. Being guarded by initcall_debug means one has to enable
tons of other debug output during boot, and the system_state condition
further means it's impossible to get them when loading modules later.

Also, the compiler can't know that these global conditions do not
change, so there are W=2 warnings

kernel/async.c:125:9: warning: ‘calltime’ may be used uninitialized in this function [-Wmaybe-uninitialized]
kernel/async.c:300:9: warning: ‘starttime’ may be used uninitialized in this function [-Wmaybe-uninitialized]

Make it possible, for a DYNAMIC_DEBUG kernel, to get these to print
their messages by booting with appropriate 'dyndbg="file async.c +p"'
command line argument. For a non-DYNAMIC_DEBUG kernel, pr_debug()
compiles to nothing.

This does cost doing an unconditional ktime_get() for the starttime
value, but the corresponding ktime_get for the end time can be elided
by factoring it into a function which only gets called if the printk()
arguments end up being evaluated.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---

Andrew, this one is of course on top of
https://lore.kernel.org/lkml/20210226124355.2503524-1-linux@rasmusvillemoes.dk/
which you already applied.

 kernel/async.c | 48 ++++++++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/kernel/async.c b/kernel/async.c
index 45a867b8644a..4b5971142922 100644
--- a/kernel/async.c
+++ b/kernel/async.c
@@ -78,6 +78,12 @@ static DECLARE_WAIT_QUEUE_HEAD(async_done);
 
 static atomic_t entry_count;
 
+static long long microseconds_since(ktime_t start)
+{
+	ktime_t now = ktime_get();
+	return ktime_to_ns(ktime_sub(now, start)) >> 10;
+}
+
 static async_cookie_t lowest_in_progress(struct async_domain *domain)
 {
 	struct async_entry *first = NULL;
@@ -111,24 +117,18 @@ static void async_run_entry_fn(struct work_struct *work)
 	struct async_entry *entry =
 		container_of(work, struct async_entry, work);
 	unsigned long flags;
-	ktime_t calltime, delta, rettime;
+	ktime_t calltime;
 
 	/* 1) run (and print duration) */
-	if (initcall_debug && system_state < SYSTEM_RUNNING) {
-		pr_debug("calling  %lli_%pS @ %i\n",
-			(long long)entry->cookie,
-			entry->func, task_pid_nr(current));
-		calltime = ktime_get();
-	}
+	pr_debug("calling  %lli_%pS @ %i\n", (long long)entry->cookie,
+		 entry->func, task_pid_nr(current));
+	calltime = ktime_get();
+
 	entry->func(entry->data, entry->cookie);
-	if (initcall_debug && system_state < SYSTEM_RUNNING) {
-		rettime = ktime_get();
-		delta = ktime_sub(rettime, calltime);
-		pr_debug("initcall %lli_%pS returned after %lld usecs\n",
-			(long long)entry->cookie,
-			entry->func,
-			(long long)ktime_to_ns(delta) >> 10);
-	}
+
+	pr_debug("initcall %lli_%pS returned after %lld usecs\n",
+		 (long long)entry->cookie, entry->func,
+		 microseconds_since(calltime));
 
 	/* 2) remove self from the pending queues */
 	spin_lock_irqsave(&async_lock, flags);
@@ -287,23 +287,15 @@ EXPORT_SYMBOL_GPL(async_synchronize_full_domain);
  */
 void async_synchronize_cookie_domain(async_cookie_t cookie, struct async_domain *domain)
 {
-	ktime_t starttime, delta, endtime;
+	ktime_t starttime;
 
-	if (initcall_debug && system_state < SYSTEM_RUNNING) {
-		pr_debug("async_waiting @ %i\n", task_pid_nr(current));
-		starttime = ktime_get();
-	}
+	pr_debug("async_waiting @ %i\n", task_pid_nr(current));
+	starttime = ktime_get();
 
 	wait_event(async_done, lowest_in_progress(domain) >= cookie);
 
-	if (initcall_debug && system_state < SYSTEM_RUNNING) {
-		endtime = ktime_get();
-		delta = ktime_sub(endtime, starttime);
-
-		pr_debug("async_continuing @ %i after %lli usec\n",
-			task_pid_nr(current),
-			(long long)ktime_to_ns(delta) >> 10);
-	}
+	pr_debug("async_continuing @ %i after %lli usec\n", task_pid_nr(current),
+		 microseconds_since(starttime));
 }
 EXPORT_SYMBOL_GPL(async_synchronize_cookie_domain);
 
-- 
2.29.2

