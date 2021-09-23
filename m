Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FBF4155E0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 05:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbhIWDTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 23:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbhIWDTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 23:19:43 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC3CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 20:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=F+4AaAJAaJGuXoXH+e2tslo3DIIjCFYYsSCWYBRvK3w=; b=I4FwDW3H5ss6QfosC/xYDjMPDq
        fM9HFGawRuVcUKhzjdy5Bda0DjpdDutHJKfL+xMijYSdZwqA/a9xtNYMlhKbjkkYssa7Td7xn2muG
        jXmwSDL5qC6IFbjWByw5JJ6TjG+cdldFsbjzOIR4QDuvo7WDLKFxmkH8hFGZKYYfcVVGkIUbMX0yK
        U7ECPHb2mbdigrGPfYDiE0WhfbFphvyUATIsB2ZyHSZSbPGx2lImft41oxub+50lZZbAA0y5D7Td7
        ZNknKbDg11l1Bd2VhHZLxHZV++RWtJsKGZk4epJM2CSPgI6jSOEvbAbJ/DypogWjaGoqn2LCrSJlk
        BSw3s6/w==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTFFT-00A9Hk-B8; Thu, 23 Sep 2021 03:18:11 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] clocksource: arc_timer: eliminate redefined macro error
Date:   Wed, 22 Sep 2021 20:18:08 -0700
Message-Id: <20210923031808.5945-1-rdunlap@infradead.org>
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
that driver only.

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
---
 drivers/clocksource/arc_timer.c |    2 +-
 include/soc/arc/timers.h        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20210917.orig/include/soc/arc/timers.h
+++ linux-next-20210917/include/soc/arc/timers.h
@@ -17,7 +17,7 @@
 #define ARC_REG_TIMER1_CNT	0x100	/* timer 1 count */
 
 /* CTRL reg bits */
-#define TIMER_CTRL_IE	        (1 << 0) /* Interrupt when Count reaches limit */
+#define TIMER_CTRL_IEN	        (1 << 0) /* Interrupt when Count reaches limit */
 #define TIMER_CTRL_NH	        (1 << 1) /* Count only when CPU NOT halted */
 
 #define ARC_TIMERN_MAX		0xFFFFFFFF
--- linux-next-20210917.orig/drivers/clocksource/arc_timer.c
+++ linux-next-20210917/drivers/clocksource/arc_timer.c
@@ -245,7 +245,7 @@ static void arc_timer_event_setup(unsign
 	write_aux_reg(ARC_REG_TIMER0_LIMIT, cycles);
 	write_aux_reg(ARC_REG_TIMER0_CNT, 0);	/* start from 0 */
 
-	write_aux_reg(ARC_REG_TIMER0_CTRL, TIMER_CTRL_IE | TIMER_CTRL_NH);
+	write_aux_reg(ARC_REG_TIMER0_CTRL, TIMER_CTRL_IEN | TIMER_CTRL_NH);
 }
 
 
