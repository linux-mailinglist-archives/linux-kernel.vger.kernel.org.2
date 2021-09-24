Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB774169D9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 04:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243894AbhIXCKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 22:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243884AbhIXCJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 22:09:59 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC8EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 19:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=JrkeemnUXU8SWdh3Y3+8kaoW8IMAUTCjlv/AEs5O68g=; b=WaU/Kq17fX3Mkvg1V28HemB7ux
        BlwfrDRiPa+U6Oo8uK1vovnbrLe0ewFmnsKdXd3Eees0fqRPvZVKZ0WDs11lhCztqX/iC1TCalthv
        Z94Eg93UBm5QiR+YE9BeW7Rb1cx0mWcMfWkh0zcl/2Ffih+No9FFrc0D1PSX8FDrKk1UJ8DB1FGxR
        ozYby6+gUGQTxXnsgJEET5YMjOJyn0eQqb2wle/HMk0FRaVUVmI6mGiB4Val8fONS2A3sMIlKT50z
        tnKwG6FUlL3xqUY8pdjq07TG0NmnKtt3G+P/4OMZmtjxrDNRXimtWnBKVLsxBZBGXV1yRlmw/oTKz
        j3ro3uWg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTadW-00Ctpd-3d; Fri, 24 Sep 2021 02:08:26 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>
Subject: [PATCH v2] clocksource: arc_timer: eliminate redefined macro error
Date:   Thu, 23 Sep 2021 19:08:25 -0700
Message-Id: <20210924020825.20317-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In drivers/clocksource/, 3 drivers use "TIMER_CTRL_IE" with 3 different
values.  Two of them (mps2-timer.c and timer-sp804.c/timer-sp.h) are
localized and left unmodifed.

One of them uses a shared header file (<soc/arc/timers.h>), which is
what is causing the "redefined" warnings, so change the macro name in
that driver only. Also change the TIMER_CTRL_NH macro name.
Both macro names are prefixed with "ARC_" to reduce the likelihood
of future name collisions.

In file included from ../drivers/clocksource/timer-sp804.c:24:
../drivers/clocksource/timer-sp.h:25: error: "TIMER_CTRL_IE" redefined [-Werror]
   25 | #define TIMER_CTRL_IE           (1 << 5)        /*   VR */
../include/soc/arc/timers.h:20: note: this is the location of the previous definition
   20 | #define TIMER_CTRL_IE           (1 << 0) /* Interrupt when Count reaches limit */

Fixes: b26c2e3823ba ("ARC: breakout timer include code into separate header")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: linux-snps-arc@lists.infradead.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Shahab Vahedi <Shahab.Vahedi@synopsys.com>
---
v2: prefix both TIMER_CTRL_xx macros with ARC_ (suggested by
    Shahab Vahedi <Shahab.Vahedi@synopsys.com>

 drivers/clocksource/arc_timer.c |    6 +++---
 include/soc/arc/timers.h        |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

--- linux-next-20210917.orig/include/soc/arc/timers.h
+++ linux-next-20210917/include/soc/arc/timers.h
@@ -17,8 +17,8 @@
 #define ARC_REG_TIMER1_CNT	0x100	/* timer 1 count */
 
 /* CTRL reg bits */
-#define TIMER_CTRL_IE	        (1 << 0) /* Interrupt when Count reaches limit */
-#define TIMER_CTRL_NH	        (1 << 1) /* Count only when CPU NOT halted */
+#define ARC_TIMER_CTRL_IE	(1 << 0) /* Interrupt when Count reaches limit */
+#define ARC_TIMER_CTRL_NH	(1 << 1) /* Count only when CPU NOT halted */
 
 #define ARC_TIMERN_MAX		0xFFFFFFFF
 
--- linux-next-20210917.orig/drivers/clocksource/arc_timer.c
+++ linux-next-20210917/drivers/clocksource/arc_timer.c
@@ -225,7 +225,7 @@ static int __init arc_cs_setup_timer1(st
 
 	write_aux_reg(ARC_REG_TIMER1_LIMIT, ARC_TIMERN_MAX);
 	write_aux_reg(ARC_REG_TIMER1_CNT, 0);
-	write_aux_reg(ARC_REG_TIMER1_CTRL, TIMER_CTRL_NH);
+	write_aux_reg(ARC_REG_TIMER1_CTRL, ARC_TIMER_CTRL_NH);
 
 	sched_clock_register(arc_timer1_clock_read, 32, arc_timer_freq);
 
@@ -245,7 +245,7 @@ static void arc_timer_event_setup(unsign
 	write_aux_reg(ARC_REG_TIMER0_LIMIT, cycles);
 	write_aux_reg(ARC_REG_TIMER0_CNT, 0);	/* start from 0 */
 
-	write_aux_reg(ARC_REG_TIMER0_CTRL, TIMER_CTRL_IE | TIMER_CTRL_NH);
+	write_aux_reg(ARC_REG_TIMER0_CTRL, ARC_TIMER_CTRL_IE | ARC_TIMER_CTRL_NH);
 }
 
 
@@ -294,7 +294,7 @@ static irqreturn_t timer_irq_handler(int
 	 *      explicitly clears IP bit
 	 * 2. Re-arm interrupt if periodic by writing to IE bit [0]
 	 */
-	write_aux_reg(ARC_REG_TIMER0_CTRL, irq_reenable | TIMER_CTRL_NH);
+	write_aux_reg(ARC_REG_TIMER0_CTRL, irq_reenable | ARC_TIMER_CTRL_NH);
 
 	evt->event_handler(evt);
 
