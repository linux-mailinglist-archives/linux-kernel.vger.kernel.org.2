Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867333F80A9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 04:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238025AbhHZCwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 22:52:51 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:32912 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232441AbhHZCwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 22:52:49 -0400
X-UUID: 40558634375a4e34ace55fa20c347fd6-20210826
X-UUID: 40558634375a4e34ace55fa20c347fd6-20210826
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1294242977; Thu, 26 Aug 2021 10:52:01 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 26 Aug 2021 10:52:00 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 26 Aug 2021 10:51:59 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ikjoon Jang <ikjn@chromium.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Yaqii wu <yaqii.wu@mediatek.com>
Subject: [PATCH next v2 2/6] Revert "usb: xhci-mtk: Do not use xhci's virt_dev in drop_endpoint"
Date:   Thu, 26 Aug 2021 10:51:40 +0800
Message-ID: <20210826025144.51992-2-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210826025144.51992-1-chunfeng.yun@mediatek.com>
References: <20210826025144.51992-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I find the patch introduce some issues, e.g.
1. oops happens when xhci_gen_setup() failed, and hash is not init
   but try to destroy it;
2. memory leakage happens when fail to insert ep, need free sch_ep,
   or insert ep after insert int list;
3. memory leakage happens when fail to allocate sch_array, need destroy
   rhashtable;
4. it's better to check ep->hcpriv when drop ep;

so prefer to revert this patch, and resend it after the issues are fixed.

This reverts commit b8731209958a1dffccc2888121f4c0280c990550.

Cc: Ikjoon Jang <ikjn@chromium.org>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: append new version patch of this one [5/6] suggested by Ikjoon
---
 drivers/usb/host/xhci-mtk-sch.c | 140 ++++++++++++++------------------
 drivers/usb/host/xhci-mtk.h     |  15 ++--
 2 files changed, 69 insertions(+), 86 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index f9b4d27ce449..cffcaf4dfa9f 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -80,7 +80,7 @@ decode_ep(struct usb_host_endpoint *ep, enum usb_device_speed speed)
 		interval /= 1000;
 	}
 
-	snprintf(buf, DBG_BUF_EN, "%s ep%d%s %s, mpkt:%d, interval:%d/%d%s",
+	snprintf(buf, DBG_BUF_EN, "%s ep%d%s %s, mpkt:%d, interval:%d/%d%s\n",
 		 usb_speed_string(speed), usb_endpoint_num(epd),
 		 usb_endpoint_dir_in(epd) ? "in" : "out",
 		 usb_ep_type_string(usb_endpoint_type(epd)),
@@ -129,12 +129,6 @@ get_bw_info(struct xhci_hcd_mtk *mtk, struct usb_device *udev,
 	int bw_index;
 
 	virt_dev = xhci->devs[udev->slot_id];
-	if (WARN_ONCE(!virt_dev, "xhci-mtk: usb %s has no virt_dev\n",
-				dev_name(&udev->dev)))
-		return NULL;
-	if (WARN_ONCE(!virt_dev->real_port, "xhci-mtk: usb %s has invalid port number\n",
-			dev_name(&udev->dev)))
-		return NULL;
 
 	if (udev->speed >= USB_SPEED_SUPER) {
 		if (usb_endpoint_dir_out(&ep->desc))
@@ -200,6 +194,7 @@ static struct mu3h_sch_tt *find_tt(struct usb_device *udev)
 			}
 			return ERR_PTR(-ENOMEM);
 		}
+		INIT_LIST_HEAD(&tt->ep_list);
 		*ptt = tt;
 	}
 
@@ -229,7 +224,7 @@ static void drop_tt(struct usb_device *udev)
 	}
 
 	tt = *ptt;
-	if (!tt || tt->nr_eps > 0)
+	if (!tt || !list_empty(&tt->ep_list))
 		return;		/* never allocated , or still in use*/
 
 	*ptt = NULL;
@@ -241,19 +236,13 @@ static void drop_tt(struct usb_device *udev)
 	}
 }
 
