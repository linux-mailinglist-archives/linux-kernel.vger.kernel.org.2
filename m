Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29916330622
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 03:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbhCHCxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 21:53:21 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:36619 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232426AbhCHCwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 21:52:31 -0500
X-UUID: d4cd30276d35464a93d9f47656204ef6-20210308
X-UUID: d4cd30276d35464a93d9f47656204ef6-20210308
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1494062988; Mon, 08 Mar 2021 10:52:28 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 10:52:26 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Mar 2021 10:52:26 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ikjoon Jang <ikjn@chromium.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v2 15/18] usb: xhci-mtk: support to build xhci-mtk-hcd.ko
Date:   Mon, 8 Mar 2021 10:52:04 +0800
Message-ID: <0b62e21ddfacc1c2874726dd27ccab80c993f303.1615170625.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <d287899e6beb2fc1bfb8900c75a872f628ecde55.1615170625.git.chunfeng.yun@mediatek.com>
References: <d287899e6beb2fc1bfb8900c75a872f628ecde55.1615170625.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently xhci-hcd.ko building depends on USB_XHCI_MTK, this
is not flexible for some cases. For example:
USB_XHCI_HCD is y, and USB_XHCI_MTK is m, then we can't
implement extended functions if only update xhci-mtk.ko
This patch is used to remove the dependence.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: no changes
---
 drivers/usb/host/Makefile       |  6 ++---
 drivers/usb/host/xhci-mem.c     |  2 +-
 drivers/usb/host/xhci-mtk-sch.c | 48 +++++++++++++++++++++++----------
 drivers/usb/host/xhci-mtk.c     |  2 ++
 drivers/usb/host/xhci-mtk.h     | 33 +++--------------------
 drivers/usb/host/xhci-ring.c    |  1 -
 drivers/usb/host/xhci.c         | 30 +++++++++------------
 drivers/usb/host/xhci.h         |  8 ++++++
 8 files changed, 64 insertions(+), 66 deletions(-)

diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 3e4d298d851f..171de4df50bd 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -19,9 +19,7 @@ ifneq ($(CONFIG_USB_XHCI_DBGCAP), )
 	xhci-hcd-y += xhci-dbgcap.o xhci-dbgtty.o
 endif
 
-ifneq ($(CONFIG_USB_XHCI_MTK), )
-	xhci-hcd-y += xhci-mtk-sch.o
-endif
+xhci-mtk-hcd-y := xhci-mtk.o xhci-mtk-sch.o
 
 xhci-plat-hcd-y := xhci-plat.o
 ifneq ($(CONFIG_USB_XHCI_MVEBU), )
@@ -73,7 +71,7 @@ obj-$(CONFIG_USB_XHCI_PCI)	+= xhci-pci.o
 obj-$(CONFIG_USB_XHCI_PCI_RENESAS)	+= xhci-pci-renesas.o
 obj-$(CONFIG_USB_XHCI_PLATFORM) += xhci-plat-hcd.o
 obj-$(CONFIG_USB_XHCI_HISTB)	+= xhci-histb.o
-obj-$(CONFIG_USB_XHCI_MTK)	+= xhci-mtk.o
+obj-$(CONFIG_USB_XHCI_MTK)	+= xhci-mtk-hcd.o
 obj-$(CONFIG_USB_XHCI_TEGRA)	+= xhci-tegra.o
 obj-$(CONFIG_USB_SL811_HCD)	+= sl811-hcd.o
 obj-$(CONFIG_USB_SL811_CS)	+= sl811_cs.o
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index f2c4ee7c4786..7eb8c07c8418 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -532,7 +532,7 @@ struct xhci_ep_ctx *xhci_get_ep_ctx(struct xhci_hcd *xhci,
 	return (struct xhci_ep_ctx *)
 		(ctx->bytes + (ep_index * CTX_SIZE(xhci->hcc_params)));
 }
-
+EXPORT_SYMBOL_GPL(xhci_get_ep_ctx);
 
 /***************** Streams structures manipulation *************************/
 
diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 7b45441f2606..046b7f1ebf94 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -691,25 +691,22 @@ int xhci_mtk_sch_init(struct xhci_hcd_mtk *mtk)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(xhci_mtk_sch_init);
 
 void xhci_mtk_sch_exit(struct xhci_hcd_mtk *mtk)
 {
 	kfree(mtk->sch_array);
 }
-EXPORT_SYMBOL_GPL(xhci_mtk_sch_exit);
 
-int xhci_mtk_add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
-		struct usb_host_endpoint *ep)
+static int add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
+			struct usb_host_endpoint *ep)
 {
 	struct xhci_hcd_mtk *mtk = hcd_to_mtk(hcd);
-	struct xhci_hcd *xhci;
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
 	struct xhci_ep_ctx *ep_ctx;
 	struct xhci_virt_device *virt_dev;
 	struct mu3h_sch_ep_info *sch_ep;
 	unsigned int ep_index;
 
-	xhci = hcd_to_xhci(hcd);
 	virt_dev = xhci->devs[udev->slot_id];
 	ep_index = xhci_get_endpoint_index(&ep->desc);
 	ep_ctx = xhci_get_ep_ctx(xhci, virt_dev->in_ctx, ep_index);
@@ -741,18 +738,16 @@ int xhci_mtk_add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(xhci_mtk_add_ep_quirk);
 
-void xhci_mtk_drop_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
-		struct usb_host_endpoint *ep)
+static void drop_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
+			  struct usb_host_endpoint *ep)
 {
 	struct xhci_hcd_mtk *mtk = hcd_to_mtk(hcd);
-	struct xhci_hcd *xhci;
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
 	struct xhci_virt_device *virt_dev;
 	struct mu3h_sch_bw_info *sch_bw;
 	struct mu3h_sch_ep_info *sch_ep, *tmp;
 
-	xhci = hcd_to_xhci(hcd);
 	virt_dev = xhci->devs[udev->slot_id];
 
 	xhci_dbg(xhci, "%s() type:%d, speed:%d, mpks:%d, dir:%d, ep:%p\n",
@@ -772,7 +767,6 @@ void xhci_mtk_drop_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 		}
 	}
 }
-EXPORT_SYMBOL_GPL(xhci_mtk_drop_ep_quirk);
 
 int xhci_mtk_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 {
@@ -818,7 +812,6 @@ int xhci_mtk_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 
 	return xhci_check_bandwidth(hcd, udev);
 }
-EXPORT_SYMBOL_GPL(xhci_mtk_check_bandwidth);
 
 void xhci_mtk_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 {
@@ -836,4 +829,31 @@ void xhci_mtk_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 
 	xhci_reset_bandwidth(hcd, udev);
 }
-EXPORT_SYMBOL_GPL(xhci_mtk_reset_bandwidth);
+
+int xhci_mtk_add_ep(struct usb_hcd *hcd, struct usb_device *udev,
+		    struct usb_host_endpoint *ep)
+{
+	int ret;
+
+	ret = xhci_add_endpoint(hcd, udev, ep);
+	if (ret)
+		return ret;
+
+	if (ep->hcpriv)
+		ret = add_ep_quirk(hcd, udev, ep);
+
+	return ret;
+}
+
+int xhci_mtk_drop_ep(struct usb_hcd *hcd, struct usb_device *udev,
+		     struct usb_host_endpoint *ep)
+{
+	int ret;
+
+	ret = xhci_drop_endpoint(hcd, udev, ep);
+	if (ret)
+		return ret;
+
+	drop_ep_quirk(hcd, udev, ep);
+	return 0;
+}
diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index fb4e56f6a6c3..57bcfdfa0465 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -417,6 +417,8 @@ static int xhci_mtk_setup(struct usb_hcd *hcd)
 
 static const struct xhci_driver_overrides xhci_mtk_overrides __initconst = {
 	.reset = xhci_mtk_setup,
+	.add_endpoint = xhci_mtk_add_ep,
+	.drop_endpoint = xhci_mtk_drop_ep,
 	.check_bandwidth = xhci_mtk_check_bandwidth,
 	.reset_bandwidth = xhci_mtk_reset_bandwidth,
 };
diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
index d25bf9e49136..621ec1a85009 100644
--- a/drivers/usb/host/xhci-mtk.h
+++ b/drivers/usb/host/xhci-mtk.h
@@ -161,38 +161,13 @@ static inline struct xhci_hcd_mtk *hcd_to_mtk(struct usb_hcd *hcd)
 	return dev_get_drvdata(hcd->self.controller);
 }
 
-#if IS_ENABLED(CONFIG_USB_XHCI_MTK)
 int xhci_mtk_sch_init(struct xhci_hcd_mtk *mtk);
 void xhci_mtk_sch_exit(struct xhci_hcd_mtk *mtk);
-int xhci_mtk_add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
-		struct usb_host_endpoint *ep);
-void xhci_mtk_drop_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
-		struct usb_host_endpoint *ep);
+int xhci_mtk_add_ep(struct usb_hcd *hcd, struct usb_device *udev,
+		    struct usb_host_endpoint *ep);
+int xhci_mtk_drop_ep(struct usb_hcd *hcd, struct usb_device *udev,
+		     struct usb_host_endpoint *ep);
 int xhci_mtk_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev);
 void xhci_mtk_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev);
 
-#else
-static inline int xhci_mtk_add_ep_quirk(struct usb_hcd *hcd,
-	struct usb_device *udev, struct usb_host_endpoint *ep)
-{
-	return 0;
-}
-
-static inline void xhci_mtk_drop_ep_quirk(struct usb_hcd *hcd,
-	struct usb_device *udev, struct usb_host_endpoint *ep)
-{
-}
-
-static inline int xhci_mtk_check_bandwidth(struct usb_hcd *hcd,
-		struct usb_device *udev)
-{
-	return 0;
-}
-
-static inline void xhci_mtk_reset_bandwidth(struct usb_hcd *hcd,
-		struct usb_device *udev)
-{
-}
-#endif
-
 #endif		/* _XHCI_MTK_H_ */
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 5e548a1c93ab..c8a880111435 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -57,7 +57,6 @@
 #include <linux/dma-mapping.h>
 #include "xhci.h"
 #include "xhci-trace.h"
-#include "xhci-mtk.h"
 
 static int queue_command(struct xhci_hcd *xhci, struct xhci_command *cmd,
 			 u32 field1, u32 field2,
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index bd27bd670104..13baeda927f0 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -20,7 +20,6 @@
 
 #include "xhci.h"
 #include "xhci-trace.h"
-#include "xhci-mtk.h"
 #include "xhci-debugfs.h"
 #include "xhci-dbgcap.h"
 
@@ -1420,6 +1419,7 @@ unsigned int xhci_get_endpoint_index(struct usb_endpoint_descriptor *desc)
 			(usb_endpoint_dir_in(desc) ? 1 : 0) - 1;
 	return index;
 }
+EXPORT_SYMBOL_GPL(xhci_get_endpoint_index);
 
 /* The reverse operation to xhci_get_endpoint_index. Calculate the USB endpoint
  * address from the XHCI endpoint index.
@@ -1852,8 +1852,8 @@ static int xhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
  * disabled, so there's no need for mutual exclusion to protect
  * the xhci->devs[slot_id] structure.
  */
