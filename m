Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389903DDC1E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbhHBPQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbhHBPQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:16:09 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104C8C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 08:16:00 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id c2-20020a0568303482b029048bcf4c6bd9so17776467otu.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 08:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gPcu9l7c7p3dsKueGHesoWzLlqrbCOPe+sPYLENSZeQ=;
        b=b3RBC0nKnIlxGMPAHna0MNBu+OgAgBWG0tyCCd4z8X6uaiC/RfGqA29xGz2xpuahvI
         k74Z2BLeY4aXDpnpcn2N02OYcvUxeq9qwsYPqEHNze1jMvps+1sDdZWs6krxKOCLG82U
         MWFUOXOB7ZOi81FeAQdBhxAavhOmcCRfU+/C5PwvDH0LtRYXt3SNOZN6LDdwLBocUBCc
         Pqw8cHli/f2qwCZwmnZb9HfxP+jWuSO+wunKVR7EHYELUXu5CxkgaVDmwdPjvnJDg7T+
         YPSEUeAzPFJTBNRnjKoJZAnz09FHnHo603W1xe8fhx96ivjgf6jn4PFXDo9fhixQINs9
         yDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=gPcu9l7c7p3dsKueGHesoWzLlqrbCOPe+sPYLENSZeQ=;
        b=FB29R1UoJxk16Cpi3iGfpdg4ebPBMfucw5hPwwxfCyMwcRdoEx1zxAmuFe5NtkSI78
         haRGnRAxKdLjQBU8zU0hDxHsSSbpTJ6GhAl0xBVzWaYvkCLwUalmvEXGuiDU8MYVYD/k
         nk43oNV/4T0YilW+VE3k4CMJvUduTcV8aBR6srnjj+Ubtglgvep9Oh3/+aNf2eH8QtaS
         C59FRg7Qk1wWIjr6Pr3EMXUQJSe8UNiedWZNDzrhfGTvt3k/jT67t3myvbC4scfJBr5J
         +c6Dq/tfYXgtKU7GqCgYYhwsXfGRjrYGpK3QPRojAN01rUkmP8o8WQlumqbZapvTA3D0
         8ofg==
X-Gm-Message-State: AOAM533Uz+fjHgu3zWhaestEX3+RZ457h3B7NQi87/zgQ9LN83Kz8dDd
        8kWrTTNfwxygjE2eRgTBuHs=
X-Google-Smtp-Source: ABdhPJzGZCARkb4WZS8yLM5L2dAbCDEBhGyqo+do2BbbyyAZ7+AhsIl4aySIIODMDlukiyqINnCCuA==
X-Received: by 2002:a9d:7548:: with SMTP id b8mr12190533otl.135.1627917359204;
        Mon, 02 Aug 2021 08:15:59 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id w16sm1807034oiv.15.2021.08.02.08.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 08:15:58 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 1/6] staging: r8188eu: Remove wrappers for kalloc() and kzalloc()
Date:   Mon,  2 Aug 2021 10:15:41 -0500
Message-Id: <20210802151546.31797-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802151546.31797-1-Larry.Finger@lwfinger.net>
References: <20210802151546.31797-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These wrappers involve an in_interrupt() call, which is not frowned on
in the kernel. These changes decrease the size of the driver by a trivial
amount.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/staging/r8188eu/core/rtw_ap.c         |   8 +-
 drivers/staging/r8188eu/core/rtw_br_ext.c     |   2 +-
 drivers/staging/r8188eu/core/rtw_br_ext.c.rej |  11 ++
 drivers/staging/r8188eu/core/rtw_cmd.c        |  11 +-
 drivers/staging/r8188eu/core/rtw_efuse.c      |   4 +-
 drivers/staging/r8188eu/core/rtw_efuse.c.rej  |  20 ++++
 drivers/staging/r8188eu/core/rtw_mlme.c       |   8 +-
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  30 ++---
 .../staging/r8188eu/core/rtw_mlme_ext.c.rej   | 107 ++++++++++++++++++
 drivers/staging/r8188eu/core/rtw_mp.c         |   2 +-
 drivers/staging/r8188eu/core/rtw_p2p.c        |   8 +-
 drivers/staging/r8188eu/core/rtw_p2p.c.rej    |  18 +++
 drivers/staging/r8188eu/core/rtw_wlan_util.c  |   2 +-
 drivers/staging/r8188eu/core/rtw_xmit.c       |   2 +-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |   2 +-
 .../staging/r8188eu/hal/rtl8188e_cmd.c.rej    |  11 ++
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |   8 +-
 .../r8188eu/hal/rtl8188e_hal_init.c.rej       |  34 ++++++
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c  |   3 +-
 .../staging/r8188eu/hal/rtl8188eu_recv.c.rej  |  12 ++
 drivers/staging/r8188eu/hal/usb_halinit.c     |   2 +-
 drivers/staging/r8188eu/hal/usb_halinit.c.rej |  11 ++
 .../staging/r8188eu/include/odm_precomp.h.rej |  19 ++++
 .../staging/r8188eu/include/osdep_service.h   |   6 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  66 +++++------
 drivers/staging/r8188eu/os_dep/mlme_linux.c   |   3 +-
 .../staging/r8188eu/os_dep/osdep_service.c    |  28 +----
 drivers/staging/r8188eu/os_dep/usb_intf.c     |   4 +-
 drivers/staging/r8188eu/os_dep/xmit_linux.c   |   2 +-
 .../staging/r8188eu/os_dep/xmit_linux.c.rej   |  11 ++
 30 files changed, 340 insertions(+), 115 deletions(-)
 create mode 100644 drivers/staging/r8188eu/core/rtw_br_ext.c.rej
 create mode 100644 drivers/staging/r8188eu/core/rtw_efuse.c.rej
 create mode 100644 drivers/staging/r8188eu/core/rtw_mlme_ext.c.rej
 create mode 100644 drivers/staging/r8188eu/core/rtw_p2p.c.rej
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_cmd.c.rej
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c.rej
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188eu_recv.c.rej
 create mode 100644 drivers/staging/r8188eu/hal/usb_halinit.c.rej
 create mode 100644 drivers/staging/r8188eu/include/odm_precomp.h.rej
 create mode 100644 drivers/staging/r8188eu/os_dep/xmit_linux.c.rej

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 0bb545135206..3a23e4675fab 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -98,7 +98,7 @@ static void update_BCNTIM(struct adapter *padapter)
 		}
 
 		if (remainder_ielen > 0) {
-			pbackup_remainder_ie = rtw_malloc(remainder_ielen);
+			pbackup_remainder_ie = kmalloc(remainder_ielen, GFP_KERNEL);
 			if (pbackup_remainder_ie && premainder_ie)
 				memcpy(pbackup_remainder_ie, premainder_ie, remainder_ielen);
 		}
@@ -180,7 +180,7 @@ void rtw_add_bcn_ie(struct adapter *padapter, struct wlan_bssid_ex *pnetwork, u8
 	}
 
 	if (remainder_ielen > 0) {
-		pbackup_remainder_ie = rtw_malloc(remainder_ielen);
+		pbackup_remainder_ie = kmalloc(remainder_ielen, GFP_KERNEL);
 		if (pbackup_remainder_ie && premainder_ie)
 			memcpy(pbackup_remainder_ie, premainder_ie, remainder_ielen);
 	}
