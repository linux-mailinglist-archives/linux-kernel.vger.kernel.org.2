Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA4B32A000
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575098AbhCBDxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:53:05 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:43905 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241331AbhCAV5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:57:20 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id E23E2AFC;
        Mon,  1 Mar 2021 16:53:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 01 Mar 2021 16:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=DHxx/OjZocwVg
        7qSKMVnYfnVP0LKk/SUtZlncBx/5iA=; b=Qd/w6iXh/jD+ON1S0Tcq+P7XbBSJO
        kfkqNxCQzCYtkcJjnlV0Iq16lhEBQSB7k2zq9ylgab2A/WiXVfI93evqxz0Mno0m
        IUR/rnY1efs4KpDtkGy+VEYgLpWNk6P9fGXiBzwfQU1F1lw9DQD//yPt/yiTYlbH
        ffojmVl2LhQtaBTMXZI2mgyes6WOKZfSuP3Wt4iZiXR4FxtkdGM6DutozRec5Znz
        bx4keeff6lTUEqRY8dj+w//QttLjcWY9dxdq1cRdcm841oMvgidjDmqthT4yzzsN
        Bqa8bwMkwuVk99zWM59ZS7RXNzTxcjlTGm/xHqZbmsbQFxogqFpR1nE0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=DHxx/OjZocwVg7qSKMVnYfnVP0LKk/SUtZlncBx/5iA=; b=X/5ad12q
        EAy5Kqg/NFzOqJyr7wf7BTuelz8DQ+UO4e6NtEdxFljIBSW5ndzEFdUW9GZz/5OH
        +hnUY1Q644gpEnnlPCoVtVfDlvQGVfqNTVHKt5VyApBtz1r9ojMx56G4r0W4Pqb6
        s8yKeOZGxSxo5t1vzlF2XbwBuYdgFuGzoaHdxBkaGuN/NlJ/7GBX42WplKRZGM59
        ZOA8lG19h4FA6lj/yWj/zzaQlhugdqp861aJxgbHW8LrhXTwugqy6LRD8vH8YcUA
        ZWEFJISuHFgaQq+oi4KCbaeDuZ603Ew9x0wXg2IxaeLR5/277IosCWc5XaMGhg6Y
        aFqJ+VtaY0FE4w==
X-ME-Sender: <xms:ZWI9YMDG9L64d17o54b6eavHOs1ZaNzD3fu_Ni4_pCB4AbxQUVWm3Q>
    <xme:ZWI9YHd5xfVIYzWP9fa7T6KaaADPUipaJLZ1U9_QAO0Kia5EGCnaFvPE2VQwpxr7u
    w5PA8Y_RBG_vDENDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrleekgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeghihhllhhi
    rghmucffuhhrrghnugcuoeifihhllhdoghhithesughrnhgurdhmvgeqnecuggftrfgrth
    htvghrnhepjedvgeffieeivdefleekvddvudffvefhiefgueeujedvgfegfeelkeduffel
    ffefnecukfhppedvudejrddvfeekrddvtdekrdejgeenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifihhllhdoghhithesughrnhgurdhmvg
X-ME-Proxy: <xmx:ZWI9YLLpIpKnmpLFWNJvEdHzpym9hSaXae-uHmhRJtWL9Z0GSfnoZg>
    <xmx:ZWI9YC2uXFrEnSkdpSgt27YWMKOvA9rHbeveeFaCzgrg_09qxpgRFw>
    <xmx:ZWI9YNjxMZ6PXGOIeX3b5yJN7kj9ac40MeNe7oj9d5QtN1U82BNhdw>
    <xmx:ZWI9YMPGGEs9xbjy_zX2k8jKlpMqzTpph0KeiG2bYVl86k3DP4q6Eg>
Received: from vagrant.vm (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id 090CF24005B;
        Mon,  1 Mar 2021 16:53:40 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] staging: rtl8192e: rename RxPktPendingTimer to rx_pkt_pending_timer in rx_ts_record struct
Date:   Mon,  1 Mar 2021 21:53:30 +0000
Message-Id: <20210301215335.767-6-will+git@drnd.me>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301215335.767-1-will+git@drnd.me>
References: <20210301215335.767-1-will+git@drnd.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename RxPktPendingTimer to rx_pkt_pending_timer to silence a checkpatch
warning about CamelCase.

Signed-off-by: William Durand <will+git@drnd.me>
---
 drivers/staging/rtl8192e/rtl819x_TS.h     |  2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 10 +++++-----
 drivers/staging/rtl8192e/rtllib_rx.c      |  8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TS.h b/drivers/staging/rtl8192e/rtl819x_TS.h
