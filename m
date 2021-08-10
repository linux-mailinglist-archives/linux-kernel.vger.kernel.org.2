Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B75F3E86B8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 01:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbhHJXvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 19:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbhHJXvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 19:51:14 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A39C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:50:51 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b11so369822wrx.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tCTP03mY/iXkXmTr0DBc8u0ZPTIj+YLf0lcyQ3NSYyA=;
        b=WUzVXMXeoOSj6WIoXrK6ew055xEaCkG8MHh3oeiXp4F4HXQxPHYryprcxReHl14qVM
         lG4aIJgO+0tEHlklC6CpvEL0llaLq1BKJiR/m2QOtPSmyqNtHupe6hFisdhIVLqL+ibR
         uCroDwgM8jAq+DgiDTxafPpj3UQ7eyoblxBk5GJPsBpV+vaOyfjILnc2Cg+icYnxADoo
         jRShm+nVRlcfK01fGYcybNWumALYsAdIT8LiIwRjkWwtnFDHjMwciSnhBTIlvdHNeJoh
         fHRlHwxaRvrchQ2MKYDxIb+Yr45jTGWmqHsi57TDQn2N+ttgYG9tEbUqJc0DwLZkqa1W
         lgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tCTP03mY/iXkXmTr0DBc8u0ZPTIj+YLf0lcyQ3NSYyA=;
        b=cDO9nYfNfuj9O400EW93wgVQORI9oq/Gdiq+sabVeoSSqKuoOggYELmiBdb9Ws8J+G
         uSM2o3555nW553nN1crvnqfHE7+wd1ZXO9OqTeba3tU6WopQL2Ly9B8YXUnhOeM5Y4YH
         62FFWA31rx4A04jTarPpV3Axap7jGk9mVc0Tn/frPxjeT0E3oJgqeZI8Tg+H2uUh7ROD
         rgL23Hdu3uBClPBkzU5p1dzpggXNRzungUFW45Bn7bTew8hAoUeUB1vjeV5FKVVnnNxr
         Fq+9EK7F20So3w0MH/pTSdthi1Bo2nUY62ixMJtn9+n6Be2LotID7h7Ptd4Q1pDVVmV0
         v+uw==
X-Gm-Message-State: AOAM531Ez+leBQkOsrl7PnsB4CiRgFa9SqlJJfUieMNf8W6meAAgxVTv
        SzJsQsvy9Z3h+h2ASwmgOfQ0NQ==
X-Google-Smtp-Source: ABdhPJyegAEN/vivc7Ad1GQayfS5Qkuq/6VsLk0R2mh9MllFfW5UtBq1h9r+TpfH+Iz0Oe2hLSZr4g==
X-Received: by 2002:a5d:5090:: with SMTP id a16mr33592894wrt.21.1628639449952;
        Tue, 10 Aug 2021 16:50:49 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id p14sm13881220wro.3.2021.08.10.16.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 16:50:49 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] staging: r8188eu: remove unused functions from os_dep/ioctl_linux.c
Date:   Wed, 11 Aug 2021 00:50:40 +0100
Message-Id: <20210810235047.177883-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810235047.177883-1-phil@philpotter.co.uk>
References: <20210810235047.177883-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused functions that are now no longer called as a result of the
removal of rtw_ioctl in a previous patch. This includes functions not
directly called from rtw_ioctl, but anything in that specific
call-chain.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 1538 ++----------------
 1 file changed, 127 insertions(+), 1411 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 4e21801cbfcf..1ccc5f8de1ee 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -1539,7 +1539,6 @@ static int rtw_wx_get_essid(struct net_device *dev,
 	wrqu->essid.length = len;
 	wrqu->essid.flags = 1;
 
-exit:
 	return ret;
 }
 
@@ -4508,1143 +4507,175 @@ static int rtw_dbg_port(struct net_device *dev,
 	return ret;
 }
 
