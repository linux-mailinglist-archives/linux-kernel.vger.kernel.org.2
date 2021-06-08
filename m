Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD8B39FB17
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 17:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhFHPp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 11:45:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232310AbhFHPpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:45:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D3B761354;
        Tue,  8 Jun 2021 15:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623167039;
        bh=+6X6fbZAHwPHNf4hp9N7d+r6MK51/LkysHT0rpz/4EE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IA0EVhs1fdei1bP7ZgR0vVbjQ3rYuJs8nVHdPzOC8IcQRiTwRYHCZnxXfNPUwy7Vr
         JTPjBMsQexNBA7C5gphKXPAmE/t/XP1Y9yxyhFzws9A+cZLg7oEHWhbxCLRxjRZvom
         sqxacUsXddeGxzPTPmuDP3MopaNyuNkQ919pDh2csNJzdZkBnsxffhoM4J2uK9WxG6
         4GbMAMig/6GMw9KUbFeC6GOcjUKYvqxY7SGl5brU0xkvUi//nMR1x12MUQQ8j6IgX3
         jv9T0A7i629U9/xHrVGTMLGr+10+kIZbwfngQ8JuLLZ2rRO6ZH66EnRonnplIb4glG
         UoFQI19OufWNg==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/2] clocksource/drivers/exynos_mct: Mark MCT device as CLOCK_EVT_FEAT_PERCPU
Date:   Tue,  8 Jun 2021 16:43:41 +0100
Message-Id: <20210608154341.10794-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210608154341.10794-1-will@kernel.org>
References: <20210608154341.10794-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "mct_tick" is a per-cpu clockevents device. Set the
CLOCK_EVT_FEAT_PERCPU feature to prevent e.g. mct_tick0 being unsafely
designated as the global broadcast timer and instead treat the device as
a per-cpu wakeup timer.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/clocksource/exynos_mct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 804d3e01c8f4..5e3e96d3d1b9 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -465,7 +465,8 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 	evt->set_state_oneshot = set_state_shutdown;
 	evt->set_state_oneshot_stopped = set_state_shutdown;
 	evt->tick_resume = set_state_shutdown;
-	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
+			CLOCK_EVT_FEAT_PERCPU;
 	evt->rating = MCT_CLKEVENTS_RATING,
 
 	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
-- 
2.32.0.rc1.229.g3e70b5a671-goog

