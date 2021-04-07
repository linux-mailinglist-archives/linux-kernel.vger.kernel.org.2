Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4E4356DE0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352691AbhDGNvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352642AbhDGNus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:50:48 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB822C0613DE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 06:50:26 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f12so12089642wro.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 06:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RzVpqlirpSeKD6iL11imtjoi7TolAZSkpIGTe37p8RE=;
        b=dIL2bmkwvsd8jWLjHsFP1KRI37JBkbnNYTDOyKzsUUHV1I+AG7quaxMe+CJcbeS5vc
         +2uVqP2XjvYqa2ZfzoQoJHy3DzMnlmM8Ku595AwBMJlbmvliMSJGKTtaZsDe6lrEiGSC
         p+2x2UfIKX18QwzA4qz7Q7uqoLVYPtMGokkrusZXIFT67ZumbBHTZdWH2/d5d/cRsbPQ
         YhVc1WB6RfmrrdLEZV+WgD5stwfrxRNkRG05gl5oTPVvExPRRwWZnb5A2j9dJYvgnxI8
         6q3+aiL95f66+0edKk/Jc+qL8Y8SLTqwPG7IPd/Obdv6RGlSJpG3AyVyZiIjENQWd01b
         t60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RzVpqlirpSeKD6iL11imtjoi7TolAZSkpIGTe37p8RE=;
        b=qCFUP9c2qzQjszs4ZMqt1bpUFKL2VRgYYcq6UbZmDsjY3Di6TktkkMMawvqXaw3wMg
         gQTLKOz0ugYVpRLLJ+yki85OQVVOqmsEMjfCsSYQGsAG41KzVxSq8Rzz0vPKjHYtaAsS
         V3078RLkJjYeFHeD/NHqoI9TqCPJWQtJxNxu4IHMODz0F0mby85aG+qhxp/IqyaeRGIC
         OjwrtoIsMEVfHbdMVDXbLcfThuHJfagx4wItBoXHTC4KJ2FFpc6rhBABwM/YMSTlFZe4
         lzZYC1EOUwPcb784v3S5Z1jtONDL5f91KIrJVPhRUnmEnOv8QLTXHojFTAeQdZZUCpFy
         LmJw==
X-Gm-Message-State: AOAM530aK/xYN4VYGI4GNDvfN4KStUFxcVucV5OkcKU2Re2h/c78twNs
        GZUgXG5NwKRap3FFKD43xTQ=
X-Google-Smtp-Source: ABdhPJxQBZshc4VcxSh9k1tn4Nu/y94jvs3RZlP0y07I80BXtsTorb8qlmIKkZLCnvLpu4b2ksyPOw==
X-Received: by 2002:adf:e604:: with SMTP id p4mr4690713wrm.53.1617803425682;
        Wed, 07 Apr 2021 06:50:25 -0700 (PDT)
Received: from agape ([5.171.81.68])
        by smtp.gmail.com with ESMTPSA id u12sm15139416wro.51.2021.04.07.06.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 06:50:25 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 18/19] staging: rtl8723bs: split long lines
Date:   Wed,  7 Apr 2021 15:49:42 +0200
Message-Id: <814139162ef516bb07bb50876578b032573271ac.1617802415.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617802415.git.fabioaiuto83@gmail.com>
References: <cover.1617802415.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following post-commit checkpatch hooks:

