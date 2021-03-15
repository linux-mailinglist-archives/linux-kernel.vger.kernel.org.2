Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B3333B014
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhCOKhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:37:54 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:45374 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCOKh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:37:26 -0400
Received: from localhost (unknown [192.168.167.69])
        by lucky1.263xmail.com (Postfix) with ESMTP id 6CF3AB99D7;
        Mon, 15 Mar 2021 18:37:11 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [111.207.172.18])
        by smtp.263.net (postfix) whith ESMTP id P1823T139670352451328S1615804623427755_;
        Mon, 15 Mar 2021 18:37:10 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <35613c0e6669eeb9805c646e3543e6a6>
X-RL-SENDER: penghaob@uniontech.com
X-SENDER: penghaob@uniontech.com
X-LOGIN-NAME: penghaob@uniontech.com
X-FST-TO: gregkh@linuxfoundation.org
X-SENDER-IP: 111.207.172.18
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Hao Peng <penghaob@uniontech.com>
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        izabela.bakollari@gmail.com, penghaob@uniontech.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: remove extra space in rtl819x_BAProc.c
Date:   Mon, 15 Mar 2021 18:33:20 +0800
Message-Id: <20210315103320.18536-1-penghaob@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra spaces in rtl819x_BAProc.c.

Signed-off-by: Hao Peng <penghaob@uniontech.com>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 2d5e4a0330c6..f692ad7f9bbc 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -45,7 +45,7 @@ static u8 TxTsDeleteBA(struct rtllib_device *ieee, struct tx_ts_record *pTxTs)
 static u8 RxTsDeleteBA(struct rtllib_device *ieee, struct rx_ts_record *pRxTs)
 {
 	struct ba_record *pBa = &pRxTs->RxAdmittedBARecord;
-	u8			bSendDELBA = false;
+	u8 bSendDELBA = false;
 
 	if (pBa->bValid) {
 		DeActivateBAEntry(ieee, pBa);
@@ -314,7 +314,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	u8 *dst = NULL, *pDialogToken = NULL, *tag = NULL;
 	u16 *pStatusCode = NULL, *pBaTimeoutVal = NULL;
 	union ba_param_set *pBaParamSet = NULL;
-	u16			ReasonCode;
+	u16 ReasonCode;
 
 	if (skb->len < sizeof(struct rtllib_hdr_3addr) + 9) {
 		netdev_warn(ieee->dev, "Invalid skb len in BARSP(%d / %d)\n",
-- 
2.20.1



