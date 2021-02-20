Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B7E32450B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 21:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbhBXUPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 15:15:24 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:38677 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235475AbhBXUK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 15:10:27 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id D667483B;
        Wed, 24 Feb 2021 15:07:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 24 Feb 2021 15:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=AtrlmDOakkutE
        1wh92s5ClV+CD1mskr98sC+uhnSB1w=; b=svOE20sGXU9UvIpYYD7bueEEwB09+
        7lY22KNulEWt92/dIxvHpQSYcpKAMN5PzJtgyja5e/KppaJiTIU8KamsHCrakduL
        PwSIhpiaPwqi3elcU3p6CN3ylkIRTjQTrcn5xu7EKlcoVn1ALj/cq85ySH0KBVBZ
        M3riH0Cd7E5jLW1OuHAAJU84jaTbM7dMoU5DCbFrSIVR4MYRzK6zRHCwOXR1MJsG
        zUEzq66trBtbgiGIkZ98kDToFpbEHzpF5feq3asTffFDHkJdv3a1JuXdISCUx7Oq
        A1k9tNMYEkJFXdgW1WBGAgZaqMb15I9tDw/nsVJiVW9il91Vf0EL7G/Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=AtrlmDOakkutE1wh92s5ClV+CD1mskr98sC+uhnSB1w=; b=dgMwETgR
        BqlYyPJddSlgDYRekIrAUxMn3iBhJlud0QGe0ePZpLD6IERPhW5pX2quhuUPMH2V
        C51SI1R9WfNkHhHnDo5mvgXXQACDYnJJVVv3mPOV4E/5ZxcPgRFLZAH6EcRV6ogW
        yLz+G7d3a+fqCtcx/joCSrL5w/iJfInku+QEYdcTLmG9IgNm3MgGy5LhEhWByXjX
        XutIWlZNA+fnfVTGiLVyflbjk3tl93mrOnEPzgqVKSK0qoVfM7Md4UJ5BplnefmL
        X8IB80dR8vMSfzMc6Uw4yjxWJA9JsCPKFmDEvktIvKx12Vw3a6HcMa7L5QilG8X6
        lNlD6VmDmtSGrQ==
X-ME-Sender: <xms:FbI2YKC9S3wa1lFABlbAvabTxhfEbHEsWyIUU1qfYcmXQSyVsf5e1g>
    <xme:FbI2YGCnvg0J71Hdt1xjJX8FJzEwfl-wIp3Lz5Cy_8GqP_k2kLILehC0Limq-y7VT
    m2oYUFUyLZKIXb4PQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeejgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeghihhllhhi
    rghmucffuhhrrghnugcuoeifihhllhdoghhithesughrnhgurdhmvgeqnecuggftrfgrth
    htvghrnhepgfevjeejheejgfefvdffgeeikedtleekffekkeegheegieevledvgeegtedt
    teejnecuffhomhgrihhnpegsshhshhhtrdgsugenucfkphepvddujedrvdefkedrvddtke
    drjeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    fihilhhlodhgihhtsegurhhnugdrmhgv
X-ME-Proxy: <xmx:FbI2YNpAI-YZCSoecbditI_rCZ_o_oVsG16hxH2WByIJCkYYJ91cVA>
    <xmx:FbI2YInSOoLClnyLi6fPg7c5oX4MilfB86Nfg42ELPz-f_r_2VCdxA>
    <xmx:FbI2YFwCuIb2PG-EXivC-W9-wugIXMSIgUmsO6QNH7Mv2oBM1SkYQg>
    <xmx:FbI2YNCV7ZW8Ta5DW2xFDgZDmLMXTq76_KVU38L9525nvxeQZddGbg>
Received: from vagrant.vm (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id 03F65108005F;
        Wed, 24 Feb 2021 15:07:48 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/13] staging: rtl8192e: rename bdRT2RTAggregation to bd_rt2rt_aggregation in bss_ht struct
Date:   Sat, 20 Feb 2021 17:29:05 +0000
Message-Id: <20210220172909.15812-10-will+git@drnd.me>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210220172909.15812-1-will+git@drnd.me>
References: <20210220172909.15812-1-will+git@drnd.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename bdRT2RTAggregation to bd_rt2rt_aggregation to silence a
checkpatch warning about CamelCase.