WARNING: line length of 110 exceeds 100 columns
266: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:623:
+			pmlmepriv->cur_network.join_res) || check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE))
--
WARNING: line length of 102 exceeds 100 columns
468: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:5234:
+				if (tx_chk != _SUCCESS && pmlmeinfo->link_count++ == link_count_limit)
--
WARNING: line length of 124 exceeds 100 columns
543: FILE: drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:335:
+	if ((padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) && !(padapter->securitypriv.binstallGrpkey))
--
WARNING: line length of 112 exceeds 100 columns
828: FILE: drivers/staging/rtl8723bs/core/rtw_wlan_util.c:1061:
+		if (TEST_FLAG(phtpriv->stbc_cap, STBC_HT_ENABLE_TX) && GET_HT_CAPABILITY_ELE_TX_STBC(pIE->data))
--
WARNING: line length of 113 exceeds 100 columns
836: FILE: drivers/staging/rtl8723bs/core/rtw_wlan_util.c:1067:
+		if (TEST_FLAG(phtpriv->ldpc_cap, LDPC_HT_ENABLE_TX) && GET_HT_CAPABILITY_ELE_LDPC_CAP(pIE->data))
--
WARNING: line length of 112 exceeds 100 columns
844: FILE: drivers/staging/rtl8723bs/core/rtw_wlan_util.c:1073:
+		if (TEST_FLAG(phtpriv->stbc_cap, STBC_HT_ENABLE_TX) && GET_HT_CAPABILITY_ELE_RX_STBC(pIE->data))
--
WARNING: line length of 125 exceeds 100 columns
883: FILE: drivers/staging/rtl8723bs/core/rtw_wlan_util.c:1282:
+		rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, WLAN_EID_HT_OPERATION, &len, bssid->IELength - _FIXED_IE_LENGTH_);
--
WARNING: line length of 101 exceeds 100 columns
904: FILE: drivers/staging/rtl8723bs/core/rtw_wlan_util.c:1305:
+		if (bssid->Ssid.Ssid[0] != '\0' && bssid->Ssid.SsidLength != 0) /* not hidden ssid */
--
WARNING: line length of 129 exceeds 100 columns
953: FILE: drivers/staging/rtl8723bs/core/rtw_wlan_util.c:1345:
+		if (pairwise_cipher != cur_network->BcnInfo.pairwise_cipher || group_cipher != cur_network->BcnInfo.group_cipher)
--
WARNING: line length of 113 exceeds 100 columns
1712: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:2651:

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c  |  8 +++++---
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c   |  3 ++-
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 18 ++++++++++++------
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c |  3 ++-
 4 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 7f998a2f8001..a1e27ba4707e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -619,8 +619,9 @@ unsigned int OnProbeReq(struct adapter *padapter, union recv_frame *precv_frame)
 			return _SUCCESS;
 
 _issue_probersp:
-		if ((check_fwstate(pmlmepriv, _FW_LINKED)  &&
-			pmlmepriv->cur_network.join_res) || check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE))
+		if ((check_fwstate(pmlmepriv, _FW_LINKED) &&
+		     pmlmepriv->cur_network.join_res) ||
+		     check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE))
 			issue_probersp(padapter, get_sa(pframe), is_valid_p2p_probereq);
 	}
 
@@ -5231,7 +5232,8 @@ void linked_status_chk(struct adapter *padapter)
 					}
 				}
 
-				if (tx_chk != _SUCCESS && pmlmeinfo->link_count++ == link_count_limit)
+				if (tx_chk != _SUCCESS &&
+				    pmlmeinfo->link_count++ == link_count_limit)
 					tx_chk = issue_nulldata_in_interrupt(padapter, NULL);
 			}
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index d43462d5e618..893c7a417587 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -332,7 +332,8 @@ static u8 PS_RDY_CHECK(struct adapter *padapter)
 	)
 		return false;
 
