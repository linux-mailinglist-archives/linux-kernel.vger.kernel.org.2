Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF49939ED04
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 05:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhFHDYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 23:24:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44241 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhFHDYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 23:24:04 -0400
Received: from mail-pj1-f72.google.com ([209.85.216.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <koba.ko@canonical.com>)
        id 1lqSJf-00036O-6y
        for linux-kernel@vger.kernel.org; Tue, 08 Jun 2021 03:22:11 +0000
Received: by mail-pj1-f72.google.com with SMTP id v2-20020a17090a9602b029015b0bb8b2b9so1307486pjo.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 20:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qY3gh5w2UEiGSIjJrUvXzHVWDt8z4mqhWBxuh6hC9o8=;
        b=oVpzY9K+5byN3Qp8OjpRnR5z/YNaIgbLL3H8vyBR2FLfza6jOrR3Z2hkGwbQ+80Yfl
         dKAfCEfdPPCZpL2q/S3CZ8+8gwH3C1t5sPZthNPe87wldUSA/PcoeUCN64EPhybwuGBM
         sRjaKZRlZQbFpSNOkwqM5QH0LXfd2dVExHFSyOjZzjDcafijtWUvW8d+fHF1rx0UD/F3
         TIih1GDlnrCIm7MapyrQmpVC8dM/Pfua/DvE/AcgdVOaW9qsrYnayGEcvlxWueJTaDCw
         GSIx4Z6qJ7C/BSn+Qfx+a/CPWNnxy0AlAhrAzgdFNg7tguVg+Civijjhrb2ncSp7A4zK
         jLNw==
X-Gm-Message-State: AOAM533wnStmkRWdmfVC/U6DY0ITA6K3z7wWbGR2/5yq6YCKKkS3tBJJ
        sclkKOGBAtrcVjs7KDy26IoNSo6J8yHNpQj50SOpa8wZ8AjU02Qfz0WEbRaZZXE3b6It1OtuhN8
        jwMwd7MtQeTp48zD5rrjNnxLCY40iNsdyX2tERbIJ/A==
X-Received: by 2002:a17:90a:f995:: with SMTP id cq21mr23912286pjb.232.1623122529606;
        Mon, 07 Jun 2021 20:22:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPmUsACNdSGWmO29jsBhpbU+MsbK3P0V2TJJtL6w1qW6ecK7bDaUFta3WAeqBWKJN5Wkg0/w==
X-Received: by 2002:a17:90a:f995:: with SMTP id cq21mr23912270pjb.232.1623122529245;
        Mon, 07 Jun 2021 20:22:09 -0700 (PDT)
Received: from canonical.com (61-220-137-34.HINET-IP.hinet.net. [61.220.137.34])
        by smtp.gmail.com with ESMTPSA id p16sm9577942pgl.60.2021.06.07.20.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 20:22:08 -0700 (PDT)
From:   Koba Ko <koba.ko@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] r8169: Use PHY_POLL when RTL8106E enable ASPM
Date:   Tue,  8 Jun 2021 11:22:07 +0800
Message-Id: <20210608032207.2923574-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For RTL8106E, it's a Fast-ethernet chip.
If ASPM is enabled, the link chang interrupt wouldn't be triggered
immediately and must wait a very long time to get link change interrupt.
Even the link change interrupt isn't triggered, the phy link is already
established.

Use PHY_POLL to watch the status of phy link and disable
the link change interrupt when ASPM is enabled on RTL8106E.

v2: Instead use PHY_POLL and identify 8106E by RTL_GIGA_MAC_VER_39.

Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 2c89cde7da1e..a59cbaef2839 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4914,6 +4914,19 @@ static const struct dev_pm_ops rtl8169_pm_ops = {
 
 #endif /* CONFIG_PM */
 
+static int rtl_phy_poll_quirk(struct rtl8169_private *tp)
+{
+	struct pci_dev *pdev = tp->pci_dev;
+
+	if (!pcie_aspm_enabled(pdev))
+		return 0;
+
+	if (tp->mac_version == RTL_GIGA_MAC_VER_39)
+		return 1;
+
+	return 0;
+}
+
 static void rtl_wol_shutdown_quirk(struct rtl8169_private *tp)
 {
 	/* WoL fails with 8168b when the receiver is disabled. */
@@ -4991,7 +5004,10 @@ static const struct net_device_ops rtl_netdev_ops = {
 
 static void rtl_set_irq_mask(struct rtl8169_private *tp)
 {
-	tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
+	tp->irq_mask = RxOK | RxErr | TxOK | TxErr;
+
+	if (!rtl_phy_poll_quirk(tp))
+		tp->irq_mask |= LinkChg;
 
 	if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
 		tp->irq_mask |= SYSErr | RxOverflow | RxFIFOOver;
@@ -5085,7 +5101,8 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 	new_bus->name = "r8169";
 	new_bus->priv = tp;
 	new_bus->parent = &pdev->dev;
-	new_bus->irq[0] = PHY_MAC_INTERRUPT;
+	new_bus->irq[0] =
+		(rtl_phy_poll_quirk(tp) ? PHY_POLL : PHY_MAC_INTERRUPT);
 	snprintf(new_bus->id, MII_BUS_ID_SIZE, "r8169-%x", pci_dev_id(pdev));
 
 	new_bus->read = r8169_mdio_read_reg;
-- 
2.25.1