-static int xhci_drop_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
-		struct usb_host_endpoint *ep)
+int xhci_drop_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
+		       struct usb_host_endpoint *ep)
 {
 	struct xhci_hcd *xhci;
 	struct xhci_container_ctx *in_ctx, *out_ctx;
@@ -1913,9 +1913,6 @@ static int xhci_drop_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
 
 	xhci_endpoint_zero(xhci, xhci->devs[udev->slot_id], ep);
 
-	if (xhci->quirks & XHCI_MTK_HOST)
-		xhci_mtk_drop_ep_quirk(hcd, udev, ep);
-
 	xhci_dbg(xhci, "drop ep 0x%x, slot id %d, new drop flags = %#x, new add flags = %#x\n",
 			(unsigned int) ep->desc.bEndpointAddress,
 			udev->slot_id,
@@ -1923,6 +1920,7 @@ static int xhci_drop_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
 			(unsigned int) new_add_flags);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(xhci_drop_endpoint);
 
 /* Add an endpoint to a new possible bandwidth configuration for this device.
  * Only one call to this function is allowed per endpoint before
@@ -1937,8 +1935,8 @@ static int xhci_drop_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
  * configuration or alt setting is installed in the device, so there's no need
  * for mutual exclusion to protect the xhci->devs[slot_id] structure.
  */
-static int xhci_add_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
-		struct usb_host_endpoint *ep)
+int xhci_add_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
+		      struct usb_host_endpoint *ep)
 {
 	struct xhci_hcd *xhci;
 	struct xhci_container_ctx *in_ctx;
@@ -2012,15 +2010,6 @@ static int xhci_add_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
 		return -ENOMEM;
 	}
 
-	if (xhci->quirks & XHCI_MTK_HOST) {
-		ret = xhci_mtk_add_ep_quirk(hcd, udev, ep);
-		if (ret < 0) {
-			xhci_ring_free(xhci, virt_dev->eps[ep_index].new_ring);
-			virt_dev->eps[ep_index].new_ring = NULL;
-			return ret;
-		}
-	}
-
 	ctrl_ctx->add_flags |= cpu_to_le32(added_ctxs);
 	new_add_flags = le32_to_cpu(ctrl_ctx->add_flags);
 
@@ -2045,6 +2034,7 @@ static int xhci_add_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
 			(unsigned int) new_add_flags);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(xhci_add_endpoint);
 
 static void xhci_zero_in_ctx(struct xhci_hcd *xhci, struct xhci_virt_device *virt_dev)
 {
@@ -3078,6 +3068,7 @@ int xhci_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(xhci_check_bandwidth);
 
 void xhci_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 {
@@ -3102,6 +3093,7 @@ void xhci_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 	}
 	xhci_zero_in_ctx(xhci, virt_dev);
 }
+EXPORT_SYMBOL_GPL(xhci_reset_bandwidth);
 
 static void xhci_setup_input_ctx_for_config_ep(struct xhci_hcd *xhci,
 		struct xhci_container_ctx *in_ctx,
@@ -5428,6 +5420,10 @@ void xhci_init_driver(struct hc_driver *drv,
 			drv->reset = over->reset;
 		if (over->start)
 			drv->start = over->start;
+		if (over->add_endpoint)
+			drv->add_endpoint = over->add_endpoint;
+		if (over->drop_endpoint)
+			drv->drop_endpoint = over->drop_endpoint;
 		if (over->check_bandwidth)
 			drv->check_bandwidth = over->check_bandwidth;
 		if (over->reset_bandwidth)
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index d41de5dc0452..5053c1adda1e 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1928,6 +1928,10 @@ struct xhci_driver_overrides {
 	size_t extra_priv_size;
 	int (*reset)(struct usb_hcd *hcd);
 	int (*start)(struct usb_hcd *hcd);
+	int (*add_endpoint)(struct usb_hcd *hcd, struct usb_device *udev,
+			    struct usb_host_endpoint *ep);
+	int (*drop_endpoint)(struct usb_hcd *hcd, struct usb_device *udev,
+			     struct usb_host_endpoint *ep);
 	int (*check_bandwidth)(struct usb_hcd *, struct usb_device *);
 	void (*reset_bandwidth)(struct usb_hcd *, struct usb_device *);
 };
@@ -2080,6 +2084,10 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks);
 void xhci_shutdown(struct usb_hcd *hcd);
 void xhci_init_driver(struct hc_driver *drv,
 		      const struct xhci_driver_overrides *over);
+int xhci_add_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
+		      struct usb_host_endpoint *ep);
+int xhci_drop_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
+		       struct usb_host_endpoint *ep);
 int xhci_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev);
 void xhci_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev);
 int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id);
-- 
2.18.0

