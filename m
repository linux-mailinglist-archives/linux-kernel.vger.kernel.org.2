Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643C93A939F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhFPHTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:19:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29058 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231256AbhFPHTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623827846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+z2gTaUpwYRjqOsBM0bYRs0d+lMxs6wuyh04NXAkJRc=;
        b=iQyERqH+G/BKMIuQR0BglGWCjeRBpyYbbEtzFCisjBvscklPpBrTHvL/H9xh1LCa8g2Du+
        Hov2H6SAvitRYoJEPhXmfKdr7DiWk7Zh4HRCtfKJVPVLGIvoTq/HBqvUW/CTGHq33i4LEB
        i13Fo5LCtvKVnEWPYy7DUEzn4CtePBo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-7wjG-B0lM0CduZgtsC0SZw-1; Wed, 16 Jun 2021 03:17:25 -0400
X-MC-Unique: 7wjG-B0lM0CduZgtsC0SZw-1
Received: by mail-ej1-f72.google.com with SMTP id br12-20020a170906d14cb02904311c0f32adso544931ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 00:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+z2gTaUpwYRjqOsBM0bYRs0d+lMxs6wuyh04NXAkJRc=;
        b=kR9XnwC9KRO3QrGkVyK7RFcGBFqAnbegNr2nWGDPiFxB/BTrlFQAmnbNIpsIDN6vrY
         zkYDPmt+bWuKj1uaLrxqLBB1RCPqK0w02V4H8zNdKTZzm4tJ8avznPCKsGl3a0INctdW
         Szbkycr1XkYJLMnN9OFktaBdZzr0D8nUGVzBTZmf1Qp5M7ZPurob+rCZfeNpHbfvaQWV
         311B3GdwobA3/wax+8rIVctTD1Voe3m/osUN2w25pOwvR3Qpo6heWs7hkWfrq1HcU38P
         ZY4Q7PaObQQNFgDMZooCBffEXbSEVQx6tmKncof5SZHKCoVVo/xv4MSQutnZ5i//W5Km
         Dk/Q==
X-Gm-Message-State: AOAM533Xi/TtU0ztyq/20FV/YZkl2tYmVYviiE6/sKAM+NWUZ6lNuOi+
        zswahb3UinQNHjk5mJyln3MY5IN/soqdumgupQ8o8zl8cEYvAnF2Fq9xaHXEqZCAewjwejCNflH
        Zi7w6kcfPZR0BOjYblfjFJ/l2
X-Received: by 2002:a05:6402:1777:: with SMTP id da23mr2413400edb.181.1623827844437;
        Wed, 16 Jun 2021 00:17:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgaSZ6MU3UClSt9gwUUhSOMfnKsE81Jd4t1DtZyhpralQ+UunmmhYbTMIS7GMNCYQ+PGo8Yg==
X-Received: by 2002:a05:6402:1777:: with SMTP id da23mr2413391edb.181.1623827844241;
        Wed, 16 Jun 2021 00:17:24 -0700 (PDT)
Received: from localhost.localdomain.hub ([151.29.48.4])
        by smtp.gmail.com with ESMTPSA id lu21sm968074ejb.31.2021.06.16.00.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 00:17:23 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     bigeasy@linutronix.de, tglx@linutronix.de
