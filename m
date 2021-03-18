Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9B733FE9E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 06:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhCRFFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 01:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhCRFFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 01:05:09 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB88C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 22:05:09 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so4391708pjc.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 22:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7onWsTpSsS7L6q9I9y9OFyM8B5rHSYCwAdPuuzVWDdA=;
        b=Qo5xIFp0u3RFXcLMywPvucE5stdaYlWfndN3bW9kIk72karyW3dcWY6M+B92+7EbZL
         S4qI14CpnAiPHmv/EWFcrQPuAeQ8RTV/tp9eD+jDXAyBkLoYZ8Uk1DNPTp6Jr48eMlDq
         dUeafyf6xDemOZNZWPlJ+4hKIq5egZAAR5b2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7onWsTpSsS7L6q9I9y9OFyM8B5rHSYCwAdPuuzVWDdA=;
        b=pCSFCgpyYJEME7z7//ncGATiBCyCP192jL6pAsVpCGEXborX8TXbJOxw1pDhLNhn+W
         SFS9kmbbrdKcPRu5keFwfPaCkSD4tLvDHZhHdn5EsM4bjkYhmIr2qcbKCZLxYvGFBZWC
         rCA6tO/wimApYVt1c2s/KhxNDtA6hf1sm39g//719/wLLNldqkU4PObIq5taT3T4NT2Z
         7PRyArpM1JPH0p9kCY+mKyvh+6Rzt+A2DT62ejRn3RdOjn6bZOS/Wo5SQKmoeMcMkolx
         vA34OBUDuUORYKxTSCCP0THoQgdYgy8fBrAwPSTL1JEOi4w4s6Ww9APCC71pPOGPzys9
         cN0w==
X-Gm-Message-State: AOAM532oGInPElRcKT7yq+E7RfmXK00gq75jtcwKVK4tjh0FNmLcM/rp
        RTDOfK/ILGal2+ybNAhUOEqIDv5Wv2xR+w==
X-Google-Smtp-Source: ABdhPJzurdZlUoc6ipkxjFah/4DrB/R5Vj+hTtzkMO+w/3yti/os6EicWmS7hBbyqr3WVdg7KZ35pg==
X-Received: by 2002:a17:90b:305:: with SMTP id ay5mr2358668pjb.74.1616043908804;
        Wed, 17 Mar 2021 22:05:08 -0700 (PDT)
Received: from evanbenn1.syd.corp.google.com ([2401:fa00:9:15:d0d6:1466:f005:1b0a])
        by smtp.gmail.com with ESMTPSA id e8sm701450pgb.35.2021.03.17.22.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 22:05:08 -0700 (PDT)
From:   Evan Benn <evanbenn@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Evan Benn <evanbenn@chromium.org>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        linux-arm-kernel@lists.infradead.org,
        Stanley Chu <stanley.chu@mediatek.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Fabien Parent <fparent@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH 2/2] drivers/clocksource/mediatek: Ack and disable interrupts on shutdown
Date:   Thu, 18 Mar 2021 16:04:51 +1100
Message-Id: <20210318160414.2.I1d9917047de06715da16e1620759f703fcfdcbcb@changeid>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210318160414.1.Ia2a09ce93b47eac45308205820db0938d47604df@changeid>
References: <20210318160414.1.Ia2a09ce93b47eac45308205820db0938d47604df@changeid>
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

 drivers/clocksource/timer-mediatek-mt6577.c | 49 +++++++++++++--------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/clocksource/timer-mediatek-mt6577.c b/drivers/clocksource/timer-mediatek-mt6577.c
index 9e5241d1876d..44598121585c 100644
--- a/drivers/clocksource/timer-mediatek-mt6577.c
+++ b/drivers/clocksource/timer-mediatek-mt6577.c
@@ -54,13 +54,33 @@ static u64 notrace mtk_gpt_read_sched_clock(void)
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
@@ -74,8 +94,10 @@ static void mtk_gpt_clkevt_time_start(struct timer_of *to,
 {
 	u32 val;
 
-	/* Acknowledge interrupt */
-	writel(GPT_IRQ_ACK(timer), timer_of_base(to) + GPT_IRQ_ACK_REG);
+	/* Enable interrupts */
+	val = readl(timer_of_base(to) + GPT_IRQ_EN_REG);
+	writel(val | GPT_IRQ_ENABLE(timer),
+	       timer_of_base(to) + GPT_IRQ_EN_REG);
 
 	val = readl(timer_of_base(to) + GPT_CTRL_REG(timer));
 
@@ -148,21 +170,6 @@ __init mtk_gpt_setup(struct timer_of *to, u8 timer, u8 option)
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
 
@@ -193,6 +200,12 @@ static int __init mtk_gpt_init(struct device_node *node)
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
@@ -206,8 +219,6 @@ static int __init mtk_gpt_init(struct device_node *node)
 	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
 					TIMER_SYNC_TICKS, 0xffffffff);
 
-	mtk_gpt_enable_irq(&to, TIMER_CLK_EVT);
-
 	return 0;
 }
 TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
-- 
2.31.0.rc2.261.g7f71774620-goog