-static struct mu3h_sch_ep_info *create_sch_ep(struct xhci_hcd_mtk *mtk,
-		struct usb_device *udev, struct usb_host_endpoint *ep,
-		struct xhci_ep_ctx *ep_ctx)
+static struct mu3h_sch_ep_info *create_sch_ep(struct usb_device *udev,
+	struct usb_host_endpoint *ep, struct xhci_ep_ctx *ep_ctx)
 {
 	struct mu3h_sch_ep_info *sch_ep;
 	struct mu3h_sch_tt *tt = NULL;
 	u32 len_bw_budget_table;
 	size_t mem_size;
-	struct mu3h_sch_bw_info *bw_info;
-
-	bw_info = get_bw_info(mtk, udev, ep);
-	if (!bw_info)
-		return ERR_PTR(-ENODEV);
 
 	if (is_fs_or_ls(udev->speed))
 		len_bw_budget_table = TT_MICROFRAMES_MAX;
@@ -277,10 +266,11 @@ static struct mu3h_sch_ep_info *create_sch_ep(struct xhci_hcd_mtk *mtk,
 		}
 	}
 
-	sch_ep->bw_info = bw_info;
 	sch_ep->sch_tt = tt;
 	sch_ep->ep = ep;
 	sch_ep->speed = udev->speed;
+	INIT_LIST_HEAD(&sch_ep->endpoint);
+	INIT_LIST_HEAD(&sch_ep->tt_endpoint);
 
 	return sch_ep;
 }
@@ -562,9 +552,9 @@ static void update_sch_tt(struct mu3h_sch_ep_info *sch_ep, bool used)
 	}
 
 	if (used)
-		tt->nr_eps++;
-	else if (!WARN_ONCE(tt->nr_eps < 1, "unbalanced sch_tt's ep count"))
-		tt->nr_eps--;
+		list_add_tail(&sch_ep->tt_endpoint, &tt->ep_list);
+	else
+		list_del(&sch_ep->tt_endpoint);
 }
 
 static int load_ep_bw(struct mu3h_sch_bw_info *sch_bw,
@@ -595,9 +585,9 @@ static u32 get_esit_boundary(struct mu3h_sch_ep_info *sch_ep)
 	return boundary;
 }
 
-static int check_sch_bw(struct mu3h_sch_ep_info *sch_ep)
+static int check_sch_bw(struct mu3h_sch_bw_info *sch_bw,
+			struct mu3h_sch_ep_info *sch_ep)
 {
-	struct mu3h_sch_bw_info *sch_bw = sch_ep->bw_info;
 	const u32 esit_boundary = get_esit_boundary(sch_ep);
 	const u32 bw_boundary = get_bw_boundary(sch_ep->speed);
 	u32 offset;
@@ -643,33 +633,23 @@ static int check_sch_bw(struct mu3h_sch_ep_info *sch_ep)
 	return load_ep_bw(sch_bw, sch_ep, true);
 }
 
-static const struct rhashtable_params sch_ep_table_param = {
-	.key_len	= sizeof(struct usb_host_endpoint *),
-	.key_offset	= offsetof(struct mu3h_sch_ep_info, ep),
-	.head_offset	= offsetof(struct mu3h_sch_ep_info, ep_link),
-};
-
-static void destroy_sch_ep(struct xhci_hcd_mtk *mtk, struct usb_device *udev,
-			   struct mu3h_sch_ep_info *sch_ep)
+static void destroy_sch_ep(struct usb_device *udev,
+	struct mu3h_sch_bw_info *sch_bw, struct mu3h_sch_ep_info *sch_ep)
 {
 	/* only release ep bw check passed by check_sch_bw() */
 	if (sch_ep->allocated)
-		load_ep_bw(sch_ep->bw_info, sch_ep, false);
+		load_ep_bw(sch_bw, sch_ep, false);
 
 	if (sch_ep->sch_tt)
 		drop_tt(udev);
 
 	list_del(&sch_ep->endpoint);
-	rhashtable_remove_fast(&mtk->sch_ep_table, &sch_ep->ep_link,
-				sch_ep_table_param);
 	kfree(sch_ep);
 }
 
