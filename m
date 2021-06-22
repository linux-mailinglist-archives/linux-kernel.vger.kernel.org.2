Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50CD3B0587
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhFVNMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhFVNMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:12:30 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3B7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:10:13 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n23so12786123wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VFzs8K1hJoNXpBOBcsMQ4sI+IDyzJg+qXoFm9HpkQS8=;
        b=VnFJmNHcmIUzxeaJbP+NoQNuaxCXwbS3igQdA8yh00jW3LuQKd8ctD6K/uOUKM0glZ
         QzXEjlh8AIeVQJEcbkQMIAPn4+2I74fiCcJ0gLK6oMCOxIuPVnCV22M+W4aLgZFrP7kP
         BdiYITNcZBNmwM2iUF2iByAqH/cht1ZiqifK5hNi1+L6MMTdluuyDSs6Vc6LAvICdXmc
         4dkG+ZfQJEpArkyEGfmAwh25r+YezkFTT1wzu96pzJbF1n1/ZHluzJRPzM8FVUio0IwZ
         p7tFvwNa7UK3CwNjSPWBUOvE2RK2K+SpLaQgA9jQD1zVUzJc/Z6T0hTU6KEMnKY/cXF/
         G1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VFzs8K1hJoNXpBOBcsMQ4sI+IDyzJg+qXoFm9HpkQS8=;
        b=GC17+GAFsZd48rdZgrGRRHmmxtCnu6/l5Z6yAxhOmTTuIyyZHHG37XfVxeTAP6xurC
         4031kLvq8DwqWznxhgRCfVku72QkEVY5mutquE7sd9PU9d0avreSrmFcdvTKTkeZBHqL
         4BTHubYqtbTgDOJ0hxoO0RRndSwFtCqSXkBYTWmGP2Z18JGt1tmIF7Al3Wb8eTocj6aP
         qIOeHdFjFaj0fpWEoP0pEs3T+r24qmC1ODldMTGUY2DBdmTuAOt3FnIKtYEBDlgYYP67
         2PbAO8nuPL8WPL/dOKsGTpyx0dmtPhoyas7TJo24AVXZiD7ooIeqzPnNHC0R3UIDA0Lo
         JhQw==
X-Gm-Message-State: AOAM530mrddJrN5ezXRjOfXMZgX9XgR8rGfjrKZsjjRzcgKb7T+Irugg
        V7x614SvSuBmg82Qqo2QVY3DpG+HHG50yQ==
X-Google-Smtp-Source: ABdhPJyL51qyKTTUmMK9IGPu7A6DRE8Mg45z5jeQatCfhbRkGagUjHJ8eykb7SnnwBd81GviyAJEbw==
X-Received: by 2002:a05:600c:b57:: with SMTP id k23mr4485577wmr.133.1624367412231;
        Tue, 22 Jun 2021 06:10:12 -0700 (PDT)
Received: from agape ([5.171.73.108])
        by smtp.gmail.com with ESMTPSA id s1sm2559287wmj.8.2021.06.22.06.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 06:10:11 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/17] staging: rtl8723bs: remove struct rt_channel_plan_5g
Date:   Tue, 22 Jun 2021 15:09:50 +0200
Message-Id: <c9780328291ef84a8b0874e34da881d5e3885ddc.1624367071.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624367071.git.fabioaiuto83@gmail.com>
References: <cover.1624367071.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove struct rt_channel_plan_5g, for rtl8723bs works
only on 2.4Ghz band.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 58 +------------------
 .../staging/rtl8723bs/include/rtw_mlme_ext.h  |  5 --
 drivers/staging/rtl8723bs/include/rtw_rf.h    | 15 ++---
 3 files changed, 8 insertions(+), 70 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 106779fb9fef..cf0079a0c179 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -79,46 +79,6 @@ static struct rt_channel_plan_2g	RTW_ChannelPlan2G[RT_CHANNEL_DOMAIN_2G_MAX] = {
 	{{}, 0},								/*  0x06, RT_CHANNEL_DOMAIN_2G_NULL */
 };
 
