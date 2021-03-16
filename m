Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B02033D5CC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 15:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbhCPOcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 10:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236542AbhCPObx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 10:31:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7419C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 07:31:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615905111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=awxuuWV5rzMg1ETs3GFZYd3MQc31waUDNLde1cS3dpU=;
        b=4EIkCQX8nkC3NEnPxDommkEVEeqEsSoL24LUQUm4NkUSB/XZylkvj16O4wIfSw2ZEUCEdI
        6OHdsHFHbG5Ur0V3njBTlCK4Z4KHMW9HvkKtR6j+5nthdXL4JhALZu5iFeg3zvVFlGFgCJ
        vQvRkKWWkdvSsnMvUbzWTugMx0FEqtQ7VOKHEPydGcIhXRTWu1NMmX8eov+0fkV+1ywzk0
        78UfHZnCpfdOWrSf1nWlYe624UBJDOiNL5E/YB/arhuDUt6PwpoTB8bc+ZW2rpztTtBi6G
        3Li3nYqsn4N9tBpXInZT3i6o/6kUqsr0BXN63w4wgW8YJGNQB6293LXJUJdxWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615905111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=awxuuWV5rzMg1ETs3GFZYd3MQc31waUDNLde1cS3dpU=;
        b=2p3OE4h4yQG5hmwgOo4oxj3PWYFa7/pDIe+FDBVKs9+zutIBtyRpXkUQsy0OT5hCpBn2Tf
        AHVKPUq6HU3BumDQ==
To:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jiafei Pan <Jiafei.Pan@nxp.com>,
        Romain Perier <romain.perier@gmail.com>
Cc:     Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH] softirq: Be more verbose on t->state BUG()
In-Reply-To: <20210315154421.11463-1-erosca@de.adit-jv.com>
References: <20210315154421.11463-1-erosca@de.adit-jv.com>
Date:   Tue, 16 Mar 2021 15:31:50 +0100
Message-ID: <87k0q7186h.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15 2021 at 16:44, Eugeniu Rosca wrote:
> From: Dirk Behme <dirk.behme@de.bosch.com>
>
> In case this BUG() is hit, it helps debugging a lot to get an idea
> what tasklet is the root cause. So, be slightly more verbose here.
>
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> ---
>  kernel/softirq.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 9908ec4a9bfe..a6b602ad48d6 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -550,9 +550,13 @@ static void tasklet_action_common(struct softirq_action *a,
>  
>  		if (tasklet_trylock(t)) {
>  			if (!atomic_read(&t->count)) {
> -				if (!test_and_clear_bit(TASKLET_STATE_SCHED,
> -							&t->state))
> +				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state)) {
> +					if (t->use_callback)
> +						pr_emerg("tasklet failed, cb: %pS\n", t->callback);
> +					else
> +						pr_emerg("tasklet failed, func: %pS\n", t->func);
>  					BUG();
> +				}
>  				if (t->use_callback)
>  					t->callback(t);
>  				else

This belongs into unreadable land and actually the BUG() should just be
replaced by a WARN_ONCE(). Something like the below. Hmm?

Thanks,

        tglx
---
 
+static bool tasklet_should_run(struct tasklet_struct *t)
+{
+	if (test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
+		return true;
+
+	WARN_ONCE(1, "tasklet SCHED state not set: %s %pS\n",
+		  t->use_callback ? "callback" : "func",
+		  t->use_callback ? (void*)t->callback : (void*)t->func);
+
+	return false;
+}
+
 static void tasklet_action_common(struct softirq_action *a,
 				  struct tasklet_head *tl_head,
 				  unsigned int softirq_nr)
@@ -550,13 +562,12 @@ static void tasklet_action_common(struct
 
 		if (tasklet_trylock(t)) {
 			if (!atomic_read(&t->count)) {
-				if (!test_and_clear_bit(TASKLET_STATE_SCHED,
-							&t->state))
-					BUG();
-				if (t->use_callback)
-					t->callback(t);
-				else
-					t->func(t->data);
+				if (tasklet_should_run(t)) {
+					if (t->use_callback)
+						t->callback(t);
+					else
+						t->func(t->data);
+				}
 				tasklet_unlock(t);
 				continue;
 			}
