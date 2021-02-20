Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4293244FB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 21:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbhBXUKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 15:10:30 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:34261 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235381AbhBXUIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 15:08:52 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A056882B;
        Wed, 24 Feb 2021 15:07:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 24 Feb 2021 15:07:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=H3Tti2otPJZfJ
        xuciIXNjGx+WAKkNiWeZPhmbEhuTBE=; b=ry+RgAz4Gtltgl2/2IaCRl4rHY0Kl
        8/kIk527PlnbvbBLfRo8KHbdy0lJCvjA3SP2VRJqj/wKmQlrBU8bvSwMdCeHnDq+
        Uplo0oBXAMgdNvL3bDVzpeExPqXkHdn1RmpFgpoWAMNiOHH69gaSJ2yJPWfJs1G1
        ASN09LzP/saAYivSpOd5OUUTFLXvMeJNUW8j80935Fwd6YqcYsQXv2tCr5LVSAXv
        PRpNvbND1JGmrdTgL4i5zvab4pAS7kNSyysUIdiBxRkkmAi74/KBQoLaXoafimHd
        bp524xbmu37+7vUynU7T7D19WBxgzFDbxyxP068m+DA+uAOEu5/+R3m4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=H3Tti2otPJZfJxuciIXNjGx+WAKkNiWeZPhmbEhuTBE=; b=JW4HxLeo
        Rv96MtTv/ZsPYdyE94xMPW535m0idue/WRESS50Y1LeclcF+LBCxbPQRhXLJ1WqH
        p2d1YFVdSD87n5MC3y2dJpJx3NqyK3tIRd4QxDlS6oEAJ/U4QoCGlxsToe/u2dkV
        8HlgKWiASSMl9o8pAd1G9ulXLBl4II/H6HcFSMbzjGfollUaWg8sdFgHMeheeUkX
        ESSKDpB9ohfOrqoTbmwl7VwRx4nva8KefSC1sFFt5diitNcpE6mhv4XPm0wWShvV
        /Zn71U4Duz1M9OxmOjz0mlrkqiDW8HnogWrH9UJiiOLqGcyXb5RRfC0sFUnKYvfT
        IBQdrFeJL+kRAQ==
X-ME-Sender: <xms:ErI2YMIRR5J2r87xDQVfbSVVo7xVxQzNTe1AKU1EXw2YPpKbLUFwdQ>
    <xme:ErI2YIfIuX7XPwA7v71LqG64qHA09ejI_mDrGFZbSMj0C4pIF7DP_CVoNT4xEGWug
    c3eVR21eTe0LQoiWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeejgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeghihhllhhi
    rghmucffuhhrrghnugcuoeifihhllhdoghhithesughrnhgurdhmvgeqnecuggftrfgrth
    htvghrnhepjedvgeffieeivdefleekvddvudffvefhiefgueeujedvgfegfeelkeduffel
    ffefnecukfhppedvudejrddvfeekrddvtdekrdejgeenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifihhllhdoghhithesughrnhgurdhmvg
X-ME-Proxy: <xmx:ErI2YPe0ttxKKAPZA3OcERtP5PNzNvfDZEO-2VcisIZH9-Mia6gZDQ>
    <xmx:ErI2YLOWqP7UmGzvI-eIrQoQ4Ah4HPdEeu1ChhipwsJ-XPCiD41U1w>
    <xmx:ErI2YGLyeUCIV46i5Xuq6dO3rd60Cegp_gUFjxto2gYtF7Yz8TRO0A>
    <xmx:ErI2YNa2Itx55hD0FD_SOsesl0Ry_sYm7HACTDmmd01KRrdxg6foPA>
Received: from vagrant.vm (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id C67C31080054;
        Wed, 24 Feb 2021 15:07:45 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/13] staging: rtl8192e: rename bdHTCapLen to bd_ht_cap_len in bss_ht struct
Date:   Sat, 20 Feb 2021 17:29:00 +0000
Message-Id: <20210220172909.15812-5-will+git@drnd.me>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210220172909.15812-1-will+git@drnd.me>
References: <20210220172909.15812-1-will+git@drnd.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename bdHTCapLen to bd_ht_cap_len to silence a checkpatch warning about
CamelCase.

