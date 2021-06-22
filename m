Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B5C3B058A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhFVNNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhFVNMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:12:35 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A702BC061756
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:10:18 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b3so13339371wrm.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MxHDvJTpqTllFjMYMNMljeDBQ43UKJThZHAjbyhvga4=;
        b=ajHugCVewYr8ny/lT4UQ+pkOnlt6sPVR1LHol+QzgPEJ/lA8ed+eRn34nECGKyGkaW
         xIi7aS7hT4ixybkJcKmqCRmX5EmpYhpFKrmdFhjd1lhHSygt+ytWUUSmAG8xzjDuo3ZA
         EQPEGtmX2Ci0Wg6jHHNwI9B4rqyRyEYmsf11f7n8ZlRurOh2CIwYeUm/rBbu727X24wh
         umBcIjr8MOLbjDqkMYos0l39QEcRkwlVIfld7wktWwlAQ1jC6kdKQsOPiZHKy22s8Kc7
         Egtriex45yW7YxJrjJ1i2uVKmGLatvyDJjg+LlVJOWIpgXtvQsGSg+K1+3/YpdCZh1IG
         azZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MxHDvJTpqTllFjMYMNMljeDBQ43UKJThZHAjbyhvga4=;
        b=sJFNo/IAt77evnqDUWMic6JKthmQxyZBbcWhXGSnPIvtP7NP1gUxOEw/kxDhTmV/mR
         a7lHa0UoJlNroTfaYD3rEKPxBYJz6ILAY5Ct1uR1IQAy/coPou2jfQL6AyR4DV970zx7
         wUf7RoccZbQ1ytqQnE3/jJgI89I5+4dPdF0DAXdtOD9jrqp8BtyWpkG1+mkvfASj3ex6
         Z1sXFquAoWmE7i4XNHF7h9JkhwOc7fBq5R59SpWp2/zVaGNv4wUN+AraqD457q8cN6UI
         02YmvdTxmoCrbvL2K57qgHmScaDp00n+N2ikvVNAuklJBGPRmPfULyfQzwOgdzJEkISw
         EvFg==
X-Gm-Message-State: AOAM531VyGYSHytI+4P5qIXEmAqWyJRcFeQ1W+yBYnM648wUM8NDYWHV
        Qy6/wpHMAxvuyg300OBUXjnp29HEI2KXWg==
X-Google-Smtp-Source: ABdhPJxbwuTTpevlF70uRuyjEG5JIMNNRyLfQ48GJrjP4E7IpxB67Fxh+mVN3DG+zMwb7G/C9FbTvA==
X-Received: by 2002:a05:6000:184a:: with SMTP id c10mr4567273wri.232.1624367416914;
        Tue, 22 Jun 2021 06:10:16 -0700 (PDT)
Received: from agape ([5.171.73.108])
        by smtp.gmail.com with ESMTPSA id r10sm17355156wrq.17.2021.06.22.06.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 06:10:16 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/17] staging: rtl8723bs: remove 5Ghz code related to channel plan definition
