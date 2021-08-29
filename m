Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4D73FA848
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 05:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbhH2DCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 23:02:53 -0400
Received: from vps.xff.cz ([195.181.215.36]:38358 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232718AbhH2DCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 23:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1630205527; bh=/dcnqM9/YFVaRxj916K0OLWPEPN969q0pSQGyqMxozM=;
        h=From:To:Cc:Subject:Date:From;
        b=kk26Zkl2XvoT3MPqFnBwx/Z1KK8aG91s2PwgJIOkC1CPnkMwmJOE9RFm9YmuQvIui
         XGNHfxaWiBVXBZJ7+/K1e4fhaXXwJ762wKw3LQBilqt2Ewr9rdshKmxwWYAY5dsMKT
         i3cVKqSRePNyFwyf7b8MRcXwJf36TsMq7mTI6ElA=
From:   Ondrej Jirman <megous@megous.com>
To:     Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Ondrej Jirman <megous@megous.com>
Subject: [PATCH] mfd: rk808: Add support for power off on RK817
Date:   Sun, 29 Aug 2021 04:51:53 +0200
Message-Id: <20210829025153.1058978-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK817 has a power-off bit in SYS_CFG3. Add support for powering
off the PMIC.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 drivers/mfd/rk808.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 77ccd31ca1d9..b181fe401330 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -543,6 +543,10 @@ static void rk808_pm_power_off(void)
 		reg = RK808_DEVCTRL_REG,
 		bit = DEV_OFF_RST;
 		break;
+	case RK817_ID:
+		reg = RK817_SYS_CFG(3);
+		bit = DEV_OFF;
+		break;
 	case RK818_ID:
 		reg = RK818_DEVCTRL_REG;
 		bit = DEV_OFF;
-- 
2.33.0

