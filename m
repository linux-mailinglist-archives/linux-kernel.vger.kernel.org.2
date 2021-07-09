Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5C13C25A2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 16:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhGIOQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 10:16:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44803 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229548AbhGIOQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 10:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625840008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PkuhaEUod5NWJ0g94zfc/Bhhe9nf73fkAPVspEdS21w=;
        b=VxeFVaV4sNnXdalMjU/LtZ18arEK2yq7zfkCs7tXCWrBO03jgXMDH5QjQCwVpNGtSVjQNG
        Ncxq2maVkZKpPPJEbxj26Tf9yrwO56YwEXf/LS28U1Z6s0WtUvEUsY8PzvUTbQOJuEg8zH
        Lrn+6sctkRG8TcsOcNEseTFpaUmCsp8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-bZsyLWL0OjCS0bOCQFYDyg-1; Fri, 09 Jul 2021 10:13:27 -0400
X-MC-Unique: bZsyLWL0OjCS0bOCQFYDyg-1
Received: by mail-wm1-f72.google.com with SMTP id z127-20020a1c7e850000b02901e46e4d52c0so5246503wmc.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 07:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=PkuhaEUod5NWJ0g94zfc/Bhhe9nf73fkAPVspEdS21w=;
        b=Yd8m+wdSMCXz5sy3Iqtrpz50D4FBzcYfyAQIgMVyV3aVQAmP+ugYPxPoo/UXYFtxpL
         kG/YM9CZS7TAr0+/jgBCo80RIq/wC+7SFUiEHEO5ZGLP/TCd8708WtHMhGMHPjuB4SjY
         jDg8DQp4wMtrK9RRIprYVurmzizAwJdofYpce6ylp99HRPLMbGeGy4WSCT9JaNWYvXEx
         ZZZtraX7irLqcKtmA3B2fu2p+zEDxvsRZEiv0lm6HSRzIWC0yJFacoS2NucY0GjcFQb7
         VQmjC2T/zKu2IHBqmNkFXAmnFjV7VexFlsomWAcD01scx4PIpFAVFi9T6s1y++v1CwJW
         GVKQ==
X-Gm-Message-State: AOAM533ex5QH6o79tw/FRQdBta++VUut2Orgr3pKsWAczRPSi32JU+e7
        mN70xZqW9mU9QiKQQwFKi+ceDXdo2pIIyIuKL2Mia46HSTCb1Bq11/+xV9rUlGGvdmNnaFShlI9
        xR/D5kAZXjTPJsw7UwwZ+enMx
X-Received: by 2002:a5d:46cc:: with SMTP id g12mr40439988wrs.136.1625840006360;
        Fri, 09 Jul 2021 07:13:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9o+o8RdMn5hHCkABeqCjArbWj+uYGLEuQsgahKc22ny6HdGWQmihnkBV5R1LbkRvPehwTFQ==
X-Received: by 2002:a5d:46cc:: with SMTP id g12mr40439972wrs.136.1625840006230;
        Fri, 09 Jul 2021 07:13:26 -0700 (PDT)
Received: from [192.168.1.136] ([79.116.5.179])
        by smtp.gmail.com with ESMTPSA id g10sm5654356wrq.63.2021.07.09.07.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 07:13:26 -0700 (PDT)
Message-ID: <4409fa71931446d9cabd849431ee0098c9b31292.camel@redhat.com>
Subject: [PATCH] timers: Fix get_next_timer_interrupt() with no timers
 pending
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     He Zhe <zhe.he@windriver.com>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     anna-maria@linutronix.de, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Date:   Fri, 09 Jul 2021 16:13:25 +0200
In-Reply-To: <f520c8b87f56fcda0158853c5127f0488918503e.camel@redhat.com>
References: <20200723151641.12236-1-frederic@kernel.org>
         <dfbf752e-91db-b128-76a8-98fde4c5d480@windriver.com>
         <20210708153620.GA6716@lothringen>
         <c7a5015a-2b93-17d2-29bc-cd03e40cc09c@windriver.com>
         <20210709084303.GA17239@lothringen>
         <11e85cd8-40ac-09fe-e1fe-0eafa351072c@windriver.com>
         <f520c8b87f56fcda0158853c5127f0488918503e.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

