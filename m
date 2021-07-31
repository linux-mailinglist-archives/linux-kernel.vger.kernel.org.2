Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35FBB3DC37B
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 07:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbhGaFQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 01:16:04 -0400
Received: from smtpbgsg1.qq.com ([54.254.200.92]:47628 "EHLO smtpbgsg1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231597AbhGaFQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 01:16:03 -0400
X-QQ-mid: bizesmtp48t1627708515tsd9nisp
Received: from localhost.localdomain (unknown [117.152.154.62])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 31 Jul 2021 13:15:13 +0800 (CST)
X-QQ-SSF: 0140000000200050B000B00A0000000
X-QQ-FEAT: VqXHZHhIyRwFZQv1sZxjLUL8hw63WBbHVzC/XJFFmWrbwMpj0veqhOUrD2+Zb
        zuq9VKsfu8JbV+aX+SviiQXiezfrNmjjyyEiWdXCO1585DjsduSG/BvmOjBmCZ5vUJRUXXd
        TNBNRdNJ3xFb4gPY31k2l/0et8iPp/HznBBSSPFVTWKHZxFwQECCsS4y42DR4PmZ/qmv+WO
        +OzSgE60DHgqMhzQlAaNm2pF31bua4QtsJk92aDQKJSyEYaGitkKiyB1LcmgBAgL6lP7yOF
        4ts9Ib/gYXuQPpJgVFhq4rQr55wQti0O1ftFNo24a5YPCumvEnL/b36CiJ5rVq48XrBiOQP
        /bEW0LGsvDDTvIz0b3hlG7caOE0C3cRZPtIRiFPT0tluaNGmJseY6OLchZKnA==
X-QQ-GoodBg: 2
From:   Hao Chen <chenhaoa@uniontech.com>
To:     peppe.cavallaro@st.com
Cc:     alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        davem@davemloft.net, kuba@kernel.org, mcoquelin.stm32@gmail.com,
        linux@armlinux.org.uk, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hao Chen <chenhaoa@uniontech.com>
Subject: [net,v7] net: stmmac: fix 'ethtool -P' return -EBUSY
Date:   Sat, 31 Jul 2021 13:15:10 +0800
Message-Id: <20210731051510.3083-1-chenhaoa@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I want to get permanent MAC address when the card is down. And I think
it is more convenient to get statistics in the down state by 'ethtool -S'.
But current all of the ethool command return -EBUSY.

I don't think we should detect that the network card is up in '. Begin',
which will cause that all the ethtool commands can't be used when the
network card is down. If some ethtool commands can only be used in the
up state, check it in the corresponding ethool OPS function is better.
This is too rude and unreasonable.

I have checked the '.begin' implementation of other drivers, most of which
support the submission of NIC driver for the first time.
They are too old to know why '.begin' is implemented. I suspect that they
have not noticed the usage of '.begin'.

Fixes: 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet
		     controllers.")

Compile-tested on arm64. Tested on an arm64 system with an on-board
STMMAC chip.

Changes v6 ... v7:
- fix arg type error of 'dev' to 'priv->device'.

Changes v5 ... v6:
- The 4.19.90 kernel not support pm_runtime, so implemente '.begin' and
  '.complete' again. Add return value check of pm_runtime function.

Changes v4 ... v5:
- test the '.begin' will return -13 error on my machine based on 4.19.90
  kernel. The platform driver does not supported pm_runtime. So remove the
  implementation of '.begin' and '.complete'.

Changes v3 ... v4:
- implement '.complete' ethtool OPS.

Changes v2 ... v3:
- add linux/pm_runtime.h head file.

Changes v1 ... v2:
- fix spell error of dev.

Signed-off-by: Hao Chen <chenhaoa@uniontech.com>
---
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index d0ce608b81c3..fd5b68f6bf53 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -12,8 +12,9 @@
 #include <linux/ethtool.h>
 #include <linux/interrupt.h>
 #include <linux/mii.h>
-#include <linux/phylink.h>
 #include <linux/net_tstamp.h>
+#include <linux/phylink.h>
+#include <linux/pm_runtime.h>
 #include <asm/io.h>
 
 #include "stmmac.h"
@@ -410,11 +411,18 @@ static void stmmac_ethtool_setmsglevel(struct net_device *dev, u32 level)
 
 }
 
-static int stmmac_check_if_running(struct net_device *dev)
+static int stmmac_ethtool_begin(struct net_device *dev)
 {
-	if (!netif_running(dev))
-		return -EBUSY;
-	return 0;
+	struct stmmac_priv *priv = netdev_priv(dev);
+
+	return pm_runtime_resume_and_get(priv->device);
+}
+
+static void stmmac_ethtool_complete(struct net_device *dev)
+{
+	struct stmmac_priv *priv = netdev_priv(dev);
+
+	pm_runtime_put(priv->device);
 }
 
 static int stmmac_ethtool_get_regs_len(struct net_device *dev)
@@ -1073,7 +1081,8 @@ static int stmmac_set_tunable(struct net_device *dev,
 static const struct ethtool_ops stmmac_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
-	.begin = stmmac_check_if_running,
+	.begin = stmmac_ethtool_begin,
+	.complete = stmmac_ethtool_complete,
 	.get_drvinfo = stmmac_ethtool_getdrvinfo,
 	.get_msglevel = stmmac_ethtool_getmsglevel,
 	.set_msglevel = stmmac_ethtool_setmsglevel,
-- 
2.20.1