-	if ((padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) && !(padapter->securitypriv.binstallGrpkey))
+	if ((padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) &&
+	    !(padapter->securitypriv.binstallGrpkey))
 		return false;
 
 	if (!rtw_cfg80211_pwr_mgmt(padapter))
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 8c516ed370f4..76c4105d1fe8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1058,19 +1058,22 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		/*  Config STBC setting */
-		if (TEST_FLAG(phtpriv->stbc_cap, STBC_HT_ENABLE_TX) && GET_HT_CAPABILITY_ELE_TX_STBC(pIE->data))
+		if (TEST_FLAG(phtpriv->stbc_cap, STBC_HT_ENABLE_TX) &&
+		    GET_HT_CAPABILITY_ELE_TX_STBC(pIE->data))
 			SET_FLAG(cur_stbc_cap, STBC_HT_ENABLE_TX);
 
 		phtpriv->stbc_cap = cur_stbc_cap;
 	} else {
 		/*  Config LDPC Coding Capability */
-		if (TEST_FLAG(phtpriv->ldpc_cap, LDPC_HT_ENABLE_TX) && GET_HT_CAPABILITY_ELE_LDPC_CAP(pIE->data))
+		if (TEST_FLAG(phtpriv->ldpc_cap, LDPC_HT_ENABLE_TX) &&
+		    GET_HT_CAPABILITY_ELE_LDPC_CAP(pIE->data))
 			SET_FLAG(cur_ldpc_cap, (LDPC_HT_ENABLE_TX | LDPC_HT_CAP_TX));
 
 		phtpriv->ldpc_cap = cur_ldpc_cap;
 
 		/*  Config STBC setting */
-		if (TEST_FLAG(phtpriv->stbc_cap, STBC_HT_ENABLE_TX) && GET_HT_CAPABILITY_ELE_RX_STBC(pIE->data))
+		if (TEST_FLAG(phtpriv->stbc_cap, STBC_HT_ENABLE_TX) &&
+		    GET_HT_CAPABILITY_ELE_RX_STBC(pIE->data))
 			SET_FLAG(cur_stbc_cap, (STBC_HT_ENABLE_TX | STBC_HT_CAP_TX));
 
 		phtpriv->stbc_cap = cur_stbc_cap;
@@ -1279,7 +1282,8 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	if (p) {
 			bcn_channel = *(p + 2);
 	} else {/* In 5G, some ap do not have DSSET IE checking HT info for channel */
-		rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, WLAN_EID_HT_OPERATION, &len, bssid->IELength - _FIXED_IE_LENGTH_);
+		rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, WLAN_EID_HT_OPERATION,
+			   &len, bssid->IELength - _FIXED_IE_LENGTH_);
 		if (pht_info)
 			bcn_channel = pht_info->primary_channel;
 		else /* we don't find channel IE, so don't check it */
@@ -1302,7 +1306,8 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 
 	if (memcmp(bssid->Ssid.Ssid, cur_network->network.Ssid.Ssid, 32) ||
 			bssid->Ssid.SsidLength != cur_network->network.Ssid.SsidLength)
-		if (bssid->Ssid.Ssid[0] != '\0' && bssid->Ssid.SsidLength != 0) /* not hidden ssid */
+		if (bssid->Ssid.Ssid[0] != '\0' &&
+		    bssid->Ssid.SsidLength != 0) /* not hidden ssid */
 			goto _mismatch;
 
 	/* check encryption info */
@@ -1342,7 +1347,8 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 						  &pairwise_cipher, &is_8021x);
 		}
 
-		if (pairwise_cipher != cur_network->BcnInfo.pairwise_cipher || group_cipher != cur_network->BcnInfo.group_cipher)
+		if (pairwise_cipher != cur_network->BcnInfo.pairwise_cipher ||
+		    group_cipher != cur_network->BcnInfo.group_cipher)
 			goto _mismatch;
 
 		if (is_8021x != cur_network->BcnInfo.is_8021x)
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 679deb781321..a9820d813d8b 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2648,7 +2648,8 @@ static int rtw_dbg_port(struct net_device *dev,
 					struct registry_priv *pregpriv = &padapter->registrypriv;
 					/*  0: disable, bit(0):enable 2.4g, bit(1):enable 5g, 0x3: enable both 2.4g and 5g */
 					/* default is set to enable 2.4GHZ for IOT issue with bufflao's AP at 5GHZ */
-					if (extra_arg == 0 || extra_arg == 1 || extra_arg == 2 || extra_arg == 3)
+					if (extra_arg == 0 || extra_arg == 1 ||
+					    extra_arg == 2 || extra_arg == 3)
 						pregpriv->rx_stbc = extra_arg;
 				}
 				break;
-- 
2.20.1

