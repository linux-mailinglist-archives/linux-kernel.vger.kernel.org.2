Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE15359D91
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhDILkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:40:42 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:41522 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233293AbhDILkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:40:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id AC1D6FB05;
        Fri,  9 Apr 2021 13:40:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XARy5O7q8hdf; Fri,  9 Apr 2021 13:40:22 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 9FD56404BF; Fri,  9 Apr 2021 13:40:21 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Liu Ying <victor.liu@nxp.com>
Subject: [PATCH v5 1/2] phy: core: Use runtime pm during configure too
Date:   Fri,  9 Apr 2021 13:40:20 +0200
Message-Id: <2de2ee26bbf443491dfff1c802f2fa9efaf58d52.1617968250.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1617968250.git.agx@sigxcpu.org>
References: <cover.1617968250.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phy's configure phase usually needs register access so taking the
device out of pm_runtime suspend looks useful.

There's currently two in tree drivers using runtime pm and .configure
(qualcomm/phy-qcom-qmp.c, rockchip/phy-rockchip-inno-dsidphy.c) but both
don't use the phy layers 'transparent' runtime phy_pm_runtime handling
but manage it manually so this will for now only affect the
phy-fsl-imx8-mipi-dphy driver.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/phy/phy-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index ccb575b13777..256a964d52d3 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -470,10 +470,16 @@ int phy_configure(struct phy *phy, union phy_configure_opts *opts)
 	if (!phy->ops->configure)
 		return -EOPNOTSUPP;
 
+	ret = phy_pm_runtime_get_sync(phy);
+	if (ret < 0 && ret != -ENOTSUPP)
+		return ret;
+	ret = 0; /* Override possible ret == -ENOTSUPP */
+
 	mutex_lock(&phy->mutex);
 	ret = phy->ops->configure(phy, opts);
 	mutex_unlock(&phy->mutex);
 
+	phy_pm_runtime_put(phy);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(phy_configure);
-- 
2.30.1

