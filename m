Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CB33D0FAF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbhGUM7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 08:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238223AbhGUM5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:57:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5589CC0613DC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:34 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id qb4so3252936ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9aHB5wDXtjVablMoi0Fk0IO6LvsBphTljb6rirl7ru4=;
        b=miDF4q5pO5yqJYFUy7KW/hYf2j46LKY4eJG+iW20XQtv+ic5b06tEf7bWj9HEyHjZv
         paxjXSfEXhRlC6sld4XzhKs8KsTxEjqqRfR2/t+ssD1mmzLvLnQ8KE8nrevPUJeJF7Xk
         QPRTcpnVa37+QagxiudqhiIBWO17P927MW8EWKn3ul3QAXElzIUKU8ly4U+8o3VEpi58
         IA9rHxmQiUBc/FNmZ/yOKYxRM+8QWLwj/b8Xx+eSYEorBRz2rGkSM1MiqR5vVQhQelaf
         ejMl69fRBJ4XnaS44zdh+Poa3MZT87jEppnn8Qn3rsoZmOIjrdUoJ952t7SzKdYR4cg9
         6HQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9aHB5wDXtjVablMoi0Fk0IO6LvsBphTljb6rirl7ru4=;
        b=E0eG+wG7uS/6P/JHJQSyOWcYUlCqlppH9fdMqPoH+546kWDM6ozsnPKOG/+swXtMKk
         3cuNCCRYb9/UX8ramq56NurmrhNaowGuN8sKcFXsmSiKukUXUtdyvdRosrIwO2CN6ySr
         k3oTjUhR4wyrfI4tHzQT2FWhF9vSfhWXulvrafS3zbIlhoBILTfiti8fhIcVSdzSZE3i
         LGZnPSlGNTjLyRlS///tCLqO57st90guEp2en75ZNUDd6H4+vFEluxiERcfSS2hgE28u
         2fqcjMw3788ZSLrC1sPPk9L3UPg/+EM5w9xggaKr+e5PUKVZ57j6MHWiau9n1O8GT5tS
         OyDQ==
X-Gm-Message-State: AOAM5315hTC82x02vuB4P2YYcUdViLHM5wKRrHz6zNnDP+Cow/f2Z1Q6
        mPt+Pz8O2/J5fe9oEFUeH+GO9vnLSLw=
X-Google-Smtp-Source: ABdhPJwy/b10bIoRYQnp4Gebk+OKIIsuchrI2l+iMTa6NZUIY+NkqgS85LS+owWWSu5gAM2hdwVamw==
X-Received: by 2002:a17:906:e088:: with SMTP id gh8mr38698680ejb.125.1626874652827;
        Wed, 21 Jul 2021 06:37:32 -0700 (PDT)
Received: from agape ([5.171.73.45])
        by smtp.gmail.com with ESMTPSA id g8sm11113099eds.25.2021.07.21.06.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 06:37:32 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/16] staging: rtl8723bs: remove 5Ghz code blocks
Date:   Wed, 21 Jul 2021 15:37:12 +0200
Message-Id: <c64443b92ce1a60f568db153842a62e3244a8c3a.1626874164.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1626874164.git.fabioaiuto83@gmail.com>
References: <cover.1626874164.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove 5 Ghz code blocks, related to networks
working over channel numbers above 14.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  7 ++-----
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 20 +++----------------
 2 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index af7d133bce94..2df8ed649519 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -3708,7 +3708,7 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 			p = rtw_get_ie(pbss_network->IEs + _FIXED_IE_LENGTH_, WLAN_EID_HT_CAPABILITY, &len, pbss_network->IELength - _FIXED_IE_LENGTH_);
 			if ((p == NULL) || (len == 0)) {/* non-HT */
 
-				if ((pbss_network->Configuration.DSConfig <= 0) || (pbss_network->Configuration.DSConfig > 14))
+				if (pbss_network->Configuration.DSConfig <= 0)
 					continue;
 
 				ICS[0][pbss_network->Configuration.DSConfig] = 1;
@@ -5428,10 +5428,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 			{
 				struct HT_info_element *pht_info = (struct HT_info_element *)(pIE->data);
 
-				if (pnetwork->Configuration.DSConfig > 14) {
-					if ((pregpriv->bw_mode >> 4) > CHANNEL_WIDTH_20)
-						cbw40_enable = 1;
-				} else {
+				if (pnetwork->Configuration.DSConfig <= 14) {
 					if ((pregpriv->bw_mode & 0x0f) > CHANNEL_WIDTH_20)
 						cbw40_enable = 1;
 				}
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 965558516cbd..8af81c4ff8db 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -129,14 +129,7 @@ static char *translate_scan(struct adapter *padapter,
 		else
 			snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11bg");
 	} else {
-		if (pnetwork->network.Configuration.DSConfig > 14) {
-			if (vht_cap)
-				snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11AC");
-			else if (ht_cap)
-				snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11an");
-			else
-				snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11a");
-		} else {
+		if (pnetwork->network.Configuration.DSConfig <= 14) {
 			if (ht_cap)
 				snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11gn");
 			else
@@ -683,7 +676,7 @@ static int rtw_wx_get_name(struct net_device *dev,
 	struct adapter *padapter = rtw_netdev_priv(dev);
 	u32 ht_ielen = 0;
 	char *p;
-	u8 ht_cap = false, vht_cap = false;
+	u8 ht_cap = false;
 	struct	mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
 	NDIS_802_11_RATES_EX *prates = NULL;
@@ -707,14 +700,7 @@ static int rtw_wx_get_name(struct net_device *dev,
 			else
 				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11bg");
 		} else {
-			if (pcur_bss->Configuration.DSConfig > 14) {
-				if (vht_cap)
-					snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11AC");
-				else if (ht_cap)
-					snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11an");
-				else
-					snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11a");
-			} else {
+			if (pcur_bss->Configuration.DSConfig <= 14) {
 				if (ht_cap)
 					snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11gn");
 				else
-- 
2.20.1

