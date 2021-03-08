Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743EF330808
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 07:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbhCHGVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 01:21:40 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:34645 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234831AbhCHGVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 01:21:25 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UQpSCpB_1615184483;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UQpSCpB_1615184483)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 08 Mar 2021 14:21:23 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     linux@roeck-us.net
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] usb: typec: tcpm: turn tcpm_ams_finish into void function
Date:   Mon,  8 Mar 2021 14:21:21 +0800
Message-Id: <1615184481-102148-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function always return '0' and no callers use the return value.
So make it a void function.

This eliminates the following coccicheck warning:
./drivers/usb/typec/tcpm/tcpm.c:778:5-8: Unneeded variable: "ret".
Return "0" on line 794

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index be0b646..6ee984e 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -773,10 +773,8 @@ static enum typec_cc_status tcpm_rp_cc(struct tcpm_port *port)
 	return TYPEC_CC_RP_DEF;
 }
 
-static int tcpm_ams_finish(struct tcpm_port *port)
+static void tcpm_ams_finish(struct tcpm_port *port)
 {
-	int ret = 0;
-
 	tcpm_log(port, "AMS %s finished", tcpm_ams_str[port->ams]);
 
 	if (port->pd_capable && port->pwr_role == TYPEC_SOURCE) {
@@ -791,7 +789,7 @@ static int tcpm_ams_finish(struct tcpm_port *port)
 	port->in_ams = false;
 	port->ams = NONE_AMS;
 
-	return ret;
+	return;
 }
 
 static int tcpm_pd_transmit(struct tcpm_port *port,
-- 
1.8.3.1