-static struct rt_channel_plan_5g	RTW_ChannelPlan5G[RT_CHANNEL_DOMAIN_5G_MAX] = {
-	{{}, 0},																					/*  0x00, RT_CHANNEL_DOMAIN_5G_NULL */
-	{{36, 40, 44, 48, 52, 56, 60, 64, 100, 104, 108, 112, 116, 120, 124, 128, 132, 136, 140}, 19},						/*  0x01, RT_CHANNEL_DOMAIN_5G_ETSI1 */
-	{{36, 40, 44, 48, 52, 56, 60, 64, 100, 104, 108, 112, 116, 120, 124, 128, 132, 136, 140, 149, 153, 157, 161, 165}, 24},	/*  0x02, RT_CHANNEL_DOMAIN_5G_ETSI2 */
-	{{36, 40, 44, 48, 52, 56, 60, 64, 100, 104, 108, 112, 116, 120, 124, 128, 132, 149, 153, 157, 161, 165}, 22},			/*  0x03, RT_CHANNEL_DOMAIN_5G_ETSI3 */
-	{{36, 40, 44, 48, 52, 56, 60, 64, 100, 104, 108, 112, 116, 120, 124, 128, 132, 136, 140, 149, 153, 157, 161, 165}, 24},	/*  0x04, RT_CHANNEL_DOMAIN_5G_FCC1 */
-	{{36, 40, 44, 48, 149, 153, 157, 161, 165}, 9},														/*  0x05, RT_CHANNEL_DOMAIN_5G_FCC2 */
-	{{36, 40, 44, 48, 52, 56, 60, 64, 149, 153, 157, 161, 165}, 13},											/*  0x06, RT_CHANNEL_DOMAIN_5G_FCC3 */
-	{{36, 40, 44, 48, 52, 56, 60, 64, 149, 153, 157, 161}, 12},												/*  0x07, RT_CHANNEL_DOMAIN_5G_FCC4 */
-	{{149, 153, 157, 161, 165}, 5},																	/*  0x08, RT_CHANNEL_DOMAIN_5G_FCC5 */
-	{{36, 40, 44, 48, 52, 56, 60, 64}, 8},																/*  0x09, RT_CHANNEL_DOMAIN_5G_FCC6 */
-	{{36, 40, 44, 48, 52, 56, 60, 64, 100, 104, 108, 112, 116, 136, 140, 149, 153, 157, 161, 165}, 20},					/*  0x0A, RT_CHANNEL_DOMAIN_5G_FCC7_IC1 */
-	{{36, 40, 44, 48, 52, 56, 60, 64, 100, 104, 108, 112, 116, 120, 124, 149, 153, 157, 161, 165}, 20},					/*  0x0B, RT_CHANNEL_DOMAIN_5G_KCC1 */
-	{{36, 40, 44, 48, 52, 56, 60, 64, 100, 104, 108, 112, 116, 120, 124, 128, 132, 136, 140}, 19},						/*  0x0C, RT_CHANNEL_DOMAIN_5G_MKK1 */
-	{{36, 40, 44, 48, 52, 56, 60, 64}, 8},																/*  0x0D, RT_CHANNEL_DOMAIN_5G_MKK2 */
-	{{100, 104, 108, 112, 116, 120, 124, 128, 132, 136, 140}, 11},											/*  0x0E, RT_CHANNEL_DOMAIN_5G_MKK3 */
-	{{56, 60, 64, 100, 104, 108, 112, 116, 136, 140, 149, 153, 157, 161, 165}, 15},								/*  0x0F, RT_CHANNEL_DOMAIN_5G_NCC1 */
-	{{56, 60, 64, 149, 153, 157, 161, 165}, 8},															/*  0x10, RT_CHANNEL_DOMAIN_5G_NCC2 */
-	{{149, 153, 157, 161, 165}, 5},																	/*  0x11, RT_CHANNEL_DOMAIN_5G_NCC3 */
-	{{36, 40, 44, 48}, 4},																			/*  0x12, RT_CHANNEL_DOMAIN_5G_ETSI4 */
-	{{36, 40, 44, 48, 52, 56, 60, 64, 100, 104, 108, 112, 116, 136, 140, 149, 153, 157, 161, 165}, 20},					/*  0x13, RT_CHANNEL_DOMAIN_5G_ETSI5 */
-	{{149, 153, 157, 161}, 4},																		/*  0x14, RT_CHANNEL_DOMAIN_5G_FCC8 */
-	{{36, 40, 44, 48, 52, 56, 60, 64}, 8},																/*  0x15, RT_CHANNEL_DOMAIN_5G_ETSI6 */
-	{{36, 40, 44, 48, 52, 56, 60, 64, 149, 153, 157, 161, 165}, 13},											/*  0x16, RT_CHANNEL_DOMAIN_5G_ETSI7 */
-	{{36, 40, 44, 48, 149, 153, 157, 161, 165}, 9},														/*  0x17, RT_CHANNEL_DOMAIN_5G_ETSI8 */
-	{{100, 104, 108, 112, 116, 120, 124, 128, 132, 136, 140}, 11},											/*  0x18, RT_CHANNEL_DOMAIN_5G_ETSI9 */
-	{{149, 153, 157, 161, 165}, 5},																	/*  0x19, RT_CHANNEL_DOMAIN_5G_ETSI10 */
-	{{36, 40, 44, 48, 52, 56, 60, 64, 132, 136, 140, 149, 153, 157, 161, 165}, 16},									/*  0x1A, RT_CHANNEL_DOMAIN_5G_ETSI11 */
-	{{52, 56, 60, 64, 100, 104, 108, 112, 116, 132, 136, 140, 149, 153, 157, 161, 165}, 17},							/*  0x1B, RT_CHANNEL_DOMAIN_5G_NCC4 */
-	{{149, 153, 157, 161}, 4},																		/*  0x1C, RT_CHANNEL_DOMAIN_5G_ETSI12 */
-	{{36, 40, 44, 48, 100, 104, 108, 112, 116, 132, 136, 140, 149, 153, 157, 161, 165}, 17},							/*  0x1D, RT_CHANNEL_DOMAIN_5G_FCC9 */
-	{{36, 40, 44, 48, 100, 104, 108, 112, 116, 132, 136, 140}, 12},											/*  0x1E, RT_CHANNEL_DOMAIN_5G_ETSI13 */
-	{{36, 40, 44, 48, 52, 56, 60, 64, 100, 104, 108, 112, 116, 132, 136, 140, 149, 153, 157, 161}, 20},					/*  0x1F, RT_CHANNEL_DOMAIN_5G_FCC10 */
-
-	/*  Driver self defined for old channel plan Compatible , Remember to modify if have new channel plan definition ===== */
-	{{36, 40, 44, 48, 52, 56, 60, 64, 100, 104, 108, 112, 116, 132, 136, 140, 149, 153, 157, 161, 165}, 21},				/*  0x20, RT_CHANNEL_DOMAIN_5G_FCC */
-	{{36, 40, 44, 48}, 4},																			/*  0x21, RT_CHANNEL_DOMAIN_5G_JAPAN_NO_DFS */
-	{{36, 40, 44, 48, 149, 153, 157, 161}, 8},															/*  0x22, RT_CHANNEL_DOMAIN_5G_FCC4_NO_DFS */
-};
-
 static struct rt_channel_plan_map	RTW_ChannelPlanMap[RT_CHANNEL_DOMAIN_MAX] = {
 	/*  0x00 ~ 0x1F , Old Define ===== */
 	{0x02, 0x20},	/* 0x00, RT_CHANNEL_DOMAIN_FCC */
@@ -393,8 +353,8 @@ static void init_channel_list(struct adapter *padapter, struct rt_channel_info *
 static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, struct rt_channel_info *channel_set)
 {
 	u8 index, chanset_size = 0;
-	u8 b5GBand = false, b2_4GBand = false;
-	u8 Index2G = 0, Index5G = 0;
+	u8 b2_4GBand = false;
+	u8 Index2G = 0;
 
 	memset(channel_set, 0, sizeof(struct rt_channel_info)*MAX_CHANNEL_NUM);
 
@@ -433,20 +393,6 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, struct rt_c
 		}
 	}
 
