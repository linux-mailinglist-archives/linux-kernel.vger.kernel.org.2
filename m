Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E85730AA90
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhBAPJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:09:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:37674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231362AbhBAPIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:08:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0425E64DA5;
        Mon,  1 Feb 2021 15:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612192091;
        bh=tCXMXsxrCf3yHE4Kyh5CUR0UJfTh9canQVGIxxaS64Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pEugpGDC/OqN7cdsAqxFa7WiQLAhlfokv80S2T790AhgyS3uACG04m1gU75nkpygA
         Ikx2tRrJ9cpM3od3rrfuZleG0szjku/NXE1hzzoQB23sntbybQ79YuRX4Ke12HK8Mq
         gwWFu//UCyFt58baRSaJWs4bgFg42IGL75d6wnMdwXXVvTaECuq/HxWVhckMblyRmD
         AelP9CukTWcbb43rUGcy7WfM05rbxmVoEXZvCSWmMWHSF/QkMe5utCA9l4urGn6Og5
         mXOvjpkscu6TADJq8HqGKLFyZBTAcqYHd4zCN2hKUkYfJxX808rf3dkYWI9gRxW9GI
         6Wl+/rMIvtfhg==
Received: by pali.im (Postfix)
        id C1968872; Mon,  1 Feb 2021 16:08:08 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Peter Chen <peter.chen@nxp.com>
Cc:     Tomasz Maciej Nowak <tmn505@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jun Li <jun.li@nxp.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Marek Behun <marek.behun@nic.cz>
Subject: [PATCH v2] usb: host: xhci: mvebu: make USB 3.0 PHY optional for Armada 3720
Date:   Mon,  1 Feb 2021 16:08:03 +0100
Message-Id: <20210201150803.7305-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201223162403.10897-1-pali@kernel.org>
References: <20201223162403.10897-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older ATF does not provide SMC call for USB 3.0 phy power on functionality
and therefore initialization of xhci-hcd is failing when older version of
ATF is used. In this case phy_power_on() function returns -EOPNOTSUPP.

[    3.108467] mvebu-a3700-comphy d0018300.phy: unsupported SMC call, try updating your firmware
[    3.117250] phy phy-d0018300.phy.0: phy poweron failed --> -95
[    3.123465] xhci-hcd: probe of d0058000.usb failed with error -95

This patch introduces a new plat_setup callback for xhci platform drivers
which is called prior calling usb_add_hcd() function. This function at its
beginning skips PHY init if hcd->skip_phy_initialization is set.

Current init_quirk callback for xhci platform drivers is called from
xhci_plat_setup() function which is called after chip reset completes.
It happens in the middle of the usb_add_hcd() function and therefore this
callback cannot be used for setting if PHY init should be skipped or not.

For Armada 3720 this patch introduce a new xhci_mvebu_a3700_plat_setup()
function configured as a xhci platform plat_setup callback. This new
function calls phy_power_on() and in case it returns -EOPNOTSUPP then
XHCI_SKIP_PHY_INIT quirk is set to instruct xhci-plat to skip PHY
initialization.

This patch fixes above failure by ignoring 'not supported' error in
xhci-hcd driver. In this case it is expected that phy is already power on.

It fixes initialization of xhci-hcd on Espressobin boards where is older
Marvell's Arm Trusted Firmware without SMC call for USB 3.0 phy power.

This is regression introduced in commit bd3d25b07342 ("arm64: dts: marvell:
armada-37xx: link USB hosts with their PHYs") where USB 3.0 phy was defined
and therefore xhci-hcd on Espressobin with older ATF started failing.

Signed-off-by: Pali Rohár <pali@kernel.org>
Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>
Fixes: bd3d25b07342 ("arm64: dts: marvell: armada-37xx: link USB hosts with their PHYs")
Cc: <stable@vger.kernel.org> # 5.1+: ea17a0f153af: phy: marvell: comphy: Convert internal SMCC firmware return codes to errno
Cc: <stable@vger.kernel.org> # 5.1+: f768e718911e: usb: host: xhci-plat: add priv quirk for skip PHY initialization

---
Changes in v2:
* Drop dependency on patch "usb: host: xhci-plat: fix support for XHCI_SKIP_PHY_INIT quirk"
* Introduce a new .plat_setup callback for xhci-plat drivers in this patch (to simplify backporting and review)
* Move implementation from xhci_mvebu_mbus_init_quirk() into xhci_mvebu_a3700_plat_setup()
---
 drivers/usb/host/xhci-mvebu.c | 42 +++++++++++++++++++++++++++++++++++
 drivers/usb/host/xhci-mvebu.h |  6 +++++
 drivers/usb/host/xhci-plat.c  | 20 ++++++++++++++++-
 drivers/usb/host/xhci-plat.h  |  1 +
 4 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mvebu.c b/drivers/usb/host/xhci-mvebu.c
index 60651a50770f..8ca1a235d164 100644
--- a/drivers/usb/host/xhci-mvebu.c
+++ b/drivers/usb/host/xhci-mvebu.c
@@ -8,6 +8,7 @@
 #include <linux/mbus.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/phy/phy.h>
 
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
@@ -74,6 +75,47 @@ int xhci_mvebu_mbus_init_quirk(struct usb_hcd *hcd)
 	return 0;
 }
 
