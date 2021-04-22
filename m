Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B9E368178
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 15:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbhDVNdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 09:33:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230005AbhDVNdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 09:33:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D15761452;
        Thu, 22 Apr 2021 13:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619098348;
        bh=HaYg8AntHpv2moTHkNC8VL3gq+V6YC01MWWFKsYaKOE=;
        h=From:To:Cc:Subject:Date:From;
        b=gIsPB8NKiJ3Q/siV51BwnYH1WT7Diwcj95eKIue6AKimohPmlbiw+DweMFMMnb9yG
         DmuEod5nzMGepdF/FGr+bPa2lrX3F8N7h5vieS0RgMUnG1p+aLwd9xSAG263Xt+e9x
         udMOPFz2/PsFcNSd6eVq9RPE8lDIhvrZDbyDzpVqa2QjRh42IT2BDdsmoOdxaI0QxG
         lingcKYhyRgQ7pRRcn5S36Zs9ShclgnJAxbDq4B+czIVLYhiav/CZEDQcJgMPGQakR
         sAG3xiMNBvjUO5N6q/dgmv1BMEq/ZkTWcS/PWMeRURHR2YxsQkgh98Ea7ZRBXkgM5/
         bj/1bkO0YLHrA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        Marco Cesati <marcocesati@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Ivan Safonov <insafonov@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: avoid bogus gcc warning
Date:   Thu, 22 Apr 2021 15:32:04 +0200
Message-Id: <20210422133219.1689027-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc gets confused by some of the type casts and produces an
apparently senseless warning about an out-of-bound memcpy to
an unrelated array in the same structure:

drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c: In function 'rtw_cfg80211_ap_set_encryption':
cc1: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
In file included from drivers/staging/rtl8723bs/include/drv_types.h:32,
                 from drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:10:
drivers/staging/rtl8723bs/include/rtw_security.h:98:15: note: at offset [184, 4264] into destination object 'dot11AuthAlgrthm' of size 4
   98 |         u32   dot11AuthAlgrthm;         /*  802.11 auth, could be open, shared, 8021x and authswitch */
      |               ^~~~~~~~~~~~~~~~
cc1: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
drivers/staging/rtl8723bs/include/rtw_security.h:98:15: note: at offset [264, 4344] into destination object 'dot11AuthAlgrthm' of size 4

This is a known gcc bug, and the patch here is only a workaround,
but the approach of using a temporary variable to hold a pointer
to the key also improves readability in addition to avoiding the
warning, so overall this should still help.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99673
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 27 ++++++++++---------
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 21 ++++++++-------
 2 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 89a21eb63c0a..72ce3a3e7d5f 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -523,6 +523,9 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct security_priv *psecuritypriv =  &(padapter->securitypriv);
 	struct sta_priv *pstapriv = &padapter->stapriv;
+	char *grpkey = padapter->securitypriv.dot118021XGrpKey[param->u.crypt.idx].skey;
+	char *txkey = padapter->securitypriv.dot118021XGrptxmickey[param->u.crypt.idx].skey;
+	char *rxkey = padapter->securitypriv.dot118021XGrprxmickey[param->u.crypt.idx].skey;
 
 	param->u.crypt.err = 0;
 	param->u.crypt.alg[IEEE_CRYPT_ALG_NAME_LEN - 1] = '\0';
