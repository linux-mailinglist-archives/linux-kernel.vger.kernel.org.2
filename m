Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613E239FB16
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 17:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhFHPpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 11:45:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231253AbhFHPpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:45:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 572456135D;
        Tue,  8 Jun 2021 15:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623167037;
        bh=bsYzVEMG9BYgcZnx/EZ1OP5xs5Pgm+sMA9zDhEIER7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R2L0bJ8OntAbkqWgj+6CPqwzpwjNVDcxjfqRh23rrNPZL+s7hVpcfmv2SpaywA60P
         u3FyUsrQlD50xke6w80M65EW4hBxS0GnWN0z8toOJ2597ng1tmerE4cfk9h+REmx/f
         Zq7ISdW9u2HUW6PntVDh27HjS4nt/cqo4a22BLOMcpSwh1FJSBeV4mje1XCEkp0ylQ
         DpDk6TEDPMIxlBcgPcpks78A8UhHdZ565vzfTz88LqoR0F38wxVMd/Nglgac8nIDgZ
         p9C8qNjYUIFKmO6eD4KjB11kVeiVVM4/MeEcBIhsK726zFvTWGRdOeJaLTJUXTi+vh
         JG0Acl9AqjRQw==
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
Subject: [PATCH 1/2] clocksource/drivers/exynos_mct: Prioritise Arm arch timer on arm64
Date:   Tue,  8 Jun 2021 16:43:40 +0100
Message-Id: <20210608154341.10794-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210608154341.10794-1-will@kernel.org>
References: <20210608154341.10794-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All arm64 CPUs feature an architected timer, which offers a relatively
low-latency interface to a per-cpu clocksource and timer. For the most
part, using this interface is a no-brainer, with the exception of SoCs
where it cannot be used to wake up from deep idle state (i.e.
CLOCK_EVT_FEAT_C3STOP is set).

On the contrary, the Exynos MCT is extremely slow to access yet can be
used as a wakeup source. In preparation for using the Exynos MCT as a
potential wakeup timer for the Arm architected timer, reduce its ratings
so that the architected timer is preferred.

This effectively reverts the decision made in 6282edb72bed
("clocksource/drivers/exynos_mct: Increase priority over ARM arch timer")
for arm64, as the reasoning for the original change was to work around
a 32-bit SoC design.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/clocksource/exynos_mct.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index fabad79baafc..804d3e01c8f4 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -51,6 +51,15 @@
 
 #define TICK_BASE_CNT	1
 
+#ifdef CONFIG_ARM
+/* Use values higher than ARM arch timer. See 6282edb72bed. */
+#define MCT_CLKSOURCE_RATING		450
+#define MCT_CLKEVENTS_RATING		500
+#else
+#define MCT_CLKSOURCE_RATING		350
+#define MCT_CLKEVENTS_RATING		350
+#endif
+
 enum {
 	MCT_INT_SPI,
 	MCT_INT_PPI
@@ -206,7 +215,7 @@ static void exynos4_frc_resume(struct clocksource *cs)
 
 static struct clocksource mct_frc = {
 	.name		= "mct-frc",
-	.rating		= 450,	/* use value higher than ARM arch timer */
+	.rating		= MCT_CLKSOURCE_RATING,
 	.read		= exynos4_frc_read,
 	.mask		= CLOCKSOURCE_MASK(32),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
@@ -457,7 +466,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 	evt->set_state_oneshot_stopped = set_state_shutdown;
 	evt->tick_resume = set_state_shutdown;
 	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
-	evt->rating = 500;	/* use value higher than ARM arch timer */
+	evt->rating = MCT_CLKEVENTS_RATING,
 
 	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
 
-- 
2.32.0.rc1.229.g3e70b5a671-goog

