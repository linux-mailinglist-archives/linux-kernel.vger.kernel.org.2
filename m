Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D87830A2B2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 08:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhBAHbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 02:31:36 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:34990 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229613AbhBAHbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 02:31:34 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UNWqz.g_1612164642;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UNWqz.g_1612164642)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Feb 2021 15:30:42 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     arnd@arndb.de
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] misc: rtsx: Remove unneeded return variable
Date:   Mon,  1 Feb 2021 15:30:40 +0800
Message-Id: <1612164640-84541-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes unneeded return variables, using only
'0' instead.
It fixes the following warning detected by coccinelle:
./drivers/misc/cardreader/rtsx_pcr.c:1808:5-8: Unneeded variable: "ret".
Return "0" on line 1833.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/misc/cardreader/rtsx_pcr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 5a491d2..7dc7780 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1805,7 +1805,6 @@ static int rtsx_pci_runtime_resume(struct device *device)
 	struct pci_dev *pcidev = to_pci_dev(device);
 	struct pcr_handle *handle;
 	struct rtsx_pcr *pcr;
-	int ret = 0;
 
 	handle = pci_get_drvdata(pcidev);
 	pcr = handle->pcr;
@@ -1830,7 +1829,7 @@ static int rtsx_pci_runtime_resume(struct device *device)
 	schedule_delayed_work(&pcr->idle_work, msecs_to_jiffies(200));
 
 	mutex_unlock(&pcr->pcr_mutex);
-	return ret;
+	return 0;
 }
 
 #else /* CONFIG_PM */
-- 
1.8.3.1

