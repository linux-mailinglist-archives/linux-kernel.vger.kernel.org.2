Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D684F35B8E6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 05:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbhDLDXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 23:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbhDLDWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 23:22:53 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43098C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 20:22:33 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id i4so5896943pjk.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 20:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2MIF0iAJlOzjRFkD1X3zRNDFEO5YU1OCow9vUrQ1Ec0=;
        b=eqJG/xyJz4pFsiGLXd8iRXk6L7TKPaSTVxu31AE1BxCVz/bKjGYUGV43TZ1+wXQi44
         f5RdejpDlM1yY8aNsVhvcLc4S9AHNUxfEjzOl5E6O9WkIkBSlZJuh/akbrJ0PAIeptXm
         IOArD+4S1RvBmvgQ6zO35TEIK/zEBSZW+scg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2MIF0iAJlOzjRFkD1X3zRNDFEO5YU1OCow9vUrQ1Ec0=;
        b=lRXherpDS3QdqOFLyzQLd1fTyV4e8+Du6k9WNn6kTxtVRDyxVxZ8k+93RSuZSTdAxo
         PqjCfbcdPk3e1NDDIRRAkM4woITiR/UnK+FBq+zxMitHgXf/HKrX0uqBmDRwsB04hABQ
         ogQ0IDlGSed+HRMgfk4ysxRvtyEQu804d9Z68wmK+vk6jN/g0fAf1UglonLInM2p9NZ9
         5PHwuLMK+FTEgh4MIr4K28iL8G03ddrm85QbqdVnCPvhM5zi6mXcwJ/JUNIsuJH6SOpG
         S48/tVi/gGjW5V6Ajp2prFHwoUuvs+3jAb8HaLPvJMptOCK/Oe+9dqUcb7hdZlOiAowX
         8BFw==
X-Gm-Message-State: AOAM532R7w+Yo6lH1rtMbUdWd3xY+OP8FzWOtzs3tHbb+VuuqBxfFT4x
        dxvkwTHau2k1ii4Wt6EUf1aD+A==
X-Google-Smtp-Source: ABdhPJwmDZ638Yqs1btdo68wp/5hoyLDHJEcFhSlXcJCXASInPEUYg3KQwuvbRhg+wHRmIQqw/wkhQ==
X-Received: by 2002:a17:902:7589:b029:e8:c011:1f28 with SMTP id j9-20020a1709027589b02900e8c0111f28mr23859383pll.35.1618197752825;
        Sun, 11 Apr 2021 20:22:32 -0700 (PDT)
Received: from evanbenn1.syd.corp.google.com ([2401:fa00:9:15:9f69:197:25b3:20f8])
        by smtp.gmail.com with ESMTPSA id f17sm9558020pgj.86.2021.04.11.20.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 20:22:32 -0700 (PDT)
From:   Evan Benn <evanbenn@chromium.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Evan Benn <evanbenn@chromium.org>,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] drivers/clocksource/mediatek: Ack and disable interrupts on suspend
Date:   Mon, 12 Apr 2021 13:22:19 +1000
Message-Id: <20210412132200.v3.1.I1d9917047de06715da16e1620759f703fcfdcbcb@changeid>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupts are disabled during suspend before this driver disables its
timers. ARM trusted firmware will abort suspend if the timer irq is
pending, so ack and disable the timer interrupt during suspend.

Signed-off-by: Evan Benn <evanbenn@chromium.org>
---

Changes in v3:
Move the ACK from the shutdown to the suspend function.

Changes in v2:
Remove the patch that splits the drivers into 2 files.

 drivers/clocksource/timer-mediatek.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
index 9318edcd8963..1ae8fee639bf 100644
--- a/drivers/clocksource/timer-mediatek.c
+++ b/drivers/clocksource/timer-mediatek.c
@@ -241,6 +241,27 @@ static void mtk_gpt_enable_irq(struct timer_of *to, u8 timer)
 	       timer_of_base(to) + GPT_IRQ_EN_REG);
 }
 
+static void mtk_gpt_resume(struct clock_event_device *clk)
+{
+	struct timer_of *to = to_timer_of(clk);
+
+	mtk_gpt_enable_irq(to, TIMER_CLK_EVT);
+}
+
+static void mtk_gpt_suspend(struct clock_event_device *clk)
+{
+	struct timer_of *to = to_timer_of(clk);
+
+	/* Disable all interrupts */
+	writel(0x0, timer_of_base(to) + GPT_IRQ_EN_REG);
+
+	/* This is called with interrupts disabled,
+	 * so we need to ack any interrupt that is pending
+	 * Or for example ATF will prevent a suspend from completing.
+	 */
+	writel(0x3f, timer_of_base(to) + GPT_IRQ_ACK_REG);
+}
+
 static struct timer_of to = {
 	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
 
@@ -286,6 +307,8 @@ static int __init mtk_gpt_init(struct device_node *node)
 	to.clkevt.set_state_oneshot = mtk_gpt_clkevt_shutdown;
 	to.clkevt.tick_resume = mtk_gpt_clkevt_shutdown;
 	to.clkevt.set_next_event = mtk_gpt_clkevt_next_event;
+	to.clkevt.suspend = mtk_gpt_suspend;
+	to.clkevt.resume = mtk_gpt_resume;
 	to.of_irq.handler = mtk_gpt_interrupt;
 
 	ret = timer_of_init(node, &to);
-- 
2.31.1.295.g9ea45b61b8-goog

