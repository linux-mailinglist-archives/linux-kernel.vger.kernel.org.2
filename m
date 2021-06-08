Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3925239F047
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhFHIAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:00:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53573 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231228AbhFHIAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:00:10 -0400
X-UUID: ced58110a58f4509a4277dd642c5ec22-20210608
X-UUID: ced58110a58f4509a4277dd642c5ec22-20210608
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 231150256; Tue, 08 Jun 2021 15:58:15 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Jun 2021 15:58:14 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Jun 2021 15:58:13 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Yuwen Ng <yuwen.ng@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 19/23] usb: mtu3: support runtime PM for host mode
Date:   Tue, 8 Jun 2021 15:57:45 +0800
Message-ID: <1623139069-8173-20-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1623139069-8173-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1623139069-8173-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a dedicated wakeup irq for runtime suspend/resume, and interrupts
names are provided if using wakeup irq, this patch only support host
mode.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3.h      |  1 +
 drivers/usb/mtu3/mtu3_core.c | 13 ++++++--
 drivers/usb/mtu3/mtu3_plat.c | 62 +++++++++++++++++++++++++++++++++---
 3 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index 710abe83ba1a..1f479a867ed1 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -247,6 +247,7 @@ struct ssusb_mtk {
 	void __iomem *ippc_base;
 	struct phy **phys;
 	int num_phys;
+	int wakeup_irq;
 	/* common power & clock */
 	struct regulator *vusb33;
 	struct clk *sys_clk;
diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index 562f4357831e..6d23acb4fffc 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -888,9 +888,16 @@ int ssusb_gadget_init(struct ssusb_mtk *ssusb)
 	if (mtu == NULL)
 		return -ENOMEM;
 
-	mtu->irq = platform_get_irq(pdev, 0);
-	if (mtu->irq < 0)
-		return mtu->irq;
+	mtu->irq = platform_get_irq_byname_optional(pdev, "device");
+	if (mtu->irq < 0) {
+		if (mtu->irq == -EPROBE_DEFER)
+			return mtu->irq;
+
+		/* for backward compatibility */
+		mtu->irq = platform_get_irq(pdev, 0);
+		if (mtu->irq < 0)
+			return mtu->irq;
+	}
 	dev_info(dev, "irq %d\n", mtu->irq);
 
 	mtu->mac_base = devm_platform_ioremap_resource_byname(pdev, "mac");
diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index 30b940ebe9b4..9f8f2759b08e 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -13,6 +13,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
 
 #include "mtu3.h"
 #include "mtu3_dr.h"
@@ -266,6 +267,10 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 	if (IS_ERR(ssusb->ippc_base))
 		return PTR_ERR(ssusb->ippc_base);
 
+	ssusb->wakeup_irq = platform_get_irq_byname_optional(pdev, "wakeup");
+	if (ssusb->wakeup_irq == -EPROBE_DEFER)
+		return ssusb->wakeup_irq;
+
 	ssusb->dr_mode = usb_get_dr_mode(dev);
 	if (ssusb->dr_mode == USB_DR_MODE_UNKNOWN)
 		ssusb->dr_mode = USB_DR_MODE_OTG;
@@ -353,14 +358,25 @@ static int mtu3_probe(struct platform_device *pdev)
 	ssusb_debugfs_create_root(ssusb);
 
 	/* enable power domain */
+	pm_runtime_set_active(dev);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_autosuspend_delay(dev, 4000);
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
-	device_enable_async_suspend(dev);
 
 	ret = ssusb_rscs_init(ssusb);
 	if (ret)
 		goto comm_init_err;
 
+	if (ssusb->wakeup_irq > 0) {
+		ret = dev_pm_set_dedicated_wake_irq(dev, ssusb->wakeup_irq);
+		if (ret) {
+			dev_err(dev, " failed to set wakeup irq %d\n", ssusb->wakeup_irq);
+			goto comm_exit;
+		}
+		dev_info(dev, "wakeup irq %d\n", ssusb->wakeup_irq);
+	}
+
 	ssusb_ip_sw_reset(ssusb);
 
 	if (IS_ENABLED(CONFIG_USB_MTU3_HOST))
@@ -411,6 +427,11 @@ static int mtu3_probe(struct platform_device *pdev)
 		goto comm_exit;
 	}
 
+	device_enable_async_suspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+	pm_runtime_forbid(dev);
+
 	return 0;
 
 host_exit:
@@ -431,6 +452,8 @@ static int mtu3_remove(struct platform_device *pdev)
 {
 	struct ssusb_mtk *ssusb = platform_get_drvdata(pdev);
 
+	pm_runtime_get_sync(&pdev->dev);
+
 	switch (ssusb->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
 		ssusb_gadget_exit(ssusb);
@@ -448,9 +471,10 @@ static int mtu3_remove(struct platform_device *pdev)
 	}
 
 	ssusb_rscs_exit(ssusb);
-	pm_runtime_put_sync(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
 	ssusb_debugfs_remove_root(ssusb);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 
 	return 0;
 }
@@ -459,7 +483,7 @@ static int mtu3_remove(struct platform_device *pdev)
  * when support dual-role mode, we reject suspend when
  * it works as device mode;
  */
-static int __maybe_unused mtu3_suspend(struct device *dev)
+static int mtu3_suspend_common(struct device *dev, pm_message_t msg)
 {
 	struct ssusb_mtk *ssusb = dev_get_drvdata(dev);
 
@@ -477,7 +501,7 @@ static int __maybe_unused mtu3_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused mtu3_resume(struct device *dev)
+static int mtu3_resume_common(struct device *dev, pm_message_t msg)
 {
 	struct ssusb_mtk *ssusb = dev_get_drvdata(dev);
 	int ret;
@@ -506,8 +530,36 @@ static int __maybe_unused mtu3_resume(struct device *dev)
 	return ret;
 }
 
+static int __maybe_unused mtu3_suspend(struct device *dev)
+{
+	return mtu3_suspend_common(dev, PMSG_SUSPEND);
+}
+
+static int __maybe_unused mtu3_resume(struct device *dev)
+{
+	return mtu3_resume_common(dev, PMSG_SUSPEND);
+}
+
+static int __maybe_unused mtu3_runtime_suspend(struct device *dev)
+{
+	if (!device_may_wakeup(dev))
+		return 0;
+
+	return mtu3_suspend_common(dev, PMSG_AUTO_SUSPEND);
+}
+
+static int __maybe_unused mtu3_runtime_resume(struct device *dev)
+{
+	if (!device_may_wakeup(dev))
+		return 0;
+
+	return mtu3_resume_common(dev, PMSG_AUTO_SUSPEND);
+}
+
 static const struct dev_pm_ops mtu3_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(mtu3_suspend, mtu3_resume)
+	SET_RUNTIME_PM_OPS(mtu3_runtime_suspend,
+			   mtu3_runtime_resume, NULL)
 };
 
 #define DEV_PM_OPS (IS_ENABLED(CONFIG_PM) ? &mtu3_pm_ops : NULL)
-- 
2.18.0

