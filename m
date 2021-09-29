Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3F641C325
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 13:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245636AbhI2LHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 07:07:17 -0400
Received: from smtp181.sjtu.edu.cn ([202.120.2.181]:44074 "EHLO
        smtp181.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244363AbhI2LHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 07:07:16 -0400
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp181.sjtu.edu.cn (Postfix) with ESMTPS id 789C21008CBC0;
        Wed, 29 Sep 2021 19:05:34 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id 8CD3F200B5753;
        Wed, 29 Sep 2021 19:05:31 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Rn75ASWTZkzI; Wed, 29 Sep 2021 19:05:31 +0800 (CST)
Received: from guozhi-ipads.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
        (Authenticated sender: qtxuning1999@sjtu.edu.cn)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id 84914200C02CB;
        Wed, 29 Sep 2021 19:05:14 +0800 (CST)
From:   Guo Zhi <qtxuning1999@sjtu.edu.cn>
To:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Guo Zhi <qtxuning1999@sjtu.edu.cn>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clockresource/npcm: Fix kernel pointer leak
Date:   Wed, 29 Sep 2021 19:04:29 +0800
Message-Id: <20210929110431.1113708-1-qtxuning1999@sjtu.edu.cn>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointers should be printed with %p rather than %px
which printed kernel pointer directly.
Change %px to %p to print the secured pointer.

Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
---
 drivers/clocksource/timer-npcm7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-npcm7xx.c b/drivers/clocksource/timer-npcm7xx.c
index a00520cbb660..bf477685d545 100644
--- a/drivers/clocksource/timer-npcm7xx.c
+++ b/drivers/clocksource/timer-npcm7xx.c
@@ -202,7 +202,7 @@ static int __init npcm7xx_timer_init(struct device_node *np)
 	npcm7xx_clocksource_init();
 	npcm7xx_clockevents_init();
 
-	pr_info("Enabling NPCM7xx clocksource timer base: %px, IRQ: %d ",
+	pr_info("Enabling NPCM7xx clocksource timer base: %p, IRQ: %d ",
 		timer_of_base(&npcm7xx_to), timer_of_irq(&npcm7xx_to));
 
 	return 0;
-- 
2.33.0