@@ -224,7 +224,7 @@ void rtw_remove_bcn_ie(struct adapter *padapter, struct wlan_bssid_ex *pnetwork,
 	}
 
 	if (remainder_ielen > 0) {
-		pbackup_remainder_ie = rtw_malloc(remainder_ielen);
+		pbackup_remainder_ie = kmalloc(remainder_ielen, GFP_KERNEL);
 		if (pbackup_remainder_ie && premainder_ie)
 			memcpy(pbackup_remainder_ie, premainder_ie, remainder_ielen);
 	}
@@ -1302,7 +1302,7 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 	remainder_ielen = ielen - wps_offset - wps_ielen;
 
 	if (remainder_ielen > 0) {
-		pbackup_remainder_ie = rtw_malloc(remainder_ielen);
+		pbackup_remainder_ie = kmalloc(remainder_ielen, GFP_KERNEL);
 		if (pbackup_remainder_ie)
 			memcpy(pbackup_remainder_ie, premainder_ie, remainder_ielen);
 	}
diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 8f434768dd15..c62e40d1d3ef 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -420,7 +420,7 @@ static void __nat25_db_network_insert(struct adapter *priv,
 		}
 		db = db->next_hash;
 	}
-	db = (struct nat25_network_db_entry *) rtw_malloc(sizeof(*db));
+	db = kmalloc(sizeof(*db), GFP_KERNEL);
 	if (db == NULL) {
 		spin_unlock_bh(&priv->br_ext_lock);
 		return;
diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c.rej b/drivers/staging/r8188eu/core/rtw_br_ext.c.rej
new file mode 100644
index 000000000000..18113389acce
--- /dev/null
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c.rej
@@ -0,0 +1,11 @@
+--- drivers/staging/r8188eu/core/rtw_br_ext.c
++++ drivers/staging/r8188eu/core/rtw_br_ext.c
+@@ -420,7 +420,7 @@ static void __nat25_db_network_insert(st
+ 		}
+ 		db = db->next_hash;
+ 	}
+-	db = (struct nat25_network_db_entry *) rtw_malloc(sizeof(*db));
++	db = kmalloc(sizeof(*db), GFP_KERNEL);
+ 	if (db == NULL) {
+ 		spin_unlock_bh(&priv->br_ext_lock);
+ 		return;
diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 4e17972ee66e..55971c47c90a 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1947,10 +1947,13 @@ static void c2h_wk_callback(struct work_struct *work)
 		if ((c2h_evt = (struct c2h_evt_hdr *)rtw_cbuf_pop(evtpriv->c2h_queue)) != NULL) {
 			/* This C2H event is read, clear it */
 			c2h_evt_clear(adapter);
-		} else if ((c2h_evt = (struct c2h_evt_hdr *)rtw_malloc(16)) != NULL) {
-			/* This C2H event is not read, read & clear now */
-			if (c2h_evt_read(adapter, (u8 *)c2h_evt) != _SUCCESS)
-				continue;
+		} else {
+			c2h_evt = kmalloc(16, GFP_KERNEL);
+			if (c2h_evt) {
+				/* This C2H event is not read, read & clear now */
+				if (c2h_evt_read(adapter, (u8 *)c2h_evt) != _SUCCESS)
+					continue;
+			}
 		}
 
 		/* Special pointer to trigger c2h_evt_clear only */
diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index e84540a7d2c5..e49613726c04 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -533,7 +533,7 @@ u8 rtw_efuse_map_write(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 	if ((addr + cnts) > mapLen)
 		return _FAIL;
 
-	map = rtw_zmalloc(mapLen);
+	map = kzalloc(mapLen, GFP_KERNEL);
 	if (map == NULL)
 		return _FAIL;
 
@@ -625,7 +625,7 @@ u8 rtw_BT_efuse_map_write(struct adapter *padapter, u16 addr, u16 cnts, u8 *data
 	if ((addr + cnts) > mapLen)
 		return _FAIL;
 
-	map = rtw_zmalloc(mapLen);
+	map = kzalloc(mapLen, GFP_KERNEL);
 	if (map == NULL)
 		return _FAIL;
 
diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c.rej b/drivers/staging/r8188eu/core/rtw_efuse.c.rej
new file mode 100644
index 000000000000..c549e8392561
--- /dev/null
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c.rej
@@ -0,0 +1,20 @@
+--- drivers/staging/r8188eu/core/rtw_efuse.c
++++ drivers/staging/r8188eu/core/rtw_efuse.c
+@@ -533,7 +533,7 @@ u8 rtw_efuse_map_write(struct adapter *p
+ 	if ((addr + cnts) > mapLen)
+ 		return _FAIL;
+ 
+-	map = rtw_zmalloc(mapLen);
++	map = kzalloc(mapLen, GFP_KERNEL);
+ 	if (map == NULL)
+ 		return _FAIL;
+ 
+@@ -625,7 +625,7 @@ u8 rtw_BT_efuse_map_write(struct adapter
+ 	if ((addr + cnts) > mapLen)
+ 		return _FAIL;
+ 
+-	map = rtw_zmalloc(mapLen);
++	map = kzalloc(mapLen, GFP_KERNEL);
+ 	if (map == NULL)
+ 		return _FAIL;
+ 
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index d692f1477cc8..d8716a8b224a 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1750,13 +1750,13 @@ int rtw_set_auth(struct adapter *adapter, struct security_priv *psecuritypriv)
 	struct	cmd_priv *pcmdpriv = &(adapter->cmdpriv);
 	int		res = _SUCCESS;
 
-	pcmd = (struct	cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
+	pcmd = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
 	if (pcmd == NULL) {
 		res = _FAIL;  /* try again */
 		goto exit;
 	}
 
-	psetauthparm = (struct setauth_parm *)rtw_zmalloc(sizeof(struct setauth_parm));
+	psetauthparm = kzalloc(sizeof(struct setauth_parm), GFP_KERNEL);
 	if (psetauthparm == NULL) {
 		kfree(pcmd);
 		res = _FAIL;
@@ -1788,12 +1788,12 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 	struct mlme_priv		*pmlmepriv = &(adapter->mlmepriv);
 	int	res = _SUCCESS;
 
-	pcmd = (struct	cmd_obj *)rtw_zmalloc(sizeof(struct	cmd_obj));
+	pcmd = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
 	if (pcmd == NULL) {
 		res = _FAIL;  /* try again */
 		goto exit;
 	}
-	psetkeyparm = (struct setkey_parm *)rtw_zmalloc(sizeof(struct setkey_parm));
+	psetkeyparm = kzalloc(sizeof(struct setkey_parm), GFP_KERNEL);
 	if (psetkeyparm == NULL) {
 		kfree(pcmd);
 		res = _FAIL;
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 1160b7caffdd..045179b4a1d6 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -662,7 +662,7 @@ unsigned int OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 	if (!memcmp(GetAddr3Ptr(pframe), get_my_bssid(&pmlmeinfo->network), ETH_ALEN)) {
 		if (pmlmeinfo->state & WIFI_FW_AUTH_NULL) {
 			/* we should update current network before auth, or some IE is wrong */
-			pbss = (struct wlan_bssid_ex *)rtw_malloc(sizeof(struct wlan_bssid_ex));
+			pbss = kmalloc(sizeof(struct wlan_bssid_ex), GFP_ATOMIC);
 			if (pbss) {
 				if (collect_bss_info(padapter, precv_frame, pbss) == _SUCCESS) {
 					update_network(&(pmlmepriv->cur_network.network), pbss, padapter, true);
@@ -6990,12 +6990,12 @@ void report_survey_event(struct adapter *padapter, struct recv_frame *precv_fram
 	pmlmeext = &padapter->mlmeextpriv;
 	pcmdpriv = &padapter->cmdpriv;
 
-	pcmd_obj = (struct cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
+	pcmd_obj = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
 	if (pcmd_obj == NULL)
 		return;
 
 	cmdsz = (sizeof(struct survey_event) + sizeof(struct C2HEvent_Header));
-	pevtcmd = (u8 *)rtw_zmalloc(cmdsz);
+	pevtcmd = kzalloc(cmdsz, GFP_ATOMIC);
 	if (pevtcmd == NULL) {
 		kfree(pcmd_obj);
 		return;
@@ -7042,12 +7042,12 @@ void report_surveydone_event(struct adapter *padapter)
 	struct mlme_ext_priv		*pmlmeext = &padapter->mlmeextpriv;
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
-	pcmd_obj = (struct cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
+	pcmd_obj = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
 	if (pcmd_obj == NULL)
 		return;
 
 	cmdsz = (sizeof(struct surveydone_event) + sizeof(struct C2HEvent_Header));
-	pevtcmd = (u8 *)rtw_zmalloc(cmdsz);
+	pevtcmd = kzalloc(cmdsz, GFP_KERNEL);
 	if (pevtcmd == NULL) {
 		kfree(pcmd_obj);
 		return;
@@ -7088,12 +7088,12 @@ void report_join_res(struct adapter *padapter, int res)
 	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
-	pcmd_obj = (struct cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
+	pcmd_obj = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
 	if (pcmd_obj == NULL)
 		return;
 
 	cmdsz = (sizeof(struct joinbss_event) + sizeof(struct C2HEvent_Header));
-	pevtcmd = (u8 *)rtw_zmalloc(cmdsz);
+	pevtcmd = kzalloc(cmdsz, GFP_ATOMIC);
 	if (pevtcmd == NULL) {
 		kfree(pcmd_obj);
 		return;
@@ -7139,12 +7139,12 @@ void report_del_sta_event(struct adapter *padapter, unsigned char *MacAddr, unsi
 	struct mlme_ext_priv		*pmlmeext = &padapter->mlmeextpriv;
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
-	pcmd_obj = (struct cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
+	pcmd_obj = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
 	if (pcmd_obj == NULL)
 		return;
 
 	cmdsz = (sizeof(struct stadel_event) + sizeof(struct C2HEvent_Header));
-	pevtcmd = (u8 *)rtw_zmalloc(cmdsz);
+	pevtcmd = kzalloc(cmdsz, GFP_KERNEL);
 	if (pevtcmd == NULL) {
 		kfree(pcmd_obj);
 		return;
@@ -7193,12 +7193,12 @@ void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr, int
 	struct mlme_ext_priv		*pmlmeext = &padapter->mlmeextpriv;
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
-	pcmd_obj = (struct cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
+	pcmd_obj = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
 	if (pcmd_obj == NULL)
 		return;
 
 	cmdsz = (sizeof(struct stassoc_event) + sizeof(struct C2HEvent_Header));
-	pevtcmd = (u8 *)rtw_zmalloc(cmdsz);
+	pevtcmd = kzalloc(cmdsz, GFP_KERNEL);
 	if (pevtcmd == NULL) {
 		kfree(pcmd_obj);
 		return;
@@ -7616,11 +7616,11 @@ void survey_timer_hdl(struct adapter *padapter)
 			pmlmeext->scan_abort = false;/* reset */
 		}
 
-		ph2c = (struct cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
+		ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
 		if (ph2c == NULL)
 			goto exit_survey_timer_hdl;
 
-		psurveyPara = (struct sitesurvey_parm *)rtw_zmalloc(sizeof(struct sitesurvey_parm));
+		psurveyPara = kzalloc(sizeof(struct sitesurvey_parm), GFP_ATOMIC);
 		if (psurveyPara == NULL) {
 			kfree(ph2c);
 			goto exit_survey_timer_hdl;
@@ -8193,13 +8193,13 @@ u8 set_tx_beacon_cmd(struct adapter *padapter)
 	u8 res = _SUCCESS;
 	int len_diff = 0;
 
-	ph2c = (struct cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
+	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
 	if (ph2c == NULL) {
 		res = _FAIL;
 		goto exit;
 	}
 
-	ptxBeacon_parm = (struct Tx_Beacon_param *)rtw_zmalloc(sizeof(struct Tx_Beacon_param));
+	ptxBeacon_parm = kzalloc(sizeof(struct Tx_Beacon_param), GFP_KERNEL);
 	if (ptxBeacon_parm == NULL) {
 		kfree(ph2c);
 		res = _FAIL;
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c.rej b/drivers/staging/r8188eu/core/rtw_mlme_ext.c.rej
new file mode 100644
index 000000000000..b91a178bdae2
--- /dev/null
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c.rej
@@ -0,0 +1,107 @@
+--- drivers/staging/r8188eu/core/rtw_mlme_ext.c
++++ drivers/staging/r8188eu/core/rtw_mlme_ext.c
+@@ -6990,12 +6990,12 @@ void report_survey_event(struct adapter
+ 	pmlmeext = &padapter->mlmeextpriv;
+ 	pcmdpriv = &padapter->cmdpriv;
+ 
+-	pcmd_obj = (struct cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
++	pcmd_obj = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
+ 	if (pcmd_obj == NULL)
+ 		return;
+ 
+ 	cmdsz = (sizeof(struct survey_event) + sizeof(struct C2HEvent_Header));
+-	pevtcmd = (u8 *)rtw_zmalloc(cmdsz);
++	pevtcmd = kzalloc(cmdsz, GFP_ATOMIC);
+ 	if (pevtcmd == NULL) {
+ 		kfree(pcmd_obj);
+ 		return;
+@@ -7042,12 +7042,12 @@ void report_surveydone_event(struct adap
+ 	struct mlme_ext_priv		*pmlmeext = &padapter->mlmeextpriv;
+ 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
+ 
+-	pcmd_obj = (struct cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
++	pcmd_obj = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
+ 	if (pcmd_obj == NULL)
+ 		return;
+ 
+ 	cmdsz = (sizeof(struct surveydone_event) + sizeof(struct C2HEvent_Header));
+-	pevtcmd = (u8 *)rtw_zmalloc(cmdsz);
++	pevtcmd = kzalloc(cmdsz, GFP_KERNEL);
+ 	if (pevtcmd == NULL) {
+ 		kfree(pcmd_obj);
+ 		return;
+@@ -7088,12 +7088,12 @@ void report_join_res(struct adapter *pad
+ 	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+ 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
+ 
+-	pcmd_obj = (struct cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
++	pcmd_obj = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
+ 	if (pcmd_obj == NULL)
+ 		return;
+ 
+ 	cmdsz = (sizeof(struct joinbss_event) + sizeof(struct C2HEvent_Header));
+-	pevtcmd = (u8 *)rtw_zmalloc(cmdsz);
++	pevtcmd = kzalloc(cmdsz, GFP_ATOMIC);
+ 	if (pevtcmd == NULL) {
+ 		kfree(pcmd_obj);
+ 		return;
+@@ -7139,12 +7139,12 @@ void report_del_sta_event(struct adapter
+ 	struct mlme_ext_priv		*pmlmeext = &padapter->mlmeextpriv;
+ 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
+ 
+-	pcmd_obj = (struct cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
++	pcmd_obj = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
+ 	if (pcmd_obj == NULL)
+ 		return;
+ 
+ 	cmdsz = (sizeof(struct stadel_event) + sizeof(struct C2HEvent_Header));
+-	pevtcmd = (u8 *)rtw_zmalloc(cmdsz);
++	pevtcmd = kzalloc(cmdsz, GFP_KERNEL);
+ 	if (pevtcmd == NULL) {
+ 		kfree(pcmd_obj);
+ 		return;
+@@ -7193,12 +7193,12 @@ void report_add_sta_event(struct adapter
+ 	struct mlme_ext_priv		*pmlmeext = &padapter->mlmeextpriv;
+ 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
+ 
+-	pcmd_obj = (struct cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
++	pcmd_obj = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
+ 	if (pcmd_obj == NULL)
+ 		return;
+ 
+ 	cmdsz = (sizeof(struct stassoc_event) + sizeof(struct C2HEvent_Header));
+-	pevtcmd = (u8 *)rtw_zmalloc(cmdsz);
++	pevtcmd = kzalloc(cmdsz, GFP_KERNEL);
+ 	if (pevtcmd == NULL) {
+ 		kfree(pcmd_obj);
+ 		return;
+@@ -7616,11 +7616,11 @@ void survey_timer_hdl(struct adapter *pa
+ 			pmlmeext->scan_abort = false;/* reset */
+ 		}
+ 
+-		ph2c = (struct cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
++		ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
+ 		if (ph2c == NULL)
+ 			goto exit_survey_timer_hdl;
+ 
+-		psurveyPara = (struct sitesurvey_parm *)rtw_zmalloc(sizeof(struct sitesurvey_parm));
++		psurveyPara = kzalloc(sizeof(struct sitesurvey_parm), GFP_ATOMIC);
+ 		if (psurveyPara == NULL) {
+ 			kfree(ph2c);
+ 			goto exit_survey_timer_hdl;
+@@ -8193,13 +8193,13 @@ u8 set_tx_beacon_cmd(struct adapter *pad
+ 	u8 res = _SUCCESS;
+ 	int len_diff = 0;
+ 
+-	ph2c = (struct cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
++	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
+ 	if (ph2c == NULL) {
+ 		res = _FAIL;
+ 		goto exit;
+ 	}
+ 
+-	ptxBeacon_parm = (struct Tx_Beacon_param *)rtw_zmalloc(sizeof(struct Tx_Beacon_param));
++	ptxBeacon_parm = kzalloc(sizeof(struct Tx_Beacon_param), GFP_KERNEL);
+ 	if (ptxBeacon_parm == NULL) {
+ 		kfree(ph2c);
+ 		res = _FAIL;
diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index 1b4e9bbc394b..a12c6e0ad002 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -669,7 +669,7 @@ void SetPacketTx(struct adapter *padapter)
 	kfree(pmp_priv->tx.pallocated_buf);
 	pmp_priv->tx.write_size = pkt_size;
 	pmp_priv->tx.buf_size = pkt_size + XMITBUF_ALIGN_SZ;
-	pmp_priv->tx.pallocated_buf = rtw_zmalloc(pmp_priv->tx.buf_size);
+	pmp_priv->tx.pallocated_buf = kzalloc(pmp_priv->tx.buf_size, GFP_KERNEL);
 	if (pmp_priv->tx.pallocated_buf == NULL) {
 		DBG_88E("%s: malloc(%d) fail!!\n", __func__, pmp_priv->tx.buf_size);
 		return;
diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index 30823bfdd1b5..3e550bc126db 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -34,7 +34,7 @@ static u32 go_add_group_info_attr(struct wifidirect_info *pwdinfo, u8 *pbuf)
 
 	DBG_88E("%s\n", __func__);
 
-	pdata_attr = rtw_zmalloc(MAX_P2P_IE_LEN);
+	pdata_attr = kzalloc(MAX_P2P_IE_LEN, GFP_KERNEL);
 
 	pstart = pdata_attr;
 	pcur = pdata_attr;
@@ -857,7 +857,7 @@ u32 process_assoc_req_p2p_ie(struct wifidirect_info *pwdinfo, u8 *pframe, uint l
 		/* Check P2P Device Info ATTR */
 		if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_DEVICE_INFO, NULL, (uint *)&attr_contentlen)) {
 			DBG_88E("[%s] Got P2P DEVICE INFO Attr!!\n", __func__);
-			pattr_content = rtw_zmalloc(attr_contentlen);
+			pattr_content = kzalloc(attr_contentlen, GFP_KERNEL);
 			pbuf = pattr_content;
 			if (pattr_content) {
 				u8 num_of_secdev_type;
@@ -1699,13 +1699,13 @@ u8 p2p_ps_wk_cmd(struct adapter *padapter, u8 p2p_ps_state, u8 enqueue)
 		return res;
 
 	if (enqueue) {
-		ph2c = (struct cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
+		ph2c = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
 		if (ph2c == NULL) {
 			res = _FAIL;
 			goto exit;
 		}
 
-		pdrvextra_cmd_parm = (struct drvextra_cmd_parm *)rtw_zmalloc(sizeof(struct drvextra_cmd_parm));
+		pdrvextra_cmd_parm = kzalloc(sizeof(struct drvextra_cmd_parm), GFP_KERNEL);
 		if (pdrvextra_cmd_parm == NULL) {
 			kfree(ph2c);
 			res = _FAIL;
diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c.rej b/drivers/staging/r8188eu/core/rtw_p2p.c.rej
new file mode 100644
index 000000000000..e94a68cb68ac
--- /dev/null
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c.rej
@@ -0,0 +1,18 @@
+--- drivers/staging/r8188eu/core/rtw_p2p.c
++++ drivers/staging/r8188eu/core/rtw_p2p.c
+@@ -1699,13 +1699,13 @@ u8 p2p_ps_wk_cmd(struct adapter *padapte
+ 		return res;
+ 
+ 	if (enqueue) {
+-		ph2c = (struct cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
++		ph2c = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
+ 		if (ph2c == NULL) {
+ 			res = _FAIL;
+ 			goto exit;
+ 		}
+ 
+-		pdrvextra_cmd_parm = (struct drvextra_cmd_parm *)rtw_zmalloc(sizeof(struct drvextra_cmd_parm));
++		pdrvextra_cmd_parm = kzalloc(sizeof(struct drvextra_cmd_parm), GFP_KERNEL);
+ 		if (pdrvextra_cmd_parm == NULL) {
+ 			kfree(ph2c);
+ 			res = _FAIL;
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 15edccef9f1d..2a30b9164107 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -919,7 +919,7 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 		return true;
 	}
 
-	bssid = (struct wlan_bssid_ex *)rtw_zmalloc(sizeof(struct wlan_bssid_ex));
+	bssid = kzalloc(sizeof(struct wlan_bssid_ex), GFP_ATOMIC);
 	if (!bssid)
 		return _FAIL;
 
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 4a5393184737..408d2b9955b9 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -1625,7 +1625,7 @@ void rtw_alloc_hwxmits(struct adapter *padapter)
 
 	pxmitpriv->hwxmit_entry = HWXMIT_ENTRY;
 
-	pxmitpriv->hwxmits = (struct hw_xmit *)rtw_zmalloc(sizeof(struct hw_xmit) * pxmitpriv->hwxmit_entry);
+	pxmitpriv->hwxmits = kzalloc(sizeof(struct hw_xmit) * pxmitpriv->hwxmit_entry, GFP_KERNEL);
 
 	hwxmits = pxmitpriv->hwxmits;
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index 4bd471873531..303661258e9c 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -489,7 +489,7 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 	struct rsvdpage_loc RsvdPageLoc;
 
 	DBG_88E("%s\n", __func__);
-	ReservedPagePacket = (u8 *)rtw_zmalloc(1000);
+	ReservedPagePacket = kzalloc(1000, GFP_KERNEL);
 	if (ReservedPagePacket == NULL) {
 		DBG_88E("%s: alloc ReservedPagePacket fail!\n", __func__);
 		return;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c.rej b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c.rej
new file mode 100644
index 000000000000..eaf3d40646fb
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c.rej
@@ -0,0 +1,11 @@
+--- drivers/staging/r8188eu/hal/rtl8188e_cmd.c
++++ drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+@@ -489,7 +489,7 @@ static void SetFwRsvdPagePkt(struct adap
+ 	struct rsvdpage_loc RsvdPageLoc;
+ 
+ 	DBG_88E("%s\n", __func__);
+-	ReservedPagePacket = (u8 *)rtw_zmalloc(1000);
++	ReservedPagePacket = kzalloc(1000, GFP_KERNEL);
+ 	if (ReservedPagePacket == NULL) {
+ 		DBG_88E("%s: alloc ReservedPagePacket fail!\n", __func__);
+ 		return;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 1a7a62dd8504..62d8a7ca3a9a 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -76,13 +76,13 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
 	u16	efuse_utilized = 0;
 	u8 u1temp = 0;
 
-	efuseTbl = (u8 *)rtw_zmalloc(EFUSE_MAP_LEN_88E);
+	efuseTbl = kzalloc(EFUSE_MAP_LEN_88E, GFP_KERNEL);
 	if (efuseTbl == NULL) {
 		DBG_88E("%s: alloc efuseTbl fail!\n", __func__);
 		goto exit;
 	}
 
-	eFuseWord = (u16 **)rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
+	eFuseWord = rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
 	if (eFuseWord == NULL) {
 		DBG_88E("%s: alloc eFuseWord fail!\n", __func__);
 		goto exit;
@@ -810,13 +810,13 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 		goto exit;
 	}
 
-	efuseTbl = (u8 *)rtw_zmalloc(EFUSE_MAP_LEN_88E);
+	efuseTbl = kzalloc(EFUSE_MAP_LEN_88E, GFP_KERNEL);
 	if (efuseTbl == NULL) {
 		DBG_88E("%s: alloc efuseTbl fail!\n", __func__);
 		goto exit;
 	}
 
-	eFuseWord = (u16 **)rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
+	eFuseWord = rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
 	if (eFuseWord == NULL) {
 		DBG_88E("%s: alloc eFuseWord fail!\n", __func__);
 		goto exit;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c.rej b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c.rej
new file mode 100644
index 000000000000..9d344b641344
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c.rej
@@ -0,0 +1,34 @@
+--- drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
++++ drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+@@ -76,13 +76,13 @@ efuse_phymap_to_logical(u8 *phymap, u16
+ 	u16	efuse_utilized = 0;
+ 	u8 u1temp = 0;
+ 
+-	efuseTbl = (u8 *)rtw_zmalloc(EFUSE_MAP_LEN_88E);
++	efuseTbl = kzalloc(EFUSE_MAP_LEN_88E, GFP_KERNEL);
+ 	if (efuseTbl == NULL) {
+ 		DBG_88E("%s: alloc efuseTbl fail!\n", __func__);
+ 		goto exit;
+ 	}
+ 
+-	eFuseWord = (u16 **)rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
++	eFuseWord = rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
+ 	if (eFuseWord == NULL) {
+ 		DBG_88E("%s: alloc eFuseWord fail!\n", __func__);
+ 		goto exit;
+@@ -810,13 +810,13 @@ static void Hal_EfuseReadEFuse88E(struct
+ 		goto exit;
+ 	}
+ 
+-	efuseTbl = (u8 *)rtw_zmalloc(EFUSE_MAP_LEN_88E);
++	efuseTbl = kzalloc(EFUSE_MAP_LEN_88E, GFP_KERNEL);
+ 	if (efuseTbl == NULL) {
+ 		DBG_88E("%s: alloc efuseTbl fail!\n", __func__);
+ 		goto exit;
+ 	}
+ 
+-	eFuseWord = (u16 **)rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
++	eFuseWord = rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
+ 	if (eFuseWord == NULL) {
+ 		DBG_88E("%s: alloc eFuseWord fail!\n", __func__);
+ 		goto exit;
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
index 2e3f624d0f22..278a89763258 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
@@ -44,7 +44,8 @@ int	rtl8188eu_init_recv_priv(struct adapter *padapter)
 	/* init recv_buf */
 	_rtw_init_queue(&precvpriv->free_recv_buf_queue);
 
-	precvpriv->pallocated_recv_buf = rtw_zmalloc(NR_RECVBUFF * sizeof(struct recv_buf) + 4);
+	precvpriv->pallocated_recv_buf = kzalloc(NR_RECVBUFF * sizeof(struct recv_buf) + 4,
+						 GFP_KERNEL);
 	if (precvpriv->pallocated_recv_buf == NULL) {
 		res = _FAIL;
 		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("alloc recv_buf fail!\n"));
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c.rej b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c.rej
new file mode 100644
index 000000000000..55f656764485
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c.rej
@@ -0,0 +1,12 @@
+--- drivers/staging/r8188eu/hal/rtl8188eu_recv.c
++++ drivers/staging/r8188eu/hal/rtl8188eu_recv.c
+@@ -44,7 +44,8 @@ int	rtl8188eu_init_recv_priv(struct adap
+ 	/* init recv_buf */
+ 	_rtw_init_queue(&precvpriv->free_recv_buf_queue);
+ 
+-	precvpriv->pallocated_recv_buf = rtw_zmalloc(NR_RECVBUFF * sizeof(struct recv_buf) + 4);
++	precvpriv->pallocated_recv_buf = kzalloc(NR_RECVBUFF * sizeof(struct recv_buf) + 4,
++						 GFP_KERNEL);
+ 	if (precvpriv->pallocated_recv_buf == NULL) {
+ 		res = _FAIL;
+ 		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("alloc recv_buf fail!\n"));
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index d985894c0f30..441080bd0b74 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -2252,7 +2252,7 @@ void rtl8188eu_set_hal_ops(struct adapter *adapt)
 {
 	struct hal_ops	*halfunc = &adapt->HalFunc;
 
-	adapt->HalData = rtw_zmalloc(sizeof(struct hal_data_8188e));
+	adapt->HalData = kzalloc(sizeof(struct hal_data_8188e), GFP_KERNEL);
 	if (adapt->HalData == NULL)
 		DBG_88E("cant not alloc memory for HAL DATA\n");
 	adapt->hal_data_sz = sizeof(struct hal_data_8188e);
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c.rej b/drivers/staging/r8188eu/hal/usb_halinit.c.rej
new file mode 100644
index 000000000000..ea8027b55821
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c.rej
@@ -0,0 +1,11 @@
+--- drivers/staging/r8188eu/hal/usb_halinit.c
++++ drivers/staging/r8188eu/hal/usb_halinit.c
+@@ -2252,7 +2252,7 @@ void rtl8188eu_set_hal_ops(struct adapte
+ {
+ 	struct hal_ops	*halfunc = &adapt->HalFunc;
+ 
+-	adapt->HalData = rtw_zmalloc(sizeof(struct hal_data_8188e));
++	adapt->HalData = kzalloc(sizeof(struct hal_data_8188e), GFP_KERNEL);
+ 	if (adapt->HalData == NULL)
+ 		DBG_88E("cant not alloc memory for HAL DATA\n");
+ 	adapt->hal_data_sz = sizeof(struct hal_data_8188e);
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h.rej b/drivers/staging/r8188eu/include/odm_precomp.h.rej
new file mode 100644
index 000000000000..31b7babc4910
--- /dev/null
+++ b/drivers/staging/r8188eu/include/odm_precomp.h.rej
@@ -0,0 +1,19 @@
+--- drivers/staging/r8188eu/include/odm_precomp.h
++++ drivers/staging/r8188eu/include/odm_precomp.h
+@@ -35,8 +35,6 @@
+ #include "odm_RegConfig8188E.h"
+ #include "odm_RTL8188E.h"
+ 
+-void odm_CmnInfoHook_Debug(struct odm_dm_struct *pDM_Odm);
+-void odm_CmnInfoInit_Debug(struct odm_dm_struct *pDM_Odm);
+ void odm_DIGInit(struct odm_dm_struct *pDM_Odm);
+ void odm_RateAdaptiveMaskInit(struct odm_dm_struct *pDM_Odm);
+ void odm_DynamicBBPowerSavingInit(struct odm_dm_struct *pDM_Odm);
+@@ -45,7 +43,6 @@ void odm_TXPowerTrackingInit(struct odm_
+ void ODM_EdcaTurboInit(struct odm_dm_struct *pDM_Odm);
+ void odm_SwAntDivInit_NIC(struct odm_dm_struct *pDM_Odm);
+ void odm_GlobalAdapterCheck(void);
+-void odm_CmnInfoUpdate_Debug(struct odm_dm_struct *pDM_Odm);
+ void odm_CommonInfoSelfUpdate(struct odm_dm_struct *pDM_Odm);
+ void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm);
+ void odm_DIG(struct odm_dm_struct *pDM_Odm);
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 05cbc9b0dadd..30f645d89fe8 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -215,15 +215,9 @@ extern unsigned char RSN_TKIP_CIPHER[4];
 u8 *_rtw_vmalloc(u32 sz);
 u8 *_rtw_zvmalloc(u32 sz);
 void _rtw_vmfree(u8 *pbuf, u32 sz);
-u8 *_rtw_zmalloc(u32 sz);
-u8 *_rtw_malloc(u32 sz);
-void _rtw_mfree(u8 *pbuf, u32 sz);
 #define rtw_vmalloc(sz)			_rtw_vmalloc((sz))
 #define rtw_zvmalloc(sz)			_rtw_zvmalloc((sz))
 #define rtw_vmfree(pbuf, sz)		_rtw_vmfree((pbuf), (sz))
-#define rtw_malloc(sz)			_rtw_malloc((sz))
-#define rtw_zmalloc(sz)			_rtw_zmalloc((sz))
-#define rtw_mfree(pbuf, sz)		_rtw_mfree((pbuf), (sz))
 
 void *rtw_malloc2d(int h, int w, int size);
 
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 8ba2b81e32b8..5f4355cb03e7 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -522,7 +522,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
-			pwep = (struct ndis_802_11_wep *)rtw_malloc(wep_total_len);
+			pwep = kmalloc(wep_total_len, GFP_KERNEL);
 			if (!pwep) {
 				RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, (" wpa_set_encryption: pwep allocate fail !!!\n"));
 				goto exit;
@@ -642,7 +642,7 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 	}
 
 	if (ielen) {
-		buf = rtw_zmalloc(ielen);
+		buf = kzalloc(ielen, GFP_KERNEL);
 		if (!buf) {
 			ret =  -ENOMEM;
 			goto exit;
@@ -2109,11 +2109,9 @@ static int rtw_wx_set_enc_ext(struct net_device *dev,
 	int ret = 0;
 
 	param_len = sizeof(struct ieee_param) + pext->key_len;
-	param = (struct ieee_param *)rtw_malloc(param_len);
+	param = kzalloc(param_len, GFP_KERNEL);
 	if (!param)
-		return -1;
-
-	memset(param, 0, param_len);
+		return -ENOMEM;
 
 	param->cmd = IEEE_CMD_SET_ENCRYPTION;
 	memset(param->sta_addr, 0xff, ETH_ALEN);
@@ -2194,8 +2192,8 @@ static int rtw_wx_read32(struct net_device *dev,
 	padapter = (struct adapter *)rtw_netdev_priv(dev);
 	p = &wrqu->data;
 	len = p->length;
-	ptmp = (u8 *)rtw_malloc(len);
-	if (NULL == ptmp)
+	ptmp = kmalloc(len, GFP_KERNEL);
+	if (!ptmp)
 		return -ENOMEM;
 
 	if (copy_from_user(ptmp, p->pointer, len)) {
@@ -2464,7 +2462,7 @@ static int rtw_mp_ioctl_hdl(struct net_device *dev, struct iw_request_info *info
 	pparmbuf = NULL;
 	bset = (u8)(p->flags & 0xFFFF);
 	len = p->length;
-	pparmbuf = (u8 *)rtw_malloc(len);
+	pparmbuf = kmalloc(len, GFP_KERNEL);
 	if (!pparmbuf) {
 		ret = -ENOMEM;
 		goto _rtw_mp_ioctl_hdl_exit;
@@ -4674,7 +4672,7 @@ static int wpa_supplicant_ioctl(struct net_device *dev, struct iw_point *p)
 		goto out;
 	}
 
-	param = (struct ieee_param *)rtw_malloc(p->length);
+	param = kmalloc(p->length, GFP_KERNEL);
 	if (!param) {
 		ret = -ENOMEM;
 		goto out;
@@ -4728,13 +4726,13 @@ static u8 set_pairwise_key(struct adapter *padapter, struct sta_info *psta)
 	struct cmd_priv	*pcmdpriv = &padapter->cmdpriv;
 	u8 res = _SUCCESS;
 
-	ph2c = (struct cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
+	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
 	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
-	psetstakey_para = (struct set_stakey_parm *)rtw_zmalloc(sizeof(struct set_stakey_parm));
+	psetstakey_para = kzalloc(sizeof(struct set_stakey_parm), GFP_KERNEL);
 	if (!psetstakey_para) {
 		kfree(ph2c);
 		res = _FAIL;
@@ -4766,12 +4764,12 @@ static int set_group_key(struct adapter *padapter, u8 *key, u8 alg, int keyid)
 
 	DBG_88E("%s\n", __func__);
 
-	pcmd = (struct cmd_obj *)rtw_zmalloc(sizeof(struct	cmd_obj));
+	pcmd = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
 	if (!pcmd) {
 		res = _FAIL;
 		goto exit;
 	}
-	psetkeyparm = (struct setkey_parm *)rtw_zmalloc(sizeof(struct setkey_parm));
+	psetkeyparm = kzalloc(sizeof(struct setkey_parm), GFP_KERNEL);
 	if (!psetkeyparm) {
 		kfree(pcmd);
 		res = _FAIL;
@@ -4887,14 +4885,11 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
-			pwep = (struct ndis_802_11_wep *)rtw_malloc(wep_total_len);
+			pwep = kzalloc(wep_total_len, GFP_KERNEL);
 			if (!pwep) {
-				DBG_88E(" r871x_set_encryption: pwep allocate fail !!!\n");
+				ret = -ENOMEM;
 				goto exit;
 			}
-
-			memset(pwep, 0, wep_total_len);
-
 			pwep->KeyLength = wep_key_len;
 			pwep->Length = wep_total_len;
 		}
@@ -5315,7 +5310,7 @@ static int rtw_set_wps_beacon(struct net_device *dev, struct ieee_param *param,
 	}
 
 	if (ie_len > 0) {
-		pmlmepriv->wps_beacon_ie = rtw_malloc(ie_len);
+		pmlmepriv->wps_beacon_ie = kmalloc(ie_len, GFP_KERNEL);
 		pmlmepriv->wps_beacon_ie_len = ie_len;
 		if (!pmlmepriv->wps_beacon_ie) {
 			DBG_88E("%s()-%d: rtw_malloc() ERROR!\n", __func__, __LINE__);
@@ -5352,7 +5347,7 @@ static int rtw_set_wps_probe_resp(struct net_device *dev, struct ieee_param *par
 	}
 
 	if (ie_len > 0) {
-		pmlmepriv->wps_probe_resp_ie = rtw_malloc(ie_len);
+		pmlmepriv->wps_probe_resp_ie = kmalloc(ie_len, GFP_KERNEL);
 		pmlmepriv->wps_probe_resp_ie_len = ie_len;
 		if (!pmlmepriv->wps_probe_resp_ie) {
 			DBG_88E("%s()-%d: rtw_malloc() ERROR!\n", __func__, __LINE__);
@@ -5384,11 +5379,11 @@ static int rtw_set_wps_assoc_resp(struct net_device *dev, struct ieee_param *par
 	}
 
 	if (ie_len > 0) {
-		pmlmepriv->wps_assoc_resp_ie = rtw_malloc(ie_len);
+		pmlmepriv->wps_assoc_resp_ie = kmalloc(ie_len, GFP_KERNEL);
 		pmlmepriv->wps_assoc_resp_ie_len = ie_len;
 		if (!pmlmepriv->wps_assoc_resp_ie) {
 			DBG_88E("%s()-%d: rtw_malloc() ERROR!\n", __func__, __LINE__);
-			return -EINVAL;
+			return -ENOMEM;
 		}
 
 		memcpy(pmlmepriv->wps_assoc_resp_ie, param->u.bcn_ie.buf, ie_len);
@@ -5491,7 +5486,7 @@ static int rtw_hostapd_ioctl(struct net_device *dev, struct iw_point *p)
 		goto out;
 	}
 
-	param = (struct ieee_param *)rtw_malloc(p->length);
+	param = kmalloc(p->length, GFP_KERNEL);
 	if (!param) {
 		ret = -ENOMEM;
 		goto out;
@@ -5600,9 +5595,8 @@ static int rtw_wx_set_priv(struct net_device *dev,
 			kfree(pmlmepriv->wps_probe_req_ie);
 			pmlmepriv->wps_probe_req_ie = NULL;
 
-			pmlmepriv->wps_probe_req_ie = rtw_malloc(cp_sz);
+			pmlmepriv->wps_probe_req_ie = kmalloc(cp_sz, GFP_KERNEL);
 			if (!pmlmepriv->wps_probe_req_ie) {
-				pr_info("%s()-%d: rtw_malloc() ERROR!\n", __func__, __LINE__);
 				ret =  -EINVAL;
 				goto FREE_EXT;
 			}
@@ -5674,12 +5668,12 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 	pEfuseHal = &haldata->EfuseHal;
 
 	err = 0;
-	data = _rtw_zmalloc(EFUSE_BT_MAX_MAP_LEN);
+	data = kzalloc(EFUSE_BT_MAX_MAP_LEN, GFP_KERNEL);
 	if (!data) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	rawdata = _rtw_zmalloc(EFUSE_BT_MAX_MAP_LEN);
+	rawdata = kzalloc(EFUSE_BT_MAX_MAP_LEN, GFP_KERNEL);
 	if (!rawdata) {
 		err = -ENOMEM;
 		goto exit;
@@ -5989,22 +5983,22 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 	haldata = GET_HAL_DATA(padapter);
 	pEfuseHal = &haldata->EfuseHal;
 	err = 0;
-	setdata = _rtw_zmalloc(1024);
+	setdata = kzalloc(1024, GFP_KERNEL);
 	if (!setdata) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	ShadowMapBT = _rtw_malloc(EFUSE_BT_MAX_MAP_LEN);
+	ShadowMapBT = kmalloc(EFUSE_BT_MAX_MAP_LEN, GFP_KERNEL);
 	if (!ShadowMapBT) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	ShadowMapWiFi = _rtw_malloc(EFUSE_MAP_SIZE);
+	ShadowMapWiFi = kmalloc(EFUSE_MAP_SIZE, GFP_KERNEL);
 	if (!ShadowMapWiFi) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	setrawdata = _rtw_malloc(EFUSE_MAX_SIZE);
+	setrawdata = kmalloc(EFUSE_MAX_SIZE, GFP_KERNEL);
 	if (!setrawdata) {
 		err = -ENOMEM;
 		goto exit;
@@ -7486,7 +7480,7 @@ static int rtw_test(
 	DBG_88E("+%s\n", __func__);
 	len = wrqu->data.length;
 
-	pbuf = (u8 *)rtw_zmalloc(len);
+	pbuf = kzalloc(len, GFP_KERNEL);
 	if (!pbuf) {
 		DBG_88E("%s: no memory!\n", __func__);
 		return -ENOMEM;
@@ -7832,7 +7826,7 @@ static int rtw_ioctl_wext_private(struct net_device *dev, union iwreq_data *wrq_
 	input_len = wdata.data.length;
 	if (input_len == 0)
 		return -EFAULT;
-	input = rtw_zmalloc(input_len);
+	input = kzalloc(input_len, GFP_KERNEL);
 	if (NULL == input)
 		return -ENOMEM;
 	if (copy_from_user(input, wdata.data.pointer, input_len)) {
@@ -7895,7 +7889,7 @@ static int rtw_ioctl_wext_private(struct net_device *dev, union iwreq_data *wrq_
 		k = j;
 	}
 
-	buffer = rtw_zmalloc(4096);
+	buffer = kzalloc(4096, GFP_KERNEL);
 	if (NULL == buffer) {
 		err = -ENOMEM;
 		goto exit;
@@ -8044,7 +8038,7 @@ static int rtw_ioctl_wext_private(struct net_device *dev, union iwreq_data *wrq_
 		else
 			n = wdata.data.length;
 
-		output = rtw_zmalloc(4096);
+		output = kzalloc(4096, GFP_KERNEL);
 		if (NULL == output) {
 			err =  -ENOMEM;
 			goto exit;
diff --git a/drivers/staging/r8188eu/os_dep/mlme_linux.c b/drivers/staging/r8188eu/os_dep/mlme_linux.c
index 766b346afbb8..0855b218f7b1 100644
--- a/drivers/staging/r8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/r8188eu/os_dep/mlme_linux.c
@@ -119,10 +119,9 @@ void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
 	if (authmode == _WPA_IE_ID_) {
 		RT_TRACE(_module_mlme_osdep_c_, _drv_info_,
 			 ("rtw_report_sec_ie, authmode=%d\n", authmode));
-		buff = rtw_malloc(IW_CUSTOM_MAX);
+		buff = kzalloc(IW_CUSTOM_MAX, GFP_KERNEL);
 		if (!buff)
 			return;
-		memset(buff, 0, IW_CUSTOM_MAX);
 		p = buff;
 		p += sprintf(p, "ASSOCINFO(ReqIEs =");
 		len = sec_ie[1]+2;
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index 99ddc535e5ea..d537f6352fc5 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -58,32 +58,13 @@ inline void _rtw_vmfree(u8 *pbuf, u32 sz)
 	vfree(pbuf);
 }
 
-u8 *_rtw_malloc(u32 sz)
-{
-	u8	*pbuf = NULL;
-
-	pbuf = kmalloc(sz, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
-	return pbuf;
-}
-
-u8 *_rtw_zmalloc(u32 sz)
-{
-	u8	*pbuf = _rtw_malloc(sz);
-
-	if (pbuf)
-		memset(pbuf, 0, sz);
-	return pbuf;
-}
-
 void *rtw_malloc2d(int h, int w, int size)
 {
 	int j;
 
-	void **a = (void **)rtw_zmalloc(h*sizeof(void *) + h*w*size);
-	if (!a) {
-		pr_info("%s: alloc memory fail!\n", __func__);
+	void **a = kzalloc(h * sizeof(void *) + h * w * size, GFP_KERNEL);
+	if (!a)
 		return NULL;
-	}
 
 	for (j = 0; j < h; j++)
 		a[j] = ((char *)(a+h)) + j*w*size;
@@ -401,7 +382,7 @@ void rtw_buf_update(u8 **buf, u32 *buf_len, u8 *src, u32 src_len)
 		goto keep_ori;
 
 	/* duplicate src */
-	dup = rtw_malloc(src_len);
+	dup = kmalloc(src_len, GFP_ATOMIC);
 	if (dup) {
 		dup_len = src_len;
 		memcpy(dup, src, dup_len);
@@ -494,8 +475,7 @@ struct rtw_cbuf *rtw_cbuf_alloc(u32 size)
 {
 	struct rtw_cbuf *cbuf;
 
-	cbuf = (struct rtw_cbuf *)rtw_malloc(sizeof(*cbuf) +
-	       sizeof(void *)*size);
+	cbuf = kmalloc(sizeof(*cbuf) + sizeof(void *)*size, GFP_KERNEL);
 
 	if (cbuf) {
 		cbuf->write = 0;
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index bc7f4bd7ce0b..270de35f1d35 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -118,7 +118,7 @@ static u8 rtw_init_intf_priv(struct dvobj_priv *dvobj)
 
 	_rtw_mutex_init(&dvobj->usb_vendor_req_mutex);
 
-	dvobj->usb_alloc_vendor_req_buf = rtw_zmalloc(MAX_USB_IO_CTL_SIZE);
+	dvobj->usb_alloc_vendor_req_buf = kzalloc(MAX_USB_IO_CTL_SIZE, GFP_KERNEL);
 	if (!dvobj->usb_alloc_vendor_req_buf) {
 		DBG_88E("alloc usb_vendor_req_buf failed... /n");
 		rst = _FAIL;
@@ -150,7 +150,7 @@ static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
 	struct usb_endpoint_descriptor	*pendp_desc;
 	struct usb_device	*pusbd;
 
-	pdvobjpriv = (struct dvobj_priv *)rtw_zmalloc(sizeof(*pdvobjpriv));
+	pdvobjpriv = kzalloc(sizeof(*pdvobjpriv), GFP_KERNEL);
 	if (!pdvobjpriv)
 		goto exit;
 
diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index 421328173984..df9bdbff91ac 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -76,7 +76,7 @@ int rtw_os_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitb
 {
 	int i;
 
-	pxmitbuf->pallocated_buf = rtw_zmalloc(alloc_sz);
+	pxmitbuf->pallocated_buf = kzalloc(alloc_sz, GFP_KERNEL);
 	if (!pxmitbuf->pallocated_buf)
 		return _FAIL;
 
diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c.rej b/drivers/staging/r8188eu/os_dep/xmit_linux.c.rej
new file mode 100644
index 000000000000..285ff79b6ce5
--- /dev/null
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c.rej
@@ -0,0 +1,11 @@
+--- drivers/staging/r8188eu/os_dep/xmit_linux.c
++++ drivers/staging/r8188eu/os_dep/xmit_linux.c
+@@ -76,7 +76,7 @@ int rtw_os_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitb
+ {
+	int i;
+
+-	pxmitbuf->pallocated_buf = rtw_zmalloc(alloc_sz);
++	pxmitbuf->pallocated_buf = kzalloc(alloc_sz, GFP_KERNEL);
+	if (pxmitbuf->pallocated_buf == NULL)
+		return _FAIL;
+
-- 
2.32.0

