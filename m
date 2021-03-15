Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D3C33AB78
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 07:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhCOGM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 02:12:29 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:58270 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhCOGM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 02:12:28 -0400
Received: from localhost (unknown [192.168.167.13])
        by lucky1.263xmail.com (Postfix) with ESMTP id CFEE6CC26E;
        Mon, 15 Mar 2021 14:12:03 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P13099T140547744294656S1615788724196639_;
        Mon, 15 Mar 2021 14:12:04 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <6af1cf402b318c9f64df771cc8e606d9>
X-RL-SENDER: zhaoxiao@uniontech.com
X-SENDER: zhaoxiao@uniontech.com
X-LOGIN-NAME: zhaoxiao@uniontech.com
X-FST-TO: gregkh@linuxfoundation.org
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     gregkh@linuxfoundation.org, straube.linux@gmail.com,
        serrazimone@gmail.com, lu@pplo.net, dan.carpenter@oracle.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] staging: rtl8192u: fixed no space coding style issue.
Date:   Mon, 15 Mar 2021 14:12:02 +0800
Message-Id: <20210315061202.10219-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added space around the binary operator for readability in
r8192U_wx.c file

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 drivers/staging/rtl8192u/r8192U_wx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_wx.c b/drivers/staging/rtl8192u/r8192U_wx.c
index 5211b2005763..6ead461e3279 100644
--- a/drivers/staging/rtl8192u/r8192U_wx.c
+++ b/drivers/staging/rtl8192u/r8192U_wx.c
@@ -276,7 +276,7 @@ static int rtl8180_wx_get_range(struct net_device *dev,
 	range->min_pmp = 0;
 	range->max_pmp = 5000000;
 	range->min_pmt = 0;
-	range->max_pmt = 65535*1000;
+	range->max_pmt = 65535 * 1000;
 	range->pmp_flags = IW_POWER_PERIOD;
 	range->pmt_flags = IW_POWER_TIMEOUT;
 	range->pm_capa = IW_POWER_PERIOD | IW_POWER_TIMEOUT | IW_POWER_ALL_R;
@@ -519,14 +519,14 @@ static int r8192_wx_set_enc(struct net_device *dev,
 	/* sometimes, the length is zero while we do not type key value */
 	if (wrqu->encoding.length != 0) {
 		for (i = 0; i < 4; i++) {
-			hwkey[i] |=  key[4*i+0]&mask;
-			if (i == 1 && (4*i+1) == wrqu->encoding.length)
+			hwkey[i] |=  key[4 * i + 0] & mask;
+			if (i == 1 && (4 * i + 1) == wrqu->encoding.length)
 				mask = 0x00;
-			if (i == 3 && (4*i+1) == wrqu->encoding.length)
+			if (i == 3 && (4 * i + 1) == wrqu->encoding.length)
 				mask = 0x00;
-			hwkey[i] |= (key[4*i+1]&mask)<<8;
-			hwkey[i] |= (key[4*i+2]&mask)<<16;
-			hwkey[i] |= (key[4*i+3]&mask)<<24;
+			hwkey[i] |= (key[4 * i + 1] & mask) << 8;
+			hwkey[i] |= (key[4 * i + 2] & mask) << 16;
+			hwkey[i] |= (key[4 * i + 3] & mask) << 24;
 		}
 
 		#define CONF_WEP40  0x4
-- 
2.20.1



