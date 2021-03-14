Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2135133A3B3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 10:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbhCNJDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 05:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbhCNJDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 05:03:43 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB412C061762
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 01:03:42 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id f16so12616750ljm.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 01:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NM5ACNVlNsaeVilpuhcf3lEQy2OFRoK36i9tu3alhXc=;
        b=ghriHR4ENRWqRC44nxpsrAnJjkiQK4VUUKB3i3jA376ctOUhDjxAyr1yZ8dy7QTtHR
         IuHAO2dQznkX7fLfR262fW+t5qwCVz16KIbDXyO8TxRJtsvj4DsA8rZScYVCEVZE5Z0m
         djHsiK7/+/9BmLKKT2oS+nEofn+9yiLm2/hoMiBtcMQNQ5Re0qaz+mIgfeFbeg61RgS2
         BtKQaonOyU8YcE1tejOxYtL+Wbub93ZIe5KBtR9TBirzdj82xgok22VjmGwfe1qMnLYB
         /VCjf133g35FsSsfpYpP71Fnjq4b+sBbpCXIIptCFkOoCDg9g3Vnryti1UY4NmfPyaQo
         R67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NM5ACNVlNsaeVilpuhcf3lEQy2OFRoK36i9tu3alhXc=;
        b=RkwMMxp8b5j1JTzcTTd/Q2LjWZPxY1Tx47HiZrmHTWDxuF3ZfieuXmJyCoOTFxA76B
         75vATNmZLgiyK+61BTV9VJjTqzOMMbkVQSYzhNAiBN85ip0RhrPXm23mrmA4LldI0Tis
         hvHVDCcjj/rBpaHiPpnLWWUm+bSstt9MTpDF6vkmbT/rKYbsXRhmqiBr8vxwbFRe3Mcf
         6h4dKVGZ2rjUWitU512eGPr5Gvo2ZvtNy6IQQarqDkukY2gFp9LYWdwYSM8ryWnN5ZUo
         cXL5b9pJqpJCWA5bvYgyE4FKsnSQEVGjjzarvcmo6aTsElt6weG3auVmMomf9s6Md6Jb
         EoAw==
X-Gm-Message-State: AOAM533tgkwHmgc2+COY1Eq3ZmM38LbR7ekIfXcO7eGT/C985yQahhb0
        PoLQvKbKafuEVNieW90eA74=
X-Google-Smtp-Source: ABdhPJxac/lCpil0vSc5mOE5yBYUjVme3QpLGreVkqd2oCBSXYc7/CsdsPzAEvW+60wWTM7fLSbXvg==
X-Received: by 2002:a2e:7a08:: with SMTP id v8mr7486947ljc.344.1615712620284;
        Sun, 14 Mar 2021 01:03:40 -0800 (PST)
Received: from alpha (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id e24sm2239743lfn.62.2021.03.14.01.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 01:03:39 -0800 (PST)
Received: (nullmailer pid 21233 invoked by uid 1000);
        Sun, 14 Mar 2021 09:03:26 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brooke Basile <brookebasile@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Michael Straube <straube.linux@gmail.com>,
        Mrinal Pandey <mrinalmni@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Simon Fong <simon.fodin@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH 3/4] staging:r8188eu: replace cap_* definitions with native kernel WLAN_CAPABILITY_*
Date:   Sun, 14 Mar 2021 12:02:46 +0300
Message-Id: <20210314090247.21181-4-insafonov@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210314090247.21181-1-insafonov@gmail.com>
References: <20210314090247.21181-1-insafonov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cap_* definitions duplicate WLAN_CAPABILITY_*. Remove cap_* definitions,
improve code consistency.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c |  6 +++---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c  |  6 +++---
 drivers/staging/rtl8188eu/include/wifi.h       | 12 ------------
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index ec5b8be14c2b..7a706fe11750 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
@@ -223,13 +223,13 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
 	/* capability info */
 	*(u16 *)ie = 0;
 
-	*(__le16 *)ie |= cpu_to_le16(cap_IBSS);
+	*(__le16 *)ie |= cpu_to_le16(WLAN_CAPABILITY_IBSS);
 
 	if (pregistrypriv->preamble == PREAMBLE_SHORT)
-		*(__le16 *)ie |= cpu_to_le16(cap_ShortPremble);
+		*(__le16 *)ie |= cpu_to_le16(WLAN_CAPABILITY_SHORT_PREAMBLE);
 
 	if (pdev_network->Privacy)
-		*(__le16 *)ie |= cpu_to_le16(cap_Privacy);
+		*(__le16 *)ie |= cpu_to_le16(WLAN_CAPABILITY_PRIVACY);
 
 	sz += 2;
 	ie += 2;
diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index bee19d5b22c0..50d3c3631be0 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -2188,7 +2188,7 @@ static void start_create_ibss(struct adapter *padapter)
 	/* update capability */
 	caps = rtw_get_capability(pnetwork);
 	update_capinfo(padapter, caps);
-	if (caps & cap_IBSS) {/* adhoc master */
+	if (caps & WLAN_CAPABILITY_IBSS) {/* adhoc master */
 		val8 = 0xcf;
 		rtw_hal_set_hwreg(padapter, HW_VAR_SEC_CFG, (u8 *)(&val8));
 
@@ -2240,7 +2240,7 @@ static void start_clnt_join(struct adapter *padapter)
 	/* update capability */
 	caps = rtw_get_capability(pnetwork);
 	update_capinfo(padapter, caps);
-	if (caps & cap_ESS) {
+	if (caps & WLAN_CAPABILITY_ESS) {
 		Set_MSR(padapter, WIFI_FW_STATION_STATE);
 
 		val8 = (pmlmeinfo->auth_algo == dot11AuthAlgrthm_8021X) ? 0xcc : 0xcf;
@@ -2258,7 +2258,7 @@ static void start_clnt_join(struct adapter *padapter)
 			  msecs_to_jiffies((REAUTH_TO * REAUTH_LIMIT) + (REASSOC_TO * REASSOC_LIMIT) + beacon_timeout));
 
 		pmlmeinfo->state = WIFI_FW_AUTH_NULL | WIFI_FW_STATION_STATE;
-	} else if (caps & cap_IBSS) { /* adhoc client */
+	} else if (caps & WLAN_CAPABILITY_IBSS) { /* adhoc client */
 		Set_MSR(padapter, WIFI_FW_ADHOC_STATE);
 
 		val8 = 0xcf;
diff --git a/drivers/staging/rtl8188eu/include/wifi.h b/drivers/staging/rtl8188eu/include/wifi.h
index f03359602db7..d65a0a88a69a 100644
--- a/drivers/staging/rtl8188eu/include/wifi.h
+++ b/drivers/staging/rtl8188eu/include/wifi.h
@@ -238,18 +238,6 @@ static inline int IsFrameTypeCtrl(unsigned char *pframe)
 #define AUTH_ODD_TO		0
 #define AUTH_EVEN_TO		1
 
-#define cap_ESS		BIT(0)
-#define cap_IBSS	BIT(1)
-#define cap_CFPollable	BIT(2)
-#define cap_CFRequest	BIT(3)
-#define cap_Privacy	BIT(4)
-#define cap_ShortPremble BIT(5)
-#define cap_PBCC	BIT(6)
-#define cap_ChAgility	BIT(7)
-#define cap_SpecMgmt	BIT(8)
-#define cap_QoSi	BIT(9)
-#define cap_ShortSlot	BIT(10)
-
 /*-----------------------------------------------------------------------------
 				Below is the definition for 802.11i / 802.1x
 ------------------------------------------------------------------------------*/
-- 
2.26.2

