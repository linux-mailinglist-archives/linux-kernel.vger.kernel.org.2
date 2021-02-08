Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A7D312B25
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 08:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhBHHhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 02:37:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40784 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229751AbhBHHhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 02:37:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612769766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hPAubHAlkGX30PBG5/0RoaT0SoUvSxPRk2VFQPqXOtQ=;
        b=VmP+ioJ2OdlicKK5H4ihFiXL2Zv8GRuPCu0Q9boijk0fg/Gl59bvR8L0Sn+OikS945hEQy
        QrJQUL5TcPNo7Ij76Ie02ZtJXAJtrDBh8iCgd2Fso7D29fw9chQ8FQBj5ktIXp4Kv/f710
        Id391irxV74giv/wfDAfDAJIzEw6eZM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-oF24Y5tBPLCsry52Htqw6A-1; Mon, 08 Feb 2021 02:36:05 -0500
X-MC-Unique: oF24Y5tBPLCsry52Htqw6A-1
Received: by mail-ed1-f69.google.com with SMTP id ck25so12706055edb.16
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 23:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hPAubHAlkGX30PBG5/0RoaT0SoUvSxPRk2VFQPqXOtQ=;
        b=OqVB0M/SxbWAtTQd8pKWgEuK+dHHR6/7QOZiiwjmedyXHp32oU6SQbgVd0V8vbX9kM
         wpIPxsNnvJtBW5QjSCh7zQlriXIZ+efVoV9tHeNh2ucMppev8b8gvvwf0Ty3BMH6k33M
         1xOR34JuM+zYZGElcAuf4wsPFGwfcd0mFIihPui1d0AO5tOzgcE9TTaPvZ0GA0Cuu+jj
         GIvBWYCCyo1RorXPOPCPMvQjnIVBM7upjZTxEXHCVI6x3c0qqnP1ty3zE2Js7UQeLIrF
         eO7R9GkNvu5zGVcbKEXY8B1lDmF6fJVFhyX/xBFvQBVe70Eqk9P0weWmkc2p2iYaW1qn
         HZ5g==
X-Gm-Message-State: AOAM530nLyYzsGGXmgPbZ4ILVMICfIE29ILjeTGl/obqDTAdQYX5XS85
        e0dLUWaurg1H7zCM6fhsyNOUQ2qfxbadhR/4i7/GPmieZiohA+92Zd17b5AOiY6UFedpHbR6jZY
        bPumd2nFrRW85uW9oa3JSjs1e
X-Received: by 2002:aa7:c0cd:: with SMTP id j13mr15856142edp.156.1612769763835;
        Sun, 07 Feb 2021 23:36:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzoF60DX/I0MJUZMqxdEG2A3rqxhFnwKfwkiuM3uxNDESAugDI6P4xhE5xvx8CZFaeQhjKOKA==
X-Received: by 2002:aa7:c0cd:: with SMTP id j13mr15856120edp.156.1612769763645;
        Sun, 07 Feb 2021 23:36:03 -0800 (PST)
Received: from localhost.localdomain.com ([151.34.162.6])
        by smtp.gmail.com with ESMTPSA id ec18sm8116317ejb.24.2021.02.07.23.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 23:36:03 -0800 (PST)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bristot@redhat.com, bsegall@google.com,
        mgorman@suse.de, lgoncalv@redhat.com, williams@redhat.com,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 1/2] sched/features: Fix hrtick reprogramming
Date:   Mon,  8 Feb 2021 08:35:53 +0100
Message-Id: <20210208073554.14629-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210208073554.14629-1-juri.lelli@redhat.com>
References: <20210208073554.14629-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hung tasks and RCU stall cases were reported on systems which were not
100% busy. Investigation of such unexpected cases (no sign of potential
starvation caused by tasks hogging the system) pointed out that the
periodic sched tick timer wasn't serviced anymore after a certain point
and that caused all machinery that depends on it (timers, RCU, etc.) to
stop working as well. This issues was however only reproducible if
HRTICK was enabled.

Looking at core dumps it was found that the rbtree of the hrtimer base
used also for the hrtick was corrupted (i.e. next as seen from the base
root and actual leftmost obtained by traversing the tree are different).
Same base is also used for periodic tick hrtimer, which might get "lost"
if the rbtree gets corrupted.

Much alike what described in commit 1f71addd34f4c ("tick/sched: Do not
mess with an enqueued hrtimer") there is a race window between
hrtimer_set_expires() in hrtick_start and hrtimer_start_expires() in
__hrtick_restart() in which the former might be operating on an already
queued hrtick hrtimer, which might lead to corruption of the base.

Use hrtick_start() (which removes the timer before enqueuing it back) to
ensure hrtick hrtimer reprogramming is entirely guarded by the base
lock, so that no race conditions can occur.

Co-developed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Co-developed-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/core.c  | 8 +++-----
 kernel/sched/sched.h | 1 +
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index be3a956c2d23..d2d79a2c30f5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -355,8 +355,9 @@ static enum hrtimer_restart hrtick(struct hrtimer *timer)
 static void __hrtick_restart(struct rq *rq)
 {
 	struct hrtimer *timer = &rq->hrtick_timer;
+	ktime_t time = rq->hrtick_time;
 
-	hrtimer_start_expires(timer, HRTIMER_MODE_ABS_PINNED_HARD);
+	hrtimer_start(timer, time, HRTIMER_MODE_ABS_PINNED_HARD);
 }
 
 /*
@@ -380,7 +381,6 @@ static void __hrtick_start(void *arg)
 void hrtick_start(struct rq *rq, u64 delay)
 {
 	struct hrtimer *timer = &rq->hrtick_timer;
-	ktime_t time;
 	s64 delta;
 
 	/*
@@ -388,9 +388,7 @@ void hrtick_start(struct rq *rq, u64 delay)
 	 * doesn't make sense and can cause timer DoS.
 	 */
 	delta = max_t(s64, delay, 10000LL);
-	time = ktime_add_ns(timer->base->get_time(), delta);
-
-	hrtimer_set_expires(timer, time);
+	rq->hrtick_time = ktime_add_ns(timer->base->get_time(), delta);
 
 	if (rq == this_rq())
 		__hrtick_restart(rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6edc67df3554..3e16dff206b3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1030,6 +1030,7 @@ struct rq {
 	call_single_data_t	hrtick_csd;
 #endif
 	struct hrtimer		hrtick_timer;
+	ktime_t 		hrtick_time;
 #endif
 
 #ifdef CONFIG_SCHEDSTATS
-- 
2.29.2

