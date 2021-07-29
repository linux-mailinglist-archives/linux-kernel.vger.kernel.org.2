Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78023D9AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 03:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhG2BKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 21:10:03 -0400
Received: from emcscan.emc.com.tw ([192.72.220.5]:36055 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbhG2BKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 21:10:01 -0400
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Jul 2021 21:10:01 EDT
X-IronPort-AV: E=Sophos;i="5.56,253,1539619200"; 
   d="scan'208";a="41940684"
Received: from unknown (HELO webmail.emc.com.tw) ([192.168.10.1])
  by emcscan.emc.com.tw with ESMTP; 29 Jul 2021 09:09:58 +0800
Received: from 192.168.10.23
        by webmail.emc.com.tw with MailAudit ESMTP Server V5.0(115098:0:AUTH_RELAY)
        (envelope-from <phoenix@emc.com.tw>); Thu, 29 Jul 2021 09:09:55 +0800 (CST)
Received: from 49.216.187.106
        by webmail.emc.com.tw with Mail2000 ESMTPA Server V7.00(2476:0:AUTH_LOGIN)
        (envelope-from <phoenix@emc.com.tw>); Thu, 29 Jul 2021 09:09:55 +0800 (CST)
From:   Phoenix Huang <phoenix@emc.com.tw>
To:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com
Cc:     jingle.wu@emc.com.tw, josh.chen@emc.com.tw, dave.wang@emc.com.tw,
        Phoenix Huang <phoenix@emc.com.tw>
Subject: [PATCH] Input: elantench - Fix the firmware misreport coordinates for trackpoint occasionally.
Date:   Thu, 29 Jul 2021 09:09:40 +0800
Message-Id: <20210729010940.5752-1-phoenix@emc.com.tw>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Phoenix Huang <phoenix@emc.com.tw>
---
 drivers/input/mouse/elantech.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 2d0bc029619f..07e1098f2d31 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -517,6 +517,17 @@ static void elantech_report_trackpoint(struct psmouse *psmouse,
 	case 0x16008020U:
 	case 0x26800010U:
 	case 0x36808000U:
+	
+		/* This firmware misreport coordinates for trackpoint occasionally.
+		* So we discard these packets by pattern to prevent cursor jumps.
+		*/
+		if (packet[4] == 0x80 || packet[5] == 0x80 ||
+		    packet[1] >> 7 == packet[4] >> 7 ||
+		    packet[2] >> 7 == packet[5] >> 7) {
+		    	elantech_debug("discarding packet [%6ph]\n", packet);
+			break;
+
+		}
 		x = packet[4] - (int)((packet[1]^0x80) << 1);
 		y = (int)((packet[2]^0x80) << 1) - packet[5];
 
-- 
2.25.1

