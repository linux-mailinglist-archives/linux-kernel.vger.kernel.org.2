Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875C8348673
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 02:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhCYBgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 21:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbhCYBfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 21:35:42 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA7AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 18:35:41 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x26so405380pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 18:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PNclna4r96z+ADs9Z6sKNU7TGol0SXSB3VYQsdRhSU4=;
        b=hBxECUX1Vkcjb71TpZJ98CXLuQr84nnIqLkomuaWFi3m+H6fZ2NSrM49RBs5o5bq11
         MyjI2tenjLJYYDG6wo07g94ffQSH5rly9K/9y6ne3voOIEhEsy81mTQOAyTM1viam5yE
         KVUA1B+unox70IVa0Jj+OdAzv67Za8B0nswRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PNclna4r96z+ADs9Z6sKNU7TGol0SXSB3VYQsdRhSU4=;
        b=A01C4YyzwdBAUT8U/7lftbz1xdNj4V/4MtZCZ1rqN8DKJcsrfCkRtHY9tpJTivbAU7
         XGiRhbFllsVqQNfMTDsKdtuwR7UeshAIbQrrHO211rj1I8d0oOA8k9PRkiAODLw0kTuw
         hB53ymx2kF8XYhW4o0JlweZ/UtVM2zIVIzL2kreTyg00cmTrecW9DrsaemfNGB+1k8uR
         sDgY+AWR4IzYCaJ2QDrgwrBAufNZwAQDtiq5sZCbRn6tyDx92uAOV8E6znvPARXhdPMD
         ZiSvGwzlZ1HbNfzQor5VLc1Gu/VJvCerqVyiso+U6Njuq/DEzWss/nQiValieTSQK/o6
         ZYdw==
X-Gm-Message-State: AOAM532ZWzDrZtWHKHe4K6Q+5b4wsv7skEwweC1dKF9j7m1UVr/kJyei
        5x3mGKsdekHgldPnBKM3zmp9HA==
X-Google-Smtp-Source: ABdhPJyaMBulk3s1mm/SNbnsxJGB+1AhFTA5Tqmuc39h8ixwGUrWDFzcvYQdzesbAeUlzQjkr6jIXA==
X-Received: by 2002:a17:902:7c94:b029:e6:e1d7:62b7 with SMTP id y20-20020a1709027c94b02900e6e1d762b7mr6522874pll.29.1616636141541;
        Wed, 24 Mar 2021 18:35:41 -0700 (PDT)
Received: from evanbenn1.syd.corp.google.com ([2401:fa00:9:15:5d74:fcca:830d:3b2f])
        by smtp.gmail.com with ESMTPSA id w203sm3645602pfc.188.2021.03.24.18.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 18:35:41 -0700 (PDT)
From:   Evan Benn <evanbenn@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Stanley Chu <stanley.chu@mediatek.com>,
        Alexey Klimov <alexey.klimov@linaro.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mediatek@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Evan Benn <evanbenn@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v2] drivers/clocksource/mediatek: Ack and disable interrupts on shutdown
Date:   Thu, 25 Mar 2021 12:35:00 +1100
Message-Id: <20210325123446.v2.1.I1d9917047de06715da16e1620759f703fcfdcbcb@changeid>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_state_shutdown is called during system suspend after interrupts have
been disabled. If the timer has fired in the meantime, there will be
a pending IRQ. So we ack that now and disable the timer. Without this
ARM trusted firmware will abort the suspend due to the pending
interrupt.

Now always disable the IRQ in state transitions, and re-enable in
set_periodic and next_event.

Signed-off-by: Evan Benn <evanbenn@chromium.org>
---

Changes in v2:
Remove the patch that splits the drivers into 2 files.

 drivers/clocksource/timer-mediatek.c | 49 +++++++++++++++++-----------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
index 9318edcd8963..fba2f9494d90 100644
--- a/drivers/clocksource/timer-mediatek.c
+++ b/drivers/clocksource/timer-mediatek.c
@@ -132,13 +132,33 @@ static u64 notrace mtk_gpt_read_sched_clock(void)
 	return readl_relaxed(gpt_sched_reg);
 }
 