Cc:     linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH RT v2 1/2] time/hrtimer: Add PINNED_HARD mode for realtime hrtimers
Date:   Wed, 16 Jun 2021 09:17:04 +0200
Message-Id: <20210616071705.166658-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210616071705.166658-1-juri.lelli@redhat.com>
References: <20210616071705.166658-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running cyclictest on isolated CPUs with timer_migration enabled,
I noticed the following behavior, where CPU0 is one of the housekeeping
CPUs and CPU2 is isolated:

     <idle>-0     [000] ... hrtimer_cancel:       hrtimer=0xffffb4a74be7fe70
     <idle>-0     [000] ... hrtimer_expire_entry: hrtimer=0xffffb4a74be7fe70 now=144805770984 function=hrtimer_wakeup/0x0
     <idle>-0     [000] ... sched_wakeup:         cyclictest:1171 [4] success=1 CPU:002
     <idle>-0     [000] ... hrtimer_expire_exit:  hrtimer=0xffffb4a74be7fe70
     <idle>-0     [002] ... sched_switch:         swapper/2:0 [120] R ==> cyclictest:1171 [4]
 cyclictest-1171  [002] ... hrtimer_init:         hrtimer=0xffffb4a74be7fe70 clockid=CLOCK_MONOTONIC mode=0x8
 cyclictest-1171  [002] ... hrtimer_start:        hrtimer=0xffffb4a74be7fe70 function=hrtimer_wakeup/0x0 ...
 cyclictest-1171  [002] ... sched_switch:         cyclictest:1171 [4] S ==> swapper/2:0 [120]

While cyclitest was arming the hrtimer while running on isolated CPU2
(by means of clock_nanosleep), the hrtimer was then firing on CPU0. This
is due to the fact that switch_hrtimer_base(), called at hrtimer enqueue
time, will prefer to enqueue the timer on an housekeeping !idle CPU, if
the timer is not pinned and timer_migration is enabled.

The problem with this is that we are measuring wake up latencies across
isolated and !isolated domains, which is against the purpose of
configuring the latter.

Since PREEMPT_RT already forces HARD mode for hrtimers armed by tasks
running with RT policies, it makes sense to also force PINNED mode under
the same conditions.

This patch implements this behavior, achieving something like the
following:

     <idle>-0     [002] ... hrtimer_cancel:       hrtimer=0xffffafbacc19fe78
     <idle>-0     [002] ... hrtimer_expire_entry: hrtimer=0xffffafbacc19fe78 now=104335855898 function=hrtimer_wakeup/0x0
     <idle>-0     [002] ... sched_wakeup:         cyclictest:1165 [4] success=1 CPU:002
     <idle>-0     [002] ... hrtimer_expire_exit:  hrtimer=0xffffafbacc19fe78
     <idle>-0     [002] ... sched_switch:         swapper/2:0 [120] R ==> cyclictest:1165 [4]
 cyclictest-1165  [002] ... hrtimer_init:         hrtimer=0xffffafbacc19fe78 clockid=CLOCK_MONOTONIC mode=0xa
 cyclictest-1165  [002] ... hrtimer_start:        hrtimer=0xffffafbacc19fe78 function=hrtimer_wakeup/0x0 ...
 cyclictest-1165  [002] ... sched_switch:         cyclictest:1165 [4] S ==> swapper/2:0 [120]

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/hrtimer.h | 2 ++
 kernel/time/hrtimer.c   | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index e425a26a5ed8..bca9402a1030 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -55,6 +55,8 @@ enum hrtimer_mode {
 	HRTIMER_MODE_ABS_HARD	= HRTIMER_MODE_ABS | HRTIMER_MODE_HARD,
 	HRTIMER_MODE_REL_HARD	= HRTIMER_MODE_REL | HRTIMER_MODE_HARD,
 
+	HRTIMER_MODE_PINNED_HARD = HRTIMER_MODE_PINNED | HRTIMER_MODE_HARD,
+
 	HRTIMER_MODE_ABS_PINNED_HARD = HRTIMER_MODE_ABS_PINNED | HRTIMER_MODE_HARD,
 	HRTIMER_MODE_REL_PINNED_HARD = HRTIMER_MODE_REL_PINNED | HRTIMER_MODE_HARD,
 };
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 3fa18a01f5b2..f64954d5c8f8 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1842,7 +1842,7 @@ static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
 		if (task_is_realtime(current) && !(mode & HRTIMER_MODE_SOFT))
-			mode |= HRTIMER_MODE_HARD;
+			mode |= HRTIMER_MODE_PINNED_HARD;
 	}
 
 	__hrtimer_init(&sl->timer, clock_id, mode);
-- 
2.31.1

