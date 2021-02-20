Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DC1323269
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 21:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbhBWUsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 15:48:51 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:58025 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234444AbhBWUsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 15:48:36 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7D97882B;
        Tue, 23 Feb 2021 15:47:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 23 Feb 2021 15:47:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=KsUsx0Hz9lGQO
        VvBBFgUkiZwFrRoQsVq8O5pTnwoALs=; b=F9Txl/ni08+DRObSRzi8QQHPvy6ZF
        H6HVoIN6V40hEM97YcsniQEguXzaDXjJW2LYlJmu+w0LHoQswcIHzT1adZITwteo
        g6sch3A2IpQd90vG7hTikhNHWqhrn0MZx1YuC5/bgMtMDCOa2+iayqYB5eLD5ZOE
        G54ayB7yB0vP8N5Sm3nCRvp/ssK1W3F01+l9jzyHqk35F2SZ5mDT0Gut2fQoPFPv
        CKMtH8GPSjKdfpSt/c0UX0GWnxPTXkvOifywZ8SM0N2WIBGEiWsR6b2g5HGDEr4u
        WnAu34eDfZJzZdWXja+xr7yr51iYwDSQLTcZNESsF5IP9m14rg0adQTsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=KsUsx0Hz9lGQOVvBBFgUkiZwFrRoQsVq8O5pTnwoALs=; b=Ga5iaDPr
        y3E/BwYS653S0rMOX0Jyy2wZ19v0xyfDvuTYDpmqE+aDm9JoeRSqARnACxrg25th
        Gmh0RNkEwJzafp8ZcND3kEGKo4uJM3Tvt1iluSvGQVIJyxk0uHlvpZ1XDA/Ja7xB
        rs8irBG2kFTS9mh9Vuv7Ru4lCfOpCiO0Y78O8Ita3kpF8yZDH+IMff/MsWVNZ/1i
        62/8op775lZOb38wfHoct4mtTQZ0R6p+kHySzOkAn6XgR4vJWjoYntzJknENZXsU
        LimY07iv7jQvLNrGszBMjyMG7ZGNCje18oDuMotGAICD61leb8auIAvqUA5B1CIP
        r2jyqdh6yLZdwg==
X-ME-Sender: <xms:4mk1YKj4KBLVdNDIfqoGA9NX5U8Wl3cR-wae0tRQNCfCoKRtVhYO4w>
    <xme:4mk1YLDrrr14-ekVK4qrKptwJbdImi9mzlEfRIdBAiOOBSb3dNmYqg-R220evEp1g
    kCX9A7eyYkqiW662w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeehgddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeghihhllhhi
    rghmucffuhhrrghnugcuoeifihhllhdoghhithesughrnhgurdhmvgeqnecuggftrfgrth
    htvghrnhepgfevjeejheejgfefvdffgeeikedtleekffekkeegheegieevledvgeegtedt
    teejnecuffhomhgrihhnpegsshhshhhtrdgsugenucfkphepvddujedrvdefkedrvddtke
    drjeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    fihilhhlodhgihhtsegurhhnugdrmhgv
X-ME-Proxy: <xmx:4mk1YCHS2shBv0GJ-XJ4ACtwm-Tzi7OyCjyCyku6S6HmHTFa_LMCwA>
    <xmx:4mk1YDSKRLd232cYuV6ACnZ50QNZ3UET5Q-MqsYPs4xdh9a7AmbGLg>
    <xmx:4mk1YHxUjVjUkCH8A6MgZPfRZSd0B4rYdFMv5poUM7_0d2SbvCkSjQ>
    <xmx:4mk1YFayydKPVI9ce9tV-cpGuqW9ktExDz7i-0Y4oNWeKpYb-iGNsg>
Received: from vagrant.vm (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8BF1424005E;
        Tue, 23 Feb 2021 15:47:29 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] staging: rtl8192e: rename bdSupportHT to bd_support_ht in bss_ht struct
Date:   Sat, 20 Feb 2021 15:54:06 +0000
Message-Id: <20210220155418.12282-3-will+git@drnd.me>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210220155418.12282-1-will+git@drnd.me>
References: <20210220155418.12282-1-will+git@drnd.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a checkpatch CHECK issue.