+static void mtk_gpt_disable_ack_interrupts(struct timer_of *to, u8 timer)
+{
+	u32 val;
+
+	/* Disable interrupts */
+	val = readl(timer_of_base(to) + GPT_IRQ_EN_REG);
+	writel(val & ~GPT_IRQ_ENABLE(timer), timer_of_base(to) +
+	       GPT_IRQ_EN_REG);
+
+	/* Ack interrupts */
+	writel(GPT_IRQ_ACK(timer), timer_of_base(to) + GPT_IRQ_ACK_REG);
+}
+
 static void mtk_gpt_clkevt_time_stop(struct timer_of *to, u8 timer)
 {
 	u32 val;
 
+	/* Disable timer */
 	val = readl(timer_of_base(to) + GPT_CTRL_REG(timer));
 	writel(val & ~GPT_CTRL_ENABLE, timer_of_base(to) +
 	       GPT_CTRL_REG(timer));
+
+	/* This may be called with interrupts disabled,
+	 * so we need to ack any interrupt that is pending
+	 * Or for example ATF will prevent a suspend from completing.
+	 */
+	mtk_gpt_disable_ack_interrupts(to, timer);
 }
 
 static void mtk_gpt_clkevt_time_setup(struct timer_of *to,
@@ -152,8 +172,10 @@ static void mtk_gpt_clkevt_time_start(struct timer_of *to,
 {
 	u32 val;
 
-	/* Acknowledge interrupt */
-	writel(GPT_IRQ_ACK(timer), timer_of_base(to) + GPT_IRQ_ACK_REG);
+	/* Enable interrupts */
+	val = readl(timer_of_base(to) + GPT_IRQ_EN_REG);
+	writel(val | GPT_IRQ_ENABLE(timer),
+	       timer_of_base(to) + GPT_IRQ_EN_REG);
 
 	val = readl(timer_of_base(to) + GPT_CTRL_REG(timer));
 
@@ -226,21 +248,6 @@ __init mtk_gpt_setup(struct timer_of *to, u8 timer, u8 option)
 	       timer_of_base(to) + GPT_CTRL_REG(timer));
 }
 
-static void mtk_gpt_enable_irq(struct timer_of *to, u8 timer)
-{
-	u32 val;
-
-	/* Disable all interrupts */
-	writel(0x0, timer_of_base(to) + GPT_IRQ_EN_REG);
-
-	/* Acknowledge all spurious pending interrupts */
-	writel(0x3f, timer_of_base(to) + GPT_IRQ_ACK_REG);
-
-	val = readl(timer_of_base(to) + GPT_IRQ_EN_REG);
-	writel(val | GPT_IRQ_ENABLE(timer),
-	       timer_of_base(to) + GPT_IRQ_EN_REG);
-}
-
 static struct timer_of to = {
 	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
 
@@ -292,6 +299,12 @@ static int __init mtk_gpt_init(struct device_node *node)
 	if (ret)
 		return ret;
 
+	/* In case the firmware left the interrupts enabled
+	 * disable and ack those now
+	 */
+	mtk_gpt_disable_ack_interrupts(&to, TIMER_CLK_SRC);
+	mtk_gpt_disable_ack_interrupts(&to, TIMER_CLK_EVT);
+
 	/* Configure clock source */
 	mtk_gpt_setup(&to, TIMER_CLK_SRC, GPT_CTRL_OP_FREERUN);
 	clocksource_mmio_init(timer_of_base(&to) + GPT_CNT_REG(TIMER_CLK_SRC),
@@ -305,8 +318,6 @@ static int __init mtk_gpt_init(struct device_node *node)
 	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
 					TIMER_SYNC_TICKS, 0xffffffff);
 
-	mtk_gpt_enable_irq(&to, TIMER_CLK_EVT);
-
 	return 0;
 }
 TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
-- 
2.31.0.291.g576ba9dcdaf-goog

