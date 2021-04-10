Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6DE35AE31
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbhDJOXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbhDJOV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:21:28 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE58C061347
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:21:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id s15so9784781edd.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W7Kv7f/29V71pu6rmSUwewCJKEOJLcvfozN05jxY9Dk=;
        b=RCqWs/14SFLfSQnPHMh4jgPcc/rYANChNR6gsNMmGNlkTzrTf8MLh6MVsOhyR7apsA
         u89b+Ddbr7iMO0G1Gx2znxvEsecNooJGozBwov2aiF2wblGlOHL1rglgYfvF9igjep4C
         7Yao8VGacwtNJXLf4nlPo2mOfnOD/fwK9TIoptX1bBovUAEsa4f95QasuXb1C2icwB65
         0YtvhKSC9el99+rNU+/aRuWSAgozAup6uDBpAyCtAYluzv7syDiNsHMes8MDjNczVnF2
         z0/7+y0JbaNaA27QupLHb7amDyvdpo+nMGRNXT1VRtAMdBkr6yseCAo7dpcAdavtudbN
         FxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W7Kv7f/29V71pu6rmSUwewCJKEOJLcvfozN05jxY9Dk=;
        b=k1gIXZKHdxZnoJPwp2j73Jj7MWyopCDEDzn9DCXEDR6R4k3j4YJ3ZSQKSj4GGVARhN
         0wa5vWY4YdxXPbtlMlWBw/fpXgCjSdLD7FG+aMFQbxUqlJ2ay63IqB2r9V4zBBtC0Tun
         BKKfK9TFCv7gU5jP1+GNmUdHKQNqPjqR3n1CrJ0yaJF5JLvu2WLLToTmgoCnk4B7r57Z
         JSwqqFl4srDnSXNzP0OCgkDb48jRxEprNQhfE6heWoaWVrjUzl5h5Qe5kgbwF999aKbG
         Ws4Uhf7UCKxIW/PhPmZWtURNu9IX+/VP/gbyv7L6/MF0gyvPG3iYKUulvhE8kNoAyc+9
         Kwbw==
X-Gm-Message-State: AOAM530+jeHILo6C+pG3RLn+dNlj1H5B7putyE6PlArlS/R8heoDptZa
        d/rfR2jtMaMKQK2Q/ZnCVQKnjW2RFbPOYQ==
X-Google-Smtp-Source: ABdhPJyrP+ry2RQidwxgz7pkOqz1qDQVhJDj0SFxx39Kvw9ygjWcEj+D8somFFBZQUp/JEC6GqmRHQ==
X-Received: by 2002:a05:6402:1c04:: with SMTP id ck4mr21803128edb.74.1618064470259;
        Sat, 10 Apr 2021 07:21:10 -0700 (PDT)
Received: from agape ([5.171.81.28])
        by smtp.gmail.com with ESMTPSA id w22sm3238984edl.92.2021.04.10.07.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 07:21:10 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 19/25] staging: rtl8723bs: remove empty if and else blocks
Date:   Sat, 10 Apr 2021 16:20:32 +0200
Message-Id: <2d2e09d5033bda1ceb77576e582ecf1dcfccf428.1618064274.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618064274.git.fabioaiuto83@gmail.com>
References: <cover.1618064274.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove if and else blocks after DBG_8192C removal

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  |  1 -
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |  7 -----
 drivers/staging/rtl8723bs/hal/sdio_ops.c      |  1 -
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 27 +++----------------
 4 files changed, 3 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index f5aa9a680446..2451875ab3c0 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -975,7 +975,6 @@ void rtl8723b_download_BTCoex_AP_mode_rsvd_page(struct adapter *padapter)
 	if (bcn_valid) {
 		struct pwrctrl_priv *pwrctl = adapter_to_pwrctl(padapter);
 		pwrctl->fw_psmode_iface_id = padapter->iface_id;
-	} else {
 	}
 
 	/*  2010.05.11. Added by tynli. */
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 54cb1ab8d4cf..6bf0cbb17b99 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -678,10 +678,6 @@ static void Hal_EfusePowerSwitch(
 
 				mdelay(10);
 			} while (1);
