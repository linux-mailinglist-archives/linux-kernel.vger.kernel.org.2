Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBF53DB900
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 15:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbhG3NCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 09:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhG3NCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 09:02:48 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793E4C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 06:02:43 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so3714404wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 06:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1lTphDnFtXTn69K1uTByCl1I1cLhGd9B5IYrL1/J8es=;
        b=HJZcYazDcYYPPJCELjsStPl/025/gV+zsZdrZnpOlH9CeQ5gQkqN5GkLWo0+qfYJqy
         YU9ZZmtBaT8PxzO7tD/7lmI0fQtL40Dl/1jGUOs1gGPguZLQqYnI1QoY8ap2Jtqp8fiV
         h3a2ilA0uMZ/0GUxJqvgdK811X4/t8yiAE5M/rj/9z0aIhV4IfwWJlqoCUiuroPx2Hd+
         PP6+ZxYCNrY+es6EjEIUz1FGsJheZE1gZxsgND82kUK2RT8J0XL/ccZxMICpivbbdSs5
         MjhSq8/6KMVK/VmNoMlKTaNYhj7cXZuq1xdSBEXR7IDidh4xg6SmYXmz+vFFs2gel4Ui
         +RAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1lTphDnFtXTn69K1uTByCl1I1cLhGd9B5IYrL1/J8es=;
        b=oFS6nx4lkq+Psnij5C9StnWquh/+IdfKTF5M6q1+/C4/WMJ3f39UQMZjP1kVKK1KQd
         z7DXNpfZr+TGVnUqoPLcKszjH8k2Ga/7vbz6f9lnlsdAIMTHmm0Ui8K9OgpEyOW/PteR
         1bAKz8KfIDjaUowEh1FvKPI8tNiooOU037qACpHgkC9zP4h84H3LjrQNdoRgJTCfJr2t
         O5ZIrhc4PDeNPYBw/4DvsF6B9RjRYmB7MPDT9V0a1yPp4Pkt61pWNyYw6n7k9/WW/u5q
         lpu2G43fb8jcF1yH0i+YmQtO5aXAojI2Abfi9YK7+cEWUlgqKs3YHE+HjGP2fXNiLmEg
         jUCQ==
X-Gm-Message-State: AOAM530uzuPOZnayyTeCvVWV7bBI9220KCwuF9AoCA0jwGkIOoVHhOoz
        DWveLkO5cZMXfRSlgltw9QU=
X-Google-Smtp-Source: ABdhPJxZHvZboQoAQnaW7UxfXWsb4xJYoEMgfur3b8fZha1nUoqBaQP1G47cht+qGrY0+67v/9nz7w==
X-Received: by 2002:a1c:a74f:: with SMTP id q76mr2743294wme.112.1627650161866;
        Fri, 30 Jul 2021 06:02:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4bf9])
        by smtp.gmail.com with ESMTPSA id h15sm1612280wrq.88.2021.07.30.06.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 06:02:41 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: clean up comparsions to NULL in os_dep directory
Date:   Fri, 30 Jul 2021 15:02:04 +0200
Message-Id: <20210730130204.18229-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up comparsions to NULL in the os_dep directory reported by
checkpatch.

x == NULL -> !x
x != NULL -> x

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 108 +++++++++---------
 drivers/staging/r8188eu/os_dep/mlme_linux.c   |   4 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  12 +-
 .../staging/r8188eu/os_dep/osdep_service.c    |   6 +-
 drivers/staging/r8188eu/os_dep/recv_linux.c   |   4 +-
 drivers/staging/r8188eu/os_dep/usb_intf.c     |  12 +-
 drivers/staging/r8188eu/os_dep/xmit_linux.c   |   4 +-
 7 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 109389549435..100369a79666 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -523,7 +523,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
 			pwep = (struct ndis_802_11_wep *)rtw_malloc(wep_total_len);
-			if (pwep == NULL) {
+			if (!pwep) {
 				RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, (" wpa_set_encryption: pwep allocate fail !!!\n"));
 				goto exit;
 			}
