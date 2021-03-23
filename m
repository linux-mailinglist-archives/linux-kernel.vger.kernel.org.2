Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C9034557C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 03:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhCWC32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 22:29:28 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:18570 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229494AbhCWC3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 22:29:19 -0400
X-UUID: 48e53b11c35f4e56b99ec7d95215c6c0-20210323
X-UUID: 48e53b11c35f4e56b99ec7d95215c6c0-20210323
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <fengquan.chen@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 635549371; Tue, 23 Mar 2021 10:29:17 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 23 Mar 2021 10:29:11 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Mar 2021 10:29:10 +0800
From:   Fengquan Chen <Fengquan.Chen@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <fengquan.chen@mediatek.com>, <dehui.sun@mediatek.com>,
        Fengquan Chen <Fengquan.Chen@mediatek.com>
Subject: [PATCH] [v2, 1/1]Fixes: e3af677607d9(clocksource/drivers/timer-mediatek: optimize systimer irq clear flow on shutdown)
Date:   Tue, 23 Mar 2021 10:29:03 +0800
Message-ID: <1616466543-13387-2-git-send-email-Fengquan.Chen@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1616466543-13387-1-git-send-email-Fengquan.Chen@mediatek.com>
References: <1616466543-13387-1-git-send-email-Fengquan.Chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D4488B2E5BBE6B138EAD1D7F778C11CE6D71F350986AF03F3C2E7D89D3F24D972000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk_syst_clkevt_shutdown is called after irq disabled in suspend flow,
clear any pending systimer irq when shutdown to avoid suspend aborted
due to timer irq pending

Also as for systimer in mediatek socs, there must be firstly enable
timer before clear systimer irq

Change-Id: Ia3eda83324af2fdaf5cbb3569a9bf020a11f8009
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

