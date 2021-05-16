Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35743381F45
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 16:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbhEPOcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 10:32:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47396 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbhEPOcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 10:32:41 -0400
Date:   Sun, 16 May 2021 14:31:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621175485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sHr7K1BEfZAqGACa4J3evLQp4uh59lQCCGhvTQ8BQyw=;
        b=eW4StM50ycWZJv1qfIwINK8tTa6nS3sgijLW4HXDib6xIFjZ+5B0JkwwGHd2uDQGiP52cB
        52lq+pldB+S9891ti5HrpeidbGVZ0DclSkI1NJhqWujA//IwrRM4MXgBhANtrH69Xhz/ym
        s/d3mmFzC1+WmIclCg1PZpj+ricfFM5jefCiuoKeWzxGsOCwK3y6957fLBlHBYnHUatMLc
        P1FqQe90sd8ItymTEUwskXKrA1QowW+oaa63z8IfyI9yfILJRD8fSQzb63VwdbwYS/uSI3
        1qMR0nxRvjoAWwXFoHeOuAyV+QOEGb21dh6wMPifsNGtNVlMDgGN1wLi63T25Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621175485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sHr7K1BEfZAqGACa4J3evLQp4uh59lQCCGhvTQ8BQyw=;
        b=QRtRlPadixez17uHHfnYQIXMEXAX5zL3GhZTxH35dCUKv+gQR1oY93bGjZccX/Q7o4GDcU
        AlP96tEGLJzlQGBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for v5.13-rc2
Message-ID: <162117546694.3259.3288098599139638606.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2021-05-16

up to:  3486d2c9be65: clocksource/drivers/hyper-v: Re-enable VDSO_CLOCKMODE_HVCLOCK on X86


Two fixes for timers:

  - Use the ALARM feature check in the alarmtimer core code insted of
    the old method of checking for the set_alarm() callback. Drivers
    can have that callback set but the feature bit cleared. If such
    a RTC device is selected then alarms wont work.

  - Use a proper define to let the preprocessor check whether Hyper-V VDSO
    clocksource should be active. The code used a constant in an enum with
    #ifdef, which evaluates to always false and disabled the clocksource
    for VDSO.

    

Thanks,

	tglx

------------------>
Alexandre Belloni (1):
      alarmtimer: Check RTC features instead of ops

Vitaly Kuznetsov (1):
      clocksource/drivers/hyper-v: Re-enable VDSO_CLOCKMODE_HVCLOCK on X86


 arch/x86/include/asm/vdso/clocksource.h | 2 ++
 drivers/clocksource/hyperv_timer.c      | 4 ++--
 kernel/time/alarmtimer.c                | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/vdso/clocksource.h b/arch/x86/include/asm/vdso/clocksource.h
index 119ac8612d89..136e5e57cfe1 100644
--- a/arch/x86/include/asm/vdso/clocksource.h
+++ b/arch/x86/include/asm/vdso/clocksource.h
@@ -7,4 +7,6 @@
 	VDSO_CLOCKMODE_PVCLOCK,	\
 	VDSO_CLOCKMODE_HVCLOCK
 
+#define HAVE_VDSO_CLOCKMODE_HVCLOCK
+
 #endif /* __ASM_VDSO_CLOCKSOURCE_H */
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 977fd05ac35f..d6ece7bbce89 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -419,7 +419,7 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
 	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
 }
 
-#ifdef VDSO_CLOCKMODE_HVCLOCK
+#ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
 static int hv_cs_enable(struct clocksource *cs)
 {
 	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
@@ -435,7 +435,7 @@ static struct clocksource hyperv_cs_tsc = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 	.suspend= suspend_hv_clock_tsc,
 	.resume	= resume_hv_clock_tsc,
-#ifdef VDSO_CLOCKMODE_HVCLOCK
+#ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
 	.enable = hv_cs_enable,
 	.vdso_clock_mode = VDSO_CLOCKMODE_HVCLOCK,
 #else
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index bea9d08b1698..5897828b9d7e 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -92,7 +92,7 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 	if (rtcdev)
 		return -EBUSY;
 
-	if (!rtc->ops->set_alarm)
+	if (!test_bit(RTC_FEATURE_ALARM, rtc->features))
 		return -1;
 	if (!device_may_wakeup(rtc->dev.parent))
 		return -1;

