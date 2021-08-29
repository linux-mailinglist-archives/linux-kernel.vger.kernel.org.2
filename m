Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531593FACC0
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 17:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbhH2Pqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 11:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbhH2Pql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 11:46:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E285C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 08:45:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z4so18619338wrr.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 08:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XiiyDhZUUAtLYqBMyS+3PDlLVTY1Q5GeHO8Lp+pXuNw=;
        b=rPOZpoexG3fwHSvJzTk9/UDs+2WuK76I80zBF17US94/1Ud9A16T5sFClACgRVFsHX
         X0hEUdzkH32EGT1j8RUhRyni6W62VEpyNeJqgsgPWPVTGr79kNI3aV8h/5mJMMW/69WM
         N+0ocEbBp3Fx8BpaT6yv/D5LMVzhBLxywCzhejOri+VZQrAjTFwyteCdr0aic/9AAa48
         mYkYKzLvSiYApAeOcTAW9x0geBBByfS+H7FGFMad9uYrdFWnW7VstfZ6sPLBCzTsxJrc
         4jaZG+GOjwqsyxJxeB3M1ZXIOFK56OaNFkE/LFcd+k10E0KznuAVrJ00VIUT9ZGwMo2O
         0Yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XiiyDhZUUAtLYqBMyS+3PDlLVTY1Q5GeHO8Lp+pXuNw=;
        b=M+rRANWzSkuyBJ3iRSC2FpuTNB9Tbq4jSeRgvQqkINrYI16s1uvPmyuNpgPO89SagC
         dbXI+iXnflBLWe2AjVtCfS202LgFvk01L/W6Op5y000UtT6TGkiKZ+nmc3hcXn9OK/Xv
         atrc+zQre0D50F3pHKlA8iSXlpu400dhlVJJt1rmN4Pgo+fKa6ynmhfWlAmxWbnFGaHa
         Gb7+zX+GE+ePPmNI3FVWj9wT8hzV/VQwWELf/8VAnAC4YDAQx8TPQUWaNftq1NdtwEbm
         PZ3qYCeMsHGxyqJzGlLI/LncN23hHmjEIKWzrAwESym2lxOOGpiegBPpUkn8juYS3u5q
         fHYA==
X-Gm-Message-State: AOAM531sD5x4pjGfnrJweyKnXxdpbQolHcKpCph8uw2z51l3hOIZeeDR
        orMlSWvZIuHveR7bfLNADXqUvtwdjjUwsA==
X-Google-Smtp-Source: ABdhPJznRt2AKSo6Ochc81vTXsk6n+mfYy+9JQ7d+XKeIPOGel7B64oSSs4cLgpSVPwrQplxJtFkGQ==
X-Received: by 2002:adf:c542:: with SMTP id s2mr19442250wrf.374.1630251947184;
        Sun, 29 Aug 2021 08:45:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id q13sm12567243wrv.79.2021.08.29.08.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 08:45:46 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        fabioaiuto83@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8723bs: clean up comparsions to NULL
Date:   Sun, 29 Aug 2021 17:45:33 +0200
Message-Id: <20210829154533.11054-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up comparsions to NULL reported by checkpatch.

x == NULL -> !x
x != NULL -> x

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c       | 20 ++--
 drivers/staging/rtl8723bs/core/rtw_cmd.c      | 96 +++++++++----------
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    |  4 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c     |  6 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 56 +++++------
 drivers/staging/rtl8723bs/core/rtw_security.c |  6 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 24 ++---
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 18 ++--
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   |  4 +-
 9 files changed, 117 insertions(+), 117 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 6064dd6a76b4..674592e914e2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -891,7 +891,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		&ie_len,
 		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
-	if (p !=  NULL) {
+	if (p) {
 		memcpy(supportRate, p + 2, ie_len);
 		supportRateNum = ie_len;
 	}
@@ -903,7 +903,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		&ie_len,
 		pbss_network->ie_length - _BEACON_IE_OFFSET_
 	);
-	if (p !=  NULL) {
+	if (p) {
 		memcpy(supportRate + supportRateNum, p + 2, ie_len);
 		supportRateNum += ie_len;
 	}
@@ -991,7 +991,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 			break;
 		}
 
-		if ((p == NULL) || (ie_len == 0))
+		if (!p || ie_len == 0)
 			break;
 	}
 
@@ -1021,7 +1021,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 				break;
 			}
 
-			if ((p == NULL) || (ie_len == 0))
+			if (!p || ie_len == 0)
 				break;
 		}
 	}
