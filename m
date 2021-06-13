Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC133A5ACD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 00:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbhFMWoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 18:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbhFMWoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 18:44:09 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363B8C061574
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 15:41:55 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m41-20020a05600c3b29b02901b9e5d74f02so8566766wms.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 15:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rJcVaNtayCmRC0+TdITTBgTJZtfeM8wWvimCLXL7Fw8=;
        b=XsonZfLbZVqpkWYL8KL6QDulrdOvxN7wRui8vpHCn+wdvDBgWd114+9BnZmu+2/MID
         MGaCUGdn6q4WvKCdHHwyEVZcM3gxiDXn1XBEdmjVzlBX2KJ7IwTNZaNHfAmrVK8qs2Q4
         qF0SOGp9oY7TR+6pqeOFcmwKA9c564fLSAcuUA4qcAqk+Ym83N+Nh6gb9Fp8LQNvedzc
         2TUwM7ANwPGvCpFiqw0odG7hlAHBUmvG+HB28qMuURPcsTxzIsEyxFD4KKoyZjA9dvwp
         RafDoR0Sm+sFOyHx4fT+PyogryXQcJ/OBVH+DXUABpIpX78tKC9T/oBu8YQDq8SB+pjJ
         GGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rJcVaNtayCmRC0+TdITTBgTJZtfeM8wWvimCLXL7Fw8=;
        b=VZNUahC4J6bRZ9Qxq0DrTnj3TmezGRyJV5SXvLccsNyBvK1L8X9uOJgu/scLrojWHQ
         xqbI0cK2gBBsbL5vVN3tch7V+9d+Tj7TdKw1MigrmK14HRugzlqEPByfzj6MA/PD9NGz
         l1olkUJA9GX4GGfaggOynVp8w4/BPpxf/U616ydhtgeF0M6txsbUyDOeHqHOFopOe+QV
         nns/58Iu46aIUKy3Rx+FwV512MN367SK4qdL8TBLbDm/78nWfUqIE1fcIy3rJl4lJSaW
         jAW0H0iQuemd5coHO0AU0Sf5cph9L1fdVbgJja2Arrs9zbWHmKvRm2ef7upK3RP0cv/I
         ekeQ==
X-Gm-Message-State: AOAM532gIPi2unnylMoUJ5xhDcWq+yWbuenW6nKnFNMROyyVmeftHhiR
        tpPRjGV5yxxD0j/0DjzRB9rD2g==
X-Google-Smtp-Source: ABdhPJwHWyt0f0clHnPwFjnUCQtE/EmSAMF6piTZ6I1oEPmrbsgW2Qyal+VJ1jTfBJaiyRDBpsUAsA==
X-Received: by 2002:a05:600c:5122:: with SMTP id o34mr13572081wms.168.1623624113634;
        Sun, 13 Jun 2021 15:41:53 -0700 (PDT)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id w11sm15120618wrv.89.2021.06.13.15.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 15:41:53 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, insafonov@gmail.com,
        linux@roeck-us.net, straube.linux@gmail.com, liushixin2@huawei.com,
        gustavoars@kernel.org, christophe.jaillet@wanadoo.fr,
        yepeilin.cs@gmail.com, dan.carpenter@oracle.com, martin@kaiser.cx,
        simon.fodin@gmail.com, romain.perier@gmail.com,
        apais@linux.microsoft.com, mh12gx2825@gmail.com
Subject: [PATCH 2/3] staging: rtl8188eu: convert DBG_88E calls in core/rtw_xmit.c
Date:   Sun, 13 Jun 2021 23:41:46 +0100
Message-Id: <20210613224147.1045-3-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210613224147.1045-1-phil@philpotter.co.uk>
References: <20210613224147.1045-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert all calls to the DBG_88E and DBG_88E_LEVEL macros in
core/rtw_xmit.c into netdev_dbg calls. These are unnecessary,
as visibility of debug messages can be controlled more precisely
by just using debugfs. It is important to keep these messages
still, as they are displayable via a kernel module parameter when
using DBG_88E.

To do this, also modify the rtw_sctx_wait, rtw_sctx_done_err and
qos_acm functions and call sites, to pass through a struct net_device
pointer so that netdev_dbg can be used in these as well.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c |  2 +-
 drivers/staging/rtl8188eu/core/rtw_xmit.c     | 60 +++++++++++--------
 .../staging/rtl8188eu/hal/rtl8188eu_xmit.c    |  4 +-
 drivers/staging/rtl8188eu/include/rtw_xmit.h  |  6 +-
 drivers/staging/rtl8188eu/os_dep/os_intfs.c   |  2 +-
 .../staging/rtl8188eu/os_dep/usb_ops_linux.c  | 11 +++-
 6 files changed, 52 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 507672120cbc..e73054f6c1cb 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -240,7 +240,7 @@ static s32 dump_mgntframe_and_wait(struct adapter *padapter,
 	ret = rtw_hal_mgnt_xmit(padapter, pmgntframe);
 
 	if (ret == _SUCCESS)
-		ret = rtw_sctx_wait(&sctx);
+		ret = rtw_sctx_wait(padapter->pnetdev, &sctx);
 
 	return ret;
 }
diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 718dd20ff36c..a0bc9093e68b 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -340,7 +340,7 @@ static void update_attrib_phy_info(struct pkt_attrib *pattrib, struct sta_info *
 	pattrib->retry_ctrl = false;
 }
 
-u8 qos_acm(u8 acm_mask, u8 priority)
+u8 qos_acm(struct net_device *dev, u8 acm_mask, u8 priority)
 {
 	u8 change_priority = priority;
 
@@ -364,8 +364,7 @@ u8 qos_acm(u8 acm_mask, u8 priority)
 			change_priority = 5;
 		break;
 	default:
-		DBG_88E("%s(): invalid pattrib->priority: %d!!!\n",
-			__func__, priority);
+		netdev_dbg(dev, "invalid pattrib->priority: %d!!!\n", priority);
 		break;
 	}
 
@@ -451,7 +450,7 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 			}
 		}
 	} else if (pattrib->ether_type == ETH_P_PAE) {
-		DBG_88E_LEVEL(_drv_info_, "send eapol packet\n");
+		netdev_dbg(padapter->pnetdev, "send eapol packet\n");
 	}
 
 	if ((pattrib->ether_type == ETH_P_PAE) || (pattrib->dhcp_pkt == 1))
@@ -481,7 +480,6 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 
 	if (psta) {
 		pattrib->mac_id = psta->mac_id;
-		/* DBG_88E("%s ==> mac_id(%d)\n", __func__, pattrib->mac_id); */
 		pattrib->psta = psta;
 	} else {
 		/*  if we cannot get psta => drop the pkt */
@@ -505,7 +503,9 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 			set_qos(pkt, pattrib);
 
 			if (pmlmepriv->acm_mask != 0)
-				pattrib->priority = qos_acm(pmlmepriv->acm_mask, pattrib->priority);
+				pattrib->priority = qos_acm(padapter->pnetdev,
+							    pmlmepriv->acm_mask,
+							    pattrib->priority);
 		}
 	}
 
@@ -927,7 +927,7 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 		return _FAIL;
 
 	if (!pxmitframe->buf_addr) {
-		DBG_88E("==> %s buf_addr == NULL\n", __func__);
+		netdev_dbg(padapter->pnetdev, "buf_addr == NULL\n");
 		return _FAIL;
 	}
 
@@ -939,7 +939,7 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 
 	if (rtw_make_wlanhdr(padapter, mem_start, pattrib) == _FAIL) {
 		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("%s: rtw_make_wlanhdr fail; drop pkt\n", __func__));
-		DBG_88E("%s: rtw_make_wlanhdr fail; drop pkt\n", __func__);
+		netdev_dbg(padapter->pnetdev, "rtw_make_wlanhdr fail; drop pkt\n");
 		res = _FAIL;
 		goto exit;
 	}
@@ -1040,7 +1040,8 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 
 	if (xmitframe_addmic(padapter, pxmitframe) == _FAIL) {
 		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("xmitframe_addmic(padapter, pxmitframe) == _FAIL\n"));
-		DBG_88E("xmitframe_addmic(padapter, pxmitframe) == _FAIL\n");
+		netdev_dbg(padapter->pnetdev,
+			   "xmitframe_addmic(padapter, pxmitframe) == _FAIL\n");
 		res = _FAIL;
 		goto exit;
 	}
@@ -1154,8 +1155,11 @@ struct xmit_buf *rtw_alloc_xmitbuf_ext(struct xmit_priv *pxmitpriv)
 		pxmitpriv->free_xmit_extbuf_cnt--;
 		pxmitbuf->priv_data = NULL;
 		if (pxmitbuf->sctx) {
-			DBG_88E("%s pxmitbuf->sctx is not NULL\n", __func__);
-			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
+			netdev_dbg(pxmitpriv->adapter->pnetdev,
+				   "pxmitbuf->sctx is not NULL\n");
+			rtw_sctx_done_err(pxmitpriv->adapter->pnetdev,
+					  &pxmitbuf->sctx,
+					  RTW_SCTX_DONE_BUF_ALLOC);
 		}
 	}
 	spin_unlock_irqrestore(&pfree_queue->lock, irql);
