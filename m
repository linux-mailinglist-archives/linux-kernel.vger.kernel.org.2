Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C0934754E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbhCXKGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:06:49 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:52526 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233165AbhCXKGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:06:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UTAJrkW_1616580363;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UTAJrkW_1616580363)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Mar 2021 18:06:03 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     arnd@arndb.de
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] misc: rtsx: check the value returned from a function for errors before being used
Date:   Wed, 24 Mar 2021 18:05:58 +0800
Message-Id: <1616580358-93156-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing return value check in pm_runtime_get disabling the
sensor. The issue is reported by coverity with the following error:

Medium:Unchecked return value(CHECKED_RETURN)
CWE252: Value returned from a function is not checked for errors before
being used.
Calling "pm_runtime_get" without checking return value.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/misc/cardreader/rtsx_pcr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 2733111..2cc37fd 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -142,13 +142,16 @@ static void rtsx_pm_full_on(struct rtsx_pcr *pcr)
 
 void rtsx_pci_start_run(struct rtsx_pcr *pcr)
 {
+	int status;
 	/* If pci device removed, don't queue idle work any more */
 	if (pcr->remove_pci)
 		return;
 
 	if (pcr->rtd3_en)
 		if (pcr->is_runtime_suspended) {
-			pm_runtime_get(&(pcr->pci->dev));
+			status = pm_runtime_get(&(pcr->pci->dev));
+			if (status < 0 && status != -EINPROGRESS)
+				pm_runtime_put_noidle(&(pcr->pci->dev));
 			pcr->is_runtime_suspended = false;
 		}
 
-- 
1.8.3.1

