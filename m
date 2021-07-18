Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00F03CCAA0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 22:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhGRUjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 16:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhGRUje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 16:39:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD45C061762
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 13:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=mG8NjMjtpCytDn93HlZDflokzrUD7KDjtW8h4/CiqqI=; b=JD0vpZaeA/MVZSRLHQHUkS9sGc
        j5G4CkFSw0cnqmi3eUAd59oPdIRO7PAu89sBKBR2jcMaKVDrkblxcUSZ7KBESB1y6955WHfU65+Ss
        HDvCtKdbV2WmMNufJs4ye6iC2BgUCI+eTM47eZXUih8G3X99tqg9oUXw5JXbjjU3wEAjRUGIfcuQh
        yovcTNRSJdURov/MLkIhy/QnwDugvNmWzNRyWDdAZqXx+kqxeF+ttTqgJ8CnKOz+Yc5yQgyILGnLZ
        pZRYfMoBhGbdCc5p9lB/SP7Mr7sZLZx3SFjhMiKD+t1O4TlPyaKpRKBiD8+h4n8FYIKFXg+tEt/BS
        ZJ0iszTw==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5DWc-0080J7-ME; Sun, 18 Jul 2021 20:36:34 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH] arc: rename arc_timer's TIMER_CTRL_IE to avoid redefinition
Date:   Sun, 18 Jul 2021 13:36:32 -0700
Message-Id: <20210718203632.3982-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 2 other clocksource drivers that use the symbol
(macro/define) TIMER_CTRL_IE (in 3 files). Change the ARC timer
symbol "TIMER_CTRL_IE" to "TIMER_CTRL_IEN" to resolve the symbol
collision (redefinition).

In file included from ../drivers/clocksource/timer-integrator-ap.c:17:
../drivers/clocksource/timer-sp.h:25: warning: "TIMER_CTRL_IE" redefined
   25 | #define TIMER_CTRL_IE  (1 << 5) /*   VR */
../include/soc/arc/timers.h:20: note: this is the location of the previous definition
   20 | #define TIMER_CTRL_IE         (1 << 0) /* Interrupt when Count reaches limit */

../drivers/clocksource/mps2-timer.c:25: warning: "TIMER_CTRL_IE" redefined
   25 | #define TIMER_CTRL_IE  BIT(3)
../include/soc/arc/timers.h:20: note: this is the location of the previous definition
   20 | #define TIMER_CTRL_IE         (1 << 0) /* Interrupt when Count reaches limit */

In file included from ../drivers/clocksource/timer-sp804.c:24:
../drivers/clocksource/timer-sp.h:25: warning: "TIMER_CTRL_IE" redefined
   25 | #define TIMER_CTRL_IE  (1 << 5) /*   VR */
../include/soc/arc/timers.h:20: note: this is the location of the previous definition
   20 | #define TIMER_CTRL_IE         (1 << 0) /* Interrupt when Count reaches limit */

Fixes: b26c2e3823ba ("ARC: breakout timer include code into separate header")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
---
 drivers/clocksource/arc_timer.c |    2 +-
 include/soc/arc/timers.h        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20210716.orig/drivers/clocksource/arc_timer.c
+++ linux-next-20210716/drivers/clocksource/arc_timer.c
@@ -245,7 +245,7 @@ static void arc_timer_event_setup(unsign
 	write_aux_reg(ARC_REG_TIMER0_LIMIT, cycles);
 	write_aux_reg(ARC_REG_TIMER0_CNT, 0);	/* start from 0 */
 
-	write_aux_reg(ARC_REG_TIMER0_CTRL, TIMER_CTRL_IE | TIMER_CTRL_NH);
+	write_aux_reg(ARC_REG_TIMER0_CTRL, TIMER_CTRL_IEN | TIMER_CTRL_NH);
 }
 
 
--- linux-next-20210716.orig/include/soc/arc/timers.h
+++ linux-next-20210716/include/soc/arc/timers.h
@@ -17,7 +17,7 @@
 #define ARC_REG_TIMER1_CNT	0x100	/* timer 1 count */
 
 /* CTRL reg bits */
-#define TIMER_CTRL_IE	        (1 << 0) /* Interrupt when Count reaches limit */
+#define TIMER_CTRL_IEN	        (1 << 0) /* Interrupt when Count reaches limit */
 #define TIMER_CTRL_NH	        (1 << 1) /* Count only when CPU NOT halted */
 
 #define ARC_TIMERN_MAX		0xFFFFFFFF
