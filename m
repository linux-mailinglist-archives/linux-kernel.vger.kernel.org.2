Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFF63CC3EC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 16:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhGQPAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 11:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbhGQPAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 11:00:04 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA45C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 07:57:07 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id f9so15504870wrq.11
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 07:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h7cmhoo6uHHiWyqOEukiZuxiFoAIrYlsbE+X0TBfTdY=;
        b=doKjqXkI/gpnoxGX8nWtdVGFLTDHSF+c4lba5VXfY60uhdGMhS3M2aLN1dVT8Yq2xw
         fH6IPtUBOfgl/hXFZENI5RH2bdjWwQGjDJwRijM6jPBsCOhdJ9esdkiIi5+SqybpRT6D
         EpDEYsbySjZDAU5C7z8/f5aIM+vGCMj8wDqDsHHIuvl7dPL5RoHgHvt4TJGXb4d3szAF
         UrKXap501hP2e4aXHGJJGOsh0wbj3xBrKZxjCxy4FjyjeQv8MYnU+6MlDdwp+0uMakj2
         G+UjONQJ7Axc8tUOrvgLkJ5C61fp9gVc6iLd2oNHErw9jU0k1PlzvSrg8ZAqaSdE41Rw
         idhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h7cmhoo6uHHiWyqOEukiZuxiFoAIrYlsbE+X0TBfTdY=;
        b=H1Ui+ZYgs8EZCbfvDRhQ35YyY7eReYXUqAr1mNNStfKJzI2OKccAwbvDyE21YCUnL6
         k0Ry5ncG/jQEBgXlrQYx7rB5K0zYtoXr86+JmVEZBntTrRn/6TunaEF8oS/t7mU6sB75
         iDmf3SDedkUDrCtCCcxFtUDhoyt3dzgYYBhY9R2s5uaFSC6QS3X6WpCVKc+6PtZzq3QC
         8BYbhwyAufOIw8XnZEbgVk6GRgktJNR5IWoX64thxowveTsi1M286a+5RgsNpUPmKXwv
         jIScYn2tMXbEiGZ9zNh06Xo/9sFQerbd9BzNMJ9OIV0n4Zy2OB1JGqTymFF5FTdEOHQX
         jyMg==
X-Gm-Message-State: AOAM530okFGvgDtFV9SkL3ZDYO36qUWZgQTUC6tHJmNSMpt+oqJJjeeL
        jxd/SsZFpS7iaTkydFiyKHj6FGUovAc=
X-Google-Smtp-Source: ABdhPJxamHsM3u1x1WHlbUePsD58eNV/XXJd7c4inKG36h2O7lY0P6VtaLQnA0dlt1f8tlAhHm5qlw==
X-Received: by 2002:adf:e101:: with SMTP id t1mr19540015wrz.215.1626533826048;
        Sat, 17 Jul 2021 07:57:06 -0700 (PDT)
Received: from agape ([5.171.72.101])
        by smtp.gmail.com with ESMTPSA id g138sm13303380wmg.32.2021.07.17.07.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 07:57:05 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/10] staging: rtl8723bs: fix camel case name in macro IsSupportedTxCCK
Date:   Sat, 17 Jul 2021 16:56:50 +0200
Message-Id: <65aec26a3c25f1e756e33bf5f7f5af0cd3b105df.1626533647.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1626533647.git.fabioaiuto83@gmail.com>
References: <cover.1626533647.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix camel case name in macro IsSupportedTxCCK

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c        | 2 +-
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 2 +-
 drivers/staging/rtl8723bs/include/ieee80211.h  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index a6fcb5e9d637..da67adde2ebd 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -402,7 +402,7 @@ void update_bmc_sta(struct adapter *padapter)
 						      supportRateNum,
 						      pcur_network->Configuration.DSConfig
 		);
-		if (IsSupportedTxCCK(network_type)) {
+		if (is_supported_tx_cck(network_type)) {
 			network_type = WIRELESS_11B;
 		} else if (network_type == WIRELESS_INVALID) { /*  error handling */
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 56c5cb318fdf..08f9ba9bf7ff 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1661,7 +1661,7 @@ void update_wireless_mode(struct adapter *padapter)
 
 void update_sta_basic_rate(struct sta_info *psta, u8 wireless_mode)
 {
-	if (IsSupportedTxCCK(wireless_mode)) {
+	if (is_supported_tx_cck(wireless_mode)) {
 		/*  Only B, B/G, and B/G/N AP could use CCK rate */
 		memcpy(psta->bssrateset, rtw_basic_rate_cck, 4);
 		psta->bssratelen = 4;
diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index 9fa79146c39a..07cff4c490a0 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -158,7 +158,7 @@ enum network_type {
 
 #define is_supported_24g(net_type) ((net_type) & SUPPORTED_24G_NETTYPE_MSK ? true : false)
 
-#define IsSupportedTxCCK(NetType) (((NetType) & (WIRELESS_11B)) ? true : false)
+#define is_supported_tx_cck(NetType) (((NetType) & (WIRELESS_11B)) ? true : false)
 #define is_supported_ht(net_type) (((net_type) & (WIRELESS_11_24N)) ? true : false)
 
 struct ieee_param {
-- 
2.20.1

