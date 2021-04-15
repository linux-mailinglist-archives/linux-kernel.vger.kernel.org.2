Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DB8360696
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhDOKH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhDOKHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:07:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129B0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 03:07:31 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n127so368282wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 03:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=guSNPzcWFQAwUaj556MNs7MHJEI2uCWAKb8/udd1cQE=;
        b=JluNu4CFfP0qpbLpXIgvqZlIcOzav0eeig9msLmXPQYhffqJ4vzVwBNlzY1KOpkyQq
         QISpIXfafurqBg390QwnEKAqLhT9Bhcd9/M1Bqiva+fXUUFR8FruMnc1QV6FnLaG88OK
         OoDbprgsLfBqiLsJu4gRlUxhzL8Sb33PTGj4jT8osONqdQCFjhgdSacbcLXDadBHzjLf
         X4OjSXOMxj6ml3AaKR4IKJdt05aisRGkg3lEDTTEUsYneZYYFDj3E+xp8v971qJP9cXw
         mJdO0Td9/Pha0895r/itMPiVgESaX7KbgTdSjzrINmnI93Nyjz+ET/wa1ljhQEjHu4aq
         Q3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=guSNPzcWFQAwUaj556MNs7MHJEI2uCWAKb8/udd1cQE=;
        b=BlNzxkzp0uDy0v56JUSVGqlgIJR+q3hOvV0oQeJtscSdDg9nIdmF7+MmJP0ZEX7oDu
         aswrNBClXq7r+8UD2M2iBXKk2pQ4VJ1pjWKWSbbN+xC2m18dl3dd2z+FkBvakxwDTln2
         F+Zex+PP13mpA+e5GoDWvb23uFmFNzplN88pE1cxHQLBVh5eYYntXLypn678mo7EeF6S
         OpDe2B+vCSnv2lwFtFy5DbvmlB5STpPbw+x5NeK0YfSt4jL+QL4LcCPNmyVYmzVioYu2
         KKm8qh3mIM8BX2q1NXlCEBkCE6hfhYC2LDkBfKtTxhxfRWt9QVvFNXJPY2p2Dft0PLDX
         LF5A==
X-Gm-Message-State: AOAM5319RGIsrsdUREIgG3TE5xqjtl/WhraOPpkG1pakrBUFjBaJFkza
        9nOUSG3GfBqanf+JGxyvp8FdagaWAiQ=
X-Google-Smtp-Source: ABdhPJxQfv0ZZVX7neFgeQA57vL1H8ZxXUrkad7+3FxwHA2G71mAuICsHXIIXC3NQrMJXfbrRszLag==
X-Received: by 2002:a1c:a7c8:: with SMTP id q191mr2376645wme.6.1618481249014;
        Thu, 15 Apr 2021 03:07:29 -0700 (PDT)
Received: from agape ([5.171.72.223])
        by smtp.gmail.com with ESMTPSA id g9sm1824406wmh.21.2021.04.15.03.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 03:07:28 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] staging: rtl8723bs: replace DBG_871X_LEVEL logs with netdev_*()
Date:   Thu, 15 Apr 2021 12:07:19 +0200
Message-Id: <4a02f9f5665fa4b78c0b321ce0cc62254255c9dd.1618480688.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618480688.git.fabioaiuto83@gmail.com>
References: <cover.1618480688.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace DBG_871X_LEVEL logs with netdev_*() functions
where possible (i.e. where a pointer to netdev is easily
available).

This is not possible in correspondance of redundant
log in module initialization.

So remove those ones.

DBG_871X_LEVEL macro wraps a raw printk call which is not
recommended in a device driver context, prefer using
netdev_*() log functions.

The remove/replace operation has been done with the
following semantic patch script:

@@
expression list args;
identifier padapter;
identifier func;
symbol _drv_always_, _drv_info_, _drv_warning_;
symbol _drv_err_, _drv_emerg_;
@@

func(..., struct adapter *padapter, ...) {
	<...
(
-	DBG_871X_LEVEL(_drv_always_, args);
+	netdev_dbg(padapter->pnetdev, args);
|
-	DBG_871X_LEVEL(_drv_info_, args);
+	netdev_info(padapter->pnetdev, args);
|
-	DBG_871X_LEVEL(_drv_warning_, args);
+	netdev_warn(padapter->pnetdev, args);
|
-	DBG_871X_LEVEL(_drv_err_, args);
+	netdev_err(padapter->pnetdev, args);
|
-	DBG_871X_LEVEL(_drv_emerg_, args);
+	netdev_emerg(padapter->pnetdev, args);
)
	...>
}

@rule@
identifier func, context, padapter;
@@

func(void *context)
{
	...
struct adapter *padapter = context;
	...
}

@@
expression list args;
identifier rule.padapter;
identifier rule.func, rule.context;
@@

func(void *context)
{
	<...
(
-	DBG_871X_LEVEL(_drv_always_, args);
+	netdev_dbg(padapter->pnetdev, args);
|
-	DBG_871X_LEVEL(_drv_info_, args);
+	netdev_info(padapter->pnetdev, args);
|
-	DBG_871X_LEVEL(_drv_warning_, args);
+	netdev_warn(padapter->pnetdev, args);
|
-	DBG_871X_LEVEL(_drv_err_, args);
+	netdev_err(padapter->pnetdev, args);
|
-	DBG_871X_LEVEL(_drv_emerg_, args);
+	netdev_emerg(padapter->pnetdev, args);
)
	...>
}

@@
expression list args;
expression get_dev;
identifier func, dev;
@@

func(...)
{
	...
	struct net_device *dev = get_dev;
	<...
(
-	DBG_871X_LEVEL(_drv_always_, args);
+	netdev_dbg(dev, args);
|
-	DBG_871X_LEVEL(_drv_info_, args);
+	netdev_info(dev, args);
|
-	DBG_871X_LEVEL(_drv_warning_, args);
+	netdev_warn(dev, args);
|
-	DBG_871X_LEVEL(_drv_err_, args);
+	netdev_err(dev, args);
|
-	DBG_871X_LEVEL(_drv_emerg_, args);
+	netdev_emerg(dev, args);
)
	...>
}

@@
expression list args;
identifier func, dev;
@@

