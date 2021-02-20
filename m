Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9597B32326B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 21:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbhBWUtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 15:49:16 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:37575 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234449AbhBWUsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 15:48:37 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B96089C4;
        Tue, 23 Feb 2021 15:47:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 23 Feb 2021 15:47:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=m2SPuS+TqZIaR
        WPYk39VEBgiHi9CQ4ibi3VfiVMAUb0=; b=csigxpor2nCvsiKMcQtjfO7gYqp10
        ZMclgsQ044CpaQbgiAfqqmCi7aNPgVLkPb2GBzjQp9KsYWCj+7B05P/TFMo51MCJ
        ob/iKi1kEs5ITIWJGgKLi70GHlrppuGnMQ0h6rdjJBcn1Bcb+n7fqnlrfB8Gd3hO
        ULEEdt55D/z3uadGZ29PB4rCn7SBIkrybM5ZRyEmK9VQG6bDzt95Ubpa/mXjmuqy
        ZMmrCjQfE3wS1XjThrqNGdqAIj0HdtmetBVBy0AcjwrcbZ6GGV3468OjWVyRyKR2
        i5SqB2WOE76VrkruT+EDP0kC1yo57CSDpsh6MGWTmwP5/iZCHFu95OUxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=m2SPuS+TqZIaRWPYk39VEBgiHi9CQ4ibi3VfiVMAUb0=; b=RnwSRiWE
        bzgNfY/ZPYVgltrF8joYG2mKjwooBFiS+CWczKc+neombQvrahtiC5qYsS/Kn/jJ
        cUR5/SdRUE5nNrgexWcNxR9F7jViuWKbBg8AU/KY4JyLM2sgeA/9QD2XFLLDlROW
        865dfYbL+ASNWnNohpLRUAGKLvNDxewp8PDSQdp4VNbNIDVkA1m2DMVCsUzfEupW
        RdmCyefe83oCQ0zzsYuUnxeIOWMFWspxvLYlqHPil30Q6t2CyhBdklLxDO/0+gDt
        10B0fqtdiaaDYYF/hdC+eCV1QaJl77jFXZll/6vozt+xFZN+o70cqIGaSAdIwRrv
        Esv4bCVS3eo5jQ==
X-ME-Sender: <xms:42k1YGwiQ4GYT3IBPTXDGbTjaqj5V8h2OsiigIyNdusodWQmWWkUwA>
    <xme:42k1YCTMCAYeqq2Jem831eW8SQQJ3Ak_7nKl17Kqfo2YqqS-j-iooCfb0wWtQ8Zf0
    G1fB0z9XMbEnZ2-mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeehgddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeghihhllhhi
    rghmucffuhhrrghnugcuoeifihhllhdoghhithesughrnhgurdhmvgeqnecuggftrfgrth
    htvghrnhepjedvgeffieeivdefleekvddvudffvefhiefgueeujedvgfegfeelkeduffel
    ffefnecukfhppedvudejrddvfeekrddvtdekrdejgeenucevlhhushhtvghrufhiiigvpe
    dunecurfgrrhgrmhepmhgrihhlfhhrohhmpeifihhllhdoghhithesughrnhgurdhmvg
X-ME-Proxy: <xmx:42k1YIWbt9lDouJGmEO8j9g97iqe89dOJPcuF6vbz57OkuHEXU0O9Q>
    <xmx:42k1YMghZqJqHAcfYW9f8AV32FdW8jXq_L9W9zsjZOQgknlxDJ4y4g>
    <xmx:42k1YIDWebj19ugHs8xsCr7RgNTXrPxykTWJ-Z3CGPlni0Iy0i_Btg>
    <xmx:42k1YDrEyFfFvipy3JdhA0ZKpE-l8YApY0RM5We7WgQ-YYFPGp_30w>
Received: from vagrant.vm (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id CB014240065;
        Tue, 23 Feb 2021 15:47:30 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] staging: rtl8192e: rename bdHTCapLen to bd_ht_cap_len in bss_ht struct
Date:   Sat, 20 Feb 2021 15:54:08 +0000
Message-Id: <20210220155418.12282-5-will+git@drnd.me>
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