@@ -564,7 +564,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 		if (check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_MP_STATE)) { /* sta mode */
 			psta = rtw_get_stainfo(pstapriv, get_bssid(pmlmepriv));
-			if (psta == NULL) {
+			if (!psta) {
 				;
 			} else {
 				if (strcmp(param->u.crypt.alg, "none") != 0)
@@ -603,7 +603,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 				}
 			}
 			pbcmc_sta = rtw_get_bcmc_stainfo(padapter);
-			if (pbcmc_sta == NULL) {
+			if (!pbcmc_sta) {
 				;
 			} else {
 				/* Jeff: don't disable ieee8021x_blocked while clearing key */
@@ -633,9 +633,9 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 #endif /* CONFIG_88EU_P2P */
 
-	if ((ielen > MAX_WPA_IE_LEN) || (pie == NULL)) {
+	if (ielen > MAX_WPA_IE_LEN || !pie) {
 		_clr_fwstate_(&padapter->mlmepriv, WIFI_UNDER_WPS);
-		if (pie == NULL)
+		if (!pie)
 			return ret;
 		else
 			return -EINVAL;
@@ -643,7 +643,7 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 
 	if (ielen) {
 		buf = rtw_zmalloc(ielen);
-		if (buf == NULL) {
+		if (!buf) {
 			ret =  -ENOMEM;
 			goto exit;
 		}
@@ -1217,7 +1217,7 @@ static int rtw_wx_set_mlme(struct net_device *dev,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct iw_mlme *mlme = (struct iw_mlme *)extra;
 
-	if (mlme == NULL)
+	if (!mlme)
 		return -1;
 
 	DBG_88E("%s\n", __func__);
@@ -2110,7 +2110,7 @@ static int rtw_wx_set_enc_ext(struct net_device *dev,
 
 	param_len = sizeof(struct ieee_param) + pext->key_len;
 	param = (struct ieee_param *)rtw_malloc(param_len);
-	if (param == NULL)
+	if (!param)
 		return -1;
 
 	memset(param, 0, param_len);
@@ -2465,7 +2465,7 @@ static int rtw_mp_ioctl_hdl(struct net_device *dev, struct iw_request_info *info
 	bset = (u8)(p->flags & 0xFFFF);
 	len = p->length;
 	pparmbuf = (u8 *)rtw_malloc(len);
-	if (pparmbuf == NULL) {
+	if (!pparmbuf) {
 		ret = -ENOMEM;
 		goto _rtw_mp_ioctl_hdl_exit;
 	}
@@ -2562,7 +2562,7 @@ static int rtw_get_ap_info(struct net_device *dev,
 
 	DBG_88E("+rtw_get_aplist_info\n");
 
-	if ((padapter->bDriverStopped) || (pdata == NULL)) {
+	if (padapter->bDriverStopped || !pdata) {
 		ret = -EINVAL;
 		goto exit;
 	}
@@ -2641,7 +2641,7 @@ static int rtw_set_pid(struct net_device *dev,
 	int *pdata = (int *)wrqu;
 	int selector;
 
-	if ((padapter->bDriverStopped) || (pdata == NULL)) {
+	if (padapter->bDriverStopped || !pdata) {
 		ret = -EINVAL;
 		goto exit;
 	}
@@ -2673,7 +2673,7 @@ static int rtw_wps_start(struct net_device *dev,
 		goto exit;
 	}
 
-	if ((padapter->bDriverStopped) || (pdata == NULL)) {
+	if (padapter->bDriverStopped || !pdata) {
 		ret = -EINVAL;
 		goto exit;
 	}
@@ -4161,7 +4161,7 @@ static int rtw_dbg_port(struct net_device *dev,
 			struct xmit_frame	*xmit_frame;
 
 			xmit_frame = rtw_IOL_accquire_xmit_frame(padapter);
-			if (xmit_frame == NULL) {
+			if (!xmit_frame) {
 				ret = -ENOMEM;
 				break;
 			}
@@ -4181,7 +4181,7 @@ static int rtw_dbg_port(struct net_device *dev,
 			struct xmit_frame	*xmit_frame;
 
 			xmit_frame = rtw_IOL_accquire_xmit_frame(padapter);
-			if (xmit_frame == NULL) {
+			if (!xmit_frame) {
 				ret = -ENOMEM;
 				break;
 			}
@@ -4207,7 +4207,7 @@ static int rtw_dbg_port(struct net_device *dev,
 			struct xmit_frame	*xmit_frame;
 
 			xmit_frame = rtw_IOL_accquire_xmit_frame(padapter);
-			if (xmit_frame == NULL) {
+			if (!xmit_frame) {
 				ret = -ENOMEM;
 				break;
 			}
@@ -4236,7 +4236,7 @@ static int rtw_dbg_port(struct net_device *dev,
 			struct xmit_frame	*xmit_frame;
 
 			xmit_frame = rtw_IOL_accquire_xmit_frame(padapter);
-			if (xmit_frame == NULL) {
+			if (!xmit_frame) {
 				ret = -ENOMEM;
 				break;
 			}
@@ -4264,7 +4264,7 @@ static int rtw_dbg_port(struct net_device *dev,
 			struct xmit_frame	*xmit_frame;
 
 			xmit_frame = rtw_IOL_accquire_xmit_frame(padapter);
-			if (xmit_frame == NULL) {
+			if (!xmit_frame) {
 				ret = -ENOMEM;
 				break;
 			}
@@ -4702,7 +4702,7 @@ static int wpa_supplicant_ioctl(struct net_device *dev, struct iw_point *p)
 	}
 
 	param = (struct ieee_param *)rtw_malloc(p->length);
-	if (param == NULL) {
+	if (!param) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -4756,13 +4756,13 @@ static u8 set_pairwise_key(struct adapter *padapter, struct sta_info *psta)
 	u8 res = _SUCCESS;
 
 	ph2c = (struct cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	psetstakey_para = (struct set_stakey_parm *)rtw_zmalloc(sizeof(struct set_stakey_parm));
-	if (psetstakey_para == NULL) {
+	if (!psetstakey_para) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -4794,12 +4794,12 @@ static int set_group_key(struct adapter *padapter, u8 *key, u8 alg, int keyid)
 	DBG_88E("%s\n", __func__);
 
 	pcmd = (struct cmd_obj *)rtw_zmalloc(sizeof(struct	cmd_obj));
-	if (pcmd == NULL) {
+	if (!pcmd) {
 		res = _FAIL;
 		goto exit;
 	}
 	psetkeyparm = (struct setkey_parm *)rtw_zmalloc(sizeof(struct setkey_parm));
-	if (psetkeyparm == NULL) {
+	if (!psetkeyparm) {
 		kfree(pcmd);
 		res = _FAIL;
 		goto exit;
@@ -4895,13 +4895,13 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 		}
 	}
 
-	if (strcmp(param->u.crypt.alg, "none") == 0 && (psta == NULL)) {
+	if (strcmp(param->u.crypt.alg, "none") == 0 && !psta) {
 		/* todo:clear default encryption keys */
 
 		DBG_88E("clear default encryption keys, keyid =%d\n", param->u.crypt.idx);
 		goto exit;
 	}
-	if (strcmp(param->u.crypt.alg, "WEP") == 0 && (psta == NULL)) {
+	if (strcmp(param->u.crypt.alg, "WEP") == 0 && !psta) {
 		DBG_88E("r871x_set_encryption, crypt.alg = WEP\n");
 		wep_key_idx = param->u.crypt.idx;
 		wep_key_len = param->u.crypt.key_len;
@@ -4915,7 +4915,7 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
 			pwep = (struct ndis_802_11_wep *)rtw_malloc(wep_total_len);
-			if (pwep == NULL) {
+			if (!pwep) {
 				DBG_88E(" r871x_set_encryption: pwep allocate fail !!!\n");
 				goto exit;
 			}
@@ -5344,7 +5344,7 @@ static int rtw_set_wps_beacon(struct net_device *dev, struct ieee_param *param,
 	if (ie_len > 0) {
 		pmlmepriv->wps_beacon_ie = rtw_malloc(ie_len);
 		pmlmepriv->wps_beacon_ie_len = ie_len;
-		if (pmlmepriv->wps_beacon_ie == NULL) {
+		if (!pmlmepriv->wps_beacon_ie) {
 			DBG_88E("%s()-%d: rtw_malloc() ERROR!\n", __func__, __LINE__);
 			return -EINVAL;
 		}
@@ -5381,7 +5381,7 @@ static int rtw_set_wps_probe_resp(struct net_device *dev, struct ieee_param *par
 	if (ie_len > 0) {
 		pmlmepriv->wps_probe_resp_ie = rtw_malloc(ie_len);
 		pmlmepriv->wps_probe_resp_ie_len = ie_len;
-		if (pmlmepriv->wps_probe_resp_ie == NULL) {
+		if (!pmlmepriv->wps_probe_resp_ie) {
 			DBG_88E("%s()-%d: rtw_malloc() ERROR!\n", __func__, __LINE__);
 			return -EINVAL;
 		}
@@ -5413,7 +5413,7 @@ static int rtw_set_wps_assoc_resp(struct net_device *dev, struct ieee_param *par
 	if (ie_len > 0) {
 		pmlmepriv->wps_assoc_resp_ie = rtw_malloc(ie_len);
 		pmlmepriv->wps_assoc_resp_ie_len = ie_len;
-		if (pmlmepriv->wps_assoc_resp_ie == NULL) {
+		if (!pmlmepriv->wps_assoc_resp_ie) {
 			DBG_88E("%s()-%d: rtw_malloc() ERROR!\n", __func__, __LINE__);
 			return -EINVAL;
 		}
@@ -5519,7 +5519,7 @@ static int rtw_hostapd_ioctl(struct net_device *dev, struct iw_point *p)
 	}
 
 	param = (struct ieee_param *)rtw_malloc(p->length);
-	if (param == NULL) {
+	if (!param) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -5629,7 +5629,7 @@ static int rtw_wx_set_priv(struct net_device *dev,
 			pmlmepriv->wps_probe_req_ie = NULL;
 
 			pmlmepriv->wps_probe_req_ie = rtw_malloc(cp_sz);
-			if (pmlmepriv->wps_probe_req_ie == NULL) {
+			if (!pmlmepriv->wps_probe_req_ie) {
 				pr_info("%s()-%d: rtw_malloc() ERROR!\n", __func__, __LINE__);
 				ret =  -EINVAL;
 				goto FREE_EXT;
@@ -5703,12 +5703,12 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 
 	err = 0;
 	data = _rtw_zmalloc(EFUSE_BT_MAX_MAP_LEN);
-	if (data == NULL) {
+	if (!data) {
 		err = -ENOMEM;
 		goto exit;
 	}
 	rawdata = _rtw_zmalloc(EFUSE_BT_MAX_MAP_LEN);
-	if (rawdata == NULL) {
+	if (!rawdata) {
 		err = -ENOMEM;
 		goto exit;
 	}
@@ -5772,7 +5772,7 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 			sprintf(extra + strlen(extra), "\n");
 		}
 	} else if (strcmp(tmp[0], "rmap") == 0) {
-		if ((tmp[1] == NULL) || (tmp[2] == NULL)) {
+		if (!tmp[1] || !tmp[2]) {
 			DBG_88E("%s: rmap Fail!! Parameters error!\n", __func__);
 			err = -EINVAL;
 			goto exit;
@@ -5911,7 +5911,7 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 			sprintf(extra + strlen(extra), "\n");
 		}
 	} else if (strcmp(tmp[0], "btrmap") == 0) {
-		if ((tmp[1] == NULL) || (tmp[2] == NULL)) {
+		if (!tmp[1] || !tmp[2]) {
 			err = -EINVAL;
 			goto exit;
 		}
@@ -6018,22 +6018,22 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 	pEfuseHal = &haldata->EfuseHal;
 	err = 0;
 	setdata = _rtw_zmalloc(1024);
-	if (setdata == NULL) {
+	if (!setdata) {
 		err = -ENOMEM;
 		goto exit;
 	}
 	ShadowMapBT = _rtw_malloc(EFUSE_BT_MAX_MAP_LEN);
-	if (ShadowMapBT == NULL) {
+	if (!ShadowMapBT) {
 		err = -ENOMEM;
 		goto exit;
 	}
 	ShadowMapWiFi = _rtw_malloc(EFUSE_MAP_SIZE);
-	if (ShadowMapWiFi == NULL) {
+	if (!ShadowMapWiFi) {
 		err = -ENOMEM;
 		goto exit;
 	}
 	setrawdata = _rtw_malloc(EFUSE_MAX_SIZE);
-	if (setrawdata == NULL) {
+	if (!setrawdata) {
 		err = -ENOMEM;
 		goto exit;
 	}
@@ -6058,7 +6058,7 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 	/*  tmp[0],[1],[2] */
 	/*  wmap, addr, 00e04c871200 */
 	if (strcmp(tmp[0], "wmap") == 0) {
-		if ((tmp[1] == NULL) || (tmp[2] == NULL)) {
+		if (!tmp[1] || !tmp[2]) {
 			err = -EINVAL;
 			goto exit;
 		}
@@ -6097,7 +6097,7 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 			goto exit;
 		}
 	} else if (strcmp(tmp[0], "wraw") == 0) {
-		if ((tmp[1] == NULL) || (tmp[2] == NULL)) {
+		if (!tmp[1] || !tmp[2]) {
 			err = -EINVAL;
 			goto exit;
 		}
@@ -6129,7 +6129,7 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 			goto exit;
 		}
 	} else if (strcmp(tmp[0], "mac") == 0) {
-		if (tmp[1] == NULL) {
+		if (!tmp[1]) {
 			err = -EINVAL;
 			goto exit;
 		}
@@ -6172,7 +6172,7 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 			goto exit;
 		}
 	} else if (strcmp(tmp[0], "vidpid") == 0) {
-		if (tmp[1] == NULL) {
+		if (!tmp[1]) {
 			err = -EINVAL;
 			goto exit;
 		}
@@ -6210,7 +6210,7 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 			goto exit;
 		}
 	} else if (strcmp(tmp[0], "btwmap") == 0) {
-		if ((tmp[1] == NULL) || (tmp[2] == NULL)) {
+		if (!tmp[1] || !tmp[2]) {
 			err = -EINVAL;
 			goto exit;
 		}
@@ -6249,7 +6249,7 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 			goto exit;
 		}
 	} else if (strcmp(tmp[0], "btwfake") == 0) {
-		if ((tmp[1] == NULL) || (tmp[2] == NULL)) {
+		if (!tmp[1] || !tmp[2]) {
 			err = -EINVAL;
 			goto exit;
 		}
@@ -6315,7 +6315,7 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 			goto exit;
 		}
 	} else if (strcmp(tmp[0], "wlwfake") == 0) {
-		if ((tmp[1] == NULL) || (tmp[2] == NULL)) {
+		if (!tmp[1] || !tmp[2]) {
 			err = -EINVAL;
 			goto exit;
 		}
@@ -6376,14 +6376,14 @@ static int rtw_mp_write_reg(struct net_device *dev,
 
 	pch = extra;
 	pnext = strpbrk(pch, ",.-");
-	if (pnext == NULL)
+	if (!pnext)
 		return -EINVAL;
 	*pnext = 0;
 	width_str = pch;
 
 	pch = pnext + 1;
 	pnext = strpbrk(pch, ",.-");
-	if (pnext == NULL)
+	if (!pnext)
 		return -EINVAL;
 	*pnext = 0;
 	addr = simple_strtoul(pch, &ptmp, 16);
@@ -6462,7 +6462,7 @@ static int rtw_mp_read_reg(struct net_device *dev,
 
 	pch = input;
 	pnext = strpbrk(pch, ",.-");
-	if (pnext == NULL) {
+	if (!pnext) {
 		kfree(input);
 		return -EINVAL;
 	}
@@ -7350,10 +7350,10 @@ static int rtw_mp_set(struct net_device *dev,
 	u32 subcmd = wrqu->flags;
 	struct adapter *padapter = rtw_netdev_priv(dev);
 
-	if (padapter == NULL)
+	if (!padapter)
 		return -ENETDOWN;
 
-	if (extra == NULL) {
+	if (!extra) {
 		wrqu->length = 0;
 		return -EIO;
 	}
@@ -7396,9 +7396,9 @@ static int rtw_mp_get(struct net_device *dev,
 	u32 subcmd = wrqu->flags;
 	struct adapter *padapter = rtw_netdev_priv(dev);
 
-	if (padapter == NULL)
+	if (!padapter)
 		return -ENETDOWN;
-	if (extra == NULL) {
+	if (!extra) {
 		wrqu->length = 0;
 		return -EIO;
 	}
@@ -7515,7 +7515,7 @@ static int rtw_test(
 	len = wrqu->data.length;
 
 	pbuf = (u8 *)rtw_zmalloc(len);
-	if (pbuf == NULL) {
+	if (!pbuf) {
 		DBG_88E("%s: no memory!\n", __func__);
 		return -ENOMEM;
 	}
@@ -7529,7 +7529,7 @@ static int rtw_test(
 
 	ptmp = (char *)pbuf;
 	pch = strsep(&ptmp, delim);
-	if ((pch == NULL) || (strlen(pch) == 0)) {
+	if (!pch || strlen(pch) == 0) {
 		kfree(pbuf);
 		DBG_88E("%s: parameter error(level 1)!\n", __func__);
 		return -EFAULT;
diff --git a/drivers/staging/r8188eu/os_dep/mlme_linux.c b/drivers/staging/r8188eu/os_dep/mlme_linux.c
index 8d78b8697016..fe434c8c167c 100644
--- a/drivers/staging/r8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/r8188eu/os_dep/mlme_linux.c
@@ -178,7 +178,7 @@ void rtw_indicate_sta_assoc_event(struct adapter *padapter, struct sta_info *pst
 	union iwreq_data wrqu;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
-	if (psta == NULL)
+	if (!psta)
 		return;
 
 	if (psta->aid > NUM_STA)
@@ -201,7 +201,7 @@ void rtw_indicate_sta_disassoc_event(struct adapter *padapter, struct sta_info *
 	union iwreq_data wrqu;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
-	if (psta == NULL)
+	if (!psta)
 		return;
 
 	if (psta->aid > NUM_STA)
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index cf92dc2a4fcc..fa20d0f753db 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -175,11 +175,11 @@ void rtw_proc_init_one(struct net_device *dev)
 	struct adapter	*padapter = rtw_netdev_priv(dev);
 	u8 rf_type;
 
-	if (rtw_proc == NULL) {
+	if (!rtw_proc) {
 		memcpy(rtw_proc_name, DRV_NAME, sizeof(DRV_NAME));
 
 		rtw_proc = create_proc_entry(rtw_proc_name, S_IFDIR, init_net.proc_net);
-		if (rtw_proc == NULL) {
+		if (!rtw_proc) {
 			DBG_88E(KERN_ERR "Unable to create rtw_proc directory\n");
 			return;
 		}
@@ -191,12 +191,12 @@ void rtw_proc_init_one(struct net_device *dev)
 		}
 	}
 
-	if (padapter->dir_dev == NULL) {
+	if (!padapter->dir_dev) {
 		padapter->dir_dev = create_proc_entry(dev->name,
 					  S_IFDIR | S_IRUGO | S_IXUGO,
 					  rtw_proc);
 		dir_dev = padapter->dir_dev;
-		if (dir_dev == NULL) {
+		if (!dir_dev) {
 			if (rtw_proc_cnt == 0) {
 				if (rtw_proc) {
 					remove_proc_entry(rtw_proc_name, init_net.proc_net);
@@ -721,7 +721,7 @@ struct net_device *rtw_init_netdev(struct adapter *old_padapter)
 
 	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+init_net_dev\n"));
 
-	if (old_padapter != NULL)
+	if (old_padapter)
 		pnetdev = rtw_alloc_etherdev_with_old_priv(sizeof(struct adapter), (void *)old_padapter);
 	else
 		pnetdev = rtw_alloc_etherdev(sizeof(struct adapter));
@@ -1007,7 +1007,7 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
 	}
 
 	/*  clear pbuddystruct adapter to avoid access wrong pointer. */
-	if (padapter->pbuddy_adapter != NULL)
+	if (padapter->pbuddy_adapter)
 		padapter->pbuddy_adapter->pbuddy_adapter = NULL;
 
 	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-rtw_free_drv_sw\n"));
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index bec784dda81b..66db8d6907d2 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -48,7 +48,7 @@ inline u8 *_rtw_zvmalloc(u32 sz)
 {
 	u8	*pbuf;
 	pbuf = _rtw_vmalloc(sz);
-	if (pbuf != NULL)
+	if (pbuf)
 		memset(pbuf, 0, sz);
 	return pbuf;
 }
@@ -70,7 +70,7 @@ u8 *_rtw_zmalloc(u32 sz)
 {
 	u8	*pbuf = _rtw_malloc(sz);
 
-	if (pbuf != NULL)
+	if (pbuf)
 		memset(pbuf, 0, sz);
 	return pbuf;
 }
@@ -80,7 +80,7 @@ void *rtw_malloc2d(int h, int w, int size)
 	int j;
 
 	void **a = (void **)rtw_zmalloc(h*sizeof(void *) + h*w*size);
-	if (a == NULL) {
+	if (!a) {
 		pr_info("%s: alloc memory fail!\n", __func__);
 		return NULL;
 	}
diff --git a/drivers/staging/r8188eu/os_dep/recv_linux.c b/drivers/staging/r8188eu/os_dep/recv_linux.c
index 5af8ffac870b..410bfbb8a187 100644
--- a/drivers/staging/r8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/r8188eu/os_dep/recv_linux.c
@@ -42,7 +42,7 @@ int rtw_os_recvbuf_resource_alloc(struct adapter *padapter,
 
 	precvbuf->irp_pending = false;
 	precvbuf->purb = usb_alloc_urb(0, GFP_KERNEL);
-	if (precvbuf->purb == NULL)
+	if (!precvbuf->purb)
 		res = _FAIL;
 	precvbuf->pskb = NULL;
 	precvbuf->reuse = false;
@@ -118,7 +118,7 @@ int rtw_recv_indicatepkt(struct adapter *padapter,
 	pfree_recv_queue = &(precvpriv->free_recv_queue);
 
 	skb = precv_frame->pkt;
-	if (skb == NULL) {
+	if (!skb) {
 		RT_TRACE(_module_recv_osdep_c_, _drv_err_,
 			 ("rtw_recv_indicatepkt():skb == NULL something wrong!!!!\n"));
 		goto _recv_indicatepkt_drop;
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 7db33946e418..314a3504168e 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -120,7 +120,7 @@ static u8 rtw_init_intf_priv(struct dvobj_priv *dvobj)
 	_rtw_mutex_init(&dvobj->usb_vendor_req_mutex);
 
 	dvobj->usb_alloc_vendor_req_buf = rtw_zmalloc(MAX_USB_IO_CTL_SIZE);
-	if (dvobj->usb_alloc_vendor_req_buf == NULL) {
+	if (!dvobj->usb_alloc_vendor_req_buf) {
 		DBG_88E("alloc usb_vendor_req_buf failed... /n");
 		rst = _FAIL;
 		goto exit;
@@ -152,7 +152,7 @@ static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
 	struct usb_device	*pusbd;
 
 	pdvobjpriv = (struct dvobj_priv *)rtw_zmalloc(sizeof(*pdvobjpriv));
-	if (pdvobjpriv == NULL)
+	if (!pdvobjpriv)
 		goto exit;
 
 	pdvobjpriv->pusbintf = usb_intf;
@@ -603,7 +603,7 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 	int status = _FAIL;
 
 	padapter = (struct adapter *)rtw_zvmalloc(sizeof(*padapter));
-	if (padapter == NULL)
+	if (!padapter)
 		goto exit;
 	padapter->dvobj = dvobj;
 	dvobj->if1 = padapter;
@@ -620,7 +620,7 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 		goto free_adapter;
 
 	pnetdev = rtw_init_netdev(padapter);
-	if (pnetdev == NULL)
+	if (!pnetdev)
 		goto handle_dualmac;
 	SET_NETDEV_DEV(pnetdev, dvobj_to_dev(dvobj));
 	padapter = rtw_netdev_priv(pnetdev);
@@ -753,14 +753,14 @@ static int rtw_drv_init(struct usb_interface *pusb_intf, const struct usb_device
 
 	/* Initialize dvobj_priv */
 	dvobj = usb_dvobj_init(pusb_intf);
-	if (dvobj == NULL) {
+	if (!dvobj) {
 		RT_TRACE(_module_hci_intfs_c_, _drv_err_,
 			 ("initialize device object priv Failed!\n"));
 		goto exit;
 	}
 
 	if1 = rtw_usb_if1_init(dvobj, pusb_intf, pdid);
-	if (if1 == NULL) {
+	if (!if1) {
 		DBG_88E("rtw_init_primarystruct adapter Failed!\n");
 		goto free_dvobj;
 	}
diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index 622735148efb..c82ae1fdd0d2 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -78,7 +78,7 @@ int rtw_os_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitb
 	int i;
 
 	pxmitbuf->pallocated_buf = rtw_zmalloc(alloc_sz);
-	if (pxmitbuf->pallocated_buf == NULL)
+	if (!pxmitbuf->pallocated_buf)
 		return _FAIL;
 
 	pxmitbuf->pbuf = (u8 *)N_BYTE_ALIGMENT((size_t)(pxmitbuf->pallocated_buf), XMITBUF_ALIGN_SZ);
@@ -86,7 +86,7 @@ int rtw_os_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitb
 
 	for (i = 0; i < 8; i++) {
 		pxmitbuf->pxmit_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
-		if (pxmitbuf->pxmit_urb[i] == NULL) {
+		if (!pxmitbuf->pxmit_urb[i]) {
 			DBG_88E("pxmitbuf->pxmit_urb[i]==NULL");
 			return _FAIL;
 		}
-- 
2.32.0

