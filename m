Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFE331F731
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhBSKP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:15:26 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51393 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230204AbhBSKNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:13:43 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AD8625C00E7;
        Fri, 19 Feb 2021 05:12:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 19 Feb 2021 05:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=6x5A3wAl/23ph
        S+Vj7yymD9ii9+9Vbclp2P6ACGXR2Q=; b=ODxZKYTOshxoRDqMNhESxsAaNHqpc
        2NG+cc36yl34nkxYrHLXBjNQwfTpeBSZAt6npKzqEjiioX3AS40yHdUex3zwxX2D
        oTN68FxijqLc07AomJZx/KgQSr+mH0zht6jz+KJmpCwNDcIJyCpB8T/+8EOxKNAv
        MFqCIJ2bngA3ryqTeu/1MlO2fZpdbVsWlNoCcaHHRFSkV+a/Rxrj+7ooGkOQJhJV
        qTX1iyiP7QBdcF9UXt+RoQ822Wz6Q1aR8TeFa49IbaRDG3GtM90rc+aEZ4j2gI4K
        +1mnTsDPoczvZC5YN1mGIKXMhMcosk8DiAlC8ku8Z9pqgZqyjXlHRyp1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=6x5A3wAl/23phS+Vj7yymD9ii9+9Vbclp2P6ACGXR2Q=; b=dLDjNhVc
        ax0WQB1hDH0tliDJEEIvtfFPBnO785K25mfAChgXast+Ik3AA40UT9M9a25yoZY+
        Lf8ldwAMWKYFX8oQHmNrCzVIC9MeI1WJq3EAJdPlch2bz3W+j/KgdapjPELRwybp
        Nn4y3g6LjHM7Fk//qByFTBWZqT3ccwehDJ+YlzakOATjjMhrfWOelsFUlu6cAmq6
        FUPlVbIlI0BpW8lJdAyHKARSpir/Ji4wMKQ00FBm5WoH7Wu2RhL3fmRMLf7P5hO0
        WbSmwRolcKYwFuGOqyRUJy1dH1aXXOJmDlQTWpYqM6DbvhfPEh6NVgQB311KGBTF
        KJFHSWXfVvkcpA==
X-ME-Sender: <xms:_Y4vYIcfCD4-e0LadZUa4_MUooXwmNXcTZUJAUX7BAAqylTwQrqL8Q>
    <xme:_Y4vYEQWiiqZhis-MV17B8yW3rGLQPyxswBnlAOG9DOzHsrXLKFYi-se_xerdgg8L
    e0g0E5VCtSoXMNG8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrjeeigdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhephghilhhlihgr
    mhcuffhurhgrnhguuceofihilhhlodhgihhtsegurhhnugdrmhgvqeenucggtffrrghtth
    gvrhhnpefhjeelheehvdfgkeffieduieefffekleevudeuleffueevkeejveetgefhtdef
    gfenucffohhmrghinhepfhhivghlugdrsggrnecukfhppedufedvrddvfedtrdduleegrd
    ejfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeif
    ihhllhdoghhithesughrnhgurdhmvg
X-ME-Proxy: <xmx:_Y4vYJbuVh-9CAsYJSA__8vIBWt0MvBOHcuvfbcQNeW3JfRoxsU7Dw>
    <xmx:_Y4vYPdUDwfUrTWGS6elvbmj2wb3gjMZHi9aklEVz8MtHTpIWwblmA>
    <xmx:_Y4vYCLVHeGbmhJN726TyQn29AnFZqTlXZjlfNDmX13OJlVJDp37PA>
    <xmx:_Y4vYBTHi9fSvA9xS-YUutean6SASVbKEA0rnvKTntFe-qCL0le0QQ>
Received: from vagrant.eduroam-fp.privat (ufr-132-230-194-73.eduroam-nat.uni-freiburg.de [132.230.194.73])
        by mail.messagingengine.com (Postfix) with ESMTPA id 347681080057;
        Fri, 19 Feb 2021 05:12:13 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] staging: rtl8192e: rename TID to tid in ba_param_set union
Date:   Fri, 19 Feb 2021 10:12:06 +0000
Message-Id: <20210219101206.18036-7-will+git@drnd.me>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210219101206.18036-1-will+git@drnd.me>
References: <20210219101206.18036-1-will+git@drnd.me>
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
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BA.h b/drivers/staging/rtl8192e/rtl819x_BA.h
index 1a8ca249ed23..36280c62fa56 100644
--- a/drivers/staging/rtl8192e/rtl819x_BA.h
+++ b/drivers/staging/rtl8192e/rtl819x_BA.h
@@ -33,7 +33,7 @@ union ba_param_set {
 	struct {
 		u16 amsdu_support:1;
 		u16 ba_policy:1;
-		u16 TID:4;
+		u16 tid:4;
 		u16 buffer_size:10;
 	} field;
 };
diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 002ec9a7a8c0..1f697e87ae8d 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -142,7 +142,7 @@ static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,
 	memset(&DelbaParamSet, 0, 2);

 	DelbaParamSet.field.Initiator = (TxRxSelect == TX_DIR) ? 1 : 0;
-	DelbaParamSet.field.TID	= pBA->BaParamSet.field.TID;
+	DelbaParamSet.field.TID	= pBA->BaParamSet.field.tid;

 	skb = dev_alloc_skb(len + sizeof(struct rtllib_hdr_3addr));
 	if (!skb)
@@ -260,7 +260,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 		goto OnADDBAReq_Fail;
 	}
 	if (!GetTs(ieee, (struct ts_common_info **)(&pTS), dst,
-	    (u8)(pBaParamSet->field.TID), RX_DIR, true)) {
+	    (u8)(pBaParamSet->field.tid), RX_DIR, true)) {
 		rc = ADDBA_STATUS_REFUSED;
 		netdev_warn(ieee->dev, "%s(): can't get TS\n", __func__);
 		goto OnADDBAReq_Fail;
@@ -346,7 +346,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)


 	if (!GetTs(ieee, (struct ts_common_info **)(&pTS), dst,
-		   (u8)(pBaParamSet->field.TID), TX_DIR, false)) {
+		   (u8)(pBaParamSet->field.tid), TX_DIR, false)) {
 		netdev_warn(ieee->dev, "%s(): can't get TS\n", __func__);
 		ReasonCode = DELBA_REASON_UNKNOWN_BA;
 		goto OnADDBARsp_Reject;
@@ -485,8 +485,7 @@ void TsInitAddBA(struct rtllib_device *ieee, struct tx_ts_record *pTS,
 	pBA->DialogToken++;
 	pBA->BaParamSet.field.amsdu_support = 0;
 	pBA->BaParamSet.field.ba_policy = Policy;
-	pBA->BaParamSet.field.TID =
-			 pTS->TsCommonInfo.TSpec.f.TSInfo.field.ucTSID;
+	pBA->BaParamSet.field.tid = pTS->TsCommonInfo.TSpec.f.TSInfo.field.ucTSID;
 	pBA->BaParamSet.field.buffer_size = 32;
 	pBA->BaTimeoutValue = 0;
 	pBA->BaStartSeqCtrl.field.seq_num = (pTS->TxCurSeq + 3) % 4096;
--
2.30.0