func(struct net_device *dev)
{
	<...
(
-	DBG_871X_LEVEL(_drv_always_, args);
+	netdev_dbg(dev, args);
|
-	DBG_871X_LEVEL(_drv_info_, args);
+	netdev_info(dev, args);
|
-	DBG_871X_LEVEL(_drv_warning_, args);
+	netdev_warn(dev, args);
|
-	DBG_871X_LEVEL(_drv_err_, args);
+	netdev_err(dev, args);
|
-	DBG_871X_LEVEL(_drv_emerg_, args);
+	netdev_emerg(dev, args);
)
	...>
}

@@
expression list args;
identifier func, dvobj;
@@

func(struct dvobj_priv *dvobj)
{
	<...
(
-	DBG_871X_LEVEL(_drv_always_, args);
+	netdev_dbg(dvobj->if1->pnetdev, args);
|
-	DBG_871X_LEVEL(_drv_info_, args);
+	netdev_info(dvobj->if1->pnetdev, args);
|
-	DBG_871X_LEVEL(_drv_warning_, args);
+	netdev_warn(dvobj->if1->pnetdev, args);
|
-	DBG_871X_LEVEL(_drv_err_, args);
+	netdev_err(dvobj->if1->pnetdev, args);
|
-	DBG_871X_LEVEL(_drv_emerg_, args);
+	netdev_emerg(dvobj->if1->pnetdev, args);
)
	...>
}

@@
@@