-
-			if (count >= 100) {
-			} else {
-			}
 		}
 
 		rtw_write8(padapter, REG_EFUSE_ACCESS_8723, EFUSE_ACCESS_ON_8723);
@@ -3671,9 +3667,6 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 						break;
 				} while (--trycnt);
 
-				if (trycnt == 0) {
-				}
-
 				/*  RQPN Load 0 */
 				rtw_write16(padapter, REG_RQPN_NPQ, 0);
 				rtw_write32(padapter, REG_RQPN, 0x80000000);
diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index 98a74f6c6876..701f1abbd0f0 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -904,7 +904,6 @@ void sd_int_dpc(struct adapter *adapter)
 			_sd_read(intfhdl, addr, 4, status);
 			_sd_write(intfhdl, addr, 4, status);
 			kfree(status);
-		} else {
 		}
 	}
 
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 54c65c125c8c..4014b692d954 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -851,10 +851,7 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 		if (check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_MP_STATE) == true) /* sta mode */
 		{
 			psta = rtw_get_stainfo(pstapriv, get_bssid(pmlmepriv));
-			if (psta == NULL) {
-			}
-			else
-			{
+			if (psta != NULL) {
 				/* Jeff: don't disable ieee8021x_blocked while clearing key */
 				if (strcmp(param->u.crypt.alg, "none") != 0)
 					psta->ieee8021x_blocked = false;
@@ -1021,9 +1018,6 @@ static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,
         {
                 ret =  rtw_cfg80211_set_encryption(ndev, param, param_len);
         }
-	else
-	{
-	}
 
 addkey_end:
 	kfree(param);
@@ -1228,10 +1222,7 @@ void rtw_cfg80211_indicate_scan_done(struct adapter *adapter, bool aborted)
 	spin_lock_bh(&pwdev_priv->scan_req_lock);
 	if (pwdev_priv->scan_request) {
 		/* avoid WARN_ON(request != wiphy_to_dev(request->wiphy)->scan_req); */
-		if (pwdev_priv->scan_request->wiphy != pwdev_priv->rtw_wdev->wiphy)
-		{
-		}
-		else
+		if (pwdev_priv->scan_request->wiphy == pwdev_priv->rtw_wdev->wiphy)
 		{
 			cfg80211_scan_done(pwdev_priv->scan_request, &info);
 		}
@@ -1365,10 +1356,6 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	{
 		if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS|_FW_UNDER_SURVEY|_FW_UNDER_LINKING) == true)
 		{
-			if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS))
-			{
-			}
-
 			need_indicate_scan_done = true;
 			goto check_need_indicate_scan_done;
 		}
@@ -1581,9 +1568,6 @@ static int rtw_cfg80211_set_key_mgt(struct security_priv *psecuritypriv, u32 key
 	else if (key_mgt == WLAN_AKM_SUITE_PSK) {
 		psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
 	}
-	else {
-		/* return -EINVAL; */
-	}
 
 	return 0;
 }
@@ -2232,10 +2216,8 @@ static netdev_tx_t rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struc
 
 		dump_mgntframe(padapter, pmgntframe);
 
-	} else {
 	}
 
-
 fail:
 
 	dev_kfree_skb_any(skb);
@@ -2512,8 +2494,7 @@ static int cfg80211_rtw_del_station(struct wiphy *wiphy, struct net_device *ndev
 		plist = get_next(plist);
 
 		if (!memcmp((u8 *)mac, psta->hwaddr, ETH_ALEN)) {
-			if (psta->dot8021xalg == 1 && psta->bpairwise_key_installed == false) {
-			} else {
+			if (psta->dot8021xalg != 1 || psta->bpairwise_key_installed == true) {
 				list_del_init(&psta->asoc_list);
 				pstapriv->asoc_list_cnt--;
 
@@ -2783,9 +2764,7 @@ static void rtw_cfg80211_init_ht_capab(struct ieee80211_sta_ht_cap *ht_cap, enum
 		ht_cap->mcs.rx_mask[4] = 0x01;
 
 		ht_cap->mcs.rx_highest = cpu_to_le16(MAX_BIT_RATE_40MHZ_MCS15);
-	} else {
 	}
-
 }
 
 void rtw_cfg80211_init_wiphy(struct adapter *padapter)
-- 
2.20.1

