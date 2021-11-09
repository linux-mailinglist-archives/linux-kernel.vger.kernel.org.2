Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65B544B093
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 16:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbhKIPp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 10:45:58 -0500
Received: from air.basealt.ru ([194.107.17.39]:51824 "EHLO air.basealt.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229955AbhKIPp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 10:45:56 -0500
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Nov 2021 10:45:56 EST
Received: by air.basealt.ru (Postfix, from userid 490)
        id EEEE35895D6; Tue,  9 Nov 2021 15:35:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on
        sa.local.altlinux.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.1
Received: from asheplyakov-rocket.smb.basealt.ru (unknown [193.43.9.4])
        by air.basealt.ru (Postfix) with ESMTPSA id 82A5058942B;
        Tue,  9 Nov 2021 15:34:59 +0000 (UTC)
From:   Alexey Sheplyakov <asheplyakov@basealt.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Alexey Sheplyakov <asheplyakov@basealt.ru>,
        "Vadim V . Vlasov" <vadim.vlasov@elpitech.ru>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] drivers/clocksource/dw_apb_timer_of: fixed probe failure
Date:   Tue,  9 Nov 2021 19:34:02 +0400
Message-Id: <20211109153401.157491-1-asheplyakov@basealt.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver refuses to probe with -EINVAL since the commit
5d9814df0aec ("clocksource/drivers/dw_apb_timer_of: Add error handling if no clock available").

Before the driver used to probe successfully if either
"clock-freq" or "clock-frequency" properties has been specified
in the device tree.

That commit changed

if (A && B)
	panic("No clock nor clock-frequency property");

into

if (!A && !B)
	return 0;

That's a bug: the reverse of `A && B` is '!A || !B', not '!A && !B'

Signed-off-by: Vadim V. Vlasov <vadim.vlasov@elpitech.ru>
Signed-off-by: Alexey Sheplyakov <asheplyakov@basealt.ru>
Fixes: 5d9814df0aec56a6 ("clocksource/drivers/dw_apb_timer_of: Add error handling if no clock available").
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vadim V. Vlasov <vadim.vlasov@elpitech.ru>
---
 drivers/clocksource/dw_apb_timer_of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
index 3819ef5b7098..3245eb0c602d 100644
--- a/drivers/clocksource/dw_apb_timer_of.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -47,7 +47,7 @@ static int __init timer_get_base_and_rate(struct device_node *np,
 			pr_warn("pclk for %pOFn is present, but could not be activated\n",
 				np);
 
-	if (!of_property_read_u32(np, "clock-freq", rate) &&
+	if (!of_property_read_u32(np, "clock-freq", rate) ||
 	    !of_property_read_u32(np, "clock-frequency", rate))
 		return 0;
 
-- 
2.30.2