-static bool need_bw_sch(struct usb_device *udev,
-			struct usb_host_endpoint *ep)
+static bool need_bw_sch(struct usb_host_endpoint *ep,
+	enum usb_device_speed speed, int has_tt)
 {
-	bool has_tt = udev->tt && udev->tt->hub->parent;
-
 	/* only for periodic endpoints */
 	if (usb_endpoint_xfer_control(&ep->desc)
 		|| usb_endpoint_xfer_bulk(&ep->desc))
@@ -680,7 +660,7 @@ static bool need_bw_sch(struct usb_device *udev,
 	 * a TT are also ignored, root-hub will schedule them directly,
 	 * but need set @bpkts field of endpoint context to 1.
 	 */
-	if (is_fs_or_ls(udev->speed) && !has_tt)
+	if (is_fs_or_ls(speed) && !has_tt)
 		return false;
 
 	/* skip endpoint with zero maxpkt */
@@ -695,12 +675,7 @@ int xhci_mtk_sch_init(struct xhci_hcd_mtk *mtk)
 	struct xhci_hcd *xhci = hcd_to_xhci(mtk->hcd);
 	struct mu3h_sch_bw_info *sch_array;
 	int num_usb_bus;
-	int ret;
-
-	/* mu3h_sch_ep_info table, 'usb_host_endpoint*' as a key */
-	ret = rhashtable_init(&mtk->sch_ep_table, &sch_ep_table_param);
-	if (ret)
-		return ret;
+	int i;
 
 	/* ss IN and OUT are separated */
 	num_usb_bus = xhci->usb3_rhub.num_ports * 2 + xhci->usb2_rhub.num_ports;
@@ -709,6 +684,9 @@ int xhci_mtk_sch_init(struct xhci_hcd_mtk *mtk)
 	if (sch_array == NULL)
 		return -ENOMEM;
 
+	for (i = 0; i < num_usb_bus; i++)
+		INIT_LIST_HEAD(&sch_array[i].bw_ep_list);
+
 	mtk->sch_array = sch_array;
 
 	INIT_LIST_HEAD(&mtk->bw_ep_chk_list);
@@ -718,7 +696,6 @@ int xhci_mtk_sch_init(struct xhci_hcd_mtk *mtk)
 
 void xhci_mtk_sch_exit(struct xhci_hcd_mtk *mtk)
 {
-	rhashtable_destroy(&mtk->sch_ep_table);
 	kfree(mtk->sch_array);
 }
 
@@ -736,7 +713,9 @@ static int add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 	ep_index = xhci_get_endpoint_index(&ep->desc);
 	ep_ctx = xhci_get_ep_ctx(xhci, virt_dev->in_ctx, ep_index);
 
-	if (!need_bw_sch(udev, ep)) {
+	xhci_dbg(xhci, "%s %s\n", __func__, decode_ep(ep, udev->speed));
+
+	if (!need_bw_sch(ep, udev->speed, !!virt_dev->tt_info)) {
 		/*
 		 * set @bpkts to 1 if it is LS or FS periodic endpoint, and its
 		 * device does not connected through an external HS hub
@@ -748,22 +727,14 @@ static int add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 		return 0;
 	}
 
-	xhci_dbg(xhci, "%s %s\n", __func__, decode_ep(ep, udev->speed));
-
-	sch_ep = create_sch_ep(mtk, udev, ep, ep_ctx);
+	sch_ep = create_sch_ep(udev, ep, ep_ctx);
 	if (IS_ERR_OR_NULL(sch_ep))
 		return -ENOMEM;
 
-	if (rhashtable_insert_fast(&mtk->sch_ep_table, &sch_ep->ep_link,
-				   sch_ep_table_param))
-		return -EEXIST;
-
 	setup_sch_info(ep_ctx, sch_ep);
 
 	list_add_tail(&sch_ep->endpoint, &mtk->bw_ep_chk_list);
 
-	xhci_dbg(xhci, "added sch_ep %p : %p\n", sch_ep, ep);
-
 	return 0;
 }
 
@@ -772,20 +743,25 @@ static void drop_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 {
 	struct xhci_hcd_mtk *mtk = hcd_to_mtk(hcd);
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
-	struct mu3h_sch_ep_info *sch_ep;
-	void *key = ep;
+	struct xhci_virt_device *virt_dev;
+	struct mu3h_sch_bw_info *sch_bw;
+	struct mu3h_sch_ep_info *sch_ep, *tmp;
 
-	if (!need_bw_sch(udev, ep))
-		return;
+	virt_dev = xhci->devs[udev->slot_id];
 
 	xhci_dbg(xhci, "%s %s\n", __func__, decode_ep(ep, udev->speed));
 
-	sch_ep = rhashtable_lookup_fast(&mtk->sch_ep_table, &key,
-					sch_ep_table_param);
-	if (sch_ep)
-		destroy_sch_ep(mtk, udev, sch_ep);
-	else
-		xhci_dbg(xhci, "ep %p is not on the bw table\n", ep);
+	if (!need_bw_sch(ep, udev->speed, !!virt_dev->tt_info))
+		return;
+
+	sch_bw = get_bw_info(mtk, udev, ep);
+
+	list_for_each_entry_safe(sch_ep, tmp, &sch_bw->bw_ep_list, endpoint) {
+		if (sch_ep->ep == ep) {
+			destroy_sch_ep(udev, sch_bw, sch_ep);
+			break;
+		}
+	}
 }
 
 int xhci_mtk_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
@@ -793,22 +769,30 @@ int xhci_mtk_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 	struct xhci_hcd_mtk *mtk = hcd_to_mtk(hcd);
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
 	struct xhci_virt_device *virt_dev = xhci->devs[udev->slot_id];
-	struct mu3h_sch_ep_info *sch_ep;
+	struct mu3h_sch_bw_info *sch_bw;
+	struct mu3h_sch_ep_info *sch_ep, *tmp;
 	int ret;
 
 	xhci_dbg(xhci, "%s() udev %s\n", __func__, dev_name(&udev->dev));
 
 	list_for_each_entry(sch_ep, &mtk->bw_ep_chk_list, endpoint) {
-		struct xhci_ep_ctx *ep_ctx;
-		struct usb_host_endpoint *ep = sch_ep->ep;
-		unsigned int ep_index = xhci_get_endpoint_index(&ep->desc);
+		sch_bw = get_bw_info(mtk, udev, sch_ep->ep);
 
-		ret = check_sch_bw(sch_ep);
+		ret = check_sch_bw(sch_bw, sch_ep);
 		if (ret) {
 			xhci_err(xhci, "Not enough bandwidth! (%s)\n",
 				 sch_error_string(-ret));
 			return -ENOSPC;
 		}
+	}
+
+	list_for_each_entry_safe(sch_ep, tmp, &mtk->bw_ep_chk_list, endpoint) {
+		struct xhci_ep_ctx *ep_ctx;
+		struct usb_host_endpoint *ep = sch_ep->ep;
+		unsigned int ep_index = xhci_get_endpoint_index(&ep->desc);
+
+		sch_bw = get_bw_info(mtk, udev, ep);
+		list_move_tail(&sch_ep->endpoint, &sch_bw->bw_ep_list);
 
 		ep_ctx = xhci_get_ep_ctx(xhci, virt_dev->in_ctx, ep_index);
 		ep_ctx->reserved[0] = cpu_to_le32(EP_BPKTS(sch_ep->pkts)
@@ -822,23 +806,22 @@ int xhci_mtk_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 			sch_ep->offset, sch_ep->repeat);
 	}
 
-	ret = xhci_check_bandwidth(hcd, udev);
-	if (!ret)
-		INIT_LIST_HEAD(&mtk->bw_ep_chk_list);
-
-	return ret;
+	return xhci_check_bandwidth(hcd, udev);
 }
 
 void xhci_mtk_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 {
 	struct xhci_hcd_mtk *mtk = hcd_to_mtk(hcd);
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+	struct mu3h_sch_bw_info *sch_bw;
 	struct mu3h_sch_ep_info *sch_ep, *tmp;
 
 	xhci_dbg(xhci, "%s() udev %s\n", __func__, dev_name(&udev->dev));
 
-	list_for_each_entry_safe(sch_ep, tmp, &mtk->bw_ep_chk_list, endpoint)
-		destroy_sch_ep(mtk, udev, sch_ep);
+	list_for_each_entry_safe(sch_ep, tmp, &mtk->bw_ep_chk_list, endpoint) {
+		sch_bw = get_bw_info(mtk, udev, sch_ep->ep);
+		destroy_sch_ep(udev, sch_bw, sch_ep);
+	}
 
 	xhci_reset_bandwidth(hcd, udev);
 }
@@ -867,7 +850,8 @@ int xhci_mtk_drop_ep(struct usb_hcd *hcd, struct usb_device *udev,
 	if (ret)
 		return ret;
 
-	drop_ep_quirk(hcd, udev, ep);
+	if (ep->hcpriv)
+		drop_ep_quirk(hcd, udev, ep);
 
 	return 0;
 }
diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
index ddcf25524f67..ace432356c41 100644
--- a/drivers/usb/host/xhci-mtk.h
+++ b/drivers/usb/host/xhci-mtk.h
@@ -10,7 +10,6 @@
 #define _XHCI_MTK_H_
 
 #include <linux/clk.h>
-#include <linux/rhashtable.h>
 
 #include "xhci.h"
 
@@ -26,34 +25,36 @@
 
 /**
  * @fs_bus_bw: array to keep track of bandwidth already used for FS
- * @nr_eps: number of endpoints using this TT
+ * @ep_list: Endpoints using this TT
  */
 struct mu3h_sch_tt {
 	u32 fs_bus_bw[XHCI_MTK_MAX_ESIT];
-	int nr_eps;
+	struct list_head ep_list;
 };
 
 /**
  * struct mu3h_sch_bw_info: schedule information for bandwidth domain
  *
  * @bus_bw: array to keep track of bandwidth already used at each uframes
+ * @bw_ep_list: eps in the bandwidth domain
  *
  * treat a HS root port as a bandwidth domain, but treat a SS root port as
  * two bandwidth domains, one for IN eps and another for OUT eps.
  */
 struct mu3h_sch_bw_info {
 	u32 bus_bw[XHCI_MTK_MAX_ESIT];
+	struct list_head bw_ep_list;
 };
 
 /**
  * struct mu3h_sch_ep_info: schedule information for endpoint
  *
- * @bw_info: bandwidth domain which this endpoint belongs
  * @esit: unit is 125us, equal to 2 << Interval field in ep-context
  * @num_budget_microframes: number of continuous uframes
  *		(@repeat==1) scheduled within the interval
  * @bw_cost_per_microframe: bandwidth cost per microframe
- * @endpoint: linked into bw_ep_chk_list, used by check_bandwidth hook
+ * @endpoint: linked into bandwidth domain which it belongs to
+ * @tt_endpoint: linked into mu3h_sch_tt's list which it belongs to
  * @sch_tt: mu3h_sch_tt linked into
  * @ep_type: endpoint type
  * @maxpkt: max packet size of endpoint
@@ -81,12 +82,11 @@ struct mu3h_sch_ep_info {
 	u32 num_budget_microframes;
 	u32 bw_cost_per_microframe;
 	struct list_head endpoint;
-	struct mu3h_sch_bw_info *bw_info;
+	struct list_head tt_endpoint;
 	struct mu3h_sch_tt *sch_tt;
 	u32 ep_type;
 	u32 maxpkt;
 	struct usb_host_endpoint *ep;
-	struct rhash_head ep_link;
 	enum usb_device_speed speed;
 	bool allocated;
 	/*
@@ -134,7 +134,6 @@ struct xhci_hcd_mtk {
 	struct device *dev;
 	struct usb_hcd *hcd;
 	struct mu3h_sch_bw_info *sch_array;
-	struct rhashtable sch_ep_table;
 	struct list_head bw_ep_chk_list;
 	struct mu3c_ippc_regs __iomem *ippc_regs;
 	int num_u2_ports;
-- 
2.18.0

