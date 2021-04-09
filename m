Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA42435990D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbhDIJXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:23:08 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:44406 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230181AbhDIJXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:23:07 -0400
X-UUID: 92cf7f6a22df4782bebec04fda71f075-20210409
X-UUID: 92cf7f6a22df4782bebec04fda71f075-20210409
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <fengquan.chen@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1677009369; Fri, 09 Apr 2021 17:22:52 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Apr 2021 17:22:48 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 9 Apr 2021 17:22:47 +0800
From:   Fengquan Chen <Fengquan.Chen@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <fengquan.chen@mediatek.com>, <dehui.sun@mediatek.com>,
        Fengquan Chen <Fengquan.Chen@mediatek.com>
Subject: [PATCH] [v4, 1/1] clocksource/drivers/timer-mediatek: optimize systimer irq clear flow on shutdown
Date:   Fri, 9 Apr 2021 17:22:42 +0800
Message-ID: <1617960162-1988-2-git-send-email-Fengquan.Chen@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1617960162-1988-1-git-send-email-Fengquan.Chen@mediatek.com>
References: <1617960162-1988-1-git-send-email-Fengquan.Chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 826507B506F2E6CE2B0689A4825496BE862FBCB05A78F7CDF6D4B0793C0B89D32000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk_syst_clkevt_shutdown is called after irq disabled in suspend flow,
clear any pending systimer irq when shutdown to avoid suspend aborted
due to timer irq pending

Also as for systimer in mediatek socs, there must be firstly enable
timer before clear systimer irq

Fixes: e3af677607d9("clocksource/drivers/timer-mediatek: Add support for system timer")
Signed-off-by: Fengquan Chen <fengquan.chen@mediatek.com>

---
 drivers/clocksource/timer-mediatek.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
index 9318edc..6461fd3 100644
--- a/drivers/clocksource/timer-mediatek.c
+++ b/drivers/clocksource/timer-mediatek.c
@@ -60,9 +60,9 @@
  * SYST_CON_EN: Clock enable. Shall be set to
  *   - Start timer countdown.
  *   - Allow timeout ticks being updated.
- *   - Allow changing interrupt functions.
+ *   - Allow changing interrupt status,like clear irq pending.
  *
- * SYST_CON_IRQ_EN: Set to allow interrupt.
+ * SYST_CON_IRQ_EN: Set to enable interrupt.
  *
  * SYST_CON_IRQ_CLR: Set to clear interrupt.
  */
@@ -75,6 +75,7 @@
 static void mtk_syst_ack_irq(struct timer_of *to)
 {
 	/* Clear and disable interrupt */
+	writel(SYST_CON_EN, SYST_CON_REG(to));
 	writel(SYST_CON_IRQ_CLR | SYST_CON_EN, SYST_CON_REG(to));
 }
 
@@ -111,6 +112,9 @@ static int mtk_syst_clkevt_next_event(unsigned long ticks,
 
 static int mtk_syst_clkevt_shutdown(struct clock_event_device *clkevt)
 {
+	/* Clear any irq */
+	mtk_syst_ack_irq(to_timer_of(clkevt));
+
 	/* Disable timer */
 	writel(0, SYST_CON_REG(to_timer_of(clkevt)));
 
-- 
1.8.1.1.dirty