Date:   Tue, 22 Jun 2021 15:09:53 +0200
Message-Id: <17a707952cec951893748d2cb59d02a294cdd1be.1624367071.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624367071.git.fabioaiuto83@gmail.com>
References: <cover.1624367071.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove 5Ghz code related to channel plan definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 214 ++++++++----------
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    |  34 ---
 drivers/staging/rtl8723bs/include/hal_data.h  |   6 +-
 .../staging/rtl8723bs/include/rtw_mlme_ext.h  |  47 +---
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |   2 -
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    |   1 -
 6 files changed, 97 insertions(+), 207 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index cf0079a0c179..285acd3d843b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -81,93 +81,93 @@ static struct rt_channel_plan_2g	RTW_ChannelPlan2G[RT_CHANNEL_DOMAIN_2G_MAX] = {
 
 static struct rt_channel_plan_map	RTW_ChannelPlanMap[RT_CHANNEL_DOMAIN_MAX] = {
 	/*  0x00 ~ 0x1F , Old Define ===== */
-	{0x02, 0x20},	/* 0x00, RT_CHANNEL_DOMAIN_FCC */
-	{0x02, 0x0A},	/* 0x01, RT_CHANNEL_DOMAIN_IC */
-	{0x01, 0x01},	/* 0x02, RT_CHANNEL_DOMAIN_ETSI */
-	{0x01, 0x00},	/* 0x03, RT_CHANNEL_DOMAIN_SPAIN */
-	{0x01, 0x00},	/* 0x04, RT_CHANNEL_DOMAIN_FRANCE */
-	{0x03, 0x00},	/* 0x05, RT_CHANNEL_DOMAIN_MKK */
-	{0x03, 0x00},	/* 0x06, RT_CHANNEL_DOMAIN_MKK1 */
-	{0x01, 0x09},	/* 0x07, RT_CHANNEL_DOMAIN_ISRAEL */
-	{0x03, 0x09},	/* 0x08, RT_CHANNEL_DOMAIN_TELEC */
-	{0x03, 0x00},	/* 0x09, RT_CHANNEL_DOMAIN_GLOBAL_DOAMIN */
-	{0x00, 0x00},	/* 0x0A, RT_CHANNEL_DOMAIN_WORLD_WIDE_13 */
-	{0x02, 0x0F},	/* 0x0B, RT_CHANNEL_DOMAIN_TAIWAN */
-	{0x01, 0x08},	/* 0x0C, RT_CHANNEL_DOMAIN_CHINA */
-	{0x02, 0x06},	/* 0x0D, RT_CHANNEL_DOMAIN_SINGAPORE_INDIA_MEXICO */
-	{0x02, 0x0B},	/* 0x0E, RT_CHANNEL_DOMAIN_KOREA */
-	{0x02, 0x09},	/* 0x0F, RT_CHANNEL_DOMAIN_TURKEY */
-	{0x01, 0x01},	/* 0x10, RT_CHANNEL_DOMAIN_JAPAN */
-	{0x02, 0x05},	/* 0x11, RT_CHANNEL_DOMAIN_FCC_NO_DFS */
-	{0x01, 0x21},	/* 0x12, RT_CHANNEL_DOMAIN_JAPAN_NO_DFS */
-	{0x00, 0x04},	/* 0x13, RT_CHANNEL_DOMAIN_WORLD_WIDE_5G */
-	{0x02, 0x10},	/* 0x14, RT_CHANNEL_DOMAIN_TAIWAN_NO_DFS */
-	{0x00, 0x21},	/* 0x15, RT_CHANNEL_DOMAIN_ETSI_NO_DFS */
-	{0x00, 0x22},	/* 0x16, RT_CHANNEL_DOMAIN_KOREA_NO_DFS */
-	{0x03, 0x21},	/* 0x17, RT_CHANNEL_DOMAIN_JAPAN_NO_DFS */
-	{0x06, 0x08},	/* 0x18, RT_CHANNEL_DOMAIN_PAKISTAN_NO_DFS */
-	{0x02, 0x08},	/* 0x19, RT_CHANNEL_DOMAIN_TAIWAN2_NO_DFS */
-	{0x00, 0x00},	/* 0x1A, */
-	{0x00, 0x00},	/* 0x1B, */
-	{0x00, 0x00},	/* 0x1C, */
-	{0x00, 0x00},	/* 0x1D, */
-	{0x00, 0x00},	/* 0x1E, */
-	{0x06, 0x04},	/* 0x1F, RT_CHANNEL_DOMAIN_WORLD_WIDE_ONLY_5G */
+	{0x02},	/* 0x00, RT_CHANNEL_DOMAIN_FCC */
+	{0x02},	/* 0x01, RT_CHANNEL_DOMAIN_IC */
+	{0x01},	/* 0x02, RT_CHANNEL_DOMAIN_ETSI */
+	{0x01},	/* 0x03, RT_CHANNEL_DOMAIN_SPAIN */
+	{0x01},	/* 0x04, RT_CHANNEL_DOMAIN_FRANCE */
+	{0x03},	/* 0x05, RT_CHANNEL_DOMAIN_MKK */
+	{0x03},	/* 0x06, RT_CHANNEL_DOMAIN_MKK1 */
+	{0x01},	/* 0x07, RT_CHANNEL_DOMAIN_ISRAEL */
+	{0x03},	/* 0x08, RT_CHANNEL_DOMAIN_TELEC */
+	{0x03},	/* 0x09, RT_CHANNEL_DOMAIN_GLOBAL_DOAMIN */
+	{0x00},	/* 0x0A, RT_CHANNEL_DOMAIN_WORLD_WIDE_13 */
+	{0x02},	/* 0x0B, RT_CHANNEL_DOMAIN_TAIWAN */
+	{0x01},	/* 0x0C, RT_CHANNEL_DOMAIN_CHINA */
+	{0x02},	/* 0x0D, RT_CHANNEL_DOMAIN_SINGAPORE_INDIA_MEXICO */
+	{0x02},	/* 0x0E, RT_CHANNEL_DOMAIN_KOREA */
+	{0x02},	/* 0x0F, RT_CHANNEL_DOMAIN_TURKEY */
+	{0x01},	/* 0x10, RT_CHANNEL_DOMAIN_JAPAN */
+	{0x02},	/* 0x11, RT_CHANNEL_DOMAIN_FCC_NO_DFS */
+	{0x01},	/* 0x12, RT_CHANNEL_DOMAIN_JAPAN_NO_DFS */
+	{0x00},	/* 0x13, RT_CHANNEL_DOMAIN_WORLD_WIDE_5G */
+	{0x02},	/* 0x14, RT_CHANNEL_DOMAIN_TAIWAN_NO_DFS */
+	{0x00},	/* 0x15, RT_CHANNEL_DOMAIN_ETSI_NO_DFS */
+	{0x00},	/* 0x16, RT_CHANNEL_DOMAIN_KOREA_NO_DFS */
+	{0x03},	/* 0x17, RT_CHANNEL_DOMAIN_JAPAN_NO_DFS */
+	{0x06},	/* 0x18, RT_CHANNEL_DOMAIN_PAKISTAN_NO_DFS */
+	{0x02},	/* 0x19, RT_CHANNEL_DOMAIN_TAIWAN2_NO_DFS */
+	{0x00},	/* 0x1A, */
+	{0x00},	/* 0x1B, */
+	{0x00},	/* 0x1C, */
+	{0x00},	/* 0x1D, */
+	{0x00},	/* 0x1E, */
+	{0x06},	/* 0x1F, RT_CHANNEL_DOMAIN_WORLD_WIDE_ONLY_5G */
 	/*  0x20 ~ 0x7F , New Define ===== */
-	{0x00, 0x00},	/* 0x20, RT_CHANNEL_DOMAIN_WORLD_NULL */
-	{0x01, 0x00},	/* 0x21, RT_CHANNEL_DOMAIN_ETSI1_NULL */
-	{0x02, 0x00},	/* 0x22, RT_CHANNEL_DOMAIN_FCC1_NULL */
-	{0x03, 0x00},	/* 0x23, RT_CHANNEL_DOMAIN_MKK1_NULL */
-	{0x04, 0x00},	/* 0x24, RT_CHANNEL_DOMAIN_ETSI2_NULL */
-	{0x02, 0x04},	/* 0x25, RT_CHANNEL_DOMAIN_FCC1_FCC1 */
-	{0x00, 0x01},	/* 0x26, RT_CHANNEL_DOMAIN_WORLD_ETSI1 */
-	{0x03, 0x0C},	/* 0x27, RT_CHANNEL_DOMAIN_MKK1_MKK1 */
-	{0x00, 0x0B},	/* 0x28, RT_CHANNEL_DOMAIN_WORLD_KCC1 */
-	{0x00, 0x05},	/* 0x29, RT_CHANNEL_DOMAIN_WORLD_FCC2 */
-	{0x00, 0x00},	/* 0x2A, */
-	{0x00, 0x00},	/* 0x2B, */
-	{0x00, 0x00},	/* 0x2C, */
-	{0x00, 0x00},	/* 0x2D, */
-	{0x00, 0x00},	/* 0x2E, */
-	{0x00, 0x00},	/* 0x2F, */
-	{0x00, 0x06},	/* 0x30, RT_CHANNEL_DOMAIN_WORLD_FCC3 */
-	{0x00, 0x07},	/* 0x31, RT_CHANNEL_DOMAIN_WORLD_FCC4 */
-	{0x00, 0x08},	/* 0x32, RT_CHANNEL_DOMAIN_WORLD_FCC5 */
-	{0x00, 0x09},	/* 0x33, RT_CHANNEL_DOMAIN_WORLD_FCC6 */
-	{0x02, 0x0A},	/* 0x34, RT_CHANNEL_DOMAIN_FCC1_FCC7 */
-	{0x00, 0x02},	/* 0x35, RT_CHANNEL_DOMAIN_WORLD_ETSI2 */
-	{0x00, 0x03},	/* 0x36, RT_CHANNEL_DOMAIN_WORLD_ETSI3 */
-	{0x03, 0x0D},	/* 0x37, RT_CHANNEL_DOMAIN_MKK1_MKK2 */
-	{0x03, 0x0E},	/* 0x38, RT_CHANNEL_DOMAIN_MKK1_MKK3 */
-	{0x02, 0x0F},	/* 0x39, RT_CHANNEL_DOMAIN_FCC1_NCC1 */
-	{0x00, 0x00},	/* 0x3A, */
-	{0x00, 0x00},	/* 0x3B, */
-	{0x00, 0x00},	/* 0x3C, */
-	{0x00, 0x00},	/* 0x3D, */
-	{0x00, 0x00},	/* 0x3E, */
-	{0x00, 0x00},	/* 0x3F, */
-	{0x02, 0x10},	/* 0x40, RT_CHANNEL_DOMAIN_FCC1_NCC2 */
-	{0x05, 0x00},	/* 0x41, RT_CHANNEL_DOMAIN_GLOBAL_NULL */
-	{0x01, 0x12},	/* 0x42, RT_CHANNEL_DOMAIN_ETSI1_ETSI4 */
-	{0x02, 0x05},	/* 0x43, RT_CHANNEL_DOMAIN_FCC1_FCC2 */
-	{0x02, 0x11},	/* 0x44, RT_CHANNEL_DOMAIN_FCC1_NCC3 */
-	{0x00, 0x13},	/* 0x45, RT_CHANNEL_DOMAIN_WORLD_ETSI5 */
-	{0x02, 0x14},	/* 0x46, RT_CHANNEL_DOMAIN_FCC1_FCC8 */
-	{0x00, 0x15},	/* 0x47, RT_CHANNEL_DOMAIN_WORLD_ETSI6 */
-	{0x00, 0x16},	/* 0x48, RT_CHANNEL_DOMAIN_WORLD_ETSI7 */
-	{0x00, 0x17},	/* 0x49, RT_CHANNEL_DOMAIN_WORLD_ETSI8 */
-	{0x00, 0x18},	/* 0x50, RT_CHANNEL_DOMAIN_WORLD_ETSI9 */
-	{0x00, 0x19},	/* 0x51, RT_CHANNEL_DOMAIN_WORLD_ETSI10 */
-	{0x00, 0x1A},	/* 0x52, RT_CHANNEL_DOMAIN_WORLD_ETSI11 */
-	{0x02, 0x1B},	/* 0x53, RT_CHANNEL_DOMAIN_FCC1_NCC4 */
-	{0x00, 0x1C},	/* 0x54, RT_CHANNEL_DOMAIN_WORLD_ETSI12 */
-	{0x02, 0x1D},	/* 0x55, RT_CHANNEL_DOMAIN_FCC1_FCC9 */
-	{0x00, 0x1E},	/* 0x56, RT_CHANNEL_DOMAIN_WORLD_ETSI13 */
-	{0x02, 0x1F},	/* 0x57, RT_CHANNEL_DOMAIN_FCC1_FCC10 */
+	{0x00},	/* 0x20, RT_CHANNEL_DOMAIN_WORLD_NULL */
+	{0x01},	/* 0x21, RT_CHANNEL_DOMAIN_ETSI1_NULL */
+	{0x02},	/* 0x22, RT_CHANNEL_DOMAIN_FCC1_NULL */
+	{0x03},	/* 0x23, RT_CHANNEL_DOMAIN_MKK1_NULL */
+	{0x04},	/* 0x24, RT_CHANNEL_DOMAIN_ETSI2_NULL */
+	{0x02},	/* 0x25, RT_CHANNEL_DOMAIN_FCC1_FCC1 */
+	{0x00},	/* 0x26, RT_CHANNEL_DOMAIN_WORLD_ETSI1 */
+	{0x03},	/* 0x27, RT_CHANNEL_DOMAIN_MKK1_MKK1 */
+	{0x00},	/* 0x28, RT_CHANNEL_DOMAIN_WORLD_KCC1 */
+	{0x00},	/* 0x29, RT_CHANNEL_DOMAIN_WORLD_FCC2 */
+	{0x00},	/* 0x2A, */
+	{0x00},	/* 0x2B, */
+	{0x00},	/* 0x2C, */
+	{0x00},	/* 0x2D, */
+	{0x00},	/* 0x2E, */
+	{0x00},	/* 0x2F, */
+	{0x00},	/* 0x30, RT_CHANNEL_DOMAIN_WORLD_FCC3 */
+	{0x00},	/* 0x31, RT_CHANNEL_DOMAIN_WORLD_FCC4 */
+	{0x00},	/* 0x32, RT_CHANNEL_DOMAIN_WORLD_FCC5 */
+	{0x00},	/* 0x33, RT_CHANNEL_DOMAIN_WORLD_FCC6 */
+	{0x02},	/* 0x34, RT_CHANNEL_DOMAIN_FCC1_FCC7 */
+	{0x00},	/* 0x35, RT_CHANNEL_DOMAIN_WORLD_ETSI2 */
+	{0x00},	/* 0x36, RT_CHANNEL_DOMAIN_WORLD_ETSI3 */
+	{0x03},	/* 0x37, RT_CHANNEL_DOMAIN_MKK1_MKK2 */
+	{0x03},	/* 0x38, RT_CHANNEL_DOMAIN_MKK1_MKK3 */
+	{0x02},	/* 0x39, RT_CHANNEL_DOMAIN_FCC1_NCC1 */
+	{0x00},	/* 0x3A, */
+	{0x00},	/* 0x3B, */
+	{0x00},	/* 0x3C, */
+	{0x00},	/* 0x3D, */
+	{0x00},	/* 0x3E, */
+	{0x00},	/* 0x3F, */
+	{0x02},	/* 0x40, RT_CHANNEL_DOMAIN_FCC1_NCC2 */
+	{0x05},	/* 0x41, RT_CHANNEL_DOMAIN_GLOBAL_NULL */
+	{0x01},	/* 0x42, RT_CHANNEL_DOMAIN_ETSI1_ETSI4 */
+	{0x02},	/* 0x43, RT_CHANNEL_DOMAIN_FCC1_FCC2 */
+	{0x02},	/* 0x44, RT_CHANNEL_DOMAIN_FCC1_NCC3 */
+	{0x00},	/* 0x45, RT_CHANNEL_DOMAIN_WORLD_ETSI5 */
+	{0x02},	/* 0x46, RT_CHANNEL_DOMAIN_FCC1_FCC8 */
+	{0x00},	/* 0x47, RT_CHANNEL_DOMAIN_WORLD_ETSI6 */
+	{0x00},	/* 0x48, RT_CHANNEL_DOMAIN_WORLD_ETSI7 */
+	{0x00},	/* 0x49, RT_CHANNEL_DOMAIN_WORLD_ETSI8 */
+	{0x00},	/* 0x50, RT_CHANNEL_DOMAIN_WORLD_ETSI9 */
+	{0x00},	/* 0x51, RT_CHANNEL_DOMAIN_WORLD_ETSI10 */
+	{0x00},	/* 0x52, RT_CHANNEL_DOMAIN_WORLD_ETSI11 */
+	{0x02},	/* 0x53, RT_CHANNEL_DOMAIN_FCC1_NCC4 */
+	{0x00},	/* 0x54, RT_CHANNEL_DOMAIN_WORLD_ETSI12 */
+	{0x02},	/* 0x55, RT_CHANNEL_DOMAIN_FCC1_FCC9 */
+	{0x00},	/* 0x56, RT_CHANNEL_DOMAIN_WORLD_ETSI13 */
+	{0x02},	/* 0x57, RT_CHANNEL_DOMAIN_FCC1_FCC10 */
 };
 
  /* use the combination for max channel numbers */
-static struct rt_channel_plan_map RTW_CHANNEL_PLAN_MAP_REALTEK_DEFINE = {0x03, 0x02};
+static struct rt_channel_plan_map RTW_CHANNEL_PLAN_MAP_REALTEK_DEFINE = {0x03};
 
 /* Search the @param ch in given @param ch_set
  * @ch_set: the given channel set
@@ -189,23 +189,6 @@ int rtw_ch_set_search_ch(struct rt_channel_info *ch_set, const u32 ch)
 	return i;
 }
 
-/* Check the @param ch is fit with setband setting of @param adapter
- * @adapter: the given adapter
- * @ch: the given channel number
- *
- * return true when check valid, false not valid
- */
-bool rtw_mlme_band_check(struct adapter *adapter, const u32 ch)
-{
-	if (adapter->setband == GHZ24_50 /* 2.4G and 5G */
-		|| (adapter->setband == GHZ_24 && ch < 35) /* 2.4G only */
-		|| (adapter->setband == GHZ_50 && ch > 35) /* 5G only */
-	) {
-		return true;
-	}
-	return false;
-}
-
 /****************************************************************************
 
 Following are the initialization functions for WiFi MLME
@@ -380,7 +363,6 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, struct rt_c
 				else if ((channel_set[chanset_size].ChannelNum  >= 12 && channel_set[chanset_size].ChannelNum  <= 14))
 					channel_set[chanset_size].ScanType  = SCAN_PASSIVE;
 			} else if (RT_CHANNEL_DOMAIN_WORLD_WIDE_13 == ChannelPlan ||
-				RT_CHANNEL_DOMAIN_WORLD_WIDE_5G == ChannelPlan ||
 				RT_CHANNEL_DOMAIN_2G_WORLD == Index2G) { /*  channel 12~13, passive scan */
 				if (channel_set[chanset_size].ChannelNum <= 11)
 					channel_set[chanset_size].ScanType = SCAN_ACTIVE;
@@ -4434,10 +4416,6 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 	while ((i < MAX_CHANNEL_NUM) && (chplan_new[i].ChannelNum != 0)) {
 		if (chplan_new[i].ChannelNum == channel) {
 			if (chplan_new[i].ScanType == SCAN_PASSIVE) {
-				/* 5G Bnad 2, 3 (DFS) doesn't change to active scan */
-				if (channel >= 52 && channel <= 144)
-					break;
-
 				chplan_new[i].ScanType = SCAN_ACTIVE;
 			}
 			break;
@@ -5557,7 +5535,6 @@ static int rtw_scan_ch_decision(struct adapter *padapter, struct rtw_ieee80211_c
 		set_idx = rtw_ch_set_search_ch(pmlmeext->channel_set, in[i].hw_value);
 		if (in[i].hw_value && !(in[i].flags & RTW_IEEE80211_CHAN_DISABLED)
 			&& set_idx >= 0
-			&& rtw_mlme_band_check(padapter, in[i].hw_value)
 		) {
 			if (j >= out_num) {
 				netdev_dbg(padapter->pnetdev,
@@ -5581,23 +5558,20 @@ static int rtw_scan_ch_decision(struct adapter *padapter, struct rtw_ieee80211_c
 	if (j == 0) {
 		for (i = 0; i < pmlmeext->max_chan_nums; i++) {
 
-			if (rtw_mlme_band_check(padapter, pmlmeext->channel_set[i].ChannelNum)) {
-
-				if (j >= out_num) {
-					netdev_dbg(padapter->pnetdev,
-						   FUNC_ADPT_FMT " out_num:%u not enough\n",
-						   FUNC_ADPT_ARG(padapter),
-						   out_num);
-					break;
-				}
+			if (j >= out_num) {
+				netdev_dbg(padapter->pnetdev,
+					   FUNC_ADPT_FMT " out_num:%u not enough\n",
+					   FUNC_ADPT_ARG(padapter),
+					   out_num);
+				break;
+			}
 
-				out[j].hw_value = pmlmeext->channel_set[i].ChannelNum;
+			out[j].hw_value = pmlmeext->channel_set[i].ChannelNum;
 
-				if (pmlmeext->channel_set[i].ScanType == SCAN_PASSIVE)
-					out[j].flags |= RTW_IEEE80211_CHAN_PASSIVE_SCAN;
+			if (pmlmeext->channel_set[i].ScanType == SCAN_PASSIVE)
+				out[j].flags |= RTW_IEEE80211_CHAN_PASSIVE_SCAN;
 
-				j++;
-			}
+			j++;
 		}
 	}
 
diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 732659a2d844..395eb3b5af71 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -1564,139 +1564,105 @@ void Hal_ChannelPlanToRegulation(struct adapter *Adapter, u16 ChannelPlan)
 		break;
 	case RT_CHANNEL_DOMAIN_FCC1_FCC1:
 		pHalData->Regulation2_4G = TXPWR_LMT_FCC;
-		pHalData->Regulation5G = TXPWR_LMT_FCC;
 		break;
 	case RT_CHANNEL_DOMAIN_WORLD_ETSI1:
 		pHalData->Regulation2_4G = TXPWR_LMT_FCC;
-		pHalData->Regulation5G = TXPWR_LMT_ETSI;
 		break;
 	case RT_CHANNEL_DOMAIN_MKK1_MKK1:
 		pHalData->Regulation2_4G = TXPWR_LMT_MKK;
-		pHalData->Regulation5G = TXPWR_LMT_MKK;
 		break;
 	case RT_CHANNEL_DOMAIN_WORLD_KCC1:
 		pHalData->Regulation2_4G = TXPWR_LMT_FCC;
-		pHalData->Regulation5G = TXPWR_LMT_MKK;
 		break;
 	case RT_CHANNEL_DOMAIN_WORLD_FCC2:
 		pHalData->Regulation2_4G = TXPWR_LMT_FCC;
-		pHalData->Regulation5G = TXPWR_LMT_FCC;
 		break;
 	case RT_CHANNEL_DOMAIN_WORLD_FCC3:
 		pHalData->Regulation2_4G = TXPWR_LMT_FCC;
-		pHalData->Regulation5G = TXPWR_LMT_FCC;
 		break;
 	case RT_CHANNEL_DOMAIN_WORLD_FCC4:
 		pHalData->Regulation2_4G = TXPWR_LMT_FCC;
-		pHalData->Regulation5G = TXPWR_LMT_FCC;
 		break;
 	case RT_CHANNEL_DOMAIN_WORLD_FCC5:
 		pHalData->Regulation2_4G = TXPWR_LMT_FCC;
-		pHalData->Regulation5G = TXPWR_LMT_FCC;
 		break;
 	case RT_CHANNEL_DOMAIN_WORLD_FCC6:
 		pHalData->Regulation2_4G = TXPWR_LMT_FCC;
-		pHalData->Regulation5G = TXPWR_LMT_FCC;
 		break;
 	case RT_CHANNEL_DOMAIN_FCC1_FCC7:
 		pHalData->Regulation2_4G = TXPWR_LMT_FCC;
-		pHalData->Regulation5G = TXPWR_LMT_FCC;
 		break;
 	case RT_CHANNEL_DOMAIN_WORLD_ETSI2:
 		pHalData->Regulation2_4G = TXPWR_LMT_FCC;
-		pHalData->Regulation5G = TXPWR_LMT_FCC;
 		break;
 	case RT_CHANNEL_DOMAIN_WORLD_ETSI3:
 		pHalData->Regulation2_4G = TXPWR_LMT_FCC;
-		pHalData->Regulation5G = TXPWR_LMT_FCC;
 		break;
 	case RT_CHANNEL_DOMAIN_MKK1_MKK2:
 		pHalData->Regulation2_4G = TXPWR_LMT_MKK;
-		pHalData->Regulation5G = TXPWR_LMT_FCC;
 		break;
 	case RT_CHANNEL_DOMAIN_MKK1_MKK3:
 		pHalData->Regulation2_4G = TXPWR_LMT_MKK;
-		pHalData->Regulation5G = TXPWR_LMT_FCC;
 		break;
 	case RT_CHANNEL_DOMAIN_FCC1_NCC1:
 		pHalData->Regulation2_4G = TXPWR_LMT_FCC;
-		pHalData->Regulation5G = TXPWR_LMT_FCC;
 		break;
 	case RT_CHANNEL_DOMAIN_FCC1_NCC2:
 		pHalData->Regulation2_4G = TXPWR_LMT_FCC;
-		pHalData->Regulation5G = TXPWR_LMT_FCC;
 		break;
 	case RT_CHANNEL_DOMAIN_GLOBAL_NULL:
 		pHalData->Regulation2_4G = TXPWR_LMT_WW;
-		pHalData->Regulation5G = TXPWR_LMT_WW;
 		break;
 	case RT_CHANNEL_DOMAIN_ETSI1_ETSI4:
 		pHalData->Regulation2_4G = TXPWR_LMT_ETSI;
-		pHalData->Regulation5G = TXPWR_LMT_ETSI;
 		break;
 	case RT_CHANNEL_DOMAIN_FCC1_FCC2:
 		pHalData->Regulation2_4G = TXPWR_LMT_FCC;
-		pHalData->Regulation5G = TXPWR_LMT_FCC;
 		break;
 	case RT_CHANNEL_DOMAIN_FCC1_NCC3:
 		pHalData->Regulation2_4G = TXPWR_LMT_FCC;
-		pHalData->Regulation5G = TXPWR_LMT_FCC;
 		break;
 	case RT_CHANNEL_DOMAIN_WORLD_ETSI5:
 		pHalData->Regulation2_4G = TXPWR_LMT_ETSI;
-		pHalData->Regulation5G = TXPWR_LMT_ETSI;
 		break;
 	case RT_CHANNEL_DOMAIN_FCC1_FCC8:
 		pHalData->Regulation2_4G = TXPWR_LMT_FCC;
-		pHalData->Regulation5G = TXPWR_LMT_FCC;
 		break;
 	case RT_CHANNEL_DOMAIN_WORLD_ETSI6:
 		pHalData->Regulation2_4G = TXPWR_LMT_ETSI;
-		pHalData->Regulation5G = TXPWR_LMT_ETSI;
 		break;
 	case RT_CHANNEL_DOMAIN_WORLD_ETSI7:
 		pHalData->Regulation2_4G = TXPWR_LMT_ETSI;
-		pHalData->Regulation5G = TXPWR_LMT_ETSI;
 		break;
 	case RT_CHANNEL_DOMAIN_WORLD_ETSI8:
 		pHalData->Regulation2_4G = TXPWR_LMT_ETSI;
-		pHalData->Regulation5G = TXPWR_LMT_ETSI;
 		break;
 	case RT_CHANNEL_DOMAIN_WORLD_ETSI9:
 		pHalData->Regulation2_4G = TXPWR_LMT_ETSI;
-		pHalData->Regulation5G = TXPWR_LMT_ETSI;
 		break;
 	case RT_CHANNEL_DOMAIN_WORLD_ETSI10:
 		pHalData->Regulation2_4G = TXPWR_LMT_ETSI;
-		pHalData->Regulation5G = TXPWR_LMT_ETSI;
 		break;
 	case RT_CHANNEL_DOMAIN_WORLD_ETSI11:
 		pHalData->Regulation2_4G = TXPWR_LMT_ETSI;
-		pHalData->Regulation5G = TXPWR_LMT_ETSI;
 		break;
 	case RT_CHANNEL_DOMAIN_FCC1_NCC4:
 		pHalData->Regulation2_4G = TXPWR_LMT_FCC;
-		pHalData->Regulation5G = TXPWR_LMT_FCC;
 		break;
 	case RT_CHANNEL_DOMAIN_WORLD_ETSI12:
 		pHalData->Regulation2_4G = TXPWR_LMT_ETSI;
-		pHalData->Regulation5G = TXPWR_LMT_ETSI;
 		break;
 	case RT_CHANNEL_DOMAIN_FCC1_FCC9:
 		pHalData->Regulation2_4G = TXPWR_LMT_FCC;
-		pHalData->Regulation5G = TXPWR_LMT_FCC;
 		break;
 	case RT_CHANNEL_DOMAIN_WORLD_ETSI13:
 		pHalData->Regulation2_4G = TXPWR_LMT_ETSI;
-		pHalData->Regulation5G = TXPWR_LMT_ETSI;
 		break;
 	case RT_CHANNEL_DOMAIN_FCC1_FCC10:
 		pHalData->Regulation2_4G = TXPWR_LMT_FCC;
-		pHalData->Regulation5G = TXPWR_LMT_FCC;
 		break;
 	case RT_CHANNEL_DOMAIN_REALTEK_DEFINE: /* Realtek Reserve */
 		pHalData->Regulation2_4G = TXPWR_LMT_WW;
-		pHalData->Regulation5G = TXPWR_LMT_WW;
 		break;
 	default:
 		break;
diff --git a/drivers/staging/rtl8723bs/include/hal_data.h b/drivers/staging/rtl8723bs/include/hal_data.h
index 78246356927b..3298fa8eb682 100644
--- a/drivers/staging/rtl8723bs/include/hal_data.h
+++ b/drivers/staging/rtl8723bs/include/hal_data.h
@@ -46,17 +46,14 @@ enum rt_ampdu_burst {
 	RT_AMPDU_BURST_8723B	= 7,
 };
 
-#define CHANNEL_MAX_NUMBER		(14 + 24 + 21)	/*  14 is the max channel number */
+#define CHANNEL_MAX_NUMBER		(14)	/*  14 is the max channel number */
 #define CHANNEL_MAX_NUMBER_2G		14
-#define CHANNEL_MAX_NUMBER_5G		54			/*  Please refer to "phy_GetChnlGroup8812A" and "Hal_ReadTxPowerInfo8812A" */
-#define CHANNEL_MAX_NUMBER_5G_80M	7
 #define MAX_PG_GROUP			13
 
 /*  Tx Power Limit Table Size */
 #define MAX_REGULATION_NUM			4
 #define MAX_2_4G_BANDWIDTH_NUM			4
 #define MAX_RATE_SECTION_NUM			10
-#define MAX_5G_BANDWIDTH_NUM			4
 
 #define MAX_BASE_NUM_IN_PHY_REG_PG_2_4G		10 /*   CCK:1, OFDM:1, HT:4, VHT:4 */
 
@@ -234,7 +231,6 @@ struct hal_com_data {
 	s8	BW40_24G_Diff[MAX_RF_PATH][MAX_TX_COUNT];
 
 	u8 Regulation2_4G;
-	u8 Regulation5G;
 
 	u8 TxPwrInPercentage;
 
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index 7d655f02d383..89b389d4c44b 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -195,47 +195,6 @@ enum {
 	RT_CHANNEL_DOMAIN_2G_MAX,
 };
 
-enum {
-	RT_CHANNEL_DOMAIN_5G_NULL = 0x00,
-	RT_CHANNEL_DOMAIN_5G_ETSI1 = 0x01,		/* Europe */
-	RT_CHANNEL_DOMAIN_5G_ETSI2 = 0x02,		/* Australia, New Zealand */
-	RT_CHANNEL_DOMAIN_5G_ETSI3 = 0x03,		/* Russia */
-	RT_CHANNEL_DOMAIN_5G_FCC1 = 0x04,		/* US */
-	RT_CHANNEL_DOMAIN_5G_FCC2 = 0x05,		/* FCC o/w DFS Channels */
-	RT_CHANNEL_DOMAIN_5G_FCC3 = 0x06,		/* India, Mexico */
-	RT_CHANNEL_DOMAIN_5G_FCC4 = 0x07,		/* Venezuela */
-	RT_CHANNEL_DOMAIN_5G_FCC5 = 0x08,		/* China */
-	RT_CHANNEL_DOMAIN_5G_FCC6 = 0x09,		/* Israel */
-	RT_CHANNEL_DOMAIN_5G_FCC7_IC1 = 0x0A,	/* US, Canada */
-	RT_CHANNEL_DOMAIN_5G_KCC1 = 0x0B,		/* Korea */
-	RT_CHANNEL_DOMAIN_5G_MKK1 = 0x0C,		/* Japan */
-	RT_CHANNEL_DOMAIN_5G_MKK2 = 0x0D,		/* Japan (W52, W53) */
-	RT_CHANNEL_DOMAIN_5G_MKK3 = 0x0E,		/* Japan (W56) */
-	RT_CHANNEL_DOMAIN_5G_NCC1 = 0x0F,		/* Taiwan */
-	RT_CHANNEL_DOMAIN_5G_NCC2 = 0x10,		/* Taiwan o/w DFS */
-	RT_CHANNEL_DOMAIN_5G_NCC3 = 0x11,		/* Taiwan w/o DFS, Band4 only */
-	RT_CHANNEL_DOMAIN_5G_ETSI4 = 0x12,		/* Europe w/o DFS, Band1 only */
-	RT_CHANNEL_DOMAIN_5G_ETSI5 = 0x13,		/* Australia, New Zealand(w/o Weather radar) */
-	RT_CHANNEL_DOMAIN_5G_FCC8 = 0x14,		/* Latin America */
-	RT_CHANNEL_DOMAIN_5G_ETSI6 = 0x15,		/* Israel, Bahrain, Egypt, India, China, Malaysia */
-	RT_CHANNEL_DOMAIN_5G_ETSI7 = 0x16,		/* China */
-	RT_CHANNEL_DOMAIN_5G_ETSI8 = 0x17,		/* Jordan */
-	RT_CHANNEL_DOMAIN_5G_ETSI9 = 0x18,		/* Lebanon */
-	RT_CHANNEL_DOMAIN_5G_ETSI10 = 0x19,		/* Qatar */
-	RT_CHANNEL_DOMAIN_5G_ETSI11 = 0x1A,		/* Russia */
-	RT_CHANNEL_DOMAIN_5G_NCC4 = 0x1B,		/* Taiwan, (w/o Weather radar) */
-	RT_CHANNEL_DOMAIN_5G_ETSI12 = 0x1C,		/* Indonesia */
-	RT_CHANNEL_DOMAIN_5G_FCC9 = 0x1D,		/* w/o Weather radar) */
-	RT_CHANNEL_DOMAIN_5G_ETSI13 = 0x1E,		/* w/o Weather radar) */
-	RT_CHANNEL_DOMAIN_5G_FCC10 = 0x1F,		/* Argentina (w/o Weather radar) */
-	/*  Add new channel plan above this line =============== */
-	/*  Driver Self Defined ===== */
-	RT_CHANNEL_DOMAIN_5G_FCC = 0x20,
-	RT_CHANNEL_DOMAIN_5G_JAPAN_NO_DFS = 0x21,
-	RT_CHANNEL_DOMAIN_5G_FCC4_NO_DFS = 0x22,
-	RT_CHANNEL_DOMAIN_5G_MAX,
-};
-
 #define rtw_is_channel_plan_valid(chplan) (chplan < RT_CHANNEL_DOMAIN_MAX || chplan == RT_CHANNEL_DOMAIN_REALTEK_DEFINE)
 
 struct rt_channel_plan {
@@ -250,7 +209,6 @@ struct rt_channel_plan_2g {
 
 struct rt_channel_plan_map {
 	unsigned char Index2G;
-	unsigned char Index5G;
 };
 
 enum {
@@ -343,13 +301,13 @@ struct FW_Sta_Info {
  * When the driver scanned RTW_SCAN_NUM_OF_CH channels, it would switch back to AP's operating channel for
  * RTW_STAY_AP_CH_MILLISECOND * SURVEY_TO milliseconds.
  * Example:
- * For chip supports 2.4G + 5GHz and AP mode is operating in channel 1,
+ * For chip supports 2.4G and AP mode is operating in channel 1,
  * RTW_SCAN_NUM_OF_CH is 8, RTW_STAY_AP_CH_MILLISECOND is 3 and SURVEY_TO is 100.
  * When it's STA mode gets set_scan command,
  * it would
  * 1. Doing the scan on channel 1.2.3.4.5.6.7.8
  * 2. Back to channel 1 for 300 milliseconds
- * 3. Go through doing site survey on channel 9.10.11.36.40.44.48.52
+ * 3. Go through doing site survey on channel 9.10.11
  * 4. Back to channel 1 for 300 milliseconds
  * 5. ... and so on, till survey done.
  */
@@ -406,7 +364,6 @@ struct rt_channel_info {
 };
 
 int rtw_ch_set_search_ch(struct rt_channel_info *ch_set, const u32 ch);
-bool rtw_mlme_band_check(struct adapter *adapter, const u32 ch);
 
 /*  P2P_MAX_REG_CLASSES - Maximum number of regulatory classes */
 #define P2P_MAX_REG_CLASSES 10
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index cc5bb534fee6..8514cfb3d7e0 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -77,7 +77,6 @@ static struct ieee80211_rate rtw_rates[] = {
 #define RTW_G_RATES_NUM	12
 
 #define RTW_2G_CHANNELS_NUM 14
-#define RTW_5G_CHANNELS_NUM 37
 
 static struct ieee80211_channel rtw_2ghz_channels[] = {
 	CHAN2G(1, 2412, 0),
@@ -1270,7 +1269,6 @@ void rtw_cfg80211_surveydone_event_callback(struct adapter *padapter)
 
 		/* report network only if the current channel set contains the channel to which this network belongs */
 		if (rtw_ch_set_search_ch(padapter->mlmeextpriv.channel_set, pnetwork->network.Configuration.DSConfig) >= 0
-			&& rtw_mlme_band_check(padapter, pnetwork->network.Configuration.DSConfig) == true
 			&& true == rtw_validate_ssid(&(pnetwork->network.Ssid))
 		)
 		{
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 5032701171f6..afefc2c8a2ac 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -1303,7 +1303,6 @@ static int rtw_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
 
 		/* report network only if the current channel set contains the channel to which this network belongs */
 		if (rtw_ch_set_search_ch(padapter->mlmeextpriv.channel_set, pnetwork->network.Configuration.DSConfig) >= 0
-			&& rtw_mlme_band_check(padapter, pnetwork->network.Configuration.DSConfig) == true
 			&& true == rtw_validate_ssid(&(pnetwork->network.Ssid))) {
 
 			ev = translate_scan(padapter, a, pnetwork, ev, stop);
-- 
2.20.1

