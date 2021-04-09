Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C174E359907
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbhDIJWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:22:38 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:44285 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230181AbhDIJWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:22:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UUzGglv_1617960137;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UUzGglv_1617960137)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 09 Apr 2021 17:22:22 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     linux@roeck-us.net
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] usb: typec: tcpm: remove useless variable
Date:   Fri,  9 Apr 2021 17:22:16 +0800
Message-Id: <1617960136-95131-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

drivers/usb/typec/tcpm/tcpm.c:2107:39: warning: ‘tcpm_altmode_ops’
defined but not used [-Wunused-const-variable=].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index ce7af39..4585785 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2104,12 +2104,6 @@ static int tcpm_altmode_vdm(struct typec_altmode *altmode,
 	return 0;
 }
 
-static const struct typec_altmode_ops tcpm_altmode_ops = {
-	.enter = tcpm_altmode_enter,
-	.exit = tcpm_altmode_exit,
-	.vdm = tcpm_altmode_vdm,
-};
-
 /*
  * PD (data, control) command handling functions
  */
-- 
1.8.3.1