@@ -1145,7 +1145,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	psta = rtw_get_stainfo(&padapter->stapriv, pbss_network->mac_address);
 	if (!psta) {
 		psta = rtw_alloc_stainfo(&padapter->stapriv, pbss_network->mac_address);
-		if (psta == NULL)
+		if (!psta)
 			return _FAIL;
 	}
 
@@ -1275,7 +1275,7 @@ u8 rtw_ap_set_pairwise_key(struct adapter *padapter, struct sta_info *psta)
 	}
 
 	psetstakey_para = rtw_zmalloc(sizeof(struct set_stakey_parm));
-	if (psetstakey_para == NULL) {
+	if (!psetstakey_para) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -1311,12 +1311,12 @@ static int rtw_ap_set_key(
 	int res = _SUCCESS;
 
 	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (pcmd == NULL) {
+	if (!pcmd) {
 		res = _FAIL;
 		goto exit;
 	}
 	psetkeyparm = rtw_zmalloc(sizeof(struct setkey_parm));
-	if (psetkeyparm == NULL) {
+	if (!psetkeyparm) {
 		kfree(pcmd);
 		res = _FAIL;
 		goto exit;
@@ -1474,11 +1474,11 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 		&wps_ielen
 	);
 
-	if (pwps_ie == NULL || wps_ielen == 0)
+	if (!pwps_ie || wps_ielen == 0)
 		return;
 
 	pwps_ie_src = pmlmepriv->wps_beacon_ie;
-	if (pwps_ie_src == NULL)
+	if (!pwps_ie_src)
 		return;
 
 	wps_offset = (uint)(pwps_ie - ie);
diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index d494c06dab96..e974c07838e7 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -255,7 +255,7 @@ int _rtw_enqueue_cmd(struct __queue *queue, struct cmd_obj *obj)
 {
 	unsigned long irqL;
 
-	if (obj == NULL)
+	if (!obj)
 		goto exit;
 
 	/* spin_lock_bh(&queue->lock); */
@@ -323,7 +323,7 @@ int rtw_enqueue_cmd(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 	int res = _FAIL;
 	struct adapter *padapter = pcmdpriv->padapter;
 
-	if (cmd_obj == NULL)
+	if (!cmd_obj)
 		goto exit;
 
 	cmd_obj->padapter = padapter;
@@ -488,7 +488,7 @@ int rtw_cmd_thread(void *context)
 		/* call callback function for post-processed */
 		if (pcmd->cmdcode < ARRAY_SIZE(rtw_cmd_callback)) {
 			pcmd_callback = rtw_cmd_callback[pcmd->cmdcode].callback;
-			if (pcmd_callback == NULL) {
+			if (!pcmd_callback) {
 				rtw_free_cmd_obj(pcmd);
 			} else {
 				/* todo: !!! fill rsp_buf to pcmd->rsp if (pcmd->rsp!= NULL) */
@@ -507,7 +507,7 @@ int rtw_cmd_thread(void *context)
 	/*  free all cmd_obj resources */
 	do {
 		pcmd = rtw_dequeue_cmd(pcmdpriv);
-		if (pcmd == NULL) {
+		if (!pcmd) {
 			rtw_unregister_cmd_alive(padapter);
 			break;
 		}
@@ -546,11 +546,11 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 		rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_SCAN, 1);
 
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL)
+	if (!ph2c)
 		return _FAIL;
 
 	psurveyPara = rtw_zmalloc(sizeof(struct sitesurvey_parm));
-	if (psurveyPara == NULL) {
+	if (!psurveyPara) {
 		kfree(ph2c);
 		return _FAIL;
 	}
@@ -608,13 +608,13 @@ u8 rtw_setdatarate_cmd(struct adapter *padapter, u8 *rateset)
 	u8 res = _SUCCESS;
 
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	pbsetdataratepara = rtw_zmalloc(sizeof(struct setdatarate_parm));
-	if (pbsetdataratepara == NULL) {
+	if (!pbsetdataratepara) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -644,7 +644,7 @@ u8 rtw_createbss_cmd(struct adapter  *padapter)
 	u8 res = _SUCCESS;
 
 	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (pcmd == NULL) {
+	if (!pcmd) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -677,7 +677,7 @@ int rtw_startbss_cmd(struct adapter  *padapter, int flags)
 	} else {
 		/* need enqueue, prepare cmd_obj and enqueue */
 		pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
-		if (pcmd == NULL) {
+		if (!pcmd) {
 			res = _FAIL;
 			goto exit;
 		}
@@ -729,7 +729,7 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 	u8 *ptmp = NULL;
 
 	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (pcmd == NULL) {
+	if (!pcmd) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -841,7 +841,7 @@ u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueu
 
 	/* prepare cmd parameter */
 	param = rtw_zmalloc(sizeof(*param));
-	if (param == NULL) {
+	if (!param) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -850,7 +850,7 @@ u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueu
 	if (enqueue) {
 		/* need enqueue, prepare cmd_obj and enqueue */
 		cmdobj = rtw_zmalloc(sizeof(*cmdobj));
-		if (cmdobj == NULL) {
+		if (!cmdobj) {
 			res = _FAIL;
 			kfree(param);
 			goto exit;
@@ -878,7 +878,7 @@ u8 rtw_setopmode_cmd(struct adapter  *padapter, enum ndis_802_11_network_infrast
 
 	psetop = rtw_zmalloc(sizeof(struct setopmode_parm));
 
-	if (psetop == NULL) {
+	if (!psetop) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -886,7 +886,7 @@ u8 rtw_setopmode_cmd(struct adapter  *padapter, enum ndis_802_11_network_infrast
 
 	if (enqueue) {
 		ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-		if (ph2c == NULL) {
+		if (!ph2c) {
 			kfree(psetop);
 			res = _FAIL;
 			goto exit;
@@ -914,7 +914,7 @@ u8 rtw_setstakey_cmd(struct adapter *padapter, struct sta_info *sta, u8 unicast_
 	u8 res = _SUCCESS;
 
 	psetstakey_para = rtw_zmalloc(sizeof(struct set_stakey_parm));
-	if (psetstakey_para == NULL) {
+	if (!psetstakey_para) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -936,14 +936,14 @@ u8 rtw_setstakey_cmd(struct adapter *padapter, struct sta_info *sta, u8 unicast_
 
 	if (enqueue) {
 		ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-		if (ph2c == NULL) {
+		if (!ph2c) {
 			kfree(psetstakey_para);
 			res = _FAIL;
 			goto exit;
 		}
 
 		psetstakey_rsp = rtw_zmalloc(sizeof(struct set_stakey_rsp));
-		if (psetstakey_rsp == NULL) {
+		if (!psetstakey_rsp) {
 			kfree(ph2c);
 			kfree(psetstakey_para);
 			res = _FAIL;
@@ -981,20 +981,20 @@ u8 rtw_clearstakey_cmd(struct adapter *padapter, struct sta_info *sta, u8 enqueu
 		}
 	} else {
 		ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-		if (ph2c == NULL) {
+		if (!ph2c) {
 			res = _FAIL;
 			goto exit;
 		}
 
 		psetstakey_para = rtw_zmalloc(sizeof(struct set_stakey_parm));
-		if (psetstakey_para == NULL) {
+		if (!psetstakey_para) {
 			kfree(ph2c);
 			res = _FAIL;
 			goto exit;
 		}
 
 		psetstakey_rsp = rtw_zmalloc(sizeof(struct set_stakey_rsp));
-		if (psetstakey_rsp == NULL) {
+		if (!psetstakey_rsp) {
 			kfree(ph2c);
 			kfree(psetstakey_para);
 			res = _FAIL;
@@ -1026,13 +1026,13 @@ u8 rtw_addbareq_cmd(struct adapter *padapter, u8 tid, u8 *addr)
 	u8 res = _SUCCESS;
 
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	paddbareq_parm = rtw_zmalloc(sizeof(struct addBaReq_parm));
-	if (paddbareq_parm == NULL) {
+	if (!paddbareq_parm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -1058,13 +1058,13 @@ u8 rtw_reset_securitypriv_cmd(struct adapter *padapter)
 	u8 res = _SUCCESS;
 
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	pdrvextra_cmd_parm = rtw_zmalloc(sizeof(struct drvextra_cmd_parm));
-	if (pdrvextra_cmd_parm == NULL) {
+	if (!pdrvextra_cmd_parm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -1093,13 +1093,13 @@ u8 rtw_free_assoc_resources_cmd(struct adapter *padapter)
 	u8 res = _SUCCESS;
 
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	pdrvextra_cmd_parm = rtw_zmalloc(sizeof(struct drvextra_cmd_parm));
-	if (pdrvextra_cmd_parm == NULL) {
+	if (!pdrvextra_cmd_parm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -1129,13 +1129,13 @@ u8 rtw_dynamic_chk_wk_cmd(struct adapter *padapter)
 
 	/* only  primary padapter does this cmd */
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	pdrvextra_cmd_parm = rtw_zmalloc(sizeof(struct drvextra_cmd_parm));
-	if (pdrvextra_cmd_parm == NULL) {
+	if (!pdrvextra_cmd_parm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -1177,7 +1177,7 @@ u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan, u8 enqueue, u8 swconf
 
 	/* prepare cmd parameter */
 	setChannelPlan_param = rtw_zmalloc(sizeof(struct SetChannelPlan_param));
-	if (setChannelPlan_param == NULL) {
+	if (!setChannelPlan_param) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -1186,7 +1186,7 @@ u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan, u8 enqueue, u8 swconf
 	if (enqueue) {
 		/* need enqueue, prepare cmd_obj and enqueue */
 		pcmdobj = rtw_zmalloc(sizeof(struct cmd_obj));
-		if (pcmdobj == NULL) {
+		if (!pcmdobj) {
 			kfree(setChannelPlan_param);
 			res = _FAIL;
 			goto exit;
@@ -1436,13 +1436,13 @@ u8 rtw_lps_ctrl_wk_cmd(struct adapter *padapter, u8 lps_ctrl_type, u8 enqueue)
 
 	if (enqueue) {
 		ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-		if (ph2c == NULL) {
+		if (!ph2c) {
 			res = _FAIL;
 			goto exit;
 		}
 
 		pdrvextra_cmd_parm = rtw_zmalloc(sizeof(struct drvextra_cmd_parm));
-		if (pdrvextra_cmd_parm == NULL) {
+		if (!pdrvextra_cmd_parm) {
 			kfree(ph2c);
 			res = _FAIL;
 			goto exit;
@@ -1478,13 +1478,13 @@ u8 rtw_dm_in_lps_wk_cmd(struct adapter *padapter)
 
 
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	pdrvextra_cmd_parm = rtw_zmalloc(sizeof(struct drvextra_cmd_parm));
-	if (pdrvextra_cmd_parm == NULL) {
+	if (!pdrvextra_cmd_parm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -1544,13 +1544,13 @@ u8 rtw_dm_ra_mask_wk_cmd(struct adapter *padapter, u8 *psta)
 
 
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	pdrvextra_cmd_parm = rtw_zmalloc(sizeof(struct drvextra_cmd_parm));
-	if (pdrvextra_cmd_parm == NULL) {
+	if (!pdrvextra_cmd_parm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -1579,13 +1579,13 @@ u8 rtw_ps_cmd(struct adapter *padapter)
 	u8 res = _SUCCESS;
 
 	ppscmd = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ppscmd == NULL) {
+	if (!ppscmd) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	pdrvextra_cmd_parm = rtw_zmalloc(sizeof(struct drvextra_cmd_parm));
-	if (pdrvextra_cmd_parm == NULL) {
+	if (!pdrvextra_cmd_parm) {
 		kfree(ppscmd);
 		res = _FAIL;
 		goto exit;
@@ -1651,13 +1651,13 @@ u8 rtw_chk_hi_queue_cmd(struct adapter *padapter)
 	u8 res = _SUCCESS;
 
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	pdrvextra_cmd_parm = rtw_zmalloc(sizeof(struct drvextra_cmd_parm));
-	if (pdrvextra_cmd_parm == NULL) {
+	if (!pdrvextra_cmd_parm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -1745,13 +1745,13 @@ u8 rtw_c2h_packet_wk_cmd(struct adapter *padapter, u8 *pbuf, u16 length)
 	u8 res = _SUCCESS;
 
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	pdrvextra_cmd_parm = rtw_zmalloc(sizeof(struct drvextra_cmd_parm));
-	if (pdrvextra_cmd_parm == NULL) {
+	if (!pdrvextra_cmd_parm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -1780,13 +1780,13 @@ u8 rtw_c2h_wk_cmd(struct adapter *padapter, u8 *c2h_evt)
 	u8 res = _SUCCESS;
 
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	pdrvextra_cmd_parm = rtw_zmalloc(sizeof(struct drvextra_cmd_parm));
-	if (pdrvextra_cmd_parm == NULL) {
+	if (!pdrvextra_cmd_parm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -1961,7 +1961,7 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)pcmd->parmbuf;
 	struct wlan_network *tgt_network = &(pmlmepriv->cur_network);
 
-	if (pcmd->parmbuf == NULL)
+	if (!pcmd->parmbuf)
 		goto exit;
 
 	if (pcmd->res != H2C_SUCCESS)
@@ -1984,9 +1984,9 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 	} else {
 		pwlan = rtw_alloc_network(pmlmepriv);
 		spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
-		if (pwlan == NULL) {
+		if (!pwlan) {
 			pwlan = rtw_get_oldest_wlan_network(&pmlmepriv->scanned_queue);
-			if (pwlan == NULL) {
+			if (!pwlan) {
 				spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
 				goto createbss_cmd_fail;
 			}
diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index 5cfde7176617..8c11daff2d59 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -370,7 +370,7 @@ u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_s
 	struct	mlme_priv 	*pmlmepriv = &padapter->mlmepriv;
 	u8 res = true;
 
-	if (padapter == NULL) {
+	if (!padapter) {
 		res = false;
 		goto exit;
 	}
@@ -481,7 +481,7 @@ u16 rtw_get_cur_max_rate(struct adapter *adapter)
 		return 0;
 
 	psta = rtw_get_stainfo(&adapter->stapriv, get_bssid(pmlmepriv));
-	if (psta == NULL)
+	if (!psta)
 		return 0;
 
 	short_GI = query_ra_short_GI(psta);
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index ab6a24d70cc9..403a09ed66d5 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -439,7 +439,7 @@ struct	wlan_network	*rtw_get_oldest_wlan_network(struct __queue *scanned_queue)
 		pwlan = list_entry(plist, struct wlan_network, list);
 
 		if (!pwlan->fixed) {
-			if (oldest == NULL || time_after(oldest->last_scanned, pwlan->last_scanned))
+			if (!oldest || time_after(oldest->last_scanned, pwlan->last_scanned))
 				oldest = pwlan;
 		}
 	}
@@ -542,7 +542,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 			/* TODO: don't select network in the same ess as oldest if it's new enough*/
 		}
 
-		if (oldest == NULL || time_after(oldest->last_scanned, pnetwork->last_scanned))
+		if (!oldest || time_after(oldest->last_scanned, pnetwork->last_scanned))
 			oldest = pnetwork;
 
 	}
@@ -1820,7 +1820,7 @@ static int rtw_check_join_candidate(struct mlme_priv *mlme
 			goto exit;
 	}
 
-	if (*candidate == NULL || (*candidate)->network.rssi < competitor->network.rssi) {
+	if (!*candidate || (*candidate)->network.rssi < competitor->network.rssi) {
 		*candidate = competitor;
 		updated = true;
 	}
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 375d2a742dd2..b6c9ea7b793b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -742,11 +742,11 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 	}
 
 	pstat = rtw_get_stainfo(pstapriv, sa);
-	if (pstat == NULL) {
+	if (!pstat) {
 
 		/*  allocate a new one */
 		pstat = rtw_alloc_stainfo(pstapriv, sa);
-		if (pstat == NULL) {
+		if (!pstat) {
 			status = WLAN_STATUS_AP_UNABLE_TO_HANDLE_NEW_STA;
 			goto auth_fail;
 		}
@@ -814,7 +814,7 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + 4 + _AUTH_IE_OFFSET_, WLAN_EID_CHALLENGE, (int *)&ie_len,
 					len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_ - 4);
 
-			if ((p == NULL) || (ie_len <= 0)) {
+			if (!p || ie_len <= 0) {
 				status = WLAN_STATUS_CHALLENGE_FAIL;
 				goto auth_fail;
 			}
@@ -1034,7 +1034,7 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 
 	/*  check if the supported rate is ok */
 	p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, WLAN_EID_SUPP_RATES, &ie_len, pkt_len - WLAN_HDR_A3_LEN - ie_offset);
-	if (p == NULL) {
+	if (!p) {
 		/*  use our own rate set as statoin used */
 		/* memcpy(supportRate, AP_BSSRATE, AP_BSSRATE_LEN); */
 		/* supportRateNum = AP_BSSRATE_LEN; */
@@ -1047,7 +1047,7 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 
 		p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, WLAN_EID_EXT_SUPP_RATES, &ie_len,
 				pkt_len - WLAN_HDR_A3_LEN - ie_offset);
-		if (p !=  NULL) {
+		if (p) {
 
 			if (supportRateNum <= sizeof(supportRate)) {
 				memcpy(supportRate+supportRateNum, p+2, ie_len);
@@ -1294,7 +1294,7 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 	/* get a unique AID */
 	if (pstat->aid == 0) {
 		for (pstat->aid = 1; pstat->aid <= NUM_STA; pstat->aid++)
-			if (pstapriv->sta_aid[pstat->aid - 1] == NULL)
+			if (!pstapriv->sta_aid[pstat->aid - 1])
 				break;
 
 		/* if (pstat->aid > NUM_STA) { */
@@ -1944,7 +1944,7 @@ static struct xmit_frame *_alloc_mgtxmitframe(struct xmit_priv *pxmitpriv, bool
 		goto exit;
 
 	pxmitbuf = rtw_alloc_xmitbuf_ext(pxmitpriv);
-	if (pxmitbuf == NULL) {
+	if (!pxmitbuf) {
 		rtw_free_xmitframe(pxmitpriv, pmgntframe);
 		pmgntframe = NULL;
 		goto exit;
@@ -2297,7 +2297,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 	struct wlan_bssid_ex		*cur_network = &(pmlmeinfo->network);
 	unsigned int	rate_len;
 
-	if (da == NULL)
+	if (!da)
 		return;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
@@ -2621,7 +2621,7 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 	__le16 le_tmp;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		return;
 
 	/* update attribute */
@@ -2752,7 +2752,7 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 	__le16 lestatus, le_tmp;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		return;
 
 	/* update attribute */
@@ -2840,7 +2840,7 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 				break;
 			}
 
-			if ((pbuf == NULL) || (ie_len == 0)) {
+			if (!pbuf || ie_len == 0) {
 				break;
 			}
 		}
@@ -2884,7 +2884,7 @@ void issue_assocreq(struct adapter *padapter)
 	u8 vs_ie_length = 0;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		goto exit;
 
 	/* update attribute */
@@ -3061,7 +3061,7 @@ static int _issue_nulldata(struct adapter *padapter, unsigned char *da,
 	pmlmeinfo = &(pmlmeext->mlmext_info);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		goto exit;
 
 	/* update attribute */
@@ -3200,7 +3200,7 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da,
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		goto exit;
 
 	/* update attribute */
@@ -3313,7 +3313,7 @@ static int _issue_deauth(struct adapter *padapter, unsigned char *da,
 	__le16 le_tmp;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL) {
+	if (!pmgntframe) {
 		goto exit;
 	}
 
@@ -3639,7 +3639,7 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 	action = ACT_PUBLIC_BSSCOEXIST;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL) {
+	if (!pmgntframe) {
 		return;
 	}
 
@@ -3706,7 +3706,7 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 			pbss_network = (struct wlan_bssid_ex *)&pnetwork->network;
 
 			p = rtw_get_ie(pbss_network->ies + _FIXED_IE_LENGTH_, WLAN_EID_HT_CAPABILITY, &len, pbss_network->ie_length - _FIXED_IE_LENGTH_);
-			if ((p == NULL) || (len == 0)) {/* non-HT */
+			if (!p || len == 0) {/* non-HT */
 
 				if (pbss_network->configuration.ds_config <= 0)
 					continue;
@@ -3769,7 +3769,7 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 			return _SUCCESS;
 
 	psta = rtw_get_stainfo(pstapriv, addr);
-	if (psta == NULL)
+	if (!psta)
 		return _SUCCESS;
 
 	if (initiator == 0) {/*  recipient */
@@ -4641,13 +4641,13 @@ void report_del_sta_event(struct adapter *padapter, unsigned char *MacAddr, unsi
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
 	pcmd_obj = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (pcmd_obj == NULL) {
+	if (!pcmd_obj) {
 		return;
 	}
 
 	cmdsz = (sizeof(struct stadel_event) + sizeof(struct C2HEvent_Header));
 	pevtcmd = rtw_zmalloc(cmdsz);
-	if (pevtcmd == NULL) {
+	if (!pevtcmd) {
 		kfree(pcmd_obj);
 		return;
 	}
@@ -4693,12 +4693,12 @@ void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr, int
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
 	pcmd_obj = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (pcmd_obj == NULL)
+	if (!pcmd_obj)
 		return;
 
 	cmdsz = (sizeof(struct stassoc_event) + sizeof(struct C2HEvent_Header));
 	pevtcmd = rtw_zmalloc(cmdsz);
-	if (pevtcmd == NULL) {
+	if (!pevtcmd) {
 		kfree(pcmd_obj);
 		return;
 	}
@@ -5147,12 +5147,12 @@ void survey_timer_hdl(struct timer_list *t)
 		}
 
 		ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-		if (ph2c == NULL) {
+		if (!ph2c) {
 			goto exit_survey_timer_hdl;
 		}
 
 		psurveyPara = rtw_zmalloc(sizeof(struct sitesurvey_parm));
-		if (psurveyPara == NULL) {
+		if (!psurveyPara) {
 			kfree(ph2c);
 			goto exit_survey_timer_hdl;
 		}
@@ -5781,7 +5781,7 @@ u8 chk_bmc_sleepq_cmd(struct adapter *padapter)
 	u8 res = _SUCCESS;
 
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -5805,13 +5805,13 @@ u8 set_tx_beacon_cmd(struct adapter *padapter)
 	int len_diff = 0;
 
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	ptxBeacon_parm = rtw_zmalloc(sizeof(struct Tx_Beacon_param));
-	if (ptxBeacon_parm == NULL) {
+	if (!ptxBeacon_parm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -5871,7 +5871,7 @@ u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
 	void (*event_callback)(struct adapter *dev, u8 *pbuf);
 	struct evt_priv *pevt_priv = &(padapter->evtpriv);
 
-	if (pbuf == NULL)
+	if (!pbuf)
 		goto _abort_event_;
 
 	peventbuf = (uint *)pbuf;
diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index b050bf62e3b9..ac731415f733 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -51,7 +51,7 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 	struct arc4_ctx *ctx = &psecuritypriv->xmit_arc4_ctx;
 
-	if (((struct xmit_frame *)pxmitframe)->buf_addr == NULL)
+	if (!((struct xmit_frame *)pxmitframe)->buf_addr)
 		return;
 
 	hw_hdr_offset = TXDESC_OFFSET;
@@ -476,7 +476,7 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 	struct arc4_ctx *ctx = &psecuritypriv->xmit_arc4_ctx;
 	u32 res = _SUCCESS;
 
-	if (((struct xmit_frame *)pxmitframe)->buf_addr == NULL)
+	if (!((struct xmit_frame *)pxmitframe)->buf_addr)
 		return _FAIL;
 
 	hw_hdr_offset = TXDESC_OFFSET;
@@ -1043,7 +1043,7 @@ u32 rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 	u32 res = _SUCCESS;
 
-	if (((struct xmit_frame *)pxmitframe)->buf_addr == NULL)
+	if (!((struct xmit_frame *)pxmitframe)->buf_addr)
 		return _FAIL;
 
 	hw_hdr_offset = TXDESC_OFFSET;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 499ac3a77512..34da8a569709 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -391,7 +391,7 @@ void rtw_cfg80211_ibss_indicate_connect(struct adapter *padapter)
 		}
 		else
 		{
-			if (scanned == NULL) {
+			if (!scanned) {
 				rtw_warn_on(1);
 				return;
 			}
@@ -432,7 +432,7 @@ void rtw_cfg80211_indicate_connect(struct adapter *padapter)
 		struct wlan_bssid_ex  *pnetwork = &(padapter->mlmeextpriv.mlmext_info.network);
 		struct wlan_network *scanned = pmlmepriv->cur_network_scanned;
 
-		if (scanned == NULL) {
+		if (!scanned) {
 			rtw_warn_on(1);
 			goto check_bss;
 		}
@@ -551,10 +551,10 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 			goto exit;
 	}
 
-	if (strcmp(param->u.crypt.alg, "none") == 0 && (psta == NULL))
+	if (strcmp(param->u.crypt.alg, "none") == 0 && !psta)
 		goto exit;
 
-	if (strcmp(param->u.crypt.alg, "WEP") == 0 && (psta == NULL))
+	if (strcmp(param->u.crypt.alg, "WEP") == 0 && !psta)
 	{
 		wep_key_idx = param->u.crypt.idx;
 		wep_key_len = param->u.crypt.key_len;
@@ -907,7 +907,7 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 			}
 
 			pbcmc_sta = rtw_get_bcmc_stainfo(padapter);
-			if (pbcmc_sta == NULL)
+			if (!pbcmc_sta)
 			{
 				/* DEBUG_ERR(("Set OID_802_11_ADD_KEY: bcmc stainfo is null\n")); */
 			}
@@ -947,7 +947,7 @@ static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,
 
 	param_len = sizeof(struct ieee_param) + params->key_len;
 	param = rtw_malloc(param_len);
-	if (param == NULL)
+	if (!param)
 		return -1;
 
 	memset(param, 0, param_len);
@@ -1098,7 +1098,7 @@ static int cfg80211_rtw_get_station(struct wiphy *wiphy,
 	}
 
 	psta = rtw_get_stainfo(pstapriv, (u8 *)mac);
-	if (psta == NULL) {
+	if (!psta) {
 		ret = -ENOENT;
 		goto exit;
 	}
@@ -1327,7 +1327,7 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	struct rtw_wdev_priv *pwdev_priv;
 	struct mlme_priv *pmlmepriv;
 
-	if (ndev == NULL) {
+	if (!ndev) {
 		ret = -EINVAL;
 		goto exit;
 	}
@@ -1571,7 +1571,7 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 	u8 *pwpa, *pwpa2;
 	u8 null_addr[] = {0, 0, 0, 0, 0, 0};
 
-	if (pie == NULL || !ielen) {
+	if (!pie || !ielen) {
 		/* Treat this as normal case, but need to clear WIFI_UNDER_WPS */
 		_clr_fwstate_(&padapter->mlmepriv, WIFI_UNDER_WPS);
 		goto exit;
@@ -1583,7 +1583,7 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 	}
 
 	buf = rtw_zmalloc(ielen);
-	if (buf == NULL) {
+	if (!buf) {
 		ret =  -ENOMEM;
 		goto exit;
 	}
@@ -1873,7 +1873,7 @@ static int cfg80211_rtw_connect(struct wiphy *wiphy, struct net_device *ndev,
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, key_material);
 			pwep = rtw_malloc(wep_total_len);
-			if (pwep == NULL) {
+			if (!pwep) {
 				ret = -ENOMEM;
 				goto exit;
 			}
@@ -2708,7 +2708,7 @@ static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy,
 	struct adapter *padapter;
 	struct rtw_wdev_priv *pwdev_priv;
 
-	if (ndev == NULL) {
+	if (!ndev) {
 		ret = -EINVAL;
 		goto exit;
 	}
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 9d4a233a861e..908022a17b3f 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -153,7 +153,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 		if (check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_MP_STATE) == true) { /* sta mode */
 			psta = rtw_get_stainfo(pstapriv, get_bssid(pmlmepriv));
-			if (psta == NULL) {
+			if (!psta) {
 				/* DEBUG_ERR(("Set wpa_set_encryption: Obtain Sta_info fail\n")); */
 			} else {
 				/* Jeff: don't disable ieee8021x_blocked while clearing key */
@@ -206,7 +206,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 			}
 
 			pbcmc_sta = rtw_get_bcmc_stainfo(padapter);
-			if (pbcmc_sta == NULL) {
+			if (!pbcmc_sta) {
 				/* DEBUG_ERR(("Set OID_802_11_ADD_KEY: bcmc stainfo is null\n")); */
 			} else {
 				/* Jeff: don't disable ieee8021x_blocked while clearing key */
@@ -236,9 +236,9 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 	int ret = 0;
 	u8 null_addr[] = {0, 0, 0, 0, 0, 0};
 
-	if ((ielen > MAX_WPA_IE_LEN) || (pie == NULL)) {
+	if (ielen > MAX_WPA_IE_LEN || !pie) {
 		_clr_fwstate_(&padapter->mlmepriv, WIFI_UNDER_WPS);
-		if (pie == NULL)
+		if (!pie)
 			return ret;
 		else
 			return -EINVAL;
@@ -246,7 +246,7 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 
 	if (ielen) {
 		buf = rtw_zmalloc(ielen);
-		if (buf == NULL) {
+		if (!buf) {
 			ret =  -ENOMEM;
 			goto exit;
 		}
@@ -491,7 +491,7 @@ static int wpa_supplicant_ioctl(struct net_device *dev, struct iw_point *p)
 		return -EINVAL;
 
 	param = rtw_malloc(p->length);
-	if (param == NULL)
+	if (!param)
 		return -ENOMEM;
 
 	if (copy_from_user(param, p->pointer, p->length)) {
@@ -571,7 +571,7 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 			goto exit;
 	}
 
-	if (strcmp(param->u.crypt.alg, "none") == 0 && (psta == NULL)) {
+	if (strcmp(param->u.crypt.alg, "none") == 0 && !psta) {
 		/* todo:clear default encryption keys */
 
 		psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
@@ -583,7 +583,7 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 	}
 
 
-	if (strcmp(param->u.crypt.alg, "WEP") == 0 && (psta == NULL)) {
+	if (strcmp(param->u.crypt.alg, "WEP") == 0 && !psta) {
 		wep_key_idx = param->u.crypt.idx;
 		wep_key_len = param->u.crypt.key_len;
 
@@ -1229,7 +1229,7 @@ static int rtw_hostapd_ioctl(struct net_device *dev, struct iw_point *p)
 		return -EINVAL;
 
 	param = rtw_malloc(p->length);
-	if (param == NULL)
+	if (!param)
 		return -ENOMEM;
 
 	if (copy_from_user(param, p->pointer, p->length)) {
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index f78bf174de8e..1b8b76f14740 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -488,7 +488,7 @@ void rtw_unregister_netdevs(struct dvobj_priv *dvobj)
 
 	padapter = dvobj->padapters;
 
-	if (padapter == NULL)
+	if (!padapter)
 		return;
 
 	pnetdev = padapter->pnetdev;
@@ -594,7 +594,7 @@ struct dvobj_priv *devobj_init(void)
 	struct dvobj_priv *pdvobj = NULL;
 
 	pdvobj = rtw_zmalloc(sizeof(*pdvobj));
-	if (pdvobj == NULL)
+	if (!pdvobj)
 		return NULL;
 
 	mutex_init(&pdvobj->hw_init_mutex);
-- 
2.33.0

