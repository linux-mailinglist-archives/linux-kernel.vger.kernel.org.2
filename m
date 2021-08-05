Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297AF3E0DD0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 07:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbhHEFiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 01:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhHEFiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 01:38:08 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FCFC061765
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 22:37:54 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id z3so5728349plg.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 22:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EtuBpllpzXBeIzqU1076VKs5G/bT6UXsF08Jk36FA9Q=;
        b=hWnORA5XkvHqMMuWZ0XS3toWF6z86dxD4xrd3h44+cYdTQ1xNqO5gJLHOwenCiJMFF
         t8q/NiMRTDH7hYP7rMCGYylU1CwKEjzPy51sYUoudTSG8xDhjCakaZE66MVycM5BqJSo
         P6tf8GHg56g8nQuhdkYyT62Gxjv7JA8gxyB9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EtuBpllpzXBeIzqU1076VKs5G/bT6UXsF08Jk36FA9Q=;
        b=p047X2+6sl7JiB0GKJ4WSVRmkgjKfghLHLr5KvHun369JkI4Yif4oRe8PQIn+65n8Y
         wdD2oZb1w173EGZ4L1hJWSuER141GGA/+0dObnXHF2DLfUxqRs3jdzR/43ODicutnydR
         WiNf7SNHHFl7/tCy1szCwXANsaI7rdnpiN5Xb21h3umLGROZiFiqUSKafTuAMhocJGFM
         Ff4q06YCrX/8EL98jOZrSXLbLc4ya9aPhZBy9QHlHjksx3yZQOMcyLl3RQNCNJLAi7ik
         voSaJLi67kYtBzLoxFROtBdakYSJFxL/+5wlMGMpQd5XvI13/0366zOK/90TGayOa9Xf
         14Hg==
X-Gm-Message-State: AOAM530KrOVs8po7ZpkOK6l0KcYc/kv2QEANMk9UiuBbm+Mne0r6EuHK
        iot/9w4928pRuByghkL9MSf5+w==
X-Google-Smtp-Source: ABdhPJz7OJgU+yP6KrdEIsUulgOU5hFRx2kJa6MwKiHeWwHR5z7tsMyKyF8zu24511XvZrhwTQasdg==
X-Received: by 2002:a63:b09:: with SMTP id 9mr137497pgl.53.1628141874125;
        Wed, 04 Aug 2021 22:37:54 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:7a1c:b216:fca0:2cc2])
        by smtp.gmail.com with ESMTPSA id w9sm4881946pfg.151.2021.08.04.22.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 22:37:53 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH] usb: xhci-mtk: Do not use xhci's virt_dev in drop_endpoint
Date:   Thu,  5 Aug 2021 13:37:47 +0800
Message-Id: <20210805133731.1.Icc0f080e75b1312692d4c7c7d25e7df9fe1a05c2@changeid>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xhci-mtk depends on xhci's internal virt_dev when it retrieves its
internal data from usb_host_endpoint both in add_endpoint and
drop_endpoint callbacks. But when setup packet was retired by
transaction errors in xhci_setup_device() path, a virt_dev for the slot
is newly created with real_port 0. This leads to xhci-mtks's NULL pointer
dereference from drop_endpoint callback as xhci-mtk assumes that virt_dev's
real_port is always started from one. The similar problems were addressed
by [1] but that can't cover the failure cases from setup_device.

This patch drops the usages of xhci's virt_dev in xhci-mtk's drop_endpoint
callback by adopting rhashtable for searching mtk's schedule entity
from a given usb_host_endpoint pointer instead of searching a linked list.
So mtk's drop_endpoint callback doesn't have to rely on virt_dev at all.

[1] https://lore.kernel.org/r/1617179142-2681-2-git-send-email-chunfeng.yun@mediatek.com

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---

 drivers/usb/host/xhci-mtk-sch.c | 140 ++++++++++++++++++--------------
 drivers/usb/host/xhci-mtk.h     |  15 ++--
 2 files changed, 86 insertions(+), 69 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index cffcaf4dfa9f..f9b4d27ce449 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -80,7 +80,7 @@ decode_ep(struct usb_host_endpoint *ep, enum usb_device_speed speed)
 		interval /= 1000;
 	}
 
