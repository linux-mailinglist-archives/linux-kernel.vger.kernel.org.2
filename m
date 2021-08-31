Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BF03FC079
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 03:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239264AbhHaB0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 21:26:37 -0400
Received: from smtpbguseast2.qq.com ([54.204.34.130]:55041 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbhHaB0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 21:26:36 -0400
X-QQ-mid: bizesmtp32t1630373126teomyjyj
Received: from localhost.localdomain (unknown [124.126.19.250])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 31 Aug 2021 09:25:25 +0800 (CST)
X-QQ-SSF: 0140000000200070D000B00A0000000
X-QQ-FEAT: QX/rXDl9P1ur4thuaXke1KHxASVcRttKMr8SgRrWrHJ7vdSYee+STb7rwRvNS
        sSioNxtoNRvQdXaHdt/gZP7ep3cLZ+2mSc+TLLDhu+PJRkPnr/3b6me1qCR+Ft/sr7JOmCx
        ClRCMfbOCyqe8Mp+C1wt3z+xvjjxhapaVFVsPC+a03iFM6qMDX+4ARgI+FYShyrep2X3N3J
        igw08sXbMgoIypheYtzNk6gSadWhe8Yi7n5SWtXP0mAGVGp2TUWR+pCJ9Psdgfg0saf3ydE
        q+laIH+nK1uVbouPXdkNK/TWoAzcJ7cDssXQbaxkGtxdCJ0v01SVMeHmEzgiH7k4/O2sWEb
        oOvOrI5
X-QQ-GoodBg: 2
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     davem@davemloft.net, kuba@kernel.org, mcoquelin.stm32@gmail.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH v3] stmmac: dwmac-loongson: change the pr_info() to dev_err() in loongson_dwmac_probe()
Date:   Tue, 31 Aug 2021 09:25:23 +0800
Message-Id: <20210831012523.2691-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the pr_info to dev_err.

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
v3:Remove the redundant blank line.
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 4c9a37dd0d3f..f03f25d9adb0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -54,14 +54,13 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	bool mdio = false;
 
 	np = dev_of_node(&pdev->dev);
-
 	if (!np) {
-		pr_info("dwmac_loongson_pci: No OF node\n");
+		dev_err(&pdev->dev, "dwmac_loongson_pci: No OF node\n");
 		return -ENODEV;
 	}
 
 	if (!of_device_is_compatible(np, "loongson, pci-gmac")) {
-		pr_info("dwmac_loongson_pci: Incompatible OF node\n");
+		dev_err(&pdev->dev, "dwmac_loongson_pci: Incompatible OF node\n");
 		return -ENODEV;
 	}
 
-- 
2.20.1



