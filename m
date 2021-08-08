Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EDE3E3A03
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 13:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhHHLex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 07:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbhHHLem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 07:34:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B0CC061760
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 04:34:24 -0700 (PDT)
Date:   Sun, 08 Aug 2021 11:33:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628422462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=vc3FApcCCEuccHS6qVIDTP4utX+ZMWCvZR4UX6wpP+U=;
        b=gfLJUHIp3o2HHOWx+zluJf98di7EaTjuJqL4lsd3Ncfh7Q4mPQYyH4PfCUCBIjQCOd+yeN
        Nkc7JNInmAAHHOeBaj/nBViFGLcNF21jwv6Dh48as0ZiYQQpV6V7mQDV/D5ID7kp30BkRy
        fuN2D5kQoIWz1yok77R7xXuS2hnTwRdM1aY9NCDXypJ/nXtVBgxKNThcDwGf30HRTKEpeo
        6mrMqWkhTagc2Wc2hWpMhd2dDbOUEWxfI7KMA09EOOxydbdno4d9jbsY6mPGUEVkBDAgXX
        ObQ29UWeKckgXMf9FAiy/5yCKm5sETWAczSWKu22QDpoogdyfRcnjqFv7ro78A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628422462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=vc3FApcCCEuccHS6qVIDTP4utX+ZMWCvZR4UX6wpP+U=;
        b=UD1gbrIgONbpgvGFskLW3/t7vY6J7+5Otxs1bulFLTm7FSub7CjstpwbUk6Fyth1HP1UaN
        o/JGYHbCpc971SDQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for 5.14-rc5
References: <162842243492.9524.2294192686333344509.tglx@xen13>
Message-ID: <162842243782.9524.4044852683603062793.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2021-08-08

up to:  bb7262b29547: timers: Move clearing of base::timer_running under base:: Lock


A single timer fix:

 - Prevent a memory ordering issue in the timer expiry code which makes it
   possible to observe falsely that the callback has been executed already
   while that's not the case, which violates the guarantee of del_timer_sync().


Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      timers: Move clearing of base::timer_running under base:: Lock


 kernel/time/timer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 9eb11c2209e5..e3d2c23c413d 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1265,8 +1265,10 @@ static inline void timer_base_unlock_expiry(struct timer_base *base)
 static void timer_sync_wait_running(struct timer_base *base)
 {
 	if (atomic_read(&base->timer_waiters)) {
+		raw_spin_unlock_irq(&base->lock);
 		spin_unlock(&base->expiry_lock);
 		spin_lock(&base->expiry_lock);
+		raw_spin_lock_irq(&base->lock);
 	}
 }
 
@@ -1457,14 +1459,14 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 		if (timer->flags & TIMER_IRQSAFE) {
 			raw_spin_unlock(&base->lock);
 			call_timer_fn(timer, fn, baseclk);
-			base->running_timer = NULL;
 			raw_spin_lock(&base->lock);
+			base->running_timer = NULL;
 		} else {
 			raw_spin_unlock_irq(&base->lock);
 			call_timer_fn(timer, fn, baseclk);
+			raw_spin_lock_irq(&base->lock);
 			base->running_timer = NULL;
 			timer_sync_wait_running(base);
-			raw_spin_lock_irq(&base->lock);
 		}
 	}
 }

