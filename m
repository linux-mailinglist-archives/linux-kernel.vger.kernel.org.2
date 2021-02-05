Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FD1311728
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhBEXdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbhBEOWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:22:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0323BC061225
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 07:47:41 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612539942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zZFsX6vz/JnEik3OiWf55qYmEOWIraRnD0UqUzEqWqo=;
        b=qCJfwtg8/Gj9LUjSo4664j+UYF9sdTsdRIKudrpOhrUAaUvkPMcsW80LJdkoN0+8WvkTT7
        KKUph2CNu/PZ0afk3ZOSiyaQrogp85i3+T7CFruAG0sEF9i75bE4X+JKbSZsqB3MIdU88+
        Sdk8xJkvWZ0dMZ0u/PdSWPhPLoybIbjcUsmnK4TaU6H2KaYr4J7RkoKV8lgq85ZHeeJ+7f
        FV7T+D3rNhhu1WwGYozskaeRKO7ZhRd6t6UprMWhu//gMy/glQfkl/axGfkPbGsk7GgcRY
        w/mX225VB1ofOEszwaqMJhIc5oV/O0lZdjIk9nTS7ETt/hXTgfrwxyYl0Z9quA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612539942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zZFsX6vz/JnEik3OiWf55qYmEOWIraRnD0UqUzEqWqo=;
        b=OGUZgCPiXeEvia+qYoPilbqzJQlcFa7hb/ZrJl21052E6hVPAtGbOEAUUlN6zP4U7b4Mvj
        fZrBepQMTBSAgzAw==
To:     Mikael Beckius <mikael.beckius@windriver.com>,
        linux-kernel@vger.kernel.org
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH] hrtimer: Interrupt storm on clock_settime
In-Reply-To: <20210128140208.30264-1-mikael.beckius@windriver.com>
References: <20210128140208.30264-1-mikael.beckius@windriver.com>
Date:   Fri, 05 Feb 2021 16:45:42 +0100
Message-ID: <87r1lu8qmx.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28 2021 at 15:02, Mikael Beckius wrote:

> During clock_settime absolute realtime timers may get updated to expire
> sooner in absolute monotonic time but if hrtimer_force_reprogram is
> called as part of a clock_settime and the next hard hrtimer expires
> before the next soft hrtimer softirq_expires_next will not be updated
> to reflect this change (assuming the realtime timer is a soft timer).
>
> This means that if the next soft hrtimer expires before
> softirq_expires_next but after now no soft hrtimer interrupt will be
> raised in hrtimer_interrupt which will instead retry tick_program_event
> three times before forcing a tick_program_event using a very short delay
> entering hrtimer_interrupt again almost immediately repeating the
> process over and over again until now exceeds softirq_expires_next and a
> soft hrtimer interrupt is finally raised.

Duh.

> This patch aims to solve this by always updating softirq_expires_next if
> a soft hrtimer exists.

  git grep 'This patch' Documentation/process/

> Signed-off-by: Mikael Beckius <mikael.beckius@windriver.com>
> ---
>  kernel/time/hrtimer.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 743c852e10f2..e4c233f404b1 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -633,7 +633,7 @@ hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal)
>  	 */
>  	expires_next = __hrtimer_get_next_event(cpu_base, HRTIMER_ACTIVE_ALL);
>  
> -	if (cpu_base->next_timer && cpu_base->next_timer->is_soft) {
> +	if (cpu_base->softirq_next_timer) {

>  		/*
>  		 * When the softirq is activated, hrtimer has to be
>  		 * programmed with the first hard hrtimer because soft
> @@ -643,7 +643,8 @@ hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal)
>  			expires_next = __hrtimer_get_next_event(cpu_base,
>  								HRTIMER_ACTIVE_HARD);
>  		else
> -			cpu_base->softirq_expires_next = expires_next;
> +			cpu_base->softirq_expires_next = __hrtimer_get_next_event(cpu_base,
> +								HRTIMER_ACTIVE_SOFT);

That works, but we can spare the double scan completely and make the
code understandable. See below.

Thanks,

        tglx
---

--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -626,26 +626,25 @@ static inline int hrtimer_hres_active(vo
 static void
 hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal)
 {
-	ktime_t expires_next;
+	ktime_t expires_next, soft = KTIME_MAX;
 
 	/*
-	 * Find the current next expiration time.
+	 * If soft interrupt has already been activated, ignore the soft
+	 * base. It will be handled in the already raised soft interrupt.
 	 */
-	expires_next = __hrtimer_get_next_event(cpu_base, HRTIMER_ACTIVE_ALL);
-
-	if (cpu_base->next_timer && cpu_base->next_timer->is_soft) {
+	if (!cpu_base->softirq_activated) {
+		soft = __hrtimer_get_next_event(cpu_base, HRTIMER_ACTIVE_SOFT);
 		/*
-		 * When the softirq is activated, hrtimer has to be
-		 * programmed with the first hard hrtimer because soft
-		 * timer interrupt could occur too late.
+		 * Update the soft expiry time. clock_settime() might have
+		 * affected it.
 		 */
-		if (cpu_base->softirq_activated)
-			expires_next = __hrtimer_get_next_event(cpu_base,
-								HRTIMER_ACTIVE_HARD);
-		else
-			cpu_base->softirq_expires_next = expires_next;
+		cpu_base->softirq_expires_next = soft;
 	}
 
+	expires_next = __hrtimer_get_next_event(cpu_base, HRTIMER_ACTIVE_HARD);
+	if (expires_next > soft)
+		expires_next = soft;
+
 	if (skip_equal && expires_next == cpu_base->expires_next)
 		return;
 
