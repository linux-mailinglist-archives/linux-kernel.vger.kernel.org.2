Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1A432A002
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575116AbhCBDxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:53:22 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:36753 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242709AbhCAV5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:57:40 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 8EE04C85;
        Mon,  1 Mar 2021 16:53:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 01 Mar 2021 16:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=qFWgS+NhL6ELU
        YFI9Xqihp8CyIzTgyucYmcjp2Rz2qQ=; b=cC9IOhf60g2AGw4qPNxUKePFvG0XQ
        bp318EMsb27HwP1WzTKdCxsQ+XUW2pA1hU3chNgHu9iW4VG2ObyakOMrsRty3pNc
        OE06XL7FIkH3IHje72hIqh/YaDqTigAEaYfxj21T6lsYDBlmSKOjxFGhpNiKvoRA
        ypDlLz0BzuijJR0V+pqNECYvHulWYBjL6XG5hEfBwiBm6K+os2ulVcRjq8+BZX9I
        YCQfNf+xM1lIq+d4gGRlfp5qABPbs1n4w7Xl8Y4DWtTXNbb2zcQ5kTU7QHV0PH8g
        cfvHLL9bQpLa/OPSf2iwjK+mUchE1wRjxsioI+KlHfd0Va1+ouWlOx95g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=qFWgS+NhL6ELUYFI9Xqihp8CyIzTgyucYmcjp2Rz2qQ=; b=ZZCRIBkv
        6lA0Its5EVXfb/Gn8Y4qljCg0Sc7t6Oobzoc6apE9A5YdYSpDUcY/jj6s8mk/Wux
        zLf3IWenWZNvgalM+PsMv9kJKInZRG05TQ7zU8dX+oPvzakZ3RuyQPQMiEtJv2fA
        WYrinShGWT23392sFayAsHDq8Bzu615I5gRZtCQG4woYzYrgA8lkHVC61ANEnhig
        3mqujKGmnMK8CGBxG9iwZXKqL4+XrGdzLop74J+pavjcfaJdvwOru+BRlETDuzZZ
        WckMpoiIWXn3cfZmYXjvRvCkTxa4uelrG03rCgZReXXIatYMEPqeOSSImO4uPyZK
        9GSdwD24QCqDoA==
X-ME-Sender: <xms:ZmI9YGNwwPXT2TSPfy5UzOSwb7L_cwE5UzJLLvf4-gOanJ-CgH2M5Q>
    <xme:ZmI9YE5NomXB7zKPiwg_-tPXSt16gsgCK7qVH6p3y_ZSQl4OyRSZuShzino426j6Z
    ogyzYgqitCWJ3naiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrleekgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeghihhllhhi
    rghmucffuhhrrghnugcuoeifihhllhdoghhithesughrnhgurdhmvgeqnecuggftrfgrth
    htvghrnhepjedvgeffieeivdefleekvddvudffvefhiefgueeujedvgfegfeelkeduffel
    ffefnecukfhppedvudejrddvfeekrddvtdekrdejgeenucevlhhushhtvghrufhiiigvpe
    dunecurfgrrhgrmhepmhgrihhlfhhrohhmpeifihhllhdoghhithesughrnhgurdhmvg
X-ME-Proxy: <xmx:ZmI9YKLzm6AYSD6695kdYTKRKmf7y8nbNPrQnExXLOxT7aNz_hKxqA>
    <xmx:ZmI9YOc0TVb80OF_ATdhfvMjFyGjxgkoNzDyGsyizTCgd8--fKo-rQ>
    <xmx:ZmI9YNcZWkISntiWJTYOIXr57U7gJeXeAD1_B7e_c9doCVwCalpKTQ>
    <xmx:ZmI9YI9GOt6LTQJdRUAAfT1ql4hB9nxNZl1egckM-LadBEFKFmMasA>
Received: from vagrant.vm (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id B0A66240064;
        Mon,  1 Mar 2021 16:53:41 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] staging: rtl8192e: rename RxAdmittedBARecord to rx_admitted_ba_record in rx_ts_record struct
Date:   Mon,  1 Mar 2021 21:53:31 +0000
Message-Id: <20210301215335.767-7-will+git@drnd.me>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301215335.767-1-will+git@drnd.me>
References: <20210301215335.767-1-will+git@drnd.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename RxAdmittedBARecord to rx_admitted_ba_record to silence a
checkpatch warning about CamelCase.