Signed-off-by: William Durand <will+git@drnd.me>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     |  2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 10 +++++-----
 drivers/staging/rtl8192e/rtllib_rx.c      |  6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index b44fd8e39263..6c5255af27fb 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -189,7 +189,7 @@ struct bss_ht {
 	enum ht_spec_ver bd_ht_spec_ver;
 	enum ht_channel_width bd_bandwidth;

-	u8					bdRT2RTAggregation;
+	u8					bd_rt2rt_aggregation;
 	u8					bdRT2RTLongSlotTime;
 	u8					RT2RT_HT_Mode;
 	u8					bdHT1R;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 48a63706b8ba..a3575272e4da 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -158,7 +158,7 @@ bool IsHTHalfNmodeAPs(struct rtllib_device *ieee)
 		!memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) ||
 		(net->broadcom_cap_exist))
 		retValue = true;
-	else if (net->bssht.bdRT2RTAggregation)
+	else if (net->bssht.bd_rt2rt_aggregation)
 		retValue = true;
 	else
 		retValue = false;
@@ -171,7 +171,7 @@ static void HTIOTPeerDetermine(struct rtllib_device *ieee)
 	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
 	struct rtllib_network *net = &ieee->current_network;

-	if (net->bssht.bdRT2RTAggregation) {
+	if (net->bssht.bd_rt2rt_aggregation) {
 		pHTInfo->IOTPeer = HT_IOT_PEER_REALTEK;
 		if (net->bssht.RT2RT_HT_Mode & RT_HT_CAP_USE_92SE)
 			pHTInfo->IOTPeer = HT_IOT_PEER_REALTEK_92SE;
@@ -591,7 +591,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 			pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;

 	} else {
-		if (ieee->current_network.bssht.bdRT2RTAggregation) {
+		if (ieee->current_network.bssht.bd_rt2rt_aggregation) {
 			if (ieee->pairwise_key_type != KEY_TYPE_NA)
 				pHTInfo->CurrentAMPDUFactor =
 						 pPeerHTCap->MaxRxAMPDUFactor;
@@ -697,7 +697,7 @@ void HTInitializeBssDesc(struct bss_ht *pBssHT)

 	pBssHT->bd_ht_spec_ver = HT_SPEC_VER_IEEE;

-	pBssHT->bdRT2RTAggregation = false;
+	pBssHT->bd_rt2rt_aggregation = false;
 	pBssHT->bdRT2RTLongSlotTime = false;
 	pBssHT->RT2RT_HT_Mode = (enum rt_ht_capability)0;
 }
@@ -731,7 +731,7 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,

 		if (pHTInfo->bRegRT2RTAggregation) {
 			pHTInfo->bCurrentRT2RTAggregation =
-				 pNetwork->bssht.bdRT2RTAggregation;
+				 pNetwork->bssht.bd_rt2rt_aggregation;
 			pHTInfo->bCurrentRT2RTLongSlotTime =
 				 pNetwork->bssht.bdRT2RTLongSlotTime;
 			pHTInfo->RT2RT_HT_Mode = pNetwork->bssht.RT2RT_HT_Mode;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index e95be64edffb..54f3bce46c0d 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1900,7 +1900,7 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 		}
 		if (ht_realtek_agg_len >= 5) {
 			network->realtek_cap_exit = true;
-			network->bssht.bdRT2RTAggregation = true;
+			network->bssht.bd_rt2rt_aggregation = true;

 			if ((ht_realtek_agg_buf[4] == 1) &&
 			    (ht_realtek_agg_buf[5] & 0x02))
@@ -2291,7 +2291,7 @@ int rtllib_parse_info_param(struct rtllib_device *ieee,

 	if (!network->atheros_cap_exist && !network->broadcom_cap_exist &&
 	    !network->cisco_cap_exist && !network->ralink_cap_exist &&
-	    !network->bssht.bdRT2RTAggregation)
+	    !network->bssht.bd_rt2rt_aggregation)
 		network->unknown_cap_exist = true;
 	else
 		network->unknown_cap_exist = false;
@@ -2459,7 +2459,7 @@ static inline void update_network(struct rtllib_device *ieee,
 	memcpy(&dst->tim, &src->tim, sizeof(struct rtllib_tim_parameters));

 	dst->bssht.bd_support_ht = src->bssht.bd_support_ht;
-	dst->bssht.bdRT2RTAggregation = src->bssht.bdRT2RTAggregation;
+	dst->bssht.bd_rt2rt_aggregation = src->bssht.bd_rt2rt_aggregation;
 	dst->bssht.bd_ht_cap_len = src->bssht.bd_ht_cap_len;
 	memcpy(dst->bssht.bd_ht_cap_buf, src->bssht.bd_ht_cap_buf,
 	       src->bssht.bd_ht_cap_len);
--
2.30.0

