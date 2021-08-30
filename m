Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99AB3FB0D1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 07:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhH3Fag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 01:30:36 -0400
Received: from smtpbguseast1.qq.com ([54.204.34.129]:44203 "EHLO
        smtpbguseast1.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhH3Faf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 01:30:35 -0400
X-QQ-mid: bizesmtp54t1630301358tp73135x
Received: from localhost.localdomain (unknown [111.207.172.18])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 30 Aug 2021 13:29:16 +0800 (CST)
X-QQ-SSF: 0140000000200070D000B00B0000000
X-QQ-FEAT: vCa7dv7JIu7h/OEU73Iq3I8ZIIaeIJtLUZK6oCc7M8av+W9edfBIM+fI9M2GP
        A2WHJV1Iki6zZMV9pK/+OlCGsPC/ZgmXcg3zBjMkdM9nYjSA/vV0S28z9ElUcamn7iCEcb4
        chSjGGNapd4NKOLkm/ctnvQwit9wnz3S55aKV1HLLnnyytYLu0gXZmL14YCEAJKAJFG4Gn7
        bO2zPvAIXgBK7lmWalTzi7C9RWf/+q+oC9wcEnEDvxJYWv0HMcQgeISzM7ZpUcQqkVXslUw
        TQlGSvcmPnWZvIxJGx703rqDxfFkGjeLt2pFrJNmPMLE3euiairPYyxlBVrlstOx1rxO4Ra
        Aw8KpvUF6rA/Q6TH7IDpk+m/GkIWg==
X-QQ-GoodBg: 2
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     davem@davemloft.net, kuba@kernel.org, mcoquelin.stm32@gmail.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] stmmac: dwmac-loongson:add the return value
Date:   Mon, 30 Aug 2021 13:29:13 +0800
Message-Id: <20210830052913.12793-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the return value when phy_mode < 0.

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 4c9a37dd0d3f..ecf759ee1c9f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -109,8 +109,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 		plat->bus_id = pci_dev_id(pdev);
 
 	phy_mode = device_get_phy_mode(&pdev->dev);
-	if (phy_mode < 0)
+	if (phy_mode < 0) {
 		dev_err(&pdev->dev, "phy_mode not found\n");
+		return phy_mode;
+	}
 
 	plat->phy_interface = phy_mode;
 	plat->interface = PHY_INTERFACE_MODE_GMII;
-- 
2.20.1