+int xhci_mvebu_a3700_plat_setup(struct usb_hcd *hcd)
+{
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+	struct device *dev = hcd->self.controller;
+	struct phy *phy;
+	int ret;
+
+	/* Old bindings miss the PHY handle */
+	phy = of_phy_get(dev->of_node, "usb3-phy");
+	if (IS_ERR(phy) && PTR_ERR(phy) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	else if (IS_ERR(phy))
+		goto phy_out;
+
+	ret = phy_init(phy);
+	if (ret)
+		goto phy_put;
+
+	ret = phy_set_mode(phy, PHY_MODE_USB_HOST_SS);
+	if (ret)
+		goto phy_exit;
+
+	ret = phy_power_on(phy);
+	if (ret == -EOPNOTSUPP) {
+		/* Skip initializatin of XHCI PHY when it is unsupported by firmware */
+		dev_warn(dev, "PHY unsupported by firmware\n");
+		xhci->quirks |= XHCI_SKIP_PHY_INIT;
+	}
+	if (ret)
+		goto phy_exit;
+
+	phy_power_off(phy);
+phy_exit:
+	phy_exit(phy);
+phy_put:
+	of_phy_put(phy);
+phy_out:
+
+	return 0;
+}
+
 int xhci_mvebu_a3700_init_quirk(struct usb_hcd *hcd)
 {
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
diff --git a/drivers/usb/host/xhci-mvebu.h b/drivers/usb/host/xhci-mvebu.h
index 3be021793cc8..01bf3fcb3eca 100644
--- a/drivers/usb/host/xhci-mvebu.h
+++ b/drivers/usb/host/xhci-mvebu.h
@@ -12,6 +12,7 @@ struct usb_hcd;
 
 #if IS_ENABLED(CONFIG_USB_XHCI_MVEBU)
 int xhci_mvebu_mbus_init_quirk(struct usb_hcd *hcd);
+int xhci_mvebu_a3700_plat_setup(struct usb_hcd *hcd);
 int xhci_mvebu_a3700_init_quirk(struct usb_hcd *hcd);
 #else
 static inline int xhci_mvebu_mbus_init_quirk(struct usb_hcd *hcd)
@@ -19,6 +20,11 @@ static inline int xhci_mvebu_mbus_init_quirk(struct usb_hcd *hcd)
 	return 0;
 }
 
+static inline int xhci_mvebu_a3700_plat_setup(struct usb_hcd *hcd)
+{
+	return 0;
+}
+
 static inline int xhci_mvebu_a3700_init_quirk(struct usb_hcd *hcd)
 {
 	return 0;
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 4d34f6005381..c1edcc9b13ce 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -44,6 +44,16 @@ static void xhci_priv_plat_start(struct usb_hcd *hcd)
 		priv->plat_start(hcd);
 }
 
+static int xhci_priv_plat_setup(struct usb_hcd *hcd)
+{
+	struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
+
+	if (!priv->plat_setup)
+		return 0;
+
+	return priv->plat_setup(hcd);
+}
+
 static int xhci_priv_init_quirk(struct usb_hcd *hcd)
 {
 	struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
@@ -111,6 +121,7 @@ static const struct xhci_plat_priv xhci_plat_marvell_armada = {
 };
 
 static const struct xhci_plat_priv xhci_plat_marvell_armada3700 = {
+	.plat_setup = xhci_mvebu_a3700_plat_setup,
 	.init_quirk = xhci_mvebu_a3700_init_quirk,
 };
 
@@ -330,7 +341,14 @@ static int xhci_plat_probe(struct platform_device *pdev)
 
 	hcd->tpl_support = of_usb_host_tpl_support(sysdev->of_node);
 	xhci->shared_hcd->tpl_support = hcd->tpl_support;
-	if (priv && (priv->quirks & XHCI_SKIP_PHY_INIT))
+
+	if (priv) {
+		ret = xhci_priv_plat_setup(hcd);
+		if (ret)
+			goto disable_usb_phy;
+	}
+
+	if ((xhci->quirks & XHCI_SKIP_PHY_INIT) || (priv && (priv->quirks & XHCI_SKIP_PHY_INIT)))
 		hcd->skip_phy_initialization = 1;
 
 	if (priv && (priv->quirks & XHCI_SG_TRB_CACHE_SIZE_QUIRK))
diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
index 1fb149d1fbce..561d0b7bce09 100644
--- a/drivers/usb/host/xhci-plat.h
+++ b/drivers/usb/host/xhci-plat.h
@@ -13,6 +13,7 @@
 struct xhci_plat_priv {
 	const char *firmware_name;
 	unsigned long long quirks;
+	int (*plat_setup)(struct usb_hcd *);
 	void (*plat_start)(struct usb_hcd *);
 	int (*init_quirk)(struct usb_hcd *);
 	int (*suspend_quirk)(struct usb_hcd *);
-- 
2.20.1

