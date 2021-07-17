Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DE13CC3E5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 16:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbhGQPAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 11:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbhGQO7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 10:59:54 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02CFC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 07:56:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u1so15572640wrs.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 07:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ErRRPMiU/cdiVnjTQlqsH1Ke5jCRomBxj7f+q6KInH4=;
        b=pt5bGuBEQk1S6yvuuK/I0rK4AlvJT1Nfm5wGELrSPdjWPmQkm4GBmghk7uBKKnmGzI
         e5KozmO5XeyT2Q+M7t2PxgMWQ63pJD/EMNIF0WlCHuwcIJ3gYX8th2ESm8p9OhjXFFBv
         ukUpvzv8lF33Ok1oZCShY8vxuVGPFtpUlr6M8BUJjqZwd1NTHUVUKJDjEwAvemf3r85u
         EJmJtSUSBDsAdnaZnb1dboXnwGdpKWIoqGmzHyruxGHPISk1uE/12gtXTJ46QhZlZiNk
         xdjZS6o2D/AA4LnsTxBaqvr3Iwnek9Kkym4XKkf09WNZT7SGASPBQtegf0bguwcQ60GN
         632g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ErRRPMiU/cdiVnjTQlqsH1Ke5jCRomBxj7f+q6KInH4=;
        b=iSy02s0fq6qqvyXo0JgujpcbQBPGIsHtbRsd51+/xMi6H8YM8QT3uYHh0ojcSC32jO
         K78tAHnc3X2OcYtS1mzaZnfLNc2dQcPyk6EqBF9k2o/H3r8s3TtL1/uiPmN44b6X2b1u
         ZT7MXT6DZ6PWSihEPWyMYCzxMnp8bp97Jx0rJqcNtD+pzHz73zc9Y28dl/Y3zPXaB0IY
         SyGl5GPWAgbdzZaHHqbvNiiBuLXTz7D9TN9tGdAfaeFZzCfoOS9iBx2IZ1TEcge+icUt
         nXYkZw2XATzZAeXwI4ZW7Eox4DjgDCI41ATWwJKsqv60WykW1Ea6MI5qqRf1QovKa4Pj
         dpZw==
X-Gm-Message-State: AOAM533sRApbrX/lpRnDGsal1sKR7IlzzrzkTO3DrAZZx4JOtJlD6KN+
        x2uCk9ERZpDNfC0hc/2Koiq7+Vf51V4=
X-Google-Smtp-Source: ABdhPJzU6hW5Cr2ntpfmwF7fF+fdZ0vDFPeHdaih03OuXGysBo1jsqgeP75INXr3WtNDv1kkm9zFew==
X-Received: by 2002:a5d:4402:: with SMTP id z2mr18699594wrq.44.1626533816393;
        Sat, 17 Jul 2021 07:56:56 -0700 (PDT)
Received: from agape ([5.171.72.101])
        by smtp.gmail.com with ESMTPSA id f82sm14257228wmf.25.2021.07.17.07.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 07:56:56 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/10] staging: rtl8723bs: convert IsSupportedHT to snake_case
Date:   Sat, 17 Jul 2021 16:56:43 +0200
Message-Id: <d3e115f3a553db07a52cc51b71d04de9c383f697.1626533647.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1626533647.git.fabioaiuto83@gmail.com>
References: <cover.1626533647.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

convert IsSupportedHT to snake case is_supported_ht.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c    | 2 +-
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c    | 2 +-
 drivers/staging/rtl8723bs/include/ieee80211.h     | 2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index bd5056507f53..fcbbdbe5448b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -554,7 +554,7 @@ u16 rtw_get_cur_max_rate(struct adapter *adapter)
 
 	short_GI = query_ra_short_GI(psta);
 
-	if (IsSupportedHT(psta->wireless_mode)) {
+	if (is_supported_ht(psta->wireless_mode)) {
 		rtw_hal_get_hwreg(adapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
 
 		max_rate = rtw_mcs_rate(rf_type,
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index c06b74f6569a..56c5cb318fdf 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -55,7 +55,7 @@ u8 networktype_to_raid_ex(struct adapter *adapter, struct sta_info *psta)
 
 	if (cur_rf_type == RF_1T1R) {
 		rf_type = RF_1T1R;
-	} else if (IsSupportedHT(psta->wireless_mode)) {
+	} else if (is_supported_ht(psta->wireless_mode)) {
 		if (psta->ra_mask & 0xfff00000)
 			rf_type = RF_2T2R;
 	}
diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index 378c21595e05..8eb0557a077a 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -167,7 +167,7 @@ enum network_type {
 
 #define IsSupportedTxCCK(NetType) (((NetType) & (WIRELESS_11B)) ? true : false)
 #define IsSupportedTxOFDM(NetType) (((NetType) & (WIRELESS_11G) ? true : false)
-#define IsSupportedHT(NetType) (((NetType) & (WIRELESS_11_24N)) ? true : false)
+#define is_supported_ht(NetType) (((NetType) & (WIRELESS_11_24N)) ? true : false)
 
 struct ieee_param {
 	u32 cmd;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index d198d10ec272..368e575c24af 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2106,7 +2106,7 @@ static u8 rtw_get_chan_type(struct adapter *adapter)
 
 	switch (mlme_ext->cur_bwmode) {
 	case CHANNEL_WIDTH_20:
-		if (IsSupportedHT(adapter->registrypriv.wireless_mode))
+		if (is_supported_ht(adapter->registrypriv.wireless_mode))
 			return NL80211_CHAN_HT20;
 		else
 			return NL80211_CHAN_NO_HT;
-- 
2.20.1

