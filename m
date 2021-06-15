Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5520E3A7DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhFOL4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:56:53 -0400
Received: from mail-m121144.qiye.163.com ([115.236.121.144]:59620 "EHLO
        mail-m121144.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhFOL4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:56:52 -0400
DKIM-Signature: a=rsa-sha256;
        b=PeXQMiK833PYRJEXSxaKzTZr1YVKKrNknEpqbzNF8/lYiDfP90V0CA22TNiUB0wDZ2e8+r6WPvtWj0D3z01AtvlSUxfnO8aVVRPGwQ+eHzK0y3WVKx7bITv2v/AiEc9+QiwLlXhanmzjf0ByDb92qNhBm0Kn4UwET9f2VhBVfzw=;
        c=relaxed/relaxed; s=default; d=vivo.com; v=1;
        bh=xmHRxG3m1xsUuLLEsYRjrxPQsscyfqKw81CZEkNKSp4=;
        h=date:mime-version:subject:message-id:from;
Received: from Wanjb.localdomain (unknown [36.152.145.182])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id 213F8AC031D;
        Tue, 15 Jun 2021 19:54:47 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] clocksource: Remove duplicated argument in arm_global_timer
Date:   Tue, 15 Jun 2021 19:54:40 +0800
Message-Id: <20210615115440.8881-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGR5OH1YdQx9LGhpMQklLQ0tVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mk06Cio4Qz8RK0hDMU4CKSgY
        LEoKCihVSlVKTUlITE5DS0NMTk5IVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKQklMNwY+
X-HM-Tid: 0a7a0f862454b039kuuu213f8ac031d
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
drivers/clocksource/arm_global_timer.c:107:4-23: 
duplicated argument to & or |

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/clocksource/arm_global_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index 60a8047fd32e..fdf32a0c86d1 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -104,7 +104,7 @@ static void gt_compare_set(unsigned long delta, int periodic)
 	counter += delta;
 	ctrl = readl(gt_base + GT_CONTROL);
 	ctrl &= ~(GT_CONTROL_COMP_ENABLE | GT_CONTROL_IRQ_ENABLE |
-		  GT_CONTROL_AUTO_INC | GT_CONTROL_AUTO_INC);
+		  GT_CONTROL_AUTO_INC);
 	ctrl |= GT_CONTROL_TIMER_ENABLE;
 	writel_relaxed(ctrl, gt_base + GT_CONTROL);
 	writel_relaxed(lower_32_bits(counter), gt_base + GT_COMP0);
-- 
2.20.1