31cd0e119d50 ("timers: Recalculate next timer interrupt only when
necessary") subtly altered get_next_timer_interrupt()'s behaviour. The
function no longer consistently returns KTIME_MAX with no timers
pending.

In order to decide if there are any timers pending we check whether the
next expiry will happen NEXT_TIMER_MAX_DELTA jiffies from now.
Unfortunately, the next expiry time and the timer base clock are no
longer updated in unison. The former changes upon certain timer
operations (enqueue, expire, detach), whereas the latter keeps track of
jiffies as they move forward. Ultimately breaking the logic above.

A simplified example:

- Upon entering get_next_timer_interrupt() with:

	jiffies = 1
	base->clk = 0;
	base->next_expiry = NEXT_TIMER_MAX_DELTA;

  'base->next_expiry == base->clk + NEXT_TIMER_MAX_DELTA', the function
  returns KTIME_MAX.

- 'base->clk' is updated to the jiffies value.

- The next time we enter get_next_timer_interrupt(), taking into account
  no timer operations happened:

	base->clk = 1;
	base->next_expiry = NEXT_TIMER_MAX_DELTA;

  'base->next_expiry != base->clk + NEXT_TIMER_MAX_DELTA', the function
  returns a valid expire time, which is incorrect.

This ultimately might unnecessarily rearm sched's timer on nohz_full
setups, and add latency to the system[1].

So, introduce 'base->timers_pending'[2], update it every time
'base->next_expiry' changes, and use it in get_next_timer_interrupt().

[1] See tick_nohz_stop_tick().
[2] A quick pahole check on x86_64 and arm64 shows it doesn't make
    'struct timer_base' any bigger.

Fixes: 31cd0e119d50 ("timers: Recalculate next timer interrupt only when necessary")
Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 kernel/time/timer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 47e5c39b005d..830a9016e0ec 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -207,6 +207,7 @@ struct timer_base {
 	unsigned int		cpu;
 	bool			next_expiry_recalc;
 	bool			is_idle;
+	bool			timers_pending;
 	DECLARE_BITMAP(pending_map, WHEEL_SIZE);
 	struct hlist_head	vectors[WHEEL_SIZE];
 } ____cacheline_aligned;
@@ -595,6 +596,7 @@ static void enqueue_timer(struct timer_base *base, struct timer_list *timer,
 		 * can reevaluate the wheel:
 		 */
 		base->next_expiry = bucket_expiry;
+		base->timers_pending = true;
 		base->next_expiry_recalc = false;
 		trigger_dyntick_cpu(base, timer);
 	}
@@ -1598,6 +1600,7 @@ static unsigned long __next_timer_interrupt(struct timer_base *base)
 	}
 
 	base->next_expiry_recalc = false;
+	base->timers_pending = !(next == base->clk + NEXT_TIMER_MAX_DELTA);
 
 	return next;
 }
@@ -1649,7 +1652,6 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 	u64 expires = KTIME_MAX;
 	unsigned long nextevt;
-	bool is_max_delta;
 
 	/*
 	 * Pretend that there is no timer pending if the cpu is offline.
@@ -1662,7 +1664,6 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	if (base->next_expiry_recalc)
 		base->next_expiry = __next_timer_interrupt(base);
 	nextevt = base->next_expiry;
-	is_max_delta = (nextevt == base->clk + NEXT_TIMER_MAX_DELTA);
 
 	/*
 	 * We have a fresh next event. Check whether we can forward the
@@ -1680,7 +1681,7 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 		expires = basem;
 		base->is_idle = false;
 	} else {
-		if (!is_max_delta)
+		if (base->timers_pending)
 			expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
 		/*
 		 * If we expect to sleep more than a tick, mark the base idle.
@@ -1970,6 +1971,7 @@ int timers_prepare_cpu(unsigned int cpu)
 		base = per_cpu_ptr(&timer_bases[b], cpu);
 		base->clk = jiffies;
 		base->next_expiry = base->clk + NEXT_TIMER_MAX_DELTA;
+		base->timers_pending = false;
 		base->is_idle = false;
 	}
 	return 0;
-- 
2.31.1