-	snprintf(buf, DBG_BUF_EN, "%s ep%d%s %s, mpkt:%d, interval:%d/%d%s\n",
+	snprintf(buf, DBG_BUF_EN, "%s ep%d%s %s, mpkt:%d, interval:%d/%d%s",
 		 usb_speed_string(speed), usb_endpoint_num(epd),
 		 usb_endpoint_dir_in(epd) ? "in" : "out",
 		 usb_ep_type_string(usb_endpoint_type(epd)),
@@ -129,6 +129,12 @@ get_bw_info(struct xhci_hcd_mtk *mtk, struct usb_device *udev,
 	int bw_index;
 
 	virt_dev = xhci->devs[udev->slot_id];
+	if (WARN_ONCE(!virt_dev, "xhci-mtk: usb %s has no virt_dev\n",
+				dev_name(&udev->dev)))
+		return NULL;
+	if (WARN_ONCE(!virt_dev->real_port, "xhci-mtk: usb %s has invalid port number\n",
+			dev_name(&udev->dev)))
+		return NULL;
 
 	if (udev->speed >= USB_SPEED_SUPER) {
 		if (usb_endpoint_dir_out(&ep->desc))
@@ -194,7 +200,6 @@ static struct mu3h_sch_tt *find_tt(struct usb_device *udev)
 			}
 			return ERR_PTR(-ENOMEM);
 		}
-		INIT_LIST_HEAD(&tt->ep_list);
 		*ptt = tt;
 	}
 
@@ -224,7 +229,7 @@ static void drop_tt(struct usb_device *udev)
 	}
 
 	tt = *ptt;
-	if (!tt || !list_empty(&tt->ep_list))
+	if (!tt || tt->nr_eps > 0)
 		return;		/* never allocated , or still in use*/
 
 	*ptt = NULL;
@@ -236,13 +241,19 @@ static void drop_tt(struct usb_device *udev)
 	}
 }
 
-static struct mu3h_sch_ep_info *create_sch_ep(struct usb_device *udev,
-	struct usb_host_endpoint *ep, struct xhci_ep_ctx *ep_ctx)
+static struct mu3h_sch_ep_info *create_sch_ep(struct xhci_hcd_mtk *mtk,
+		struct usb_device *udev, struct usb_host_endpoint *ep,
+		struct xhci_ep_ctx *ep_ctx)
 {
 	struct mu3h_sch_ep_info *sch_ep;
 	struct mu3h_sch_tt *tt = NULL;
 	u32 len_bw_budget_table;
 	size_t mem_size;
+	struct mu3h_sch_bw_info *bw_info;
+
+	bw_info = get_bw_info(mtk, udev, ep);
+	if (!bw_info)
+		return ERR_PTR(-ENODEV);
 
 	if (is_fs_or_ls(udev->speed))
 		len_bw_budget_table = TT_MICROFRAMES_MAX;
@@ -266,11 +277,10 @@ static struct mu3h_sch_ep_info *create_sch_ep(struct usb_device *udev,
 		}
 	}
 
+	sch_ep->bw_info = bw_info;
 	sch_ep->sch_tt = tt;
 	sch_ep->ep = ep;
 	sch_ep->speed = udev->speed;
-	INIT_LIST_HEAD(&sch_ep->endpoint);
-	INIT_LIST_HEAD(&sch_ep->tt_endpoint);
 
 	return sch_ep;
 }
@@ -552,9 +562,9 @@ static void update_sch_tt(struct mu3h_sch_ep_info *sch_ep, bool used)
 	}
 
 	if (used)
-		list_add_tail(&sch_ep->tt_endpoint, &tt->ep_list);
-	else
-		list_del(&sch_ep->tt_endpoint);
+		tt->nr_eps++;
+	else if (!WARN_ONCE(tt->nr_eps < 1, "unbalanced sch_tt's ep count"))
+		tt->nr_eps--;
 }
 
 static int load_ep_bw(struct mu3h_sch_bw_info *sch_bw,
@@ -585,9 +595,9 @@ static u32 get_esit_boundary(struct mu3h_sch_ep_info *sch_ep)
 	return boundary;
 }
 