-	if (b5GBand) {
-		for (index = 0; index < RTW_ChannelPlan5G[Index5G].Len; index++) {
-			if (RTW_ChannelPlan5G[Index5G].Channel[index] <= 48
-				|| RTW_ChannelPlan5G[Index5G].Channel[index] >= 149) {
-				channel_set[chanset_size].ChannelNum = RTW_ChannelPlan5G[Index5G].Channel[index];
-				if (RT_CHANNEL_DOMAIN_WORLD_WIDE_5G == ChannelPlan)/* passive scan for all 5G channels */
-					channel_set[chanset_size].ScanType = SCAN_PASSIVE;
-				else
-					channel_set[chanset_size].ScanType = SCAN_ACTIVE;
-				chanset_size++;
-			}
-		}
-	}
-
 	return chanset_size;
 }
 
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index 0248b91b4525..7d655f02d383 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -248,11 +248,6 @@ struct rt_channel_plan_2g {
 	unsigned char Len;
 };
 
-struct rt_channel_plan_5g {
-	unsigned char Channel[MAX_CHANNEL_NUM_5G];
-	unsigned char Len;
-};
-
 struct rt_channel_plan_map {
 	unsigned char Index2G;
 	unsigned char Index5G;
diff --git a/drivers/staging/rtl8723bs/include/rtw_rf.h b/drivers/staging/rtl8723bs/include/rtw_rf.h
index 48ff15a38bb0..6c25707f4ec8 100644
--- a/drivers/staging/rtl8723bs/include/rtw_rf.h
+++ b/drivers/staging/rtl8723bs/include/rtw_rf.h
@@ -21,16 +21,13 @@
 #define RTL8711_RF_MAX_SENS	 6
 #define RTL8711_RF_DEF_SENS	 4
 
-/*  */
-/*  We now define the following channels as the max channels in each channel plan. */
-/*  2G, total 14 chnls */
-/*  {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14} */
-/*  5G, total 24 chnls */
-/*  {36, 40, 44, 48, 52, 56, 60, 64, 100, 104, 108, 112, 116, 120,
- *   124, 128, 132, 136, 140, 149, 153, 157, 161, 165} */
+/*
+ * We now define the following channels as the max channels in each channel plan.
+ * 2G, total 14 chnls
+ * {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}
+ */
 #define	MAX_CHANNEL_NUM_2G	14
-#define	MAX_CHANNEL_NUM_5G	24
-#define	MAX_CHANNEL_NUM		38/* 14+24 */
+#define	MAX_CHANNEL_NUM		14
 
 #define NUM_REGULATORYS	1
 
-- 
2.20.1

