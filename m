Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26DD36FA22
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 14:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhD3M3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 08:29:35 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:59318 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhD3M3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 08:29:34 -0400
Received: from localhost (unknown [192.168.167.13])
        by lucky1.263xmail.com (Postfix) with ESMTP id 71894BA115;
        Fri, 30 Apr 2021 20:28:27 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P1751T140588856878848S1619785707734504_;
        Fri, 30 Apr 2021 20:28:27 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <2bd590c5b17d06d909c8054a1b06d97d>
X-RL-SENDER: zhaoxiao@uniontech.com
X-SENDER: zhaoxiao@uniontech.com
X-LOGIN-NAME: zhaoxiao@uniontech.com
X-FST-TO: gregkh@linuxfoundation.org
X-RCPT-COUNT: 10
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     gregkh@linuxfoundation.org
Cc:     will+git@drnd.me, dan.carpenter@oracle.com, phil@philpotter.co.uk,
        apais@linux.microsoft.com, gustavoars@kernel.org,
        davidsondfgl@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] staging: rtl8192e: remove unnecesasry ftrace-like logging
Date:   Fri, 30 Apr 2021 20:28:25 +0800
Message-Id: <20210430122826.9899-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed Check: Remove unnecessary ftrace-like logging by simply deleting
that statement as we have other modes of logging like ftrace.
Reported by checkpatch.

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 1 -
 drivers/staging/rtl8192e/rtllib_wx.c      | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index f9a51f3620d2..25b3d3950a3c 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -730,7 +730,6 @@ EXPORT_SYMBOL(rtllib_act_scanning);
 /* called with ieee->lock held */
 static void rtllib_start_scan(struct rtllib_device *ieee)
 {
-	RT_TRACE(COMP_DBG, "===>%s()\n", __func__);
 	if (ieee->rtllib_ips_leave_wq != NULL)
 		ieee->rtllib_ips_leave_wq(ieee->dev);
 
diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index ab1b8217c4e0..0d67d5880377 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -293,8 +293,6 @@ int rtllib_wx_set_encode(struct rtllib_device *ieee,
 	int i, key, key_provided, len;
 	struct lib80211_crypt_data **crypt;
 
-	netdev_dbg(ieee->dev, "%s()\n", __func__);
-
 	key = erq->flags & IW_ENCODE_INDEX;
 	if (key) {
 		if (key > NUM_WEP_KEYS)
@@ -463,8 +461,6 @@ int rtllib_wx_get_encode(struct rtllib_device *ieee,
 	int len, key;
 	struct lib80211_crypt_data *crypt;
 
-	netdev_dbg(ieee->dev, "%s()\n", __func__);
-
 	if (ieee->iw_mode == IW_MODE_MONITOR)
 		return -1;
 
-- 
2.20.1