Signed-off-by: William Durand <will+git@drnd.me>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 10 +++++-----
 drivers/staging/rtl8192e/rtl819x_TS.h     |  2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c |  4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 760d143cb3bd..7dfe7a055876 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -44,7 +44,7 @@ static u8 TxTsDeleteBA(struct rtllib_device *ieee, struct tx_ts_record *pTxTs)

 static u8 RxTsDeleteBA(struct rtllib_device *ieee, struct rx_ts_record *pRxTs)
 {
-	struct ba_record *pBa = &pRxTs->RxAdmittedBARecord;
+	struct ba_record *pBa = &pRxTs->rx_admitted_ba_record;
 	u8			bSendDELBA = false;

 	if (pBa->b_valid) {
@@ -265,7 +265,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 		netdev_warn(ieee->dev, "%s(): can't get TS\n", __func__);
 		goto OnADDBAReq_Fail;
 	}
-	pBA = &pTS->RxAdmittedBARecord;
+	pBA = &pTS->rx_admitted_ba_record;

 	if (pBaParamSet->field.ba_policy == BA_POLICY_DELAYED) {
 		rc = ADDBA_STATUS_INVALID_PARAM;
@@ -514,7 +514,7 @@ void TsInitDelBA(struct rtllib_device *ieee,
 				 (struct rx_ts_record *)pTsCommonInfo;
 		if (RxTsDeleteBA(ieee, pRxTs))
 			rtllib_send_DELBA(ieee, pTsCommonInfo->Addr,
-					  &pRxTs->RxAdmittedBARecord,
+					  &pRxTs->rx_admitted_ba_record,
 					  TxRxSelect, DELBA_REASON_END_BA);
 	}
 }
@@ -544,12 +544,12 @@ void TxBaInactTimeout(struct timer_list *t)
 void RxBaInactTimeout(struct timer_list *t)
 {
 	struct rx_ts_record *pRxTs = from_timer(pRxTs, t,
-					      RxAdmittedBARecord.timer);
+					      rx_admitted_ba_record.timer);
 	struct rtllib_device *ieee = container_of(pRxTs, struct rtllib_device,
 				     RxTsRecord[pRxTs->num]);

 	RxTsDeleteBA(ieee, pRxTs);
 	rtllib_send_DELBA(ieee, pRxTs->ts_common_info.Addr,
-			  &pRxTs->RxAdmittedBARecord, RX_DIR,
+			  &pRxTs->rx_admitted_ba_record, RX_DIR,
 			  DELBA_REASON_TIMEOUT);
 }
diff --git a/drivers/staging/rtl8192e/rtl819x_TS.h b/drivers/staging/rtl8192e/rtl819x_TS.h
index 0e936c82617b..333bf6b4f164 100644
--- a/drivers/staging/rtl8192e/rtl819x_TS.h
+++ b/drivers/staging/rtl8192e/rtl819x_TS.h
@@ -47,7 +47,7 @@ struct rx_ts_record {
 	u16				rx_timeout_indicate_seq;
 	struct list_head		rx_pending_pkt_list;
 	struct timer_list		rx_pkt_pending_timer;
-	struct ba_record RxAdmittedBARecord;
+	struct ba_record rx_admitted_ba_record;
 	u16				RxLastSeqNum;
 	u8				RxLastFragNum;
 	u8				num;
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index ae53303775da..c294a6543e12 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -126,7 +126,7 @@ static void ResetRxTsEntry(struct rx_ts_record *pTS)
 	ResetTsCommonInfo(&pTS->ts_common_info);
 	pTS->rx_indicate_seq = 0xffff;
 	pTS->rx_timeout_indicate_seq = 0xffff;
-	ResetBaEntry(&pTS->RxAdmittedBARecord);
+	ResetBaEntry(&pTS->rx_admitted_ba_record);
 }

 void TSInitialize(struct rtllib_device *ieee)
@@ -175,7 +175,7 @@ void TSInitialize(struct rtllib_device *ieee)
 		timer_setup(&pRxTS->ts_common_info.InactTimer, TsInactTimeout,
 			    0);

-		timer_setup(&pRxTS->RxAdmittedBARecord.timer,
+		timer_setup(&pRxTS->rx_admitted_ba_record.timer,
 			    RxBaInactTimeout, 0);

 		timer_setup(&pRxTS->rx_pkt_pending_timer, RxPktPendingTimeout, 0);
--
2.30.1