index 3fc89906b309..0e936c82617b 100644
--- a/drivers/staging/rtl8192e/rtl819x_TS.h
+++ b/drivers/staging/rtl8192e/rtl819x_TS.h
@@ -46,7 +46,7 @@ struct rx_ts_record {
 	u16				rx_indicate_seq;
 	u16				rx_timeout_indicate_seq;
 	struct list_head		rx_pending_pkt_list;
-	struct timer_list		RxPktPendingTimer;
+	struct timer_list		rx_pkt_pending_timer;
 	struct ba_record RxAdmittedBARecord;
 	u16				RxLastSeqNum;
 	u8				RxLastFragNum;
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 0195c75ec59c..ae53303775da 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -19,7 +19,7 @@ static void TsInactTimeout(struct timer_list *unused)
 static void RxPktPendingTimeout(struct timer_list *t)
 {
 	struct rx_ts_record *pRxTs = from_timer(pRxTs, t,
-						     RxPktPendingTimer);
+						     rx_pkt_pending_timer);
 	struct rtllib_device *ieee = container_of(pRxTs, struct rtllib_device,
 						  RxTsRecord[pRxTs->num]);

@@ -82,7 +82,7 @@ static void RxPktPendingTimeout(struct timer_list *t)

 	if (bPktInBuf && (pRxTs->rx_timeout_indicate_seq == 0xffff)) {
 		pRxTs->rx_timeout_indicate_seq = pRxTs->rx_indicate_seq;
-		mod_timer(&pRxTs->RxPktPendingTimer,  jiffies +
+		mod_timer(&pRxTs->rx_pkt_pending_timer,  jiffies +
 			  msecs_to_jiffies(ieee->pHTInfo->RxReorderPendingTime)
 			  );
 	}
@@ -178,7 +178,7 @@ void TSInitialize(struct rtllib_device *ieee)
 		timer_setup(&pRxTS->RxAdmittedBARecord.timer,
 			    RxBaInactTimeout, 0);

-		timer_setup(&pRxTS->RxPktPendingTimer, RxPktPendingTimeout, 0);
+		timer_setup(&pRxTS->rx_pkt_pending_timer, RxPktPendingTimeout, 0);

 		ResetRxTsEntry(pRxTS);
 		list_add_tail(&pRxTS->ts_common_info.List,
@@ -405,8 +405,8 @@ static void RemoveTsEntry(struct rtllib_device *ieee,
 		struct rx_reorder_entry *pRxReorderEntry;
 		struct rx_ts_record *pRxTS = (struct rx_ts_record *)pTs;

-		if (timer_pending(&pRxTS->RxPktPendingTimer))
-			del_timer_sync(&pRxTS->RxPktPendingTimer);
+		if (timer_pending(&pRxTS->rx_pkt_pending_timer))
+			del_timer_sync(&pRxTS->rx_pkt_pending_timer);

 		while (!list_empty(&pRxTS->rx_pending_pkt_list)) {
 			pRxReorderEntry = (struct rx_reorder_entry *)
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index cbf314cbfebf..50c30993f68d 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -536,7 +536,7 @@ void rtllib_FlushRxTsPendingPkts(struct rtllib_device *ieee,
 	struct rx_reorder_entry *pRxReorderEntry;
 	u8 RfdCnt = 0;

-	del_timer_sync(&pTS->RxPktPendingTimer);
+	del_timer_sync(&pTS->rx_pkt_pending_timer);
 	while (!list_empty(&pTS->rx_pending_pkt_list)) {
 		if (RfdCnt >= REORDER_WIN_SIZE) {
 			netdev_info(ieee->dev,
@@ -735,8 +735,8 @@ static void RxReorderIndicatePacket(struct rtllib_device *ieee,
 	 * Rx buffering.
 	 */
 	if (index > 0) {
-		if (timer_pending(&pTS->RxPktPendingTimer))
-			del_timer_sync(&pTS->RxPktPendingTimer);
+		if (timer_pending(&pTS->rx_pkt_pending_timer))
+			del_timer_sync(&pTS->rx_pkt_pending_timer);
 		pTS->rx_timeout_indicate_seq = 0xffff;

 		if (index > REORDER_WIN_SIZE) {
@@ -754,7 +754,7 @@ static void RxReorderIndicatePacket(struct rtllib_device *ieee,
 	if (bPktInBuf && pTS->rx_timeout_indicate_seq == 0xffff) {
 		netdev_dbg(ieee->dev, "%s(): SET rx timeout timer\n", __func__);
 		pTS->rx_timeout_indicate_seq = pTS->rx_indicate_seq;
-		mod_timer(&pTS->RxPktPendingTimer, jiffies +
+		mod_timer(&pTS->rx_pkt_pending_timer, jiffies +
 			  msecs_to_jiffies(pHTInfo->RxReorderPendingTime));
 	}
 	spin_unlock_irqrestore(&(ieee->reorder_spinlock), flags);
--
2.30.1