@@ -1197,8 +1201,11 @@ struct xmit_buf *rtw_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
 		pxmitpriv->free_xmitbuf_cnt--;
 		pxmitbuf->priv_data = NULL;
 		if (pxmitbuf->sctx) {
-			DBG_88E("%s pxmitbuf->sctx is not NULL\n", __func__);
-			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
+			netdev_dbg(pxmitpriv->adapter->pnetdev,
+				   "pxmitbuf->sctx is not NULL\n");
+			rtw_sctx_done_err(pxmitpriv->adapter->pnetdev,
+					  &pxmitbuf->sctx,
+					  RTW_SCTX_DONE_BUF_ALLOC);
 		}
 	}
 	spin_unlock_irqrestore(&pfree_xmitbuf_queue->lock, irql);
@@ -1215,8 +1222,11 @@ s32 rtw_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
 		return _FAIL;
 
 	if (pxmitbuf->sctx) {
-		DBG_88E("%s pxmitbuf->sctx is not NULL\n", __func__);
-		rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_FREE);
+		netdev_dbg(pxmitpriv->adapter->pnetdev,
+			   "pxmitbuf->sctx is not NULL\n");
+		rtw_sctx_done_err(pxmitpriv->adapter->pnetdev,
+				  &pxmitbuf->sctx,
+				  RTW_SCTX_DONE_BUF_FREE);
 	}
 
 	if (pxmitbuf->ext_tag) {
@@ -1482,7 +1492,7 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 
 	if (!psta) {
 		res = _FAIL;
-		DBG_88E("%s: psta == NULL\n", __func__);
+		netdev_dbg(padapter->pnetdev, "psta == NULL\n");
 		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("%s: psta == NULL\n", __func__));
 		goto exit;
 	}
@@ -1591,7 +1601,7 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
 	pxmitframe = rtw_alloc_xmitframe(pxmitpriv);
 	if (!pxmitframe) {
 		RT_TRACE(_module_xmit_osdep_c_, _drv_err_, ("%s: no more pxmitframe\n", __func__));
-		DBG_88E("DBG_TX_DROP_FRAME %s no more pxmitframe\n", __func__);
+		netdev_dbg(padapter->pnetdev, "DBG_TX_DROP_FRAME no more pxmitframe\n");
 		return -1;
 	}
 
@@ -1982,7 +1992,7 @@ void rtw_sctx_init(struct submit_ctx *sctx, int timeout_ms)
 	sctx->status = RTW_SCTX_SUBMITTED;
 }
 
-int rtw_sctx_wait(struct submit_ctx *sctx)
+int rtw_sctx_wait(struct net_device *dev, struct submit_ctx *sctx)
 {
 	int ret = _FAIL;
 	unsigned long expire;
@@ -1992,7 +2002,7 @@ int rtw_sctx_wait(struct submit_ctx *sctx)
 	if (!wait_for_completion_timeout(&sctx->done, expire)) {
 		/* timeout, do something?? */
 		status = RTW_SCTX_DONE_TIMEOUT;
-		DBG_88E("%s timeout\n", __func__);
+		netdev_dbg(dev, "timeout\n");
 	} else {
 		status = sctx->status;
 	}
@@ -2018,11 +2028,11 @@ static bool rtw_sctx_chk_warning_status(int status)
 	}
 }
 
-void rtw_sctx_done_err(struct submit_ctx **sctx, int status)
+void rtw_sctx_done_err(struct net_device *dev, struct submit_ctx **sctx, int status)
 {
 	if (*sctx) {
 		if (rtw_sctx_chk_warning_status(status))
-			DBG_88E("%s status:%d\n", __func__, status);
+			netdev_dbg(dev, "status:%d\n", status);
 		(*sctx)->status = status;
 		complete(&((*sctx)->done));
 		*sctx = NULL;
@@ -2037,7 +2047,7 @@ int rtw_ack_tx_wait(struct xmit_priv *pxmitpriv, u32 timeout_ms)
 	pack_tx_ops->timeout_ms = timeout_ms;
 	pack_tx_ops->status = RTW_SCTX_SUBMITTED;
 
-	return rtw_sctx_wait(pack_tx_ops);
+	return rtw_sctx_wait(pxmitpriv->adapter->pnetdev, pack_tx_ops);
 }
 
 void rtw_ack_tx_done(struct xmit_priv *pxmitpriv, int status)
@@ -2045,7 +2055,9 @@ void rtw_ack_tx_done(struct xmit_priv *pxmitpriv, int status)
 	struct submit_ctx *pack_tx_ops = &pxmitpriv->ack_tx_ops;
 
 	if (pxmitpriv->ack_tx)
-		rtw_sctx_done_err(&pack_tx_ops, status);
+		rtw_sctx_done_err(pxmitpriv->adapter->pnetdev,
+				  &pack_tx_ops,
+				  status);
 	else
-		DBG_88E("%s ack_tx not set\n", __func__);
+		netdev_dbg(pxmitpriv->adapter->pnetdev, "ack_tx not set\n");
 }
diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
index d82dd22f2903..ba6c726e8724 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
@@ -387,7 +387,9 @@ static s32 rtw_dump_xframe(struct adapter *adapt, struct xmit_frame *pxmitframe)
 	rtw_free_xmitframe(pxmitpriv, pxmitframe);
 
 	if  (ret != _SUCCESS)
-		rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_UNKNOWN);
+		rtw_sctx_done_err(adapt->pnetdev,
+				  &pxmitbuf->sctx,
+				  RTW_SCTX_DONE_UNKNOWN);
 
 	return ret;
 }
diff --git a/drivers/staging/rtl8188eu/include/rtw_xmit.h b/drivers/staging/rtl8188eu/include/rtw_xmit.h
index 456fd52717f3..bc5dc656d054 100644
--- a/drivers/staging/rtl8188eu/include/rtw_xmit.h
+++ b/drivers/staging/rtl8188eu/include/rtw_xmit.h
@@ -182,8 +182,8 @@ enum {
 };
 
 void rtw_sctx_init(struct submit_ctx *sctx, int timeout_ms);
-int rtw_sctx_wait(struct submit_ctx *sctx);
-void rtw_sctx_done_err(struct submit_ctx **sctx, int status);
+int rtw_sctx_wait(struct net_device *dev, struct submit_ctx *sctx);
+void rtw_sctx_done_err(struct net_device *dev, struct submit_ctx **sctx, int status);
 
 struct xmit_buf {
 	struct list_head list;
@@ -341,7 +341,7 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta);
 void xmit_delivery_enabled_frames(struct adapter *padapter, struct sta_info *psta);
 #endif
 
-u8	qos_acm(u8 acm_mask, u8 priority);
+u8	qos_acm(struct net_device *dev, u8 acm_mask, u8 priority);
 u32	rtw_get_ff_hwaddr(struct xmit_frame *pxmitframe);
 int rtw_ack_tx_wait(struct xmit_priv *pxmitpriv, u32 timeout_ms);
 void rtw_ack_tx_done(struct xmit_priv *pxmitpriv, int status);
diff --git a/drivers/staging/rtl8188eu/os_dep/os_intfs.c b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
index 870148020e61..663286d5a7d4 100644
--- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
@@ -254,7 +254,7 @@ static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb,
 	skb->priority = rtw_classify8021d(skb);
 
 	if (pmlmepriv->acm_mask != 0)
-		skb->priority = qos_acm(pmlmepriv->acm_mask, skb->priority);
+		skb->priority = qos_acm(dev, pmlmepriv->acm_mask, skb->priority);
 
 	return rtw_1d_to_queue[skb->priority];
 }
diff --git a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
index ec07b2017fb7..70dc0a074cbe 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
@@ -500,7 +500,8 @@ static void usb_write_port_complete(struct urb *purb)
 	}
 
 check_completion:
-	rtw_sctx_done_err(&pxmitbuf->sctx,
+	rtw_sctx_done_err(padapter->pnetdev,
+			  &pxmitbuf->sctx,
 			  purb->status ? RTW_SCTX_DONE_WRITE_PORT_ERR :
 			  RTW_SCTX_DONE_SUCCESS);
 
@@ -523,7 +524,9 @@ u32 usb_write_port(struct adapter *padapter, u32 addr, u32 cnt, struct xmit_buf
 
 	if ((padapter->bDriverStopped) || (padapter->bSurpriseRemoved) ||
 	    (padapter->pwrctrlpriv.pnp_bstop_trx)) {
-		rtw_sctx_done_err(&xmitbuf->sctx, RTW_SCTX_DONE_TX_DENY);
+		rtw_sctx_done_err(padapter->pnetdev,
+				  &xmitbuf->sctx,
+				  RTW_SCTX_DONE_TX_DENY);
 		goto exit;
 	}
 
@@ -569,7 +572,9 @@ u32 usb_write_port(struct adapter *padapter, u32 addr, u32 cnt, struct xmit_buf
 
 	status = usb_submit_urb(purb, GFP_ATOMIC);
 	if (status) {
-		rtw_sctx_done_err(&xmitbuf->sctx, RTW_SCTX_DONE_WRITE_PORT_ERR);
+		rtw_sctx_done_err(padapter->pnetdev,
+				  &xmitbuf->sctx,
+				  RTW_SCTX_DONE_WRITE_PORT_ERR);
 		if (status == -ENODEV)
 			padapter->bDriverStopped = true;
 
-- 
2.30.2