-	DBG_871X_LEVEL(...);

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c      | 30 ++++++---
 drivers/staging/rtl8723bs/core/rtw_io.c       |  4 +-
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    | 10 +--
 drivers/staging/rtl8723bs/core/rtw_mlme.c     |  3 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 67 ++++++++++++-------
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  |  9 ++-
 drivers/staging/rtl8723bs/core/rtw_security.c | 40 +++++++----
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 21 +++---
 drivers/staging/rtl8723bs/core/rtw_xmit.c     |  2 +-
 drivers/staging/rtl8723bs/hal/hal_com.c       | 26 ++++---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |  4 +-
 .../staging/rtl8723bs/hal/rtl8723bs_xmit.c    | 14 ++--
 drivers/staging/rtl8723bs/hal/sdio_ops.c      |  3 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  8 ++-
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    |  2 +-
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   | 32 +++++----
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c  | 11 +--
 17 files changed, 178 insertions(+), 108 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index d834a82aaf55..e1a8f8b47edd 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -401,18 +401,25 @@ int rtw_cmd_thread(void *context)
 
 	while (1) {
 		if (wait_for_completion_interruptible(&pcmdpriv->cmd_queue_comp)) {
-			DBG_871X_LEVEL(_drv_always_, FUNC_ADPT_FMT" wait_for_completion_interruptible(&pcmdpriv->cmd_queue_comp) return != 0, break\n", FUNC_ADPT_ARG(padapter));
+			netdev_dbg(padapter->pnetdev,
+				   FUNC_ADPT_FMT " wait_for_completion_interruptible(&pcmdpriv->cmd_queue_comp) return != 0, break\n",
+				   FUNC_ADPT_ARG(padapter));
 			break;
 		}
 
 		if ((padapter->bDriverStopped == true) || (padapter->bSurpriseRemoved == true)) {
-			DBG_871X_LEVEL(_drv_always_, "%s: DriverStopped(%d) SurpriseRemoved(%d) break at line %d\n",
-				__func__, padapter->bDriverStopped, padapter->bSurpriseRemoved, __LINE__);
+			netdev_dbg(padapter->pnetdev,
+				   "%s: DriverStopped(%d) SurpriseRemoved(%d) break at line %d\n",
+				   __func__, padapter->bDriverStopped,
+				   padapter->bSurpriseRemoved, __LINE__);
 			break;
 		}
 
 		if (pcmdpriv->stop_req) {
-			DBG_871X_LEVEL(_drv_always_, FUNC_ADPT_FMT" stop_req:%u, break\n", FUNC_ADPT_ARG(padapter), pcmdpriv->stop_req);
+			netdev_dbg(padapter->pnetdev,
+				   FUNC_ADPT_FMT " stop_req:%u, break\n",
+				   FUNC_ADPT_ARG(padapter),
+				   pcmdpriv->stop_req);
 			break;
 		}
 
@@ -424,8 +431,10 @@ int rtw_cmd_thread(void *context)
 
 _next:
 		if ((padapter->bDriverStopped == true) || (padapter->bSurpriseRemoved == true)) {
-			DBG_871X_LEVEL(_drv_always_, "%s: DriverStopped(%d) SurpriseRemoved(%d) break at line %d\n",
-				__func__, padapter->bDriverStopped, padapter->bSurpriseRemoved, __LINE__);
+			netdev_dbg(padapter->pnetdev,
+				   "%s: DriverStopped(%d) SurpriseRemoved(%d) break at line %d\n",
+				   __func__, padapter->bDriverStopped,
+				   padapter->bSurpriseRemoved, __LINE__);
 			break;
 		}
 
@@ -465,8 +474,9 @@ int rtw_cmd_thread(void *context)
 
 		if (mutex_lock_interruptible(&(pcmd->padapter->cmdpriv.sctx_mutex)) == 0) {
 			if (pcmd->sctx) {
-				DBG_871X_LEVEL(_drv_always_, FUNC_ADPT_FMT" pcmd->sctx\n",
-					       FUNC_ADPT_ARG(pcmd->padapter));
+				netdev_dbg(padapter->pnetdev,
+					   FUNC_ADPT_FMT " pcmd->sctx\n",
+					   FUNC_ADPT_ARG(pcmd->padapter));
 
 				if (pcmd->res == H2C_SUCCESS)
 					rtw_sctx_done(&pcmd->sctx);
@@ -961,7 +971,9 @@ u8 rtw_clearstakey_cmd(struct adapter *padapter, struct sta_info *sta, u8 enqueu
 
 	if (!enqueue) {
 		while ((cam_id = rtw_camid_search(padapter, sta->hwaddr, -1)) >= 0) {
-			DBG_871X_LEVEL(_drv_always_, "clear key for addr:%pM, camid:%d\n", MAC_ARG(sta->hwaddr), cam_id);
+			netdev_dbg(padapter->pnetdev,
+				   "clear key for addr:%pM, camid:%d\n",
+				   MAC_ARG(sta->hwaddr), cam_id);
 			clear_cam_entry(padapter, cam_id);
 			rtw_camid_free(padapter, cam_id);
 		}
diff --git a/drivers/staging/rtl8723bs/core/rtw_io.c b/drivers/staging/rtl8723bs/core/rtw_io.c
index 1208ead0ed52..c860ab7d618c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_io.c
+++ b/drivers/staging/rtl8723bs/core/rtw_io.c
@@ -130,7 +130,9 @@ u8 _rtw_sd_f0_read8(struct adapter *adapter, u32 addr)
 	if (_sd_f0_read8)
 		r_val = _sd_f0_read8(pintfhdl, addr);
 	else
-		DBG_871X_LEVEL(_drv_warning_, FUNC_ADPT_FMT" _sd_f0_read8 callback is NULL\n", FUNC_ADPT_ARG(adapter));
+		netdev_warn(adapter->pnetdev,
+			    FUNC_ADPT_FMT " _sd_f0_read8 callback is NULL\n",
+			    FUNC_ADPT_ARG(adapter));
 
 	return r_val;
 }
diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index f6bd360f3183..bd5056507f53 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -141,7 +141,7 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
 
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	DBG_871X_LEVEL(_drv_always_, "set bssid:%pM\n", bssid);
+	netdev_dbg(padapter->pnetdev, "set bssid:%pM\n", bssid);
 
 	if ((bssid[0] == 0x00 && bssid[1] == 0x00 && bssid[2] == 0x00 && bssid[3] == 0x00 && bssid[4] == 0x00 && bssid[5] == 0x00) ||
 	    (bssid[0] == 0xFF && bssid[1] == 0xFF && bssid[2] == 0xFF && bssid[3] == 0xFF && bssid[4] == 0xFF && bssid[5] == 0xFF)) {
@@ -206,8 +206,8 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wlan_network *pnetwork = &pmlmepriv->cur_network;
 
-	DBG_871X_LEVEL(_drv_always_, "set ssid [%s] fw_state = 0x%08x\n",
-			ssid->Ssid, get_fwstate(pmlmepriv));
+	netdev_dbg(padapter->pnetdev, "set ssid [%s] fw_state = 0x%08x\n",
+		   ssid->Ssid, get_fwstate(pmlmepriv));
 
 	if (padapter->hw_init_completed == false) {
 		status = _FAIL;
@@ -311,8 +311,8 @@ u8 rtw_set_802_11_connect(struct adapter *padapter, u8 *bssid, struct ndis_802_1
 
 	spin_lock_bh(&pmlmepriv->lock);
 
-	DBG_871X_LEVEL(_drv_always_, FUNC_ADPT_FMT"  fw_state = 0x%08x\n",
-		FUNC_ADPT_ARG(padapter), get_fwstate(pmlmepriv));
+	netdev_dbg(padapter->pnetdev, FUNC_ADPT_FMT "  fw_state = 0x%08x\n",
+		   FUNC_ADPT_ARG(padapter), get_fwstate(pmlmepriv));
 
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY) == true)
 		goto handle_tkip_countermeasure;
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 895997868c81..4707dba90397 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1247,7 +1247,8 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			if (ptarget_wlan) {
 				rtw_joinbss_update_network(adapter, ptarget_wlan, pnetwork);
 			} else {
-				DBG_871X_LEVEL(_drv_always_, "Can't find ptarget_wlan when joinbss_event callback\n");
+				netdev_dbg(adapter->pnetdev,
+					   "Can't find ptarget_wlan when joinbss_event callback\n");
 				spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
 				goto ignore_joinbss_callback;
 			}
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 963ea80083c8..775e55ecac25 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -706,7 +706,8 @@ unsigned int OnBeacon(struct adapter *padapter, union recv_frame *precv_frame)
 			if (psta) {
 				ret = rtw_check_bcn_info(padapter, pframe, len);
 				if (!ret) {
-						DBG_871X_LEVEL(_drv_always_, "ap has changed, disconnect now\n ");
+						netdev_dbg(padapter->pnetdev,
+							   "ap has changed, disconnect now\n ");
 						receive_disconnect(padapter, pmlmeinfo->network.MacAddress, 0);
 						return _SUCCESS;
 				}
@@ -1001,7 +1002,7 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 	}
 
 	if (go2asoc) {
-		DBG_871X_LEVEL(_drv_always_, "auth success, start assoc\n");
+		netdev_dbg(padapter->pnetdev, "auth success, start assoc\n");
 		start_clnt_assoc(padapter);
 		return _SUCCESS;
 	}
@@ -1569,8 +1570,9 @@ unsigned int OnDeAuth(struct adapter *padapter, union recv_frame *precv_frame)
 		/* rtw_free_stainfo(padapter, psta); */
 		/* spin_unlock_bh(&(pstapriv->sta_hash_lock)); */
 
-		DBG_871X_LEVEL(_drv_always_, "ap recv deauth reason code(%d) sta:%pM\n",
-				reason, GetAddr2Ptr(pframe));
+		netdev_dbg(padapter->pnetdev,
+			   "ap recv deauth reason code(%d) sta:%pM\n", reason,
+			   GetAddr2Ptr(pframe));
 
 		psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
 		if (psta) {
@@ -1608,8 +1610,10 @@ unsigned int OnDeAuth(struct adapter *padapter, union recv_frame *precv_frame)
 			}
 		}
 
-		DBG_871X_LEVEL(_drv_always_, "sta recv deauth reason code(%d) sta:%pM, ignore = %d\n",
-				reason, GetAddr3Ptr(pframe), ignore_received_deauth);
+		netdev_dbg(padapter->pnetdev,
+			   "sta recv deauth reason code(%d) sta:%pM, ignore = %d\n",
+			   reason, GetAddr3Ptr(pframe),
+			   ignore_received_deauth);
 
 		if (0 == ignore_received_deauth) {
 			receive_disconnect(padapter, GetAddr3Ptr(pframe), reason);
@@ -1642,8 +1646,9 @@ unsigned int OnDisassoc(struct adapter *padapter, union recv_frame *precv_frame)
 		/* rtw_free_stainfo(padapter, psta); */
 		/* spin_unlock_bh(&(pstapriv->sta_hash_lock)); */
 
-		DBG_871X_LEVEL(_drv_always_, "ap recv disassoc reason code(%d) sta:%pM\n",
-				reason, GetAddr2Ptr(pframe));
+		netdev_dbg(padapter->pnetdev,
+			   "ap recv disassoc reason code(%d) sta:%pM\n",
+			   reason, GetAddr2Ptr(pframe));
 
 		psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
 		if (psta) {
@@ -1663,8 +1668,9 @@ unsigned int OnDisassoc(struct adapter *padapter, union recv_frame *precv_frame)
 
 		return _SUCCESS;
 	} else {
-		DBG_871X_LEVEL(_drv_always_, "sta recv disassoc reason code(%d) sta:%pM\n",
-				reason, GetAddr3Ptr(pframe));
+		netdev_dbg(padapter->pnetdev,
+			   "sta recv disassoc reason code(%d) sta:%pM\n",
+			   reason, GetAddr3Ptr(pframe));
 
 		receive_disconnect(padapter, GetAddr3Ptr(pframe), reason);
 	}
@@ -2466,7 +2472,9 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 				remainder_ielen = (pframe-remainder_ie);
 
 				if (remainder_ielen > MAX_IE_SZ) {
-					DBG_871X_LEVEL(_drv_warning_, FUNC_ADPT_FMT" remainder_ielen > MAX_IE_SZ\n", FUNC_ADPT_ARG(padapter));
+					netdev_warn(padapter->pnetdev,
+						    FUNC_ADPT_FMT " remainder_ielen > MAX_IE_SZ\n",
+						    FUNC_ADPT_ARG(padapter));
 					remainder_ielen = MAX_IE_SZ;
 				}
 
@@ -4301,7 +4309,7 @@ void start_clnt_auth(struct adapter *padapter)
 	pmlmeext->retry = 0;
 
 
-	DBG_871X_LEVEL(_drv_always_, "start auth\n");
+	netdev_dbg(padapter->pnetdev, "start auth\n");
 	issue_auth(padapter, NULL, 0);
 
 	set_link_timer(pmlmeext, REAUTH_TO);
@@ -5219,8 +5227,9 @@ void linked_status_chk(struct adapter *padapter)
 			if (rx_chk == _FAIL) {
 				pmlmeext->retry++;
 				if (pmlmeext->retry > rx_chk_limit) {
-					DBG_871X_LEVEL(_drv_always_, FUNC_ADPT_FMT" disconnect or roaming\n",
-						FUNC_ADPT_ARG(padapter));
+					netdev_dbg(padapter->pnetdev,
+						   FUNC_ADPT_FMT " disconnect or roaming\n",
+						   FUNC_ADPT_ARG(padapter));
 					receive_disconnect(padapter, pmlmeinfo->network.MacAddress
 						, WLAN_REASON_EXPIRATION_CHK);
 					return;
@@ -5685,8 +5694,9 @@ static int rtw_scan_ch_decision(struct adapter *padapter, struct rtw_ieee80211_c
 			&& rtw_mlme_band_check(padapter, in[i].hw_value)
 		) {
 			if (j >= out_num) {
-				DBG_871X_LEVEL(_drv_always_, FUNC_ADPT_FMT" out_num:%u not enough\n",
-					FUNC_ADPT_ARG(padapter), out_num);
+				netdev_dbg(padapter->pnetdev,
+					   FUNC_ADPT_FMT " out_num:%u not enough\n",
+					   FUNC_ADPT_ARG(padapter), out_num);
 				break;
 			}
 
@@ -5708,8 +5718,10 @@ static int rtw_scan_ch_decision(struct adapter *padapter, struct rtw_ieee80211_c
 			if (rtw_mlme_band_check(padapter, pmlmeext->channel_set[i].ChannelNum)) {
 
 				if (j >= out_num) {
-					DBG_871X_LEVEL(_drv_always_, FUNC_ADPT_FMT" out_num:%u not enough\n",
-						FUNC_ADPT_ARG(padapter), out_num);
+					netdev_dbg(padapter->pnetdev,
+						   FUNC_ADPT_FMT " out_num:%u not enough\n",
+						   FUNC_ADPT_ARG(padapter),
+						   out_num);
 					break;
 				}
 
@@ -5835,8 +5847,10 @@ u8 setkey_hdl(struct adapter *padapter, u8 *pbuf)
 
 		ctrl = BIT(15) | BIT6 | ((pparm->algorithm) << 2) | pparm->keyid;
 		write_cam(padapter, cam_id, ctrl, addr, pparm->key);
-		DBG_871X_LEVEL(_drv_always_, "set group key camid:%d, addr:%pM, kid:%d, type:%s\n"
-			, cam_id, MAC_ARG(addr), pparm->keyid, security_type_str(pparm->algorithm));
+		netdev_dbg(padapter->pnetdev,
+			   "set group key camid:%d, addr:%pM, kid:%d, type:%s\n",
+			   cam_id, MAC_ARG(addr), pparm->keyid,
+			   security_type_str(pparm->algorithm));
 	}
 
 	if (cam_id >= 0 && cam_id <= 3)
@@ -5864,7 +5878,8 @@ u8 set_stakey_hdl(struct adapter *padapter, u8 *pbuf)
 
 	psta = rtw_get_stainfo(pstapriv, pparm->addr);
 	if (!psta) {
-		DBG_871X_LEVEL(_drv_always_, "%s sta:%pM not found\n", __func__, MAC_ARG(pparm->addr));
+		netdev_dbg(padapter->pnetdev, "%s sta:%pM not found\n",
+			   __func__, MAC_ARG(pparm->addr));
 		ret = H2C_REJECTED;
 		goto exit;
 	}
@@ -5877,13 +5892,17 @@ u8 set_stakey_hdl(struct adapter *padapter, u8 *pbuf)
 write_to_cam:
 	if (pparm->algorithm == _NO_PRIVACY_) {
 		while ((cam_id = rtw_camid_search(padapter, pparm->addr, -1)) >= 0) {
-			DBG_871X_LEVEL(_drv_always_, "clear key for addr:%pM, camid:%d\n", MAC_ARG(pparm->addr), cam_id);
+			netdev_dbg(padapter->pnetdev,
+				   "clear key for addr:%pM, camid:%d\n",
+				   MAC_ARG(pparm->addr), cam_id);
 			clear_cam_entry(padapter, cam_id);
 			rtw_camid_free(padapter, cam_id);
 		}
 	} else {
-		DBG_871X_LEVEL(_drv_always_, "set pairwise key camid:%d, addr:%pM, kid:%d, type:%s\n",
-			cam_id, MAC_ARG(pparm->addr), pparm->keyid, security_type_str(pparm->algorithm));
+		netdev_dbg(padapter->pnetdev,
+			   "set pairwise key camid:%d, addr:%pM, kid:%d, type:%s\n",
+			   cam_id, MAC_ARG(pparm->addr), pparm->keyid,
+			   security_type_str(pparm->algorithm));
 		ctrl = BIT(15) | ((pparm->algorithm) << 2) | pparm->keyid;
 		write_cam(padapter, cam_id, ctrl, pparm->addr, pparm->key);
 	}
diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index 364b96fe0a54..251b9abdf591 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -124,9 +124,12 @@ static bool rtw_pwr_unassociated_idle(struct adapter *adapter)
 
 	if (pxmit_priv->free_xmitbuf_cnt != NR_XMITBUFF ||
 		pxmit_priv->free_xmit_extbuf_cnt != NR_XMIT_EXTBUFF) {
-		DBG_871X_LEVEL(_drv_always_, "There are some pkts to transmit\n");
-		DBG_871X_LEVEL(_drv_always_, "free_xmitbuf_cnt: %d, free_xmit_extbuf_cnt: %d\n",
-			pxmit_priv->free_xmitbuf_cnt, pxmit_priv->free_xmit_extbuf_cnt);
+		netdev_dbg(adapter->pnetdev,
+			   "There are some pkts to transmit\n");
+		netdev_dbg(adapter->pnetdev,
+			   "free_xmitbuf_cnt: %d, free_xmit_extbuf_cnt: %d\n",
+			   pxmit_priv->free_xmitbuf_cnt,
+			   pxmit_priv->free_xmit_extbuf_cnt);
 		goto exit;
 	}
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 9587d89a6b24..7823055ed32d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -684,8 +684,11 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 
 					if (jiffies_to_msecs(jiffies - start) > 1000) {
 						if (no_gkey_bc_cnt || no_gkey_mc_cnt) {
-							DBG_871X_LEVEL(_drv_always_, FUNC_ADPT_FMT" no_gkey_bc_cnt:%u, no_gkey_mc_cnt:%u\n",
-								FUNC_ADPT_ARG(padapter), no_gkey_bc_cnt, no_gkey_mc_cnt);
+							netdev_dbg(padapter->pnetdev,
+								   FUNC_ADPT_FMT " no_gkey_bc_cnt:%u, no_gkey_mc_cnt:%u\n",
+								   FUNC_ADPT_ARG(padapter),
+								   no_gkey_bc_cnt,
+								   no_gkey_mc_cnt);
 						}
 						start = jiffies;
 						no_gkey_bc_cnt = 0;
@@ -695,8 +698,11 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 				}
 
 				if (no_gkey_bc_cnt || no_gkey_mc_cnt) {
-					DBG_871X_LEVEL(_drv_always_, FUNC_ADPT_FMT" gkey installed. no_gkey_bc_cnt:%u, no_gkey_mc_cnt:%u\n",
-						FUNC_ADPT_ARG(padapter), no_gkey_bc_cnt, no_gkey_mc_cnt);
+					netdev_dbg(padapter->pnetdev,
+						   FUNC_ADPT_FMT " gkey installed. no_gkey_bc_cnt:%u, no_gkey_mc_cnt:%u\n",
+						   FUNC_ADPT_ARG(padapter),
+						   no_gkey_bc_cnt,
+						   no_gkey_mc_cnt);
 				}
 				start = 0;
 				no_gkey_bc_cnt = 0;
@@ -1631,8 +1637,11 @@ u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
 
 					if (jiffies_to_msecs(jiffies - start) > 1000) {
 						if (no_gkey_bc_cnt || no_gkey_mc_cnt) {
-							DBG_871X_LEVEL(_drv_always_, FUNC_ADPT_FMT" no_gkey_bc_cnt:%u, no_gkey_mc_cnt:%u\n",
-								FUNC_ADPT_ARG(padapter), no_gkey_bc_cnt, no_gkey_mc_cnt);
+							netdev_dbg(padapter->pnetdev,
+								   FUNC_ADPT_FMT " no_gkey_bc_cnt:%u, no_gkey_mc_cnt:%u\n",
+								   FUNC_ADPT_ARG(padapter),
+								   no_gkey_bc_cnt,
+								   no_gkey_mc_cnt);
 						}
 						start = jiffies;
 						no_gkey_bc_cnt = 0;
@@ -1643,8 +1652,11 @@ u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
 				}
 
 				if (no_gkey_bc_cnt || no_gkey_mc_cnt) {
-					DBG_871X_LEVEL(_drv_always_, FUNC_ADPT_FMT" gkey installed. no_gkey_bc_cnt:%u, no_gkey_mc_cnt:%u\n",
-						FUNC_ADPT_ARG(padapter), no_gkey_bc_cnt, no_gkey_mc_cnt);
+					netdev_dbg(padapter->pnetdev,
+						   FUNC_ADPT_FMT " gkey installed. no_gkey_bc_cnt:%u, no_gkey_mc_cnt:%u\n",
+						   FUNC_ADPT_ARG(padapter),
+						   no_gkey_bc_cnt,
+						   no_gkey_mc_cnt);
 				}
 				start = 0;
 				no_gkey_bc_cnt = 0;
@@ -2149,13 +2161,17 @@ u8 rtw_handle_tkip_countermeasure(struct adapter *adapter, const char *caller)
 		unsigned long passing_ms = jiffies_to_msecs(jiffies - securitypriv->btkip_countermeasure_time);
 
 		if (passing_ms > 60*1000) {
-			DBG_871X_LEVEL(_drv_always_, "%s(%s) countermeasure time:%lus > 60s\n",
-				caller, ADPT_ARG(adapter), passing_ms/1000);
+			netdev_dbg(adapter->pnetdev,
+				   "%s(%s) countermeasure time:%lus > 60s\n",
+				   caller, ADPT_ARG(adapter),
+				   passing_ms / 1000);
 			securitypriv->btkip_countermeasure = false;
 			securitypriv->btkip_countermeasure_time = 0;
 		} else {
-			DBG_871X_LEVEL(_drv_always_, "%s(%s) countermeasure time:%lus < 60s\n",
-				caller, ADPT_ARG(adapter), passing_ms/1000);
+			netdev_dbg(adapter->pnetdev,
+				   "%s(%s) countermeasure time:%lus < 60s\n",
+				   caller, ADPT_ARG(adapter),
+				   passing_ms / 1000);
 			status = _FAIL;
 		}
 	}
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index c1b893451788..f9bd7c167da7 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -651,8 +651,9 @@ s16 rtw_camid_alloc(struct adapter *adapter, struct sta_info *sta, u8 kid)
 		&& !sta) {
 		/* AP/Ad-hoc mode group key: static alloction to default key by key ID */
 		if (kid > 3) {
-			DBG_871X_LEVEL(_drv_always_, FUNC_ADPT_FMT" group key with invalid key id:%u\n"
-				, FUNC_ADPT_ARG(adapter), kid);
+			netdev_dbg(adapter->pnetdev,
+				   FUNC_ADPT_FMT " group key with invalid key id:%u\n",
+				   FUNC_ADPT_ARG(adapter), kid);
 			rtw_warn_on(1);
 			goto bitmap_handle;
 		}
@@ -677,8 +678,9 @@ s16 rtw_camid_alloc(struct adapter *adapter, struct sta_info *sta, u8 kid)
 			if (sta || _rtw_camid_is_gk(adapter, i))
 				cam_id = i;
 			else
-				DBG_871X_LEVEL(_drv_always_, FUNC_ADPT_FMT" group key id:%u the same key id as pairwise key\n"
-					, FUNC_ADPT_ARG(adapter), kid);
+				netdev_dbg(adapter->pnetdev,
+					   FUNC_ADPT_FMT " group key id:%u the same key id as pairwise key\n",
+					   FUNC_ADPT_ARG(adapter), kid);
 			goto bitmap_handle;
 		}
 
@@ -688,11 +690,14 @@ s16 rtw_camid_alloc(struct adapter *adapter, struct sta_info *sta, u8 kid)
 
 		if (i == TOTAL_CAM_ENTRY) {
 			if (sta)
-				DBG_871X_LEVEL(_drv_always_, FUNC_ADPT_FMT" pairwise key with %pM id:%u no room\n"
-				, FUNC_ADPT_ARG(adapter), MAC_ARG(sta->hwaddr), kid);
+				netdev_dbg(adapter->pnetdev,
+					   FUNC_ADPT_FMT " pairwise key with %pM id:%u no room\n",
+					   FUNC_ADPT_ARG(adapter),
+					   MAC_ARG(sta->hwaddr), kid);
 			else
-				DBG_871X_LEVEL(_drv_always_, FUNC_ADPT_FMT" group key id:%u no room\n"
-				, FUNC_ADPT_ARG(adapter), kid);
+				netdev_dbg(adapter->pnetdev,
+					   FUNC_ADPT_FMT " group key id:%u no room\n",
+					   FUNC_ADPT_ARG(adapter), kid);
 			rtw_warn_on(1);
 			goto bitmap_handle;
 		}
diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 1ffd2ce68974..ec13d41c3b2c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -676,7 +676,7 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 				pattrib->icmp_pkt = 1;
 		}
 	} else if (0x888e == pattrib->ether_type) {
-		DBG_871X_LEVEL(_drv_always_, "send eapol packet\n");
+		netdev_dbg(padapter->pnetdev, "send eapol packet\n");
 	}
 
 	if ((pattrib->ether_type == 0x888e) || (pattrib->dhcp_pkt == 1))
diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 2e2d40469a83..e82f59fc5e9b 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -1051,12 +1051,9 @@ void SetHwReg(struct adapter *adapter, u8 variable, u8 *val)
 		/* TODO - Is something needed here? */
 		break;
 	default:
-		DBG_871X_LEVEL(
-			_drv_always_,
-			FUNC_ADPT_FMT" variable(%d) not defined!\n",
-			FUNC_ADPT_ARG(adapter),
-			variable
-		);
+		netdev_dbg(adapter->pnetdev,
+			   FUNC_ADPT_FMT " variable(%d) not defined!\n",
+			   FUNC_ADPT_ARG(adapter), variable);
 		break;
 	}
 }
@@ -1077,12 +1074,9 @@ void GetHwReg(struct adapter *adapter, u8 variable, u8 *val)
 		*((u8 *)val) = hal_data->rf_type;
 		break;
 	default:
-		DBG_871X_LEVEL(
-			_drv_always_,
-			FUNC_ADPT_FMT" variable(%d) not defined!\n",
-			FUNC_ADPT_ARG(adapter),
-			variable
-		);
+		netdev_dbg(adapter->pnetdev,
+			   FUNC_ADPT_FMT " variable(%d) not defined!\n",
+			   FUNC_ADPT_ARG(adapter), variable);
 		break;
 	}
 }
@@ -1157,7 +1151,9 @@ u8 SetHalDefVar(
 		hal_data->AntDetection = *((u8 *)value);
 		break;
 	default:
-		DBG_871X_LEVEL(_drv_always_, "%s: [WARNING] HAL_DEF_VARIABLE(%d) not defined!\n", __func__, variable);
+		netdev_dbg(adapter->pnetdev,
+			   "%s: [WARNING] HAL_DEF_VARIABLE(%d) not defined!\n",
+			   __func__, variable);
 		bResult = _FAIL;
 		break;
 	}
@@ -1212,7 +1208,9 @@ u8 GetHalDefVar(
 		*((u32 *)value) = PAGE_SIZE_128;
 		break;
 	default:
-		DBG_871X_LEVEL(_drv_always_, "%s: [WARNING] HAL_DEF_VARIABLE(%d) not defined!\n", __func__, variable);
+		netdev_dbg(adapter->pnetdev,
+			   "%s: [WARNING] HAL_DEF_VARIABLE(%d) not defined!\n",
+			   __func__, variable);
 		bResult = _FAIL;
 		break;
 	}
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 63f7f673aefb..082448557b53 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -360,7 +360,9 @@ s32 rtl8723b_FirmwareDownload(struct adapter *padapter, bool  bUsedWoWLANFw)
 	release_firmware(fw);
 	if (pFirmware->fw_length > FW_8723B_SIZE) {
 		rtStatus = _FAIL;
-		DBG_871X_LEVEL(_drv_emerg_, "Firmware size:%u exceed %u\n", pFirmware->fw_length, FW_8723B_SIZE);
+		netdev_emerg(padapter->pnetdev,
+			     "Firmware size:%u exceed %u\n",
+			     pFirmware->fw_length, FW_8723B_SIZE);
 		goto release_fw1;
 	}
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
index b40d2e1a4fd1..bd95e62fb053 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
@@ -133,7 +133,8 @@ s32 rtl8723bs_xmit_buf_handler(struct adapter *padapter)
 	pxmitpriv = &padapter->xmitpriv;
 
 	if (wait_for_completion_interruptible(&pxmitpriv->xmit_comp)) {
-		DBG_871X_LEVEL(_drv_emerg_, "%s: down SdioXmitBufSema fail!\n", __func__);
+		netdev_emerg(padapter->pnetdev,
+			     "%s: down SdioXmitBufSema fail!\n", __func__);
 		return _FAIL;
 	}
 
@@ -264,7 +265,9 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
 					pxmitbuf = rtw_alloc_xmitbuf(pxmitpriv);
 					if (!pxmitbuf) {
 #ifdef DBG_XMIT_BUF
-						DBG_871X_LEVEL(_drv_err_, "%s: xmit_buf is not enough!\n", __func__);
+						netdev_err(padapter->pnetdev,
+							   "%s: xmit_buf is not enough!\n",
+							   __func__);
 #endif
 						err = -2;
 						complete(&(pxmitpriv->xmit_comp));
@@ -296,7 +299,9 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
 
 				ret = rtw_xmitframe_coalesce(padapter, pxmitframe->pkt, pxmitframe);
 				if (ret == _FAIL) {
-					DBG_871X_LEVEL(_drv_err_, "%s: coalesce FAIL!", __func__);
+					netdev_err(padapter->pnetdev,
+						   "%s: coalesce FAIL!",
+						   __func__);
 					/*  Todo: error handler */
 				} else {
 					k++;
@@ -367,7 +372,8 @@ static s32 rtl8723bs_xmit_handler(struct adapter *padapter)
 	pxmitpriv = &padapter->xmitpriv;
 
 	if (wait_for_completion_interruptible(&pxmitpriv->SdioXmitStart)) {
-		DBG_871X_LEVEL(_drv_emerg_, "%s: SdioXmitStart fail!\n", __func__);
+		netdev_emerg(padapter->pnetdev, "%s: SdioXmitStart fail!\n",
+			     __func__);
 		return _FAIL;
 	}
 
diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index b73c535308fa..a31694525bc1 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -812,7 +812,8 @@ static struct recv_buf *sd_recv_rxfifo(struct adapter *adapter, u32 size)
 	recv_priv = &adapter->recvpriv;
 	recvbuf = rtw_dequeue_recvbuf(&recv_priv->free_recv_buf_queue);
 	if (!recvbuf) {
-		DBG_871X_LEVEL(_drv_err_, "%s: alloc recvbuf FAIL!\n", __func__);
+		netdev_err(adapter->pnetdev, "%s: alloc recvbuf FAIL!\n",
+			   __func__);
 		return NULL;
 	}
 
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 89a21eb63c0a..c1dac6eec59f 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -411,7 +411,9 @@ void rtw_cfg80211_ibss_indicate_connect(struct adapter *padapter)
 		}
 
 		if (!rtw_cfg80211_check_bss(padapter))
-			DBG_871X_LEVEL(_drv_always_, FUNC_ADPT_FMT" BSS not found !!\n", FUNC_ADPT_ARG(padapter));
+			netdev_dbg(padapter->pnetdev,
+				   FUNC_ADPT_FMT " BSS not found !!\n",
+				   FUNC_ADPT_ARG(padapter));
 	}
 	/* notify cfg80211 that device joined an IBSS */
 	chan = ieee80211_get_channel(wiphy, freq);
@@ -452,7 +454,9 @@ void rtw_cfg80211_indicate_connect(struct adapter *padapter)
 
 check_bss:
 	if (!rtw_cfg80211_check_bss(padapter))
-		DBG_871X_LEVEL(_drv_always_, FUNC_ADPT_FMT" BSS not found !!\n", FUNC_ADPT_ARG(padapter));
+		netdev_dbg(padapter->pnetdev,
+			   FUNC_ADPT_FMT " BSS not found !!\n",
+			   FUNC_ADPT_ARG(padapter));
 
 	if (rtw_to_roam(padapter) > 0) {
 		struct wiphy *wiphy = pwdev->wiphy;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 816033b6847c..e98e5388d5c7 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -58,7 +58,7 @@ void rtw_indicate_wx_assoc_event(struct adapter *padapter)
 	else
 		memcpy(wrqu.ap_addr.sa_data, pmlmepriv->cur_network.network.MacAddress, ETH_ALEN);
 
-	DBG_871X_LEVEL(_drv_always_, "assoc success\n");
+	netdev_dbg(padapter->pnetdev, "assoc success\n");
 }
 
 void rtw_indicate_wx_disassoc_event(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 1f34cb2e367c..2c04a9e37bc5 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -412,7 +412,8 @@ static int rtw_ndev_notifier_call(struct notifier_block *nb, unsigned long state
 	if (dev->netdev_ops->ndo_do_ioctl != rtw_ioctl)
 		return NOTIFY_DONE;
 
-	DBG_871X_LEVEL(_drv_info_, FUNC_NDEV_FMT " state:%lu\n", FUNC_NDEV_ARG(dev), state);
+	netdev_info(dev, FUNC_NDEV_FMT " state:%lu\n", FUNC_NDEV_ARG(dev),
+		    state);
 
 	return NOTIFY_DONE;
 }
@@ -436,7 +437,7 @@ static int rtw_ndev_init(struct net_device *dev)
 {
 	struct adapter *adapter = rtw_netdev_priv(dev);
 
-	DBG_871X_LEVEL(_drv_always_, FUNC_ADPT_FMT "\n", FUNC_ADPT_ARG(adapter));
+	netdev_dbg(dev, FUNC_ADPT_FMT "\n", FUNC_ADPT_ARG(adapter));
 	strncpy(adapter->old_ifname, dev->name, IFNAMSIZ);
 
 	return 0;
@@ -446,7 +447,7 @@ static void rtw_ndev_uninit(struct net_device *dev)
 {
 	struct adapter *adapter = rtw_netdev_priv(dev);
 
-	DBG_871X_LEVEL(_drv_always_, FUNC_ADPT_FMT "\n", FUNC_ADPT_ARG(adapter));
+	netdev_dbg(dev, FUNC_ADPT_FMT "\n", FUNC_ADPT_ARG(adapter));
 }
 
 static const struct net_device_ops rtw_netdev_ops = {
@@ -1068,11 +1069,13 @@ void rtw_dev_unload(struct adapter *padapter)
 		/* check the status of IPS */
 		if (rtw_hal_check_ips_status(padapter) || pwrctl->rf_pwrstate == rf_off) {
 			/* check HW status and SW state */
-			DBG_871X_LEVEL(_drv_always_, "%s: driver in IPS-FWLPS\n", __func__);
+			netdev_dbg(padapter->pnetdev,
+				   "%s: driver in IPS-FWLPS\n", __func__);
 			pdbgpriv->dbg_dev_unload_inIPS_cnt++;
 			LeaveAllPowerSaveMode(padapter);
 		} else {
-			DBG_871X_LEVEL(_drv_always_, "%s: driver not in IPS\n", __func__);
+			netdev_dbg(padapter->pnetdev,
+				   "%s: driver not in IPS\n", __func__);
 		}
 
 		if (!padapter->bSurpriseRemoved) {
@@ -1118,7 +1121,8 @@ static int rtw_suspend_free_assoc_resource(struct adapter *padapter)
 		rtw_indicate_scan_done(padapter, 1);
 
 	if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) {
-		DBG_871X_LEVEL(_drv_always_, "%s: fw_under_linking\n", __func__);
+		netdev_dbg(padapter->pnetdev, "%s: fw_under_linking\n",
+			   __func__);
 		rtw_indicate_disconnect(padapter);
 	}
 
@@ -1137,7 +1141,9 @@ static void rtw_suspend_normal(struct adapter *padapter)
 	rtw_suspend_free_assoc_resource(padapter);
 
 	if ((rtw_hal_check_ips_status(padapter)) || (adapter_to_pwrctl(padapter)->rf_pwrstate == rf_off))
-		DBG_871X_LEVEL(_drv_always_, "%s: ### ERROR #### driver in IPS ####ERROR###!!!\n", __func__);
+		netdev_dbg(padapter->pnetdev,
+		           "%s: ### ERROR #### driver in IPS ####ERROR###!!!\n",
+		           __func__);
 
 	rtw_dev_unload(padapter);
 
@@ -1156,7 +1162,7 @@ int rtw_suspend_common(struct adapter *padapter)
 	int ret = 0;
 	unsigned long start_time = jiffies;
 
-	DBG_871X_LEVEL(_drv_always_, " suspend start\n");
+	netdev_dbg(padapter->pnetdev, " suspend start\n");
 	pdbgpriv->dbg_suspend_cnt++;
 
 	pwrpriv->bInSuspend = true;
@@ -1191,8 +1197,8 @@ int rtw_suspend_common(struct adapter *padapter)
 	else
 		rtw_suspend_normal(padapter);
 
-	DBG_871X_LEVEL(_drv_always_, "rtw suspend success in %d ms\n",
-		jiffies_to_msecs(jiffies - start_time));
+	netdev_dbg(padapter->pnetdev, "rtw suspend success in %d ms\n",
+		   jiffies_to_msecs(jiffies - start_time));
 
 exit:
 
@@ -1265,7 +1271,7 @@ int rtw_resume_common(struct adapter *padapter)
 	struct pwrctrl_priv *pwrpriv = adapter_to_pwrctl(padapter);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	DBG_871X_LEVEL(_drv_always_, "resume start\n");
+	netdev_dbg(padapter->pnetdev, "resume start\n");
 
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 		rtw_resume_process_normal(padapter);
@@ -1280,8 +1286,8 @@ int rtw_resume_common(struct adapter *padapter)
 	if (pwrpriv) {
 		pwrpriv->bInSuspend = false;
 	}
-	DBG_871X_LEVEL(_drv_always_, "%s:%d in %d ms\n", __func__, ret,
-		jiffies_to_msecs(jiffies - start_time));
+	netdev_dbg(padapter->pnetdev, "%s:%d in %d ms\n", __func__, ret,
+		   jiffies_to_msecs(jiffies - start_time));
 
 	return ret;
 }
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 325af78e6291..c767651e2134 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -101,7 +101,9 @@ static void sdio_free_irq(struct dvobj_priv *dvobj)
 			err = sdio_release_irq(func);
 			if (err) {
 				dvobj->drv_dbg.dbg_sdio_free_irq_error_cnt++;
-				DBG_871X_LEVEL(_drv_err_, "%s: sdio_release_irq FAIL(%d)!\n", __func__, err);
+				netdev_err(dvobj->if1->pnetdev,
+					   "%s: sdio_release_irq FAIL(%d)!\n",
+					   __func__, err);
 			} else
 				dvobj->drv_dbg.dbg_sdio_free_irq_cnt++;
 			sdio_release_host(func);
@@ -485,9 +487,7 @@ static int __init rtw_drv_entry(void)
 {
 	int ret;
 
-	DBG_871X_LEVEL(_drv_always_, "module init start\n");
 #ifdef BTCOEXVERSION
-	DBG_871X_LEVEL(_drv_always_, "rtl8723bs BT-Coex version = %s\n", BTCOEXVERSION);
 #endif /*  BTCOEXVERSION */
 
 
@@ -495,19 +495,14 @@ static int __init rtw_drv_entry(void)
 	if (ret != 0)
 		rtw_ndev_notifier_unregister();
 
-	DBG_871X_LEVEL(_drv_always_, "module init ret =%d\n", ret);
 	return ret;
 }
 
 static void __exit rtw_drv_halt(void)
 {
-	DBG_871X_LEVEL(_drv_always_, "module exit start\n");
-
 	sdio_unregister_driver(&rtl8723bs_sdio_driver);
 
 	rtw_ndev_notifier_unregister();
-
-	DBG_871X_LEVEL(_drv_always_, "module exit success\n");
 }
 
 
-- 
2.20.1