Signed-off-by: William Durand <will+git@drnd.me>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     |  2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c |  4 ++--
 drivers/staging/rtl8192e/rtllib_rx.c      | 14 +++++++-------
 drivers/staging/rtl8192e/rtllib_softmac.c |  4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 1bbb9ed18e6d..71a078c0d5f5 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -179,7 +179,7 @@ struct rt_hi_throughput {
 } __packed;

 struct bss_ht {
-	u8				bdSupportHT;
+	u8				bd_support_ht;

 	u8					bdHTCapBuf[32];
 	u16					bdHTCapLen;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 9377e48c3f32..444f8ce6a170 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -689,7 +689,7 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 void HTInitializeBssDesc(struct bss_ht *pBssHT)
 {

-	pBssHT->bdSupportHT = false;
+	pBssHT->bd_support_ht = false;
 	memset(pBssHT->bdHTCapBuf, 0, sizeof(pBssHT->bdHTCapBuf));
 	pBssHT->bdHTCapLen = 0;
 	memset(pBssHT->bdHTInfoBuf, 0, sizeof(pBssHT->bdHTInfoBuf));
@@ -712,7 +712,7 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 	/* unmark bEnableHT flag here is the same reason why unmarked in
 	 * function rtllib_softmac_new_net. WB 2008.09.10
 	 */
-	if (pNetwork->bssht.bdSupportHT) {
+	if (pNetwork->bssht.bd_support_ht) {
 		pHTInfo->bCurrentHTSupport = true;
 		pHTInfo->ePeerHTSpecVer = pNetwork->bssht.bdHTSpecVer;

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 66c135321da4..98d7b9ba6099 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1858,10 +1858,10 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 			}
 		}
 		if (*tmp_htcap_len != 0) {
-			network->bssht.bdSupportHT = true;
+			network->bssht.bd_support_ht = true;
 			network->bssht.bdHT1R = ((((struct ht_capab_ele *)(network->bssht.bdHTCapBuf))->MCS[1]) == 0);
 		} else {
-			network->bssht.bdSupportHT = false;
+			network->bssht.bd_support_ht = false;
 			network->bssht.bdHT1R = false;
 		}
 	}
@@ -1885,7 +1885,7 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 		}
 	}

-	if (network->bssht.bdSupportHT) {
+	if (network->bssht.bd_support_ht) {
 		if (info_element->len >= 4 &&
 		    info_element->data[0] == 0x00 &&
 		    info_element->data[1] == 0xe0 &&
@@ -2025,7 +2025,7 @@ static void rtllib_parse_mfie_ht_cap(struct rtllib_info_element *info_element,
 				       sizeof(ht->bdHTCapBuf));
 		memcpy(ht->bdHTCapBuf, info_element->data, ht->bdHTCapLen);

-		ht->bdSupportHT = true;
+		ht->bd_support_ht = true;
 		ht->bdHT1R = ((((struct ht_capab_ele *)
 				ht->bdHTCapBuf))->MCS[1]) == 0;

@@ -2033,7 +2033,7 @@ static void rtllib_parse_mfie_ht_cap(struct rtllib_info_element *info_element,
 					     (((struct ht_capab_ele *)
 					     (ht->bdHTCapBuf))->ChlWidth);
 	} else {
-		ht->bdSupportHT = false;
+		ht->bd_support_ht = false;
 		ht->bdHT1R = false;
 		ht->bdBandWidth = HT_CHANNEL_WIDTH_20;
 	}
@@ -2380,7 +2380,7 @@ static inline int rtllib_network_init(
 		return 1;
 	}

-	if (network->bssht.bdSupportHT) {
+	if (network->bssht.bd_support_ht) {
 		if (network->mode == IEEE_A)
 			network->mode = IEEE_N_5G;
 		else if (network->mode & (IEEE_G | IEEE_B))
@@ -2456,7 +2456,7 @@ static inline void update_network(struct rtllib_device *ieee,
 	dst->last_dtim_sta_time = src->last_dtim_sta_time;
 	memcpy(&dst->tim, &src->tim, sizeof(struct rtllib_tim_parameters));

-	dst->bssht.bdSupportHT = src->bssht.bdSupportHT;
+	dst->bssht.bd_support_ht = src->bssht.bd_support_ht;
 	dst->bssht.bdRT2RTAggregation = src->bssht.bdRT2RTAggregation;
 	dst->bssht.bdHTCapLen = src->bssht.bdHTCapLen;
 	memcpy(dst->bssht.bdHTCapBuf, src->bssht.bdHTCapBuf,
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index ab4b9817888c..b348316b2784 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1692,7 +1692,7 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 				    ieee->current_network.channel,
 				    ieee->current_network.qos_data.supported,
 				    ieee->pHTInfo->bEnableHT,
-				    ieee->current_network.bssht.bdSupportHT,
+				    ieee->current_network.bssht.bd_support_ht,
 				    ieee->current_network.mode,
 				    ieee->current_network.flags);

@@ -1706,7 +1706,7 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 				/* Join the network for the first time */
 				ieee->AsocRetryCount = 0;
 				if ((ieee->current_network.qos_data.supported == 1) &&
-				    ieee->current_network.bssht.bdSupportHT)
+				    ieee->current_network.bssht.bd_support_ht)
 					HTResetSelfAndSavePeerSetting(ieee,
 						 &(ieee->current_network));
 				else
--
2.30.0