-static int wpa_set_param(struct net_device *dev, u8 name, u32 value)
-{
-	uint ret = 0;
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-
-	switch (name) {
-	case IEEE_PARAM_WPA_ENABLED:
-		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_8021X; /* 802.1x */
-		switch ((value)&0xff) {
-		case 1: /* WPA */
-			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPAPSK; /* WPA_PSK */
-			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption2Enabled;
-			break;
-		case 2: /* WPA2 */
-			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPA2PSK; /* WPA2_PSK */
-			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption3Enabled;
-			break;
-		}
-		break;
-	case IEEE_PARAM_TKIP_COUNTERMEASURES:
-		break;
-	case IEEE_PARAM_DROP_UNENCRYPTED: {
-		/* HACK:
-		 *
-		 * wpa_supplicant calls set_wpa_enabled when the driver
-		 * is loaded and unloaded, regardless of if WPA is being
-		 * used.  No other calls are made which can be used to
-		 * determine if encryption will be used or not prior to
-		 * association being expected.  If encryption is not being
-		 * used, drop_unencrypted is set to false, else true -- we
-		 * can use this to determine if the CAP_PRIVACY_ON bit should
-		 * be set.
-		 */
-
-		break;
-	}
-	case IEEE_PARAM_PRIVACY_INVOKED:
-		break;
-
-	case IEEE_PARAM_AUTH_ALGS:
-		ret = wpa_set_auth_algs(dev, value);
-		break;
-	case IEEE_PARAM_IEEE_802_1X:
-		break;
-	case IEEE_PARAM_WPAX_SELECT:
-		break;
-	default:
-		ret = -EOPNOTSUPP;
-		break;
-	}
-	return ret;
-}
-
-static int wpa_mlme(struct net_device *dev, u32 command, u32 reason)
+static int rtw_wx_set_priv(struct net_device *dev,
+				struct iw_request_info *info,
+				union iwreq_data *awrq,
+				char *extra)
 {
 	int ret = 0;
+	int len = 0;
+	char *ext;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
+	struct iw_point *dwrq = (struct iw_point *)awrq;
 
-	switch (command) {
-	case IEEE_MLME_STA_DEAUTH:
-		if (!rtw_set_802_11_disassociate(padapter))
-			ret = -1;
-		break;
-	case IEEE_MLME_STA_DISASSOC:
-		if (!rtw_set_802_11_disassociate(padapter))
-			ret = -1;
-		break;
-	default:
-		ret = -EOPNOTSUPP;
-		break;
-	}
-
-	return ret;
-}
-
-static int wpa_supplicant_ioctl(struct net_device *dev, struct iw_point *p)
-{
-	struct ieee_param *param;
-	uint ret = 0;
-
-	if (p->length < sizeof(struct ieee_param) || !p->pointer) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (dwrq->length == 0)
+		return -EFAULT;
 
-	param = kmalloc(p->length, GFP_KERNEL);
-	if (!param) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	len = dwrq->length;
+	ext = rtw_vmalloc(len);
+	if (!ext)
+		return -ENOMEM;
 
-	if (copy_from_user(param, p->pointer, p->length)) {
-		kfree(param);
-		ret = -EFAULT;
-		goto out;
+	if (copy_from_user(ext, dwrq->pointer, len)) {
+		vfree(ext);
+		return -EFAULT;
 	}
 
-	switch (param->cmd) {
-	case IEEE_CMD_SET_WPA_PARAM:
-		ret = wpa_set_param(dev, param->u.wpa_param.name, param->u.wpa_param.value);
-		break;
-
-	case IEEE_CMD_SET_WPA_IE:
-		ret =  rtw_set_wpa_ie((struct adapter *)rtw_netdev_priv(dev),
-				      (char *)param->u.wpa_ie.data, (u16)param->u.wpa_ie.len);
-		break;
+	/* added for wps2.0 @20110524 */
+	if (dwrq->flags == 0x8766 && len > 8) {
+		u32 cp_sz;
+		struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+		u8 *probereq_wpsie = ext;
+		int probereq_wpsie_len = len;
+		u8 wps_oui[4] = {0x0, 0x50, 0xf2, 0x04};
 
-	case IEEE_CMD_SET_ENCRYPTION:
-		ret = wpa_set_encryption(dev, param, p->length);
-		break;
+		if ((_VENDOR_SPECIFIC_IE_ == probereq_wpsie[0]) &&
+		    (!memcmp(&probereq_wpsie[2], wps_oui, 4))) {
+			cp_sz = probereq_wpsie_len > MAX_WPS_IE_LEN ? MAX_WPS_IE_LEN : probereq_wpsie_len;
 
-	case IEEE_CMD_MLME:
-		ret = wpa_mlme(dev, param->u.mlme.command, param->u.mlme.reason_code);
-		break;
+			pmlmepriv->wps_probe_req_ie_len = 0;
+			kfree(pmlmepriv->wps_probe_req_ie);
+			pmlmepriv->wps_probe_req_ie = NULL;
 
-	default:
-		DBG_88E("Unknown WPA supplicant request: %d\n", param->cmd);
-		ret = -EOPNOTSUPP;
-		break;
+			pmlmepriv->wps_probe_req_ie = kmalloc(cp_sz, GFP_KERNEL);
+			if (!pmlmepriv->wps_probe_req_ie) {
+				ret =  -EINVAL;
+				goto FREE_EXT;
+			}
+			memcpy(pmlmepriv->wps_probe_req_ie, probereq_wpsie, cp_sz);
+			pmlmepriv->wps_probe_req_ie_len = cp_sz;
+		}
+		goto FREE_EXT;
 	}
 
-	if (ret == 0 && copy_to_user(p->pointer, param, p->length))
-		ret = -EFAULT;
+	if (len >= WEXT_CSCAN_HEADER_SIZE &&
+	    !memcmp(ext, WEXT_CSCAN_HEADER, WEXT_CSCAN_HEADER_SIZE)) {
+		ret = rtw_wx_set_scan(dev, info, awrq, ext);
+		goto FREE_EXT;
+	}
 
-	kfree(param);
+FREE_EXT:
 
-out:
+	vfree(ext);
 
 	return ret;
 }
 
-#ifdef CONFIG_88EU_AP_MODE
-static u8 set_pairwise_key(struct adapter *padapter, struct sta_info *psta)
+static int rtw_pm_set(struct net_device *dev,
+			       struct iw_request_info *info,
+			       union iwreq_data *wrqu, char *extra)
 {
-	struct cmd_obj *ph2c;
-	struct set_stakey_parm	*psetstakey_para;
-	struct cmd_priv	*pcmdpriv = &padapter->cmdpriv;
-	u8 res = _SUCCESS;
-
-	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
-	if (!ph2c) {
-		res = _FAIL;
-		goto exit;
-	}
-
-	psetstakey_para = kzalloc(sizeof(struct set_stakey_parm), GFP_KERNEL);
-	if (!psetstakey_para) {
-		kfree(ph2c);
-		res = _FAIL;
-		goto exit;
-	}
-
-	init_h2fwcmd_w_parm_no_rsp(ph2c, psetstakey_para, _SetStaKey_CMD_);
-
-	psetstakey_para->algorithm = (u8)psta->dot118021XPrivacy;
-
-	memcpy(psetstakey_para->addr, psta->hwaddr, ETH_ALEN);
-
-	memcpy(psetstakey_para->key, &psta->dot118021x_UncstKey, 16);
+	int ret = 0;
+	unsigned	mode = 0;
+	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 
-	res = rtw_enqueue_cmd(pcmdpriv, ph2c);
+	DBG_88E("[%s] extra = %s\n", __func__, extra);
 
-exit:
+	if (!memcmp(extra, "lps =", 4)) {
+		sscanf(extra+4, "%u", &mode);
+		ret = rtw_pm_set_lps(padapter, mode);
+	} else if (!memcmp(extra, "ips =", 4)) {
+		sscanf(extra+4, "%u", &mode);
+		ret = rtw_pm_set_ips(padapter, mode);
+	} else {
+		ret = -EINVAL;
+	}
 
-	return res;
+	return ret;
 }
 
-static int set_group_key(struct adapter *padapter, u8 *key, u8 alg, int keyid)
+static int rtw_mp_efuse_get(struct net_device *dev,
+			struct iw_request_info *info,
+			union iwreq_data *wdata, char *extra)
 {
-	u8 keylen;
-	struct cmd_obj *pcmd;
-	struct setkey_parm *psetkeyparm;
-	struct cmd_priv	*pcmdpriv = &padapter->cmdpriv;
-	int res = _SUCCESS;
+	struct adapter *padapter = rtw_netdev_priv(dev);
+	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
+	struct hal_data_8188e *haldata = GET_HAL_DATA(padapter);
+	struct efuse_hal *pEfuseHal;
+	struct iw_point *wrqu;
 
-	DBG_88E("%s\n", __func__);
+	u8 *PROMContent = pEEPROM->efuse_eeprom_data;
+	u8 ips_mode = 0, lps_mode = 0;
+	struct pwrctrl_priv *pwrctrlpriv;
+	u8 *data = NULL;
+	u8 *rawdata = NULL;
+	char *pch, *ptmp, *token, *tmp[3] = {NULL, NULL, NULL};
+	u16 i = 0, j = 0, mapLen = 0, addr = 0, cnts = 0;
+	u16 max_available_size = 0, raw_cursize = 0, raw_maxsize = 0;
+	int err;
+	u8 org_fw_iol = padapter->registrypriv.fw_iol;/*  0:Disable, 1:enable, 2:by usb speed */
+
+	wrqu = (struct iw_point *)wdata;
+	pwrctrlpriv = &padapter->pwrctrlpriv;
+	pEfuseHal = &haldata->EfuseHal;
 
-	pcmd = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
-	if (!pcmd) {
-		res = _FAIL;
+	err = 0;
+	data = kzalloc(EFUSE_BT_MAX_MAP_LEN, GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
 		goto exit;
 	}
-	psetkeyparm = kzalloc(sizeof(struct setkey_parm), GFP_KERNEL);
-	if (!psetkeyparm) {
-		kfree(pcmd);
-		res = _FAIL;
+	rawdata = kzalloc(EFUSE_BT_MAX_MAP_LEN, GFP_KERNEL);
+	if (!rawdata) {
+		err = -ENOMEM;
 		goto exit;
 	}
 
-	memset(psetkeyparm, 0, sizeof(struct setkey_parm));
-
-	psetkeyparm->keyid = (u8)keyid;
-
-	psetkeyparm->algorithm = alg;
-
-	psetkeyparm->set_tx = 1;
-
-	switch (alg) {
-	case _WEP40_:
-		keylen = 5;
-		break;
-	case _WEP104_:
-		keylen = 13;
-		break;
-	case _TKIP_:
-	case _TKIP_WTMIC_:
-	case _AES_:
-	default:
-		keylen = 16;
+	if (copy_from_user(extra, wrqu->pointer, wrqu->length)) {
+		err = -EFAULT;
+		goto exit;
 	}
+	lps_mode = pwrctrlpriv->power_mgnt;/* keep org value */
+	rtw_pm_set_lps(padapter, PS_MODE_ACTIVE);
 
-	memcpy(&psetkeyparm->key[0], key, keylen);
-
-	pcmd->cmdcode = _SetKey_CMD_;
-	pcmd->parmbuf = (u8 *)psetkeyparm;
-	pcmd->cmdsz =  (sizeof(struct setkey_parm));
-	pcmd->rsp = NULL;
-	pcmd->rspsz = 0;
-
-	INIT_LIST_HEAD(&pcmd->list);
-
-	res = rtw_enqueue_cmd(pcmdpriv, pcmd);
-
-exit:
-
-	return res;
-}
+	ips_mode = pwrctrlpriv->ips_mode;/* keep org value */
+	rtw_pm_set_ips(padapter, IPS_NONE);
 
-static int set_wep_key(struct adapter *padapter, u8 *key, u8 keylen, int keyid)
-{
-	u8 alg;
+	pch = extra;
+	DBG_88E("%s: in =%s\n", __func__, extra);
 
-	switch (keylen) {
-	case 5:
-		alg = _WEP40_;
-		break;
-	case 13:
-		alg = _WEP104_;
-		break;
-	default:
-		alg = _NO_PRIVACY_;
+	i = 0;
+	/* mac 16 "00e04c871200" rmap, 00, 2 */
+	while ((token = strsep(&pch, ",")) != NULL) {
+		if (i > 2)
+			break;
+		tmp[i] = token;
+		i++;
 	}
+	padapter->registrypriv.fw_iol = 0;/*  0:Disable, 1:enable, 2:by usb speed */
 
-	return set_group_key(padapter, key, alg, keyid);
-}
+	if (strcmp(tmp[0], "status") == 0) {
+		sprintf(extra, "Load File efuse =%s, Load File MAC =%s", (pEEPROM->bloadfile_fail_flag ? "FAIL" : "OK"), (pEEPROM->bloadmac_fail_flag ? "FAIL" : "OK"));
 
-static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param, u32 param_len)
-{
-	int ret = 0;
-	u32 wep_key_idx, wep_key_len, wep_total_len;
-	struct ndis_802_11_wep	 *pwep = NULL;
-	struct sta_info *psta = NULL, *pbcmc_sta = NULL;
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
-	struct security_priv *psecuritypriv = &padapter->securitypriv;
-	struct sta_priv *pstapriv = &padapter->stapriv;
+		  goto exit;
+	} else if (strcmp(tmp[0], "filemap") == 0) {
+		mapLen = EFUSE_MAP_SIZE;
 
-	DBG_88E("%s\n", __func__);
-	param->u.crypt.err = 0;
-	param->u.crypt.alg[IEEE_CRYPT_ALG_NAME_LEN - 1] = '\0';
-	if (param_len !=  sizeof(struct ieee_param) + param->u.crypt.key_len) {
-		ret =  -EINVAL;
-		goto exit;
-	}
-	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
-	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff) {
-		if (param->u.crypt.idx >= WEP_KEYS) {
-			ret = -EINVAL;
-			goto exit;
-		}
-	} else {
-		psta = rtw_get_stainfo(pstapriv, param->sta_addr);
-		if (!psta) {
-			DBG_88E("rtw_set_encryption(), sta has already been removed or never been added\n");
-			goto exit;
+		sprintf(extra, "\n");
+		for (i = 0; i < EFUSE_MAP_SIZE; i += 16) {
+			sprintf(extra + strlen(extra), "0x%02x\t", i);
+			for (j = 0; j < 8; j++)
+				sprintf(extra + strlen(extra), "%02X ", PROMContent[i+j]);
+			sprintf(extra + strlen(extra), "\t");
+			for (; j < 16; j++)
+				sprintf(extra + strlen(extra), "%02X ", PROMContent[i+j]);
+			sprintf(extra + strlen(extra), "\n");
 		}
-	}
-
-	if (strcmp(param->u.crypt.alg, "none") == 0 && !psta) {
-		/* todo:clear default encryption keys */
-
-		DBG_88E("clear default encryption keys, keyid =%d\n", param->u.crypt.idx);
-		goto exit;
-	}
-	if (strcmp(param->u.crypt.alg, "WEP") == 0 && !psta) {
-		DBG_88E("r871x_set_encryption, crypt.alg = WEP\n");
-		wep_key_idx = param->u.crypt.idx;
-		wep_key_len = param->u.crypt.key_len;
-		DBG_88E("r871x_set_encryption, wep_key_idx=%d, len=%d\n", wep_key_idx, wep_key_len);
-		if ((wep_key_idx >= WEP_KEYS) || (wep_key_len <= 0)) {
-			ret = -EINVAL;
-			goto exit;
-		}
-
-		if (wep_key_len > 0) {
-			wep_key_len = wep_key_len <= 5 ? 5 : 13;
-			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
-			pwep = kzalloc(wep_total_len, GFP_KERNEL);
-			if (!pwep) {
-				ret = -ENOMEM;
-				goto exit;
-			}
-			pwep->KeyLength = wep_key_len;
-			pwep->Length = wep_total_len;
-		}
-
-		pwep->KeyIndex = wep_key_idx;
-
-		memcpy(pwep->KeyMaterial,  param->u.crypt.key, pwep->KeyLength);
-
-		if (param->u.crypt.set_tx) {
-			DBG_88E("wep, set_tx = 1\n");
-
-			psecuritypriv->ndisencryptstatus = Ndis802_11Encryption1Enabled;
-			psecuritypriv->dot11PrivacyAlgrthm = _WEP40_;
-			psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
-
-			if (pwep->KeyLength == 13) {
-				psecuritypriv->dot11PrivacyAlgrthm = _WEP104_;
-				psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
-			}
-
-			psecuritypriv->dot11PrivacyKeyIndex = wep_key_idx;
-
-			memcpy(&psecuritypriv->dot11DefKey[wep_key_idx].skey[0], pwep->KeyMaterial, pwep->KeyLength);
-
-			psecuritypriv->dot11DefKeylen[wep_key_idx] = pwep->KeyLength;
-
-			set_wep_key(padapter, pwep->KeyMaterial, pwep->KeyLength, wep_key_idx);
-		} else {
-			DBG_88E("wep, set_tx = 0\n");
-
-			/* don't update "psecuritypriv->dot11PrivacyAlgrthm" and */
-			/* psecuritypriv->dot11PrivacyKeyIndex = keyid", but can rtw_set_key to cam */
-
-		      memcpy(&psecuritypriv->dot11DefKey[wep_key_idx].skey[0], pwep->KeyMaterial, pwep->KeyLength);
-
-			psecuritypriv->dot11DefKeylen[wep_key_idx] = pwep->KeyLength;
-
-			set_wep_key(padapter, pwep->KeyMaterial, pwep->KeyLength, wep_key_idx);
-		}
-
-		goto exit;
-	}
-
-	if (!psta && check_fwstate(pmlmepriv, WIFI_AP_STATE)) { /*  group key */
-		if (param->u.crypt.set_tx == 1) {
-			if (strcmp(param->u.crypt.alg, "WEP") == 0) {
-				DBG_88E("%s, set group_key, WEP\n", __func__);
-
-				memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey,
-					    param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
-
-				psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
-				if (param->u.crypt.key_len == 13)
-						psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
-			} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
-				DBG_88E("%s, set group_key, TKIP\n", __func__);
-				psecuritypriv->dot118021XGrpPrivacy = _TKIP_;
-				memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey,
-					    param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
-				/* set mic key */
-				memcpy(psecuritypriv->dot118021XGrptxmickey[param->u.crypt.idx].skey, &param->u.crypt.key[16], 8);
-				memcpy(psecuritypriv->dot118021XGrprxmickey[param->u.crypt.idx].skey, &param->u.crypt.key[24], 8);
-
-				psecuritypriv->busetkipkey = true;
-			} else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
-				DBG_88E("%s, set group_key, CCMP\n", __func__);
-				psecuritypriv->dot118021XGrpPrivacy = _AES_;
-				memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey,
-					    param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
-			} else {
-				DBG_88E("%s, set group_key, none\n", __func__);
-				psecuritypriv->dot118021XGrpPrivacy = _NO_PRIVACY_;
-			}
-			psecuritypriv->dot118021XGrpKeyid = param->u.crypt.idx;
-			psecuritypriv->binstallGrpkey = true;
-			psecuritypriv->dot11PrivacyAlgrthm = psecuritypriv->dot118021XGrpPrivacy;/*  */
-			set_group_key(padapter, param->u.crypt.key, psecuritypriv->dot118021XGrpPrivacy, param->u.crypt.idx);
-			pbcmc_sta = rtw_get_bcmc_stainfo(padapter);
-			if (pbcmc_sta) {
-				pbcmc_sta->ieee8021x_blocked = false;
-				pbcmc_sta->dot118021XPrivacy = psecuritypriv->dot118021XGrpPrivacy;/* rx will use bmc_sta's dot118021XPrivacy */
-			}
-		}
-		goto exit;
-	}
-
-	if (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X && psta) { /*  psk/802_1x */
-		if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
-			if (param->u.crypt.set_tx == 1) {
-				memcpy(psta->dot118021x_UncstKey.skey,  param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
-
-				if (strcmp(param->u.crypt.alg, "WEP") == 0) {
-					DBG_88E("%s, set pairwise key, WEP\n", __func__);
-
-					psta->dot118021XPrivacy = _WEP40_;
-					if (param->u.crypt.key_len == 13)
-						psta->dot118021XPrivacy = _WEP104_;
-				} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
-					DBG_88E("%s, set pairwise key, TKIP\n", __func__);
-
-					psta->dot118021XPrivacy = _TKIP_;
-
-					/* set mic key */
-					memcpy(psta->dot11tkiptxmickey.skey, &param->u.crypt.key[16], 8);
-					memcpy(psta->dot11tkiprxmickey.skey, &param->u.crypt.key[24], 8);
-
-					psecuritypriv->busetkipkey = true;
-				} else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
-					DBG_88E("%s, set pairwise key, CCMP\n", __func__);
-
-					psta->dot118021XPrivacy = _AES_;
-				} else {
-					DBG_88E("%s, set pairwise key, none\n", __func__);
-
-					psta->dot118021XPrivacy = _NO_PRIVACY_;
-				}
-
-				set_pairwise_key(padapter, psta);
-
-				psta->ieee8021x_blocked = false;
-			} else { /* group key??? */
-				if (strcmp(param->u.crypt.alg, "WEP") == 0) {
-					memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey,
-						    param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
-					psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
-					if (param->u.crypt.key_len == 13)
-						psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
-				} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
-					psecuritypriv->dot118021XGrpPrivacy = _TKIP_;
-
-					memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey,
-						    param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
-
-					/* set mic key */
-					memcpy(psecuritypriv->dot118021XGrptxmickey[param->u.crypt.idx].skey, &param->u.crypt.key[16], 8);
-					memcpy(psecuritypriv->dot118021XGrprxmickey[param->u.crypt.idx].skey, &param->u.crypt.key[24], 8);
-
-					psecuritypriv->busetkipkey = true;
-				} else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
-					psecuritypriv->dot118021XGrpPrivacy = _AES_;
-
-					memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey,
-						    param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
-				} else {
-					psecuritypriv->dot118021XGrpPrivacy = _NO_PRIVACY_;
-				}
-
-				psecuritypriv->dot118021XGrpKeyid = param->u.crypt.idx;
-
-				psecuritypriv->binstallGrpkey = true;
-
-				psecuritypriv->dot11PrivacyAlgrthm = psecuritypriv->dot118021XGrpPrivacy;/*  */
-
-				set_group_key(padapter, param->u.crypt.key, psecuritypriv->dot118021XGrpPrivacy, param->u.crypt.idx);
-
-				pbcmc_sta = rtw_get_bcmc_stainfo(padapter);
-				if (pbcmc_sta) {
-					pbcmc_sta->ieee8021x_blocked = false;
-					pbcmc_sta->dot118021XPrivacy = psecuritypriv->dot118021XGrpPrivacy;/* rx will use bmc_sta's dot118021XPrivacy */
-				}
-			}
-		}
-	}
-
-exit:
-
-	kfree(pwep);
-
-	return ret;
-}
-
-static int rtw_set_beacon(struct net_device *dev, struct ieee_param *param, int len)
-{
-	int ret = 0;
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct sta_priv *pstapriv = &padapter->stapriv;
-	unsigned char *pbuf = param->u.bcn_ie.buf;
-
-	DBG_88E("%s, len =%d\n", __func__, len);
-
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
-		return -EINVAL;
-
-	memcpy(&pstapriv->max_num_sta, param->u.bcn_ie.reserved, 2);
-
-	if ((pstapriv->max_num_sta > NUM_STA) || (pstapriv->max_num_sta <= 0))
-		pstapriv->max_num_sta = NUM_STA;
-
-	if (rtw_check_beacon_data(padapter, pbuf,  (len-12-2)) == _SUCCESS)/*  12 = param header, 2:no packed */
-		ret = 0;
-	else
-		ret = -EINVAL;
-
-	return ret;
-}
-
-static int rtw_hostapd_sta_flush(struct net_device *dev)
-{
-	int ret = 0;
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-
-	DBG_88E("%s\n", __func__);
-
-	flush_all_cam_entry(padapter);	/* clear CAM */
-
-	ret = rtw_sta_flush(padapter);
-
-	return ret;
-}
-
-static int rtw_add_sta(struct net_device *dev, struct ieee_param *param)
-{
-	int ret = 0;
-	struct sta_info *psta = NULL;
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct sta_priv *pstapriv = &padapter->stapriv;
-
-	DBG_88E("rtw_add_sta(aid =%d) =%pM\n", param->u.add_sta.aid, (param->sta_addr));
-
-	if (!check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)))
-		return -EINVAL;
-
-	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
-	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff)
-		return -EINVAL;
-
-	psta = rtw_get_stainfo(pstapriv, param->sta_addr);
-	if (psta) {
-		int flags = param->u.add_sta.flags;
-
-		psta->aid = param->u.add_sta.aid;/* aid = 1~2007 */
-
-		memcpy(psta->bssrateset, param->u.add_sta.tx_supp_rates, 16);
-
-		/* check wmm cap. */
-		if (WLAN_STA_WME&flags)
-			psta->qos_option = 1;
-		else
-			psta->qos_option = 0;
-
-		if (pmlmepriv->qospriv.qos_option == 0)
-			psta->qos_option = 0;
-
-		/* chec 802.11n ht cap. */
-		if (WLAN_STA_HT&flags) {
-			psta->htpriv.ht_option = true;
-			psta->qos_option = 1;
-			memcpy((void *)&psta->htpriv.ht_cap, (void *)&param->u.add_sta.ht_cap, sizeof(struct ieee80211_ht_cap));
-		} else {
-			psta->htpriv.ht_option = false;
-		}
-
-		if (pmlmepriv->htpriv.ht_option == false)
-			psta->htpriv.ht_option = false;
-
-		update_sta_info_apmode(padapter, psta);
-	} else {
-		ret = -ENOMEM;
-	}
-
-	return ret;
-}
-
-static int rtw_del_sta(struct net_device *dev, struct ieee_param *param)
-{
-	int ret = 0;
-	struct sta_info *psta = NULL;
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct sta_priv *pstapriv = &padapter->stapriv;
-	int updated = 0;
-
-	DBG_88E("rtw_del_sta =%pM\n", (param->sta_addr));
-
-	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
-		return -EINVAL;
-
-	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
-	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff)
-		return -EINVAL;
-
-	psta = rtw_get_stainfo(pstapriv, param->sta_addr);
-	if (psta) {
-		spin_lock_bh(&pstapriv->asoc_list_lock);
-		if (!list_empty(&psta->asoc_list)) {
-			list_del_init(&psta->asoc_list);
-			pstapriv->asoc_list_cnt--;
-			updated = ap_free_sta(padapter, psta, true, WLAN_REASON_DEAUTH_LEAVING);
-		}
-		spin_unlock_bh(&pstapriv->asoc_list_lock);
-		associated_clients_update(padapter, updated);
-		psta = NULL;
-	} else {
-		DBG_88E("rtw_del_sta(), sta has already been removed or never been added\n");
-	}
-
-	return ret;
-}
-
-static int rtw_ioctl_get_sta_data(struct net_device *dev, struct ieee_param *param, int len)
-{
-	int ret = 0;
-	struct sta_info *psta = NULL;
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct sta_priv *pstapriv = &padapter->stapriv;
-	struct ieee_param_ex *param_ex = (struct ieee_param_ex *)param;
-	struct sta_data *psta_data = (struct sta_data *)param_ex->data;
-
-	DBG_88E("rtw_ioctl_get_sta_info, sta_addr: %pM\n", (param_ex->sta_addr));
-
-	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
-		return -EINVAL;
-
-	if (param_ex->sta_addr[0] == 0xff && param_ex->sta_addr[1] == 0xff &&
-	    param_ex->sta_addr[2] == 0xff && param_ex->sta_addr[3] == 0xff &&
-	    param_ex->sta_addr[4] == 0xff && param_ex->sta_addr[5] == 0xff)
-		return -EINVAL;
-
-	psta = rtw_get_stainfo(pstapriv, param_ex->sta_addr);
-	if (psta) {
-		psta_data->aid = (u16)psta->aid;
-		psta_data->capability = psta->capability;
-		psta_data->flags = psta->flags;
-
-/*
-		nonerp_set : BIT(0)
-		no_short_slot_time_set : BIT(1)
-		no_short_preamble_set : BIT(2)
-		no_ht_gf_set : BIT(3)
-		no_ht_set : BIT(4)
-		ht_20mhz_set : BIT(5)
-*/
-
-		psta_data->sta_set = ((psta->nonerp_set) |
-				      (psta->no_short_slot_time_set << 1) |
-				      (psta->no_short_preamble_set << 2) |
-				      (psta->no_ht_gf_set << 3) |
-				      (psta->no_ht_set << 4) |
-				      (psta->ht_20mhz_set << 5));
-		psta_data->tx_supp_rates_len =  psta->bssratelen;
-		memcpy(psta_data->tx_supp_rates, psta->bssrateset, psta->bssratelen);
-		memcpy(&psta_data->ht_cap, &psta->htpriv.ht_cap, sizeof(struct ieee80211_ht_cap));
-		psta_data->rx_pkts = psta->sta_stats.rx_data_pkts;
-		psta_data->rx_bytes = psta->sta_stats.rx_bytes;
-		psta_data->rx_drops = psta->sta_stats.rx_drops;
-		psta_data->tx_pkts = psta->sta_stats.tx_pkts;
-		psta_data->tx_bytes = psta->sta_stats.tx_bytes;
-		psta_data->tx_drops = psta->sta_stats.tx_drops;
-	} else {
-		ret = -1;
-	}
-
-	return ret;
-}
-
-static int rtw_get_sta_wpaie(struct net_device *dev, struct ieee_param *param)
-{
-	int ret = 0;
-	struct sta_info *psta = NULL;
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct sta_priv *pstapriv = &padapter->stapriv;
-
-	DBG_88E("rtw_get_sta_wpaie, sta_addr: %pM\n", (param->sta_addr));
-
-	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
-		return -EINVAL;
-
-	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
-	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff)
-		return -EINVAL;
-
-	psta = rtw_get_stainfo(pstapriv, param->sta_addr);
-	if (psta) {
-		if ((psta->wpa_ie[0] == WLAN_EID_RSN) || (psta->wpa_ie[0] == WLAN_EID_GENERIC)) {
-			int wpa_ie_len;
-			int copy_len;
-
-			wpa_ie_len = psta->wpa_ie[1];
-			copy_len = ((wpa_ie_len+2) > sizeof(psta->wpa_ie)) ? (sizeof(psta->wpa_ie)) : (wpa_ie_len+2);
-			param->u.wpa_ie.len = copy_len;
-			memcpy(param->u.wpa_ie.reserved, psta->wpa_ie, copy_len);
-		} else {
-			DBG_88E("sta's wpa_ie is NONE\n");
-		}
-	} else {
-		ret = -1;
-	}
-
-	return ret;
-}
-
-static int rtw_set_wps_beacon(struct net_device *dev, struct ieee_param *param, int len)
-{
-	int ret = 0;
-	unsigned char wps_oui[4] = {0x0, 0x50, 0xf2, 0x04};
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	int ie_len;
-
-	DBG_88E("%s, len =%d\n", __func__, len);
-
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
-		return -EINVAL;
-
-	ie_len = len-12-2;/*  12 = param header, 2:no packed */
-
-	if (pmlmepriv->wps_beacon_ie) {
-		kfree(pmlmepriv->wps_beacon_ie);
-		pmlmepriv->wps_beacon_ie = NULL;
-	}
-
-	if (ie_len > 0) {
-		pmlmepriv->wps_beacon_ie = kmalloc(ie_len, GFP_KERNEL);
-		pmlmepriv->wps_beacon_ie_len = ie_len;
-		if (!pmlmepriv->wps_beacon_ie) {
-			DBG_88E("%s()-%d: rtw_malloc() ERROR!\n", __func__, __LINE__);
-			return -EINVAL;
-		}
-
-		memcpy(pmlmepriv->wps_beacon_ie, param->u.bcn_ie.buf, ie_len);
-
-		update_beacon(padapter, _VENDOR_SPECIFIC_IE_, wps_oui, true);
-
-		pmlmeext->bstart_bss = true;
-	}
-
-	return ret;
-}
-
-static int rtw_set_wps_probe_resp(struct net_device *dev, struct ieee_param *param, int len)
-{
-	int ret = 0;
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	int ie_len;
-
-	DBG_88E("%s, len =%d\n", __func__, len);
-
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
-		return -EINVAL;
-
-	ie_len = len-12-2;/*  12 = param header, 2:no packed */
-
-	if (pmlmepriv->wps_probe_resp_ie) {
-		kfree(pmlmepriv->wps_probe_resp_ie);
-		pmlmepriv->wps_probe_resp_ie = NULL;
-	}
-
-	if (ie_len > 0) {
-		pmlmepriv->wps_probe_resp_ie = kmalloc(ie_len, GFP_KERNEL);
-		pmlmepriv->wps_probe_resp_ie_len = ie_len;
-		if (!pmlmepriv->wps_probe_resp_ie) {
-			DBG_88E("%s()-%d: rtw_malloc() ERROR!\n", __func__, __LINE__);
-			return -EINVAL;
-		}
-		memcpy(pmlmepriv->wps_probe_resp_ie, param->u.bcn_ie.buf, ie_len);
-	}
-
-	return ret;
-}
-
-static int rtw_set_wps_assoc_resp(struct net_device *dev, struct ieee_param *param, int len)
-{
-	int ret = 0;
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	int ie_len;
-
-	DBG_88E("%s, len =%d\n", __func__, len);
-
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
-		return -EINVAL;
-
-	ie_len = len-12-2;/*  12 = param header, 2:no packed */
-
-	if (pmlmepriv->wps_assoc_resp_ie) {
-		kfree(pmlmepriv->wps_assoc_resp_ie);
-		pmlmepriv->wps_assoc_resp_ie = NULL;
-	}
-
-	if (ie_len > 0) {
-		pmlmepriv->wps_assoc_resp_ie = kmalloc(ie_len, GFP_KERNEL);
-		pmlmepriv->wps_assoc_resp_ie_len = ie_len;
-		if (!pmlmepriv->wps_assoc_resp_ie) {
-			DBG_88E("%s()-%d: rtw_malloc() ERROR!\n", __func__, __LINE__);
-			return -ENOMEM;
-		}
-
-		memcpy(pmlmepriv->wps_assoc_resp_ie, param->u.bcn_ie.buf, ie_len);
-	}
-
-	return ret;
-}
-
-static int rtw_set_hidden_ssid(struct net_device *dev, struct ieee_param *param, int len)
-{
-	int ret = 0;
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
-
-	u8 value;
-
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
-		return -EINVAL;
-
-	if (param->u.wpa_param.name != 0) /* dummy test... */
-		DBG_88E("%s name(%u) != 0\n", __func__, param->u.wpa_param.name);
-	value = param->u.wpa_param.value;
-
-	/* use the same definition of hostapd's ignore_broadcast_ssid */
-	if (value != 1 && value != 2)
-		value = 0;
-	DBG_88E("%s value(%u)\n", __func__, value);
-	pmlmeinfo->hidden_ssid_mode = value;
-	return ret;
-}
-
-static int rtw_ioctl_acl_remove_sta(struct net_device *dev, struct ieee_param *param, int len)
-{
-	int ret = 0;
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
-		return -EINVAL;
-
-	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
-	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff)
-		return -EINVAL;
-	ret = rtw_acl_remove_sta(padapter, param->sta_addr);
-	return ret;
-}
-
-static int rtw_ioctl_acl_add_sta(struct net_device *dev, struct ieee_param *param, int len)
-{
-	int ret = 0;
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
-		return -EINVAL;
-
-	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
-	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff)
-		return -EINVAL;
-	ret = rtw_acl_add_sta(padapter, param->sta_addr);
-	return ret;
-}
-
-static int rtw_ioctl_set_macaddr_acl(struct net_device *dev, struct ieee_param *param, int len)
-{
-	int ret = 0;
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
-		return -EINVAL;
-
-	rtw_set_macaddr_acl(padapter, param->u.mlme.command);
-
-	return ret;
-}
-
-static int rtw_hostapd_ioctl(struct net_device *dev, struct iw_point *p)
-{
-	struct ieee_param *param;
-	int ret = 0;
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-
-	/*
-	* this function is expect to call in master mode, which allows no power saving
-	* so, we just check hw_init_completed
-	*/
-
-	if (!padapter->hw_init_completed) {
-		ret = -EPERM;
-		goto out;
-	}
-
-	if (!p->pointer || p->length > (sizeof(struct ieee_param) + 100)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	param = kmalloc(p->length, GFP_KERNEL);
-	if (!param) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	if (copy_from_user(param, p->pointer, p->length)) {
-		kfree(param);
-		ret = -EFAULT;
-		goto out;
-	}
-
-	switch (param->cmd) {
-	case RTL871X_HOSTAPD_FLUSH:
-		ret = rtw_hostapd_sta_flush(dev);
-		break;
-	case RTL871X_HOSTAPD_ADD_STA:
-		ret = rtw_add_sta(dev, param);
-		break;
-	case RTL871X_HOSTAPD_REMOVE_STA:
-		ret = rtw_del_sta(dev, param);
-		break;
-	case RTL871X_HOSTAPD_SET_BEACON:
-		ret = rtw_set_beacon(dev, param, p->length);
-		break;
-	case RTL871X_SET_ENCRYPTION:
-		ret = rtw_set_encryption(dev, param, p->length);
-		break;
-	case RTL871X_HOSTAPD_GET_WPAIE_STA:
-		ret = rtw_get_sta_wpaie(dev, param);
-		break;
-	case RTL871X_HOSTAPD_SET_WPS_BEACON:
-		ret = rtw_set_wps_beacon(dev, param, p->length);
-		break;
-	case RTL871X_HOSTAPD_SET_WPS_PROBE_RESP:
-		ret = rtw_set_wps_probe_resp(dev, param, p->length);
-		break;
-	case RTL871X_HOSTAPD_SET_WPS_ASSOC_RESP:
-		ret = rtw_set_wps_assoc_resp(dev, param, p->length);
-		break;
-	case RTL871X_HOSTAPD_SET_HIDDEN_SSID:
-		ret = rtw_set_hidden_ssid(dev, param, p->length);
-		break;
-	case RTL871X_HOSTAPD_GET_INFO_STA:
-		ret = rtw_ioctl_get_sta_data(dev, param, p->length);
-		break;
-	case RTL871X_HOSTAPD_SET_MACADDR_ACL:
-		ret = rtw_ioctl_set_macaddr_acl(dev, param, p->length);
-		break;
-	case RTL871X_HOSTAPD_ACL_ADD_STA:
-		ret = rtw_ioctl_acl_add_sta(dev, param, p->length);
-		break;
-	case RTL871X_HOSTAPD_ACL_REMOVE_STA:
-		ret = rtw_ioctl_acl_remove_sta(dev, param, p->length);
-		break;
-	default:
-		pr_info("Unknown hostapd request: %d\n", param->cmd);
-		ret = -EOPNOTSUPP;
-		break;
-	}
-
-	if (ret == 0 && copy_to_user(p->pointer, param, p->length))
-		ret = -EFAULT;
-	kfree(param);
-out:
-	return ret;
-}
-#endif
-
-static int rtw_wx_set_priv(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *awrq,
-				char *extra)
-{
-	int ret = 0;
-	int len = 0;
-	char *ext;
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct iw_point *dwrq = (struct iw_point *)awrq;
-
-	if (dwrq->length == 0)
-		return -EFAULT;
-
-	len = dwrq->length;
-	ext = rtw_vmalloc(len);
-	if (!ext)
-		return -ENOMEM;
-
-	if (copy_from_user(ext, dwrq->pointer, len)) {
-		vfree(ext);
-		return -EFAULT;
-	}
-
-	/* added for wps2.0 @20110524 */
-	if (dwrq->flags == 0x8766 && len > 8) {
-		u32 cp_sz;
-		struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-		u8 *probereq_wpsie = ext;
-		int probereq_wpsie_len = len;
-		u8 wps_oui[4] = {0x0, 0x50, 0xf2, 0x04};
-
-		if ((_VENDOR_SPECIFIC_IE_ == probereq_wpsie[0]) &&
-		    (!memcmp(&probereq_wpsie[2], wps_oui, 4))) {
-			cp_sz = probereq_wpsie_len > MAX_WPS_IE_LEN ? MAX_WPS_IE_LEN : probereq_wpsie_len;
-
-			pmlmepriv->wps_probe_req_ie_len = 0;
-			kfree(pmlmepriv->wps_probe_req_ie);
-			pmlmepriv->wps_probe_req_ie = NULL;
-
-			pmlmepriv->wps_probe_req_ie = kmalloc(cp_sz, GFP_KERNEL);
-			if (!pmlmepriv->wps_probe_req_ie) {
-				ret =  -EINVAL;
-				goto FREE_EXT;
-			}
-			memcpy(pmlmepriv->wps_probe_req_ie, probereq_wpsie, cp_sz);
-			pmlmepriv->wps_probe_req_ie_len = cp_sz;
-		}
-		goto FREE_EXT;
-	}
-
-	if (len >= WEXT_CSCAN_HEADER_SIZE &&
-	    !memcmp(ext, WEXT_CSCAN_HEADER, WEXT_CSCAN_HEADER_SIZE)) {
-		ret = rtw_wx_set_scan(dev, info, awrq, ext);
-		goto FREE_EXT;
-	}
-
-FREE_EXT:
-
-	vfree(ext);
-
-	return ret;
-}
-
-static int rtw_pm_set(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
-{
-	int ret = 0;
-	unsigned	mode = 0;
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-
-	DBG_88E("[%s] extra = %s\n", __func__, extra);
-
-	if (!memcmp(extra, "lps =", 4)) {
-		sscanf(extra+4, "%u", &mode);
-		ret = rtw_pm_set_lps(padapter, mode);
-	} else if (!memcmp(extra, "ips =", 4)) {
-		sscanf(extra+4, "%u", &mode);
-		ret = rtw_pm_set_ips(padapter, mode);
-	} else {
-		ret = -EINVAL;
-	}
-
-	return ret;
-}
-
-static int rtw_mp_efuse_get(struct net_device *dev,
-			struct iw_request_info *info,
-			union iwreq_data *wdata, char *extra)
-{
-	struct adapter *padapter = rtw_netdev_priv(dev);
-	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
-	struct hal_data_8188e *haldata = GET_HAL_DATA(padapter);
-	struct efuse_hal *pEfuseHal;
-	struct iw_point *wrqu;
-
-	u8 *PROMContent = pEEPROM->efuse_eeprom_data;
-	u8 ips_mode = 0, lps_mode = 0;
-	struct pwrctrl_priv *pwrctrlpriv;
-	u8 *data = NULL;
-	u8 *rawdata = NULL;
-	char *pch, *ptmp, *token, *tmp[3] = {NULL, NULL, NULL};
-	u16 i = 0, j = 0, mapLen = 0, addr = 0, cnts = 0;
-	u16 max_available_size = 0, raw_cursize = 0, raw_maxsize = 0;
-	int err;
-	u8 org_fw_iol = padapter->registrypriv.fw_iol;/*  0:Disable, 1:enable, 2:by usb speed */
-
-	wrqu = (struct iw_point *)wdata;
-	pwrctrlpriv = &padapter->pwrctrlpriv;
-	pEfuseHal = &haldata->EfuseHal;
-
-	err = 0;
-	data = kzalloc(EFUSE_BT_MAX_MAP_LEN, GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
-	rawdata = kzalloc(EFUSE_BT_MAX_MAP_LEN, GFP_KERNEL);
-	if (!rawdata) {
-		err = -ENOMEM;
-		goto exit;
-	}
-
-	if (copy_from_user(extra, wrqu->pointer, wrqu->length)) {
-		err = -EFAULT;
-		goto exit;
-	}
-	lps_mode = pwrctrlpriv->power_mgnt;/* keep org value */
-	rtw_pm_set_lps(padapter, PS_MODE_ACTIVE);
-
-	ips_mode = pwrctrlpriv->ips_mode;/* keep org value */
-	rtw_pm_set_ips(padapter, IPS_NONE);
-
-	pch = extra;
-	DBG_88E("%s: in =%s\n", __func__, extra);
-
-	i = 0;
-	/* mac 16 "00e04c871200" rmap, 00, 2 */
-	while ((token = strsep(&pch, ",")) != NULL) {
-		if (i > 2)
-			break;
-		tmp[i] = token;
-		i++;
-	}
-	padapter->registrypriv.fw_iol = 0;/*  0:Disable, 1:enable, 2:by usb speed */
-
-	if (strcmp(tmp[0], "status") == 0) {
-		sprintf(extra, "Load File efuse =%s, Load File MAC =%s", (pEEPROM->bloadfile_fail_flag ? "FAIL" : "OK"), (pEEPROM->bloadmac_fail_flag ? "FAIL" : "OK"));
-
-		  goto exit;
-	} else if (strcmp(tmp[0], "filemap") == 0) {
-		mapLen = EFUSE_MAP_SIZE;
-
-		sprintf(extra, "\n");
-		for (i = 0; i < EFUSE_MAP_SIZE; i += 16) {
-			sprintf(extra + strlen(extra), "0x%02x\t", i);
-			for (j = 0; j < 8; j++)
-				sprintf(extra + strlen(extra), "%02X ", PROMContent[i+j]);
-			sprintf(extra + strlen(extra), "\t");
-			for (; j < 16; j++)
-				sprintf(extra + strlen(extra), "%02X ", PROMContent[i+j]);
-			sprintf(extra + strlen(extra), "\n");
-		}
-	} else if (strcmp(tmp[0], "realmap") == 0) {
-		mapLen = EFUSE_MAP_SIZE;
-		if (rtw_efuse_map_read(padapter, 0, mapLen, pEfuseHal->fakeEfuseInitMap) == _FAIL) {
-			DBG_88E("%s: read realmap Fail!!\n", __func__);
-			err = -EFAULT;
+	} else if (strcmp(tmp[0], "realmap") == 0) {
+		mapLen = EFUSE_MAP_SIZE;
+		if (rtw_efuse_map_read(padapter, 0, mapLen, pEfuseHal->fakeEfuseInitMap) == _FAIL) {
+			DBG_88E("%s: read realmap Fail!!\n", __func__);
+			err = -EFAULT;
 			goto exit;
 		}
 
@@ -7687,318 +6718,3 @@ static const char iw_priv_type_size[] = {
 	sizeof(struct sockaddr),	/* IW_PRIV_TYPE_ADDR */
 	0,			      /* Not defined */
 };
-
-static int get_priv_size(__u16 args)
-{
-	int num = args & IW_PRIV_SIZE_MASK;
-	int type = (args & IW_PRIV_TYPE_MASK) >> 12;
-
-	return num * iw_priv_type_size[type];
-}
-/*  copy from net/wireless/wext.c end */
-
-static int rtw_ioctl_wext_private(struct net_device *dev, union iwreq_data *wrq_data)
-{
-	int err = 0;
-	u8 *input = NULL;
-	u32 input_len = 0;
-	const char delim[] = " ";
-	u8 *output = NULL;
-	u32 output_len = 0;
-	u32 count = 0;
-	u8 *buffer = NULL;
-	u32 buffer_len = 0;
-	char *ptr = NULL;
-	u8 cmdname[17] = {0}; /*  IFNAMSIZ+1 */
-	u32 cmdlen;
-	s32 len;
-	u8 *extra = NULL;
-	u32 extra_size = 0;
-
-	s32 k;
-	const iw_handler *priv;		/* Private ioctl */
-	const struct iw_priv_args *priv_args;	/* Private ioctl description */
-	u32 num_priv_args;			/* Number of descriptions */
-	iw_handler handler;
-	int temp;
-	int subcmd = 0;				/* sub-ioctl index */
-	int offset = 0;				/* Space for sub-ioctl index */
-
-	union iwreq_data wdata;
-
-	memcpy(&wdata, wrq_data, sizeof(wdata));
-
-	input_len = wdata.data.length;
-	if (input_len == 0)
-		return -EFAULT;
-	input = kzalloc(input_len, GFP_KERNEL);
-	if (NULL == input)
-		return -ENOMEM;
-	if (copy_from_user(input, wdata.data.pointer, input_len)) {
-		err = -EFAULT;
-		goto exit;
-	}
-	ptr = input;
-	len = input_len;
-
-	sscanf(ptr, "%16s", cmdname);
-	cmdlen = strlen(cmdname);
-	DBG_88E("%s: cmd =%s\n", __func__, cmdname);
-
-	/*  skip command string */
-	if (cmdlen > 0)
-		cmdlen += 1; /*  skip one space */
-	ptr += cmdlen;
-	len -= cmdlen;
-	DBG_88E("%s: parameters =%s\n", __func__, ptr);
-
-	priv = rtw_private_handler;
-	priv_args = rtw_private_args;
-	num_priv_args = sizeof(rtw_private_args) / sizeof(struct iw_priv_args);
-
-	if (num_priv_args == 0) {
-		err = -EOPNOTSUPP;
-		goto exit;
-	}
-
-	/* Search the correct ioctl */
-	k = -1;
-	while ((++k < num_priv_args) && strcmp(priv_args[k].name, cmdname));
-
-	/* If not found... */
-	if (k == num_priv_args) {
-		err = -EOPNOTSUPP;
-		goto exit;
-	}
-
-	/* Watch out for sub-ioctls ! */
-	if (priv_args[k].cmd < SIOCDEVPRIVATE) {
-		int j = -1;
-
-		/* Find the matching *real* ioctl */
-		while ((++j < num_priv_args) && ((priv_args[j].name[0] != '\0') ||
-			(priv_args[j].set_args != priv_args[k].set_args) ||
-			(priv_args[j].get_args != priv_args[k].get_args)));
-
-		/* If not found... */
-		if (j == num_priv_args) {
-			err = -EINVAL;
-			goto exit;
-		}
-
-		/* Save sub-ioctl number */
-		subcmd = priv_args[k].cmd;
-		/* Reserve one int (simplify alignment issues) */
-		offset = sizeof(__u32);
-		/* Use real ioctl definition from now on */
-		k = j;
-	}
-
-	buffer = kzalloc(4096, GFP_KERNEL);
-	if (NULL == buffer) {
-		err = -ENOMEM;
-		goto exit;
-	}
-
-	/* If we have to set some data */
-	if ((priv_args[k].set_args & IW_PRIV_TYPE_MASK) &&
-	    (priv_args[k].set_args & IW_PRIV_SIZE_MASK)) {
-		u8 *str;
-
-		switch (priv_args[k].set_args & IW_PRIV_TYPE_MASK) {
-		case IW_PRIV_TYPE_BYTE:
-			/* Fetch args */
-			count = 0;
-			do {
-				str = strsep(&ptr, delim);
-				if (NULL == str)
-					break;
-				sscanf(str, "%i", &temp);
-				buffer[count++] = (u8)temp;
-			} while (1);
-			buffer_len = count;
-			/* Number of args to fetch */
-			wdata.data.length = count;
-			if (wdata.data.length > (priv_args[k].set_args & IW_PRIV_SIZE_MASK))
-				wdata.data.length = priv_args[k].set_args & IW_PRIV_SIZE_MASK;
-			break;
-		case IW_PRIV_TYPE_INT:
-			/* Fetch args */
-			count = 0;
-			do {
-				str = strsep(&ptr, delim);
-				if (NULL == str)
-					break;
-				sscanf(str, "%i", &temp);
-				((s32 *)buffer)[count++] = (s32)temp;
-			} while (1);
-			buffer_len = count * sizeof(s32);
-			/* Number of args to fetch */
-			wdata.data.length = count;
-			if (wdata.data.length > (priv_args[k].set_args & IW_PRIV_SIZE_MASK))
-				wdata.data.length = priv_args[k].set_args & IW_PRIV_SIZE_MASK;
-			break;
-		case IW_PRIV_TYPE_CHAR:
-			if (len > 0) {
-				/* Size of the string to fetch */
-				wdata.data.length = len;
-				if (wdata.data.length > (priv_args[k].set_args & IW_PRIV_SIZE_MASK))
-					wdata.data.length = priv_args[k].set_args & IW_PRIV_SIZE_MASK;
-
-				/* Fetch string */
-				memcpy(buffer, ptr, wdata.data.length);
-			} else {
-				wdata.data.length = 1;
-				buffer[0] = '\0';
-			}
-			buffer_len = wdata.data.length;
-			break;
-		default:
-			DBG_88E("%s: Not yet implemented...\n", __func__);
-			err = -1;
-			goto exit;
-		}
-
-		if ((priv_args[k].set_args & IW_PRIV_SIZE_FIXED) &&
-		    (wdata.data.length != (priv_args[k].set_args & IW_PRIV_SIZE_MASK))) {
-			DBG_88E("%s: The command %s needs exactly %d argument(s)...\n",
-				__func__, cmdname, priv_args[k].set_args & IW_PRIV_SIZE_MASK);
-			err = -EINVAL;
-			goto exit;
-		}
-	} else {
-		/* if args to set */
-		wdata.data.length = 0L;
-	}
-
-	/* Those two tests are important. They define how the driver
-	* will have to handle the data */
-	if ((priv_args[k].set_args & IW_PRIV_SIZE_FIXED) &&
-	    ((get_priv_size(priv_args[k].set_args) + offset) <= IFNAMSIZ)) {
-		/* First case : all SET args fit within wrq */
-		if (offset)
-			wdata.mode = subcmd;
-		memcpy(wdata.name + offset, buffer, IFNAMSIZ - offset);
-	} else {
-		if ((priv_args[k].set_args == 0) &&
-		    (priv_args[k].get_args & IW_PRIV_SIZE_FIXED) &&
-		    (get_priv_size(priv_args[k].get_args) <= IFNAMSIZ)) {
-			/* Second case : no SET args, GET args fit within wrq */
-			if (offset)
-				wdata.mode = subcmd;
-		} else {
-			/* Third case : args won't fit in wrq, or variable number of args */
-			if (copy_to_user(wdata.data.pointer, buffer, buffer_len)) {
-				err = -EFAULT;
-				goto exit;
-			}
-			wdata.data.flags = subcmd;
-		}
-	}
-
-	kfree(input);
-	input = NULL;
-
-	extra_size = 0;
-	if (IW_IS_SET(priv_args[k].cmd)) {
-		/* Size of set arguments */
-		extra_size = get_priv_size(priv_args[k].set_args);
-
-		/* Does it fits in iwr ? */
-		if ((priv_args[k].set_args & IW_PRIV_SIZE_FIXED) &&
-		    ((extra_size + offset) <= IFNAMSIZ))
-			extra_size = 0;
-	} else {
-		/* Size of get arguments */
-		extra_size = get_priv_size(priv_args[k].get_args);
-
-		/* Does it fits in iwr ? */
-		if ((priv_args[k].get_args & IW_PRIV_SIZE_FIXED) &&
-		    (extra_size <= IFNAMSIZ))
-			extra_size = 0;
-	}
-
-	if (extra_size == 0) {
-		extra = (u8 *)&wdata;
-		kfree(buffer);
-		buffer = NULL;
-	} else {
-		extra = buffer;
-	}
-
-	handler = priv[priv_args[k].cmd - SIOCIWFIRSTPRIV];
-	err = handler(dev, NULL, &wdata, extra);
-
-	/* If we have to get some data */
-	if ((priv_args[k].get_args & IW_PRIV_TYPE_MASK) &&
-	    (priv_args[k].get_args & IW_PRIV_SIZE_MASK)) {
-		int j;
-		int n = 0;	/* number of args */
-		u8 str[20] = {0};
-
-		/* Check where is the returned data */
-		if ((priv_args[k].get_args & IW_PRIV_SIZE_FIXED) &&
-		    (get_priv_size(priv_args[k].get_args) <= IFNAMSIZ))
-			n = priv_args[k].get_args & IW_PRIV_SIZE_MASK;
-		else
-			n = wdata.data.length;
-
-		output = kzalloc(4096, GFP_KERNEL);
-		if (NULL == output) {
-			err =  -ENOMEM;
-			goto exit;
-		}
-		switch (priv_args[k].get_args & IW_PRIV_TYPE_MASK) {
-		case IW_PRIV_TYPE_BYTE:
-			/* Display args */
-			for (j = 0; j < n; j++) {
-				sprintf(str, "%d  ", extra[j]);
-				len = strlen(str);
-				output_len = strlen(output);
-				if ((output_len + len + 1) > 4096) {
-					err = -E2BIG;
-					goto exit;
-				}
-				memcpy(output+output_len, str, len);
-			}
-			break;
-		case IW_PRIV_TYPE_INT:
-			/* Display args */
-			for (j = 0; j < n; j++) {
-				sprintf(str, "%d  ", ((__s32 *)extra)[j]);
-				len = strlen(str);
-				output_len = strlen(output);
-				if ((output_len + len + 1) > 4096) {
-					err = -E2BIG;
-					goto exit;
-				}
-				memcpy(output+output_len, str, len);
-			}
-			break;
-		case IW_PRIV_TYPE_CHAR:
-			/* Display args */
-			memcpy(output, extra, n);
-			break;
-		default:
-			DBG_88E("%s: Not yet implemented...\n", __func__);
-			err = -1;
-			goto exit;
-		}
-
-		output_len = strlen(output) + 1;
-		wrq_data->data.length = output_len;
-		if (copy_to_user(wrq_data->data.pointer, output, output_len)) {
-			err = -EFAULT;
-			goto exit;
-		}
-	} else {
-		/* if args to set */
-		wrq_data->data.length = 0;
-	}
-
-exit:
-	kfree(input);
-	kfree(buffer);
-	kfree(output);
-	return err;
-}
-- 
2.31.1

