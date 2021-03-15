Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBD733B0A8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 12:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCOLIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 07:08:41 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:51842 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhCOLIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 07:08:19 -0400
Received: from localhost (unknown [192.168.167.13])
        by lucky1.263xmail.com (Postfix) with ESMTP id 2AF34F2C3A;
        Mon, 15 Mar 2021 19:08:08 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P13096T140547807233792S1615806482687002_;
        Mon, 15 Mar 2021 19:08:08 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <fb43d8a339f7085f2de66e963418f4e0>
X-RL-SENDER: penghaob@uniontech.com
X-SENDER: penghaob@uniontech.com
X-LOGIN-NAME: penghaob@uniontech.com
X-FST-TO: gregkh@linuxfoundation.org
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Hao Peng <penghaob@uniontech.com>
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        izabela.bakollari@gmail.com, penghaob@uniontech.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: remove extra lines in rtl819x_BAProc.c
Date:   Mon, 15 Mar 2021 19:04:18 +0800
Message-Id: <20210315110418.25117-1-penghaob@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra lines in rtl819x_BAProc.c.

Signed-off-by: Hao Peng <penghaob@uniontech.com>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index f692ad7f9bbc..adc2304ae155 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -162,7 +162,6 @@ static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,
 	*tag++ = ACT_CAT_BA;
 	*tag++ = ACT_DELBA;
 
-
 	put_unaligned_le16(DelbaParamSet.shortData, tag);
 	tag += 2;
 
@@ -182,7 +181,6 @@ static void rtllib_send_ADDBAReq(struct rtllib_device *ieee, u8 *dst,
 	struct sk_buff *skb;
 
 	skb = rtllib_ADDBA(ieee, dst, pBA, 0, ACT_ADDBAREQ);
-
 	if (skb) {
 		RT_TRACE(COMP_DBG, "====>to send ADDBAREQ!!!!!\n");
 		softmac_mgmt_xmit(skb, ieee);
@@ -344,7 +342,6 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 		goto OnADDBARsp_Reject;
 	}
 
-
 	if (!GetTs(ieee, (struct ts_common_info **)(&pTS), dst,
 		   (u8)(pBaParamSet->field.TID), TX_DIR, false)) {
 		netdev_warn(ieee->dev, "%s(): can't get TS\n", __func__);
@@ -356,7 +353,6 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	pPendingBA = &pTS->TxPendingBARecord;
 	pAdmittedBA = &pTS->TxAdmittedBARecord;
 
-
 	if (pAdmittedBA->bValid) {
 		netdev_dbg(ieee->dev, "%s(): ADDBA response already admitted\n",
 			   __func__);
@@ -375,7 +371,6 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 		DeActivateBAEntry(ieee, pPendingBA);
 	}
 
-
 	if (*pStatusCode == ADDBA_STATUS_SUCCESS) {
 		if (pBaParamSet->field.BAPolicy == BA_POLICY_DELAYED) {
 			pTS->bAddBaReqDelayed = true;
@@ -384,7 +379,6 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 			goto OnADDBARsp_Reject;
 		}
 
-
 		pAdmittedBA->DialogToken = *pDialogToken;
 		pAdmittedBA->BaTimeoutValue = *pBaTimeoutVal;
 		pAdmittedBA->BaStartSeqCtrl = pPendingBA->BaStartSeqCtrl;
-- 
2.20.1