-static int check_sch_bw(struct mu3h_sch_bw_info *sch_bw,
-			struct mu3h_sch_ep_info *sch_ep)
+static int check_sch_bw(struct mu3h_sch_ep_info *sch_ep)
 {
+	struct mu3h_sch_bw_info *sch_bw = sch_ep->bw_info;
 	const u32 esit_boundary = get_esit_boundary(sch_ep);
 	const u32 bw_boundary = get_bw_boundary(sch_ep->speed);
 	u32 offset;
@@ -633,23 +643,33 @@ static int check_sch_bw(struct mu3h_sch_bw_info *sch_bw,
 	return load_ep_bw(sch_bw, sch_ep, true);
 }
 
-static void destroy_sch_ep(struct usb_device *udev,
-	struct mu3h_sch_bw_info *sch_bw, struct mu3h_sch_ep_info *sch_ep)
+static const struct rhashtable_params sch_ep_table_param = {
+	.key_len	= sizeof(struct usb_host_endpoint *),
+	.key_offset	= offsetof(struct mu3h_sch_ep_info, ep),
+	.head_offset	= offsetof(struct mu3h_sch_ep_info, ep_link),
+};
+
+static void destroy_sch_ep(struct xhci_hcd_mtk *mtk, struct usb_device *udev,
+			   struct mu3h_sch_ep_info *sch_ep)
 {
 	/* only release ep bw check passed by check_sch_bw() */
 	if (sch_ep->allocated)
-		load_ep_bw(sch_bw, sch_ep, false);
+		load_ep_bw(sch_ep->bw_info, sch_ep, false);
 
 	if (sch_ep->sch_tt)
 		drop_tt(udev);
 
 	list_del(&sch_ep->endpoint);
+	rhashtable_remove_fast(&mtk->sch_ep_table, &sch_ep->ep_link,
+				sch_ep_table_param);
 	kfree(sch_ep);
 }
 
-static bool need_bw_sch(struct usb_host_endpoint *ep,
-	enum usb_device_speed speed, int has_tt)
+static bool need_bw_sch(struct usb_device *udev,
+			struct usb_host_endpoint *ep)
 {
+	bool has_tt = udev->tt && udev->tt->hub->parent;
+
 	/* only for periodic endpoints */
 	if (usb_endpoint_xfer_control(&ep->desc)
 		|| usb_endpoint_xfer_bulk(&ep->desc))
@@ -660,7 +680,7 @@ static bool need_bw_sch(struct usb_host_endpoint *ep,
 	 * a TT are also ignored, root-hub will schedule them directly,
 	 * but need set @bpkts field of endpoint context to 1.
 	 */
-	if (is_fs_or_ls(speed) && !has_tt)
+	if (is_fs_or_ls(udev->speed) && !has_tt)
 		return false;
 
 	/* skip endpoint with zero maxpkt */
@@ -675,7 +695,12 @@ int xhci_mtk_sch_init(struct xhci_hcd_mtk *mtk)
 	struct xhci_hcd *xhci = hcd_to_xhci(mtk->hcd);
 	struct mu3h_sch_bw_info *sch_array;
 	int num_usb_bus;
-	int i;
+	int ret;
+
+	/* mu3h_sch_ep_info table, 'usb_host_endpoint*' as a key */
+	ret = rhashtable_init(&mtk->sch_ep_table, &sch_ep_table_param);
+	if (ret)
+		return ret;
 
 	/* ss IN and OUT are separated */
 	num_usb_bus = xhci->usb3_rhub.num_ports * 2 + xhci->usb2_rhub.num_ports;
@@ -684,9 +709,6 @@ int xhci_mtk_sch_init(struct xhci_hcd_mtk *mtk)
 	if (sch_array == NULL)
 		return -ENOMEM;
 
-	for (i = 0; i < num_usb_bus; i++)
-		INIT_LIST_HEAD(&sch_array[i].bw_ep_list);
-
 	mtk->sch_array = sch_array;
 
 	INIT_LIST_HEAD(&mtk->bw_ep_chk_list);
@@ -696,6 +718,7 @@ int xhci_mtk_sch_init(struct xhci_hcd_mtk *mtk)
 
 void xhci_mtk_sch_exit(struct xhci_hcd_mtk *mtk)
 {
+	rhashtable_destroy(&mtk->sch_ep_table);
 	kfree(mtk->sch_array);
 }
 
@@ -713,9 +736,7 @@ static int add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 	ep_index = xhci_get_endpoint_index(&ep->desc);
 	ep_ctx = xhci_get_ep_ctx(xhci, virt_dev->in_ctx, ep_index);
 
-	xhci_dbg(xhci, "%s %s\n", __func__, decode_ep(ep, udev->speed));
-
-	if (!need_bw_sch(ep, udev->speed, !!virt_dev->tt_info)) {
+	if (!need_bw_sch(udev, ep)) {
 		/*
 		 * set @bpkts to 1 if it is LS or FS periodic endpoint, and its
 		 * device does not connected through an external HS hub
@@ -727,14 +748,22 @@ static int add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 		return 0;
 	}
 
-	sch_ep = create_sch_ep(udev, ep, ep_ctx);
+	xhci_dbg(xhci, "%s %s\n", __func__, decode_ep(ep, udev->speed));
+
+	sch_ep = create_sch_ep(mtk, udev, ep, ep_ctx);
 	if (IS_ERR_OR_NULL(sch_ep))
 		return -ENOMEM;
 
+	if (rhashtable_insert_fast(&mtk->sch_ep_table, &sch_ep->ep_link,
+				   sch_ep_table_param))
+		return -EEXIST;
+
 	setup_sch_info(ep_ctx, sch_ep);
 
 	list_add_tail(&sch_ep->endpoint, &mtk->bw_ep_chk_list);
 
+	xhci_dbg(xhci, "added sch_ep %p : %p\n", sch_ep, ep);
+
 	return 0;
 }
 
@@ -743,25 +772,20 @@ static void drop_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 {
 	struct xhci_hcd_mtk *mtk = hcd_to_mtk(hcd);
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
-	struct xhci_virt_device *virt_dev;
-	struct mu3h_sch_bw_info *sch_bw;
-	struct mu3h_sch_ep_info *sch_ep, *tmp;
-
-	virt_dev = xhci->devs[udev->slot_id];
-
-	xhci_dbg(xhci, "%s %s\n", __func__, decode_ep(ep, udev->speed));
+	struct mu3h_sch_ep_info *sch_ep;
+	void *key = ep;
 
-	if (!need_bw_sch(ep, udev->speed, !!virt_dev->tt_info))
+	if (!need_bw_sch(udev, ep))
 		return;
 
-	sch_bw = get_bw_info(mtk, udev, ep);
+	xhci_dbg(xhci, "%s %s\n", __func__, decode_ep(ep, udev->speed));
 
-	list_for_each_entry_safe(sch_ep, tmp, &sch_bw->bw_ep_list, endpoint) {
-		if (sch_ep->ep == ep) {
-			destroy_sch_ep(udev, sch_bw, sch_ep);
-			break;
-		}
-	}
+	sch_ep = rhashtable_lookup_fast(&mtk->sch_ep_table, &key,
+					sch_ep_table_param);
+	if (sch_ep)
+		destroy_sch_ep(mtk, udev, sch_ep);
+	else
+		xhci_dbg(xhci, "ep %p is not on the bw table\n", ep);
 }
 
 int xhci_mtk_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
@@ -769,30 +793,22 @@ int xhci_mtk_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 	struct xhci_hcd_mtk *mtk = hcd_to_mtk(hcd);
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
 	struct xhci_virt_device *virt_dev = xhci->devs[udev->slot_id];
-	struct mu3h_sch_bw_info *sch_bw;
-	struct mu3h_sch_ep_info *sch_ep, *tmp;
+	struct mu3h_sch_ep_info *sch_ep;
 	int ret;
 
 	xhci_dbg(xhci, "%s() udev %s\n", __func__, dev_name(&udev->dev));
 
 	list_for_each_entry(sch_ep, &mtk->bw_ep_chk_list, endpoint) {
-		sch_bw = get_bw_info(mtk, udev, sch_ep->ep);
+		struct xhci_ep_ctx *ep_ctx;
+		struct usb_host_endpoint *ep = sch_ep->ep;
+		unsigned int ep_index = xhci_get_endpoint_index(&ep->desc);
 
-		ret = check_sch_bw(sch_bw, sch_ep);
+		ret = check_sch_bw(sch_ep);
 		if (ret) {
 			xhci_err(xhci, "Not enough bandwidth! (%s)\n",
 				 sch_error_string(-ret));
 			return -ENOSPC;
 		}
-	}
-
-	list_for_each_entry_safe(sch_ep, tmp, &mtk->bw_ep_chk_list, endpoint) {
-		struct xhci_ep_ctx *ep_ctx;
-		struct usb_host_endpoint *ep = sch_ep->ep;
-		unsigned int ep_index = xhci_get_endpoint_index(&ep->desc);
-
-		sch_bw = get_bw_info(mtk, udev, ep);
-		list_move_tail(&sch_ep->endpoint, &sch_bw->bw_ep_list);
 
 		ep_ctx = xhci_get_ep_ctx(xhci, virt_dev->in_ctx, ep_index);
 		ep_ctx->reserved[0] = cpu_to_le32(EP_BPKTS(sch_ep->pkts)
@@ -806,22 +822,23 @@ int xhci_mtk_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 			sch_ep->offset, sch_ep->repeat);
 	}
 
-	return xhci_check_bandwidth(hcd, udev);
+	ret = xhci_check_bandwidth(hcd, udev);
+	if (!ret)
+		INIT_LIST_HEAD(&mtk->bw_ep_chk_list);
+
+	return ret;
 }
 
 void xhci_mtk_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 {
 	struct xhci_hcd_mtk *mtk = hcd_to_mtk(hcd);
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
-	struct mu3h_sch_bw_info *sch_bw;
 	struct mu3h_sch_ep_info *sch_ep, *tmp;
 
 	xhci_dbg(xhci, "%s() udev %s\n", __func__, dev_name(&udev->dev));
 
-	list_for_each_entry_safe(sch_ep, tmp, &mtk->bw_ep_chk_list, endpoint) {
-		sch_bw = get_bw_info(mtk, udev, sch_ep->ep);
-		destroy_sch_ep(udev, sch_bw, sch_ep);
-	}
+	list_for_each_entry_safe(sch_ep, tmp, &mtk->bw_ep_chk_list, endpoint)
+		destroy_sch_ep(mtk, udev, sch_ep);
 
 	xhci_reset_bandwidth(hcd, udev);
 }
@@ -850,8 +867,7 @@ int xhci_mtk_drop_ep(struct usb_hcd *hcd, struct usb_device *udev,
 	if (ret)
 		return ret;
 
-	if (ep->hcpriv)
-		drop_ep_quirk(hcd, udev, ep);
+	drop_ep_quirk(hcd, udev, ep);
 
 	return 0;
 }
diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
index ace432356c41..ddcf25524f67 100644
--- a/drivers/usb/host/xhci-mtk.h
+++ b/drivers/usb/host/xhci-mtk.h
@@ -10,6 +10,7 @@
 #define _XHCI_MTK_H_
 
 #include <linux/clk.h>
+#include <linux/rhashtable.h>
 
 #include "xhci.h"
 
@@ -25,36 +26,34 @@
 
 /**
  * @fs_bus_bw: array to keep track of bandwidth already used for FS
- * @ep_list: Endpoints using this TT
+ * @nr_eps: number of endpoints using this TT
  */
 struct mu3h_sch_tt {
 	u32 fs_bus_bw[XHCI_MTK_MAX_ESIT];
-	struct list_head ep_list;
+	int nr_eps;
 };
 
 /**
  * struct mu3h_sch_bw_info: schedule information for bandwidth domain
  *
  * @bus_bw: array to keep track of bandwidth already used at each uframes
- * @bw_ep_list: eps in the bandwidth domain
  *
  * treat a HS root port as a bandwidth domain, but treat a SS root port as
  * two bandwidth domains, one for IN eps and another for OUT eps.
  */
 struct mu3h_sch_bw_info {
 	u32 bus_bw[XHCI_MTK_MAX_ESIT];
-	struct list_head bw_ep_list;
 };
 
 /**
  * struct mu3h_sch_ep_info: schedule information for endpoint
  *
+ * @bw_info: bandwidth domain which this endpoint belongs
  * @esit: unit is 125us, equal to 2 << Interval field in ep-context
  * @num_budget_microframes: number of continuous uframes
  *		(@repeat==1) scheduled within the interval
  * @bw_cost_per_microframe: bandwidth cost per microframe
- * @endpoint: linked into bandwidth domain which it belongs to
- * @tt_endpoint: linked into mu3h_sch_tt's list which it belongs to
+ * @endpoint: linked into bw_ep_chk_list, used by check_bandwidth hook
  * @sch_tt: mu3h_sch_tt linked into
  * @ep_type: endpoint type
  * @maxpkt: max packet size of endpoint
@@ -82,11 +81,12 @@ struct mu3h_sch_ep_info {
 	u32 num_budget_microframes;
 	u32 bw_cost_per_microframe;
 	struct list_head endpoint;
-	struct list_head tt_endpoint;
+	struct mu3h_sch_bw_info *bw_info;
 	struct mu3h_sch_tt *sch_tt;
 	u32 ep_type;
 	u32 maxpkt;
 	struct usb_host_endpoint *ep;
+	struct rhash_head ep_link;
 	enum usb_device_speed speed;
 	bool allocated;
 	/*
@@ -134,6 +134,7 @@ struct xhci_hcd_mtk {
 	struct device *dev;
 	struct usb_hcd *hcd;
 	struct mu3h_sch_bw_info *sch_array;
+	struct rhashtable sch_ep_table;
 	struct list_head bw_ep_chk_list;
 	struct mu3c_ippc_regs __iomem *ippc_regs;
 	int num_u2_ports;
-- 
2.32.0.554.ge1b32706d8-goog