Signed-off-by: William Durand <will+git@drnd.me>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     |  2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c |  8 ++++----
 drivers/staging/rtl8192e/rtllib_rx.c      | 12 ++++++------
 drivers/staging/rtl8192e/rtllib_softmac.c |  2 +-
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 3b7b480a42b3..cd5dc4a3abe3 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -182,7 +182,7 @@ struct bss_ht {
 	u8				bd_support_ht;

 	u8					bd_ht_cap_buf[32];
-	u16					bdHTCapLen;
+	u16					bd_ht_cap_len;
 	u8					bdHTInfoBuf[32];
 	u16					bdHTInfoLen;

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 14c00c6f7df5..786df3fbedc2 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -691,7 +691,7 @@ void HTInitializeBssDesc(struct bss_ht *pBssHT)

 	pBssHT->bd_support_ht = false;
 	memset(pBssHT->bd_ht_cap_buf, 0, sizeof(pBssHT->bd_ht_cap_buf));
-	pBssHT->bdHTCapLen = 0;
+	pBssHT->bd_ht_cap_len = 0;
 	memset(pBssHT->bdHTInfoBuf, 0, sizeof(pBssHT->bdHTInfoBuf));
 	pBssHT->bdHTInfoLen = 0;

@@ -716,11 +716,11 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 		pHTInfo->bCurrentHTSupport = true;
 		pHTInfo->ePeerHTSpecVer = pNetwork->bssht.bdHTSpecVer;

-		if (pNetwork->bssht.bdHTCapLen > 0 &&
-		    pNetwork->bssht.bdHTCapLen <= sizeof(pHTInfo->PeerHTCapBuf))
+		if (pNetwork->bssht.bd_ht_cap_len > 0 &&
+		    pNetwork->bssht.bd_ht_cap_len <= sizeof(pHTInfo->PeerHTCapBuf))
 			memcpy(pHTInfo->PeerHTCapBuf,
 			       pNetwork->bssht.bd_ht_cap_buf,
-			       pNetwork->bssht.bdHTCapLen);
+			       pNetwork->bssht.bd_ht_cap_len);

 		if (pNetwork->bssht.bdHTInfoLen > 0 &&
 		    pNetwork->bssht.bdHTInfoLen <=
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 2abda3d3174f..697fd7fcb48b 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1851,11 +1851,11 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 					       MAX_IE_LEN);
 			if (*tmp_htcap_len != 0) {
 				network->bssht.bdHTSpecVer = HT_SPEC_VER_EWC;
-				network->bssht.bdHTCapLen = min_t(u16, *tmp_htcap_len,
+				network->bssht.bd_ht_cap_len = min_t(u16, *tmp_htcap_len,
 								  sizeof(network->bssht.bd_ht_cap_buf));
 				memcpy(network->bssht.bd_ht_cap_buf,
 				       info_element->data,
-				       network->bssht.bdHTCapLen);
+				       network->bssht.bd_ht_cap_len);
 			}
 		}
 		if (*tmp_htcap_len != 0) {
@@ -2022,9 +2022,9 @@ static void rtllib_parse_mfie_ht_cap(struct rtllib_info_element *info_element,
 	*tmp_htcap_len = min_t(u8, info_element->len, MAX_IE_LEN);
 	if (*tmp_htcap_len != 0) {
 		ht->bdHTSpecVer = HT_SPEC_VER_EWC;
-		ht->bdHTCapLen = min_t(u16, *tmp_htcap_len,
+		ht->bd_ht_cap_len = min_t(u16, *tmp_htcap_len,
 				       sizeof(ht->bd_ht_cap_buf));
-		memcpy(ht->bd_ht_cap_buf, info_element->data, ht->bdHTCapLen);
+		memcpy(ht->bd_ht_cap_buf, info_element->data, ht->bd_ht_cap_len);

 		ht->bd_support_ht = true;
 		ht->bdHT1R = ((((struct ht_capab_ele *)
@@ -2459,9 +2459,9 @@ static inline void update_network(struct rtllib_device *ieee,

 	dst->bssht.bd_support_ht = src->bssht.bd_support_ht;
 	dst->bssht.bdRT2RTAggregation = src->bssht.bdRT2RTAggregation;
-	dst->bssht.bdHTCapLen = src->bssht.bdHTCapLen;
+	dst->bssht.bd_ht_cap_len = src->bssht.bd_ht_cap_len;
 	memcpy(dst->bssht.bd_ht_cap_buf, src->bssht.bd_ht_cap_buf,
-	       src->bssht.bdHTCapLen);
+	       src->bssht.bd_ht_cap_len);
 	dst->bssht.bdHTInfoLen = src->bssht.bdHTInfoLen;
 	memcpy(dst->bssht.bdHTInfoBuf, src->bssht.bdHTInfoBuf,
 	       src->bssht.bdHTInfoLen);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 6f8f88207694..82863f737906 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2239,7 +2239,7 @@ rtllib_rx_assoc_resp(struct rtllib_device *ieee, struct sk_buff *skb,
 				}
 				memcpy(ieee->pHTInfo->PeerHTCapBuf,
 				       network->bssht.bd_ht_cap_buf,
-				       network->bssht.bdHTCapLen);
+				       network->bssht.bd_ht_cap_len);
 				memcpy(ieee->pHTInfo->PeerHTInfoBuf,
 				       network->bssht.bdHTInfoBuf,
 				       network->bssht.bdHTInfoLen);
--
2.30.0

