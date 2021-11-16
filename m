Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7DDD452901
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 05:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242329AbhKPEMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 23:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242264AbhKPEM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 23:12:27 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E36FC1FB5C7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 17:03:10 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso1365963pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 17:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F3KoFFy+W9+3ZZU0urJ14ei1qBbDsIeBZJHf0xil5zc=;
        b=oYVaGDSiFsK/jIiJhDQ/NUoQeCqDC2u2IXYx5B6ucpE1FecGXxYr/EApfdKSZKOvbK
         eSLNatmO8sqHN3nI+t1zbc1nUoAIdBV4wnEqLIx0RhPOiDk2+E/m3wIBmP7zkNu3aiPg
         DXnw7zXbrKGx0KJG7b/CEiIIczssTkC4Uvl6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F3KoFFy+W9+3ZZU0urJ14ei1qBbDsIeBZJHf0xil5zc=;
        b=Q3LSoyLjn4hDxrtWe82sfDa/GqSldWpxW4RkD6fQxWoup0MNbu47Qy/qXlAO/61jev
         XfyHhmZzib82PHTpChiLsHB+abNEzdd/luA+9UfiGbThwITXw7loFHKJbVy84tQS75XD
         Fp1kV6veDxIB8/eYzYjxXPRa4AIdY0fyTft30uC6MguNGlKoldbwZQutoITgqojCJxE5
         BI2Xmrz+WCALQ1YY9LqWVBucEpBUK4f8szqbEZtnWHUMRDYY4spa5MAHKs7H8eaf/XXv
         UVhLCEgmMrbQc2JKcL2sMmTSDsJXc4MwjLUEAOWStCllAcCIrtG+lD1xOWkFLXdkiZyV
         ET8Q==
X-Gm-Message-State: AOAM531t0Y7C9+5BCRkKsB9DLHBHz4I+Dy/OLY25dNvxzForeGmdegJa
        a+kxRFJ2lNXhhM+1vtryAAnPFQ==
X-Google-Smtp-Source: ABdhPJxbmdOLGrhIFhuPX0fx5KOhuxsvOrULn0wLtdn0TlvBeSCdJCiqSgTs3Dz81jnyL9G/SrJCmA==
X-Received: by 2002:a17:902:7b82:b0:143:a6d6:34ab with SMTP id w2-20020a1709027b8200b00143a6d634abmr36769772pll.30.1637024590100;
        Mon, 15 Nov 2021 17:03:10 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:67ef:dc01:5b8c:2a3b])
        by smtp.gmail.com with ESMTPSA id h22sm12677685pgh.80.2021.11.15.17.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 17:03:09 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joelaf@google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/rt: Don't reschedule a throttled task even if it's higher priority
Date:   Mon, 15 Nov 2021 17:02:45 -0800
Message-Id: <20211115170241.1.I94825a614577505bd1a8be9aeff208a49cb39b3d@changeid>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While testing RT_GROUP_SCHED, I found that my system would go bonkers
if my test RT tasks ever got throttled (even if my test RT tasks were
set to only get a tiny slice of CPU time). Specifically I found that
whenever my test RT tasks were throttled that all other RT tasks in
the system were being starved (!!). Several important RT tasks in the
kernel were suddenly getting almost no timeslices and my system became
unusable.

After some experimentation, I determined that this behavior only
happened when I gave my test RT tasks a high priority. If I gave my
test RT tasks a low priority then they were throttled as expected and
nothing was starved.

I managed to come up with a test case that hopefully anyone can run to
demonstrate the problem. The test case uses shell commands and python
but certainly you could reproduce in other ways:

echo "Allow 20 ms more of RT at system and top cgroup"
old_rt=$(cat /proc/sys/kernel/sched_rt_runtime_us)
echo $((old_rt + 20000)) > /proc/sys/kernel/sched_rt_runtime_us
old_rt=$(cat /sys/fs/cgroup/cpu/cpu.rt_runtime_us)
echo $((old_rt + 20000)) > /sys/fs/cgroup/cpu/cpu.rt_runtime_us

echo "Give 10 ms each to spinny and printy groups"
mkdir /sys/fs/cgroup/cpu/spinny
echo 10000 > /sys/fs/cgroup/cpu/spinny/cpu.rt_runtime_us
mkdir /sys/fs/cgroup/cpu/printy
echo 10000 > /sys/fs/cgroup/cpu/printy/cpu.rt_runtime_us

echo "Fork off a printy thing to be a nice RT citizen"
echo "Prints once per second. Priority only 1."
python -c "import time;
last_time = time.time()
while True:
  time.sleep(1)
  now_time = time.time()
  print('Time fies %f' % (now_time - last_time))
  last_time = now_time" &
pid=$!
echo "Give python a few seconds to get started"
sleep 3
echo $pid >> /sys/fs/cgroup/cpu/printy/tasks
chrt -p -f 1 $pid

echo "Sleep to observe that everything is peachy"
sleep 3

echo "Fork off a bunch of evil spinny things"
echo "Chews CPU time. Priority 99."
for i in $(seq 13); do
  python -c "while True: pass"&
  pid=$!
  echo $pid >> /sys/fs/cgroup/cpu/spinny/tasks
  chrt -p -f 99 $pid
done

echo "Huh? Almost no more prints?"

I believe that the problem is an "if" test that's been in
push_rt_task() forever where we will just reschedule the current task
if it's higher priority than the next one. If I just remove that
special case then everything works for me. I tried making it
conditional on just `!rq->rt.rt_throttled` but for whatever reason
that wasn't enough. The `if` test looks like an unlikely special case
optimization and it seems like things ought to be fine without it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I know less than zero about the scheduler (so if I told you something,
it's better than 50% chance the the opposite is true!). Here I'm
asserting that we totally don't need this special case and the system
will be fine without it, but I actually don't have any data to back
that up. If nothing else, hopefully my test case in the commit message
would let someone else reproduce and see what I'm talking about and
can come up with a better fix.

 kernel/sched/rt.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index b48baaba2fc2..93ea5de0f917 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2048,16 +2048,6 @@ static int push_rt_task(struct rq *rq, bool pull)
 	if (WARN_ON(next_task == rq->curr))
 		return 0;
 
-	/*
-	 * It's possible that the next_task slipped in of
-	 * higher priority than current. If that's the case
-	 * just reschedule current.
-	 */
-	if (unlikely(next_task->prio < rq->curr->prio)) {
-		resched_curr(rq);
-		return 0;
-	}
-
 	/* We might release rq lock */
 	get_task_struct(next_task);
 
-- 
2.34.0.rc1.387.gb447b232ab-goog