@@ -605,7 +608,7 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 		{
 			if (strcmp(param->u.crypt.alg, "WEP") == 0)
 			{
-				memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
+				memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 
 				psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
 				if (param->u.crypt.key_len == 13)
@@ -618,12 +621,12 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 			{
 				psecuritypriv->dot118021XGrpPrivacy = _TKIP_;
 
-				memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
+				memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 
 				/* DEBUG_ERR("set key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len); */
 				/* set mic key */
-				memcpy(psecuritypriv->dot118021XGrptxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[16]), 8);
-				memcpy(psecuritypriv->dot118021XGrprxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[24]), 8);
+				memcpy(txkey, &(param->u.crypt.key[16]), 8);
+				memcpy(rxkey, &(param->u.crypt.key[24]), 8);
 
 				psecuritypriv->busetkipkey = true;
 
@@ -632,7 +635,7 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 			{
 				psecuritypriv->dot118021XGrpPrivacy = _AES_;
 
-				memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
+				memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 			}
 			else
 			{
@@ -659,7 +662,6 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 		goto exit;
 
 	}
-
 	if (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X && psta) /*  psk/802_1x */
 	{
 		if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
@@ -709,7 +711,7 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 			{
 				if (strcmp(param->u.crypt.alg, "WEP") == 0)
 				{
-					memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
+					memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 
 					psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
 					if (param->u.crypt.key_len == 13)
@@ -721,12 +723,12 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 				{
 					psecuritypriv->dot118021XGrpPrivacy = _TKIP_;
 
-					memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
+					memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 
 					/* DEBUG_ERR("set key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len); */
 					/* set mic key */
-					memcpy(psecuritypriv->dot118021XGrptxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[16]), 8);
-					memcpy(psecuritypriv->dot118021XGrprxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[24]), 8);
+					memcpy(txkey, &(param->u.crypt.key[16]), 8);
+					memcpy(rxkey, &(param->u.crypt.key[24]), 8);
 
 					psecuritypriv->busetkipkey = true;
 
@@ -735,7 +737,7 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 				{
 					psecuritypriv->dot118021XGrpPrivacy = _AES_;
 
-					memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
+					memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 				}
 				else
 				{
@@ -762,7 +764,6 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 		}
 
 	}
-
 exit:
 
 	return ret;
@@ -885,8 +886,10 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 					if (strcmp(param->u.crypt.alg, "TKIP") == 0 || strcmp(param->u.crypt.alg, "CCMP") == 0)
 					{
 						memcpy(padapter->securitypriv.dot118021XGrpKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
+#if 1
 						memcpy(padapter->securitypriv.dot118021XGrptxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[16]), 8);
 						memcpy(padapter->securitypriv.dot118021XGrprxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[24]), 8);
+#endif
 	                                        padapter->securitypriv.binstallGrpkey = true;
 
 						padapter->securitypriv.dot118021XGrpKeyid = param->u.crypt.idx;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 816033b6847c..af77f03df7d0 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2963,6 +2963,9 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct security_priv *psecuritypriv = &(padapter->securitypriv);
 	struct sta_priv *pstapriv = &padapter->stapriv;
+	char *txkey = padapter->securitypriv.dot118021XGrptxmickey[param->u.crypt.idx].skey;
+	char *rxkey = padapter->securitypriv.dot118021XGrprxmickey[param->u.crypt.idx].skey;
+	char *grpkey = psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey;
 
 	param->u.crypt.err = 0;
 	param->u.crypt.alg[IEEE_CRYPT_ALG_NAME_LEN - 1] = '\0';
@@ -3064,7 +3067,7 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 	if (!psta && check_fwstate(pmlmepriv, WIFI_AP_STATE)) { /*  group key */
 		if (param->u.crypt.set_tx == 1) {
 			if (strcmp(param->u.crypt.alg, "WEP") == 0) {
-				memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
+				memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 
 				psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
 				if (param->u.crypt.key_len == 13)
@@ -3073,11 +3076,11 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 			} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
 				psecuritypriv->dot118021XGrpPrivacy = _TKIP_;
 
-				memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
+				memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 
 				/* DEBUG_ERR("set key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len); */
 				/* set mic key */
-				memcpy(psecuritypriv->dot118021XGrptxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[16]), 8);
+				memcpy(txkey, &(param->u.crypt.key[16]), 8);
 				memcpy(psecuritypriv->dot118021XGrprxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[24]), 8);
 
 				psecuritypriv->busetkipkey = true;
@@ -3086,7 +3089,7 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 			else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
 				psecuritypriv->dot118021XGrpPrivacy = _AES_;
 
-				memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
+				memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 			} else {
 				psecuritypriv->dot118021XGrpPrivacy = _NO_PRIVACY_;
 			}
@@ -3142,7 +3145,7 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 			} else { /* group key??? */
 				if (strcmp(param->u.crypt.alg, "WEP") == 0) {
-					memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
+					memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 
 					psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
 					if (param->u.crypt.key_len == 13)
@@ -3150,19 +3153,19 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 				} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
 					psecuritypriv->dot118021XGrpPrivacy = _TKIP_;
 
-					memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
+					memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 
 					/* DEBUG_ERR("set key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len); */
 					/* set mic key */
-					memcpy(psecuritypriv->dot118021XGrptxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[16]), 8);
-					memcpy(psecuritypriv->dot118021XGrprxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[24]), 8);
+					memcpy(txkey, &(param->u.crypt.key[16]), 8);
+					memcpy(rxkey, &(param->u.crypt.key[24]), 8);
 
 					psecuritypriv->busetkipkey = true;
 
 				} else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
 					psecuritypriv->dot118021XGrpPrivacy = _AES_;
 
-					memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
+					memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 				} else {
 					psecuritypriv->dot118021XGrpPrivacy = _NO_PRIVACY_;
 				}
-- 
2.29.2

