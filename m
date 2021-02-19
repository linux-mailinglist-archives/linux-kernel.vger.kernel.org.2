Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A97832003D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 22:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhBSVSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 16:18:34 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39469 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229689AbhBSVS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 16:18:27 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7F9645C0106;
        Fri, 19 Feb 2021 16:16:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 19 Feb 2021 16:16:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=ELOAyBeEhh0VX
        4FOdjIKAD/nMXMiE1K9Yu4E4QgOwvQ=; b=id2YL8MjvYrr5Mlmc9KbgdDG+5Wxz
        fz3EllcDxRSZVp9O2JbGK5LU620HmFGOc1/xCut8nZxi6PnOhuzCUgMhwNeHqHu0
        rDKNektEs9pBXbx/AbXzixoj4zK/k2vh8GDHHgpODOtP/VE42XVo01fjr5FGVnPF
        OqkOKx2OVM6MPnNSEA7RhzLZ+KtQzV7+3hxhHHW4wnDLOIE+ZmBYXUAy9pNNXeyw
        52t0qGdlAjJtWTKmix3wDnsydbQLvdplypKUhH1d6L/4wj+XlkNo1GB/MqOVzYDv
        46lagoMyveRW2IbstewoZKuFQM5bRfy0exRfrEW0HODaJECABSllaHJhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ELOAyBeEhh0VX4FOdjIKAD/nMXMiE1K9Yu4E4QgOwvQ=; b=p0VKuUjA
        lZSJlNLkg+xUxPrFV1m40HGNHtnthCFRloQJh9Ii1nGP9zEXYuCoWVYL3SmF5fo2
        dUDvAxwKoTN+wXXmytqMKTtDEkO1hLKJq4GE6lnWMGAxC4Om3kYIG2QsLWfkjIx/
        T1xspHbHiRvKopfiwO7qL33ZqY99Ukz6Dc5otng8FQzQYunNQGDp7ckV3vTnBi3c
        d8wu/xPWOZUtg4gdxLawG3mKeCLLcCBgk5phkXv3iObw8HX4EBPQiQp32MDgjQml
        F6XYnfnt1vnS34If3RIEG8IdKs0BrjXOQUr/KXeCPqmRmgeefescv2d9ZYg/RclQ
        cNJIyduvCBxu7A==
X-ME-Sender: <xms:xiowYG0dFTif4IfFZ4Q38YESGSU30JAKv0j8FqLxfB-HOWEvWu2Q0g>
    <xme:xiowYJGR38ehb7aqctP4m_OqlJad56pR8KRvjl2a3OdqQUdqXjY_GDg-WxxS8R_2w
    dM_2Zr2Vl1CieVdcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrjeeigddugeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeghihhllhhi
    rghmucffuhhrrghnugcuoeifihhllhdoghhithesughrnhgurdhmvgeqnecuggftrfgrth
    htvghrnhepjedvgeffieeivdefleekvddvudffvefhiefgueeujedvgfegfeelkeduffel
    ffefnecukfhppedvudejrddvfeekrddvtdekrdejgeenucevlhhushhtvghrufhiiigvpe
    egnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifihhllhdoghhithesughrnhgurdhmvg
X-ME-Proxy: <xmx:xiowYO6YBd4gk1-EvEWWIHphNisAQ-qWzoXQytyqFgJlRWtPi2x_hQ>
    <xmx:xiowYH1dEzSIIG3PbyNSpL8dqGPToiuRmWbsp2LMDvPKK4FHu0MMHg>
    <xmx:xiowYJHgvGNU0Wgav4gPfK-HgDOBgEIkxcoyrgT00JAFP-rHzddBCQ>
    <xmx:xiowYMOlZy3WDkwJiFKIiE6GuabrO2gPi5rr9u9yG-mDfNmrzB4ESw>
Received: from vagrant.vm (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id E8E77240057;
        Fri, 19 Feb 2021 16:16:53 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] staging: rtl8192e: rename TID to tid in delba_param_set union
Date:   Fri, 19 Feb 2021 16:14:00 +0000
Message-Id: <20210219161400.29316-6-will+git@drnd.me>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210219161400.29316-1-will+git@drnd.me>
References: <20210219161400.29316-1-will+git@drnd.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change uses lowercase for a field name to be more consistent with
the rest of the union.

Signed-off-by: William Durand <will+git@drnd.me>
---
 drivers/staging/rtl8192e/rtl819x_BA.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BA.h b/drivers/staging/rtl8192e/rtl819x_BA.h
index f94ce2d7d166..67574e26cdfc 100644
--- a/drivers/staging/rtl8192e/rtl819x_BA.h
+++ b/drivers/staging/rtl8192e/rtl819x_BA.h
@@ -44,7 +44,7 @@ union delba_param_set {
 	struct {
 		u16 reserved:11;
 		u16 initiator:1;
-		u16 TID:4;
+		u16 tid:4;
 	} field;
 };

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 3594d432b2a2..3455fd210372 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -142,7 +142,7 @@ static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,
 	memset(&DelbaParamSet, 0, 2);

 	DelbaParamSet.field.initiator = (TxRxSelect == TX_DIR) ? 1 : 0;
-	DelbaParamSet.field.TID	= pBA->BaParamSet.field.tid;
+	DelbaParamSet.field.tid	= pBA->BaParamSet.field.tid;

 	skb = dev_alloc_skb(len + sizeof(struct rtllib_hdr_3addr));
 	if (!skb)
@@ -444,11 +444,11 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 		struct rx_ts_record *pRxTs;

 		if (!GetTs(ieee, (struct ts_common_info **)&pRxTs, dst,
-		    (u8)pDelBaParamSet->field.TID, RX_DIR, false)) {
+		    (u8)pDelBaParamSet->field.tid, RX_DIR, false)) {
 			netdev_warn(ieee->dev,
 				    "%s(): can't get TS for RXTS. dst:%pM TID:%d\n",
 				    __func__, dst,
-				    (u8)pDelBaParamSet->field.TID);
+				    (u8)pDelBaParamSet->field.tid);
 			return -1;
 		}

@@ -457,7 +457,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 		struct tx_ts_record *pTxTs;

 		if (!GetTs(ieee, (struct ts_common_info **)&pTxTs, dst,
-			   (u8)pDelBaParamSet->field.TID, TX_DIR, false)) {
+			   (u8)pDelBaParamSet->field.tid, TX_DIR, false)) {
 			netdev_warn(ieee->dev, "%s(): can't get TS for TXTS\n",
 				    __func__);
 			return -1;
--
2.30.0

