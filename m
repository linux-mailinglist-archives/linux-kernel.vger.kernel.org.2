Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FFC37B428
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 04:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhELC1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 22:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhELC1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 22:27:09 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187F1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 19:26:01 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t21so11770700plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 19:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NFXf1SUAkReC3MtaV1k9mib3TBX01qLYNs8RqJ8r1VY=;
        b=WDry/cE9LcDDsvZONla927KdK58kdOq5cMvJBpA/+C5Roqpjz/q/YVsY9EPXO1hhfr
         K5wljKBiFwRzt19KANN0iSIz1JSgxbM1OGBwg4wa3rYfw3xFn6/zmE1hmjPB4jCpCQNH
         qgw/AdJ0gSIPx9mIWLjg3MP7RbYX1IU3BnB3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NFXf1SUAkReC3MtaV1k9mib3TBX01qLYNs8RqJ8r1VY=;
        b=IGPL0seHoMEJP+xDUHQdO5uJ8FSXcIG7wniG7FllDScEbpDgJbXKx06GucuSIFNmC8
         hFJyZVfooo8wIYms1mJxNHXdJKDusyJ/zZJCBVnDa7KYg1qsdapdjLWxjJoYf3+3RqIE
         W6tiL8GQgN2eiDY78meV9Hb+va4SLrqE2yDbQCakyJyBwv9AuTGKaoDOnxeD846aKece
         QPRsaDhorHI22DAB/BdszMjNnmsldAMzy2GNN8dMq3U9hLuJIb80sMH77Hn9MCnig1rK
         wclrHtbAdaNYZ4TF8M5Nbjd3nYKeXe4Q+iWpZjggak4CEJflrzAFlctBtkArfwvoRaEs
         v5Tw==
X-Gm-Message-State: AOAM533d+Fwq/jAeodC+0rpQkdIDYlIkIVeqPjT72xZlM6YUDQQKAfGW
        8ef1FD5OV/p8OgeRcQUpDXkptQ==
X-Google-Smtp-Source: ABdhPJxZh9XbVa0O5QvQA3ScydCZHBQ1k/eVLELOoCUCninL/YfEiRK9LcXbyUUwaKWXqBq1ffFctw==
X-Received: by 2002:a17:902:b183:b029:ee:ff72:f580 with SMTP id s3-20020a170902b183b02900eeff72f580mr29650246plr.26.1620786360149;
        Tue, 11 May 2021 19:26:00 -0700 (PDT)
Received: from evanbenn1.syd.corp.google.com ([2401:fa00:9:15:83b5:4bca:90bf:147c])
        by smtp.gmail.com with ESMTPSA id t10sm11716797pfq.68.2021.05.11.19.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 19:25:59 -0700 (PDT)
From:   Evan Benn <evanbenn@chromium.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Evan Benn <evanbenn@chromium.org>
Subject: [PATCH v4] drivers/clocksource/mediatek: Ack and disable interrupts on suspend
Date:   Wed, 12 May 2021 12:25:44 +1000
Message-Id: <20210512122528.v4.1.I1d9917047de06715da16e1620759f703fcfdcbcb@changeid>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
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

Changes in v4:
Fix the comment style.

Changes in v3:
Move the ACK from the shutdown to the suspend function.

Changes in v2:
Remove the patch that splits the drivers into 2 files.

 drivers/clocksource/timer-mediatek.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
index 9318edcd8963..ab63b95e414f 100644
--- a/drivers/clocksource/timer-mediatek.c
+++ b/drivers/clocksource/timer-mediatek.c
@@ -241,6 +241,28 @@ static void mtk_gpt_enable_irq(struct timer_of *to, u8 timer)
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
+	/*
+	 * This is called with interrupts disabled,
+	 * so we need to ack any interrupt that is pending
+	 * or for example ATF will prevent a suspend from completing.
+	 */
+	writel(0x3f, timer_of_base(to) + GPT_IRQ_ACK_REG);
+}
+
 static struct timer_of to = {
 	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
 
@@ -286,6 +308,8 @@ static int __init mtk_gpt_init(struct device_node *node)
 	to.clkevt.set_state_oneshot = mtk_gpt_clkevt_shutdown;
 	to.clkevt.tick_resume = mtk_gpt_clkevt_shutdown;
 	to.clkevt.set_next_event = mtk_gpt_clkevt_next_event;
+	to.clkevt.suspend = mtk_gpt_suspend;
+	to.clkevt.resume = mtk_gpt_resume;
 	to.of_irq.handler = mtk_gpt_interrupt;
 
 	ret = timer_of_init(node, &to);
-- 
2.31.1.607.g51e8a6a459-goog

