Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042263A3FF9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 12:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhFKKRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 06:17:43 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:45410 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230356AbhFKKRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 06:17:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Uc2YY7m_1623406522;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Uc2YY7m_1623406522)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 11 Jun 2021 18:15:41 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     valentina.manea.m@gmail.com
Cc:     shuah@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH v2] usbip: tools: usbipd: use ARRAY_SIZE for sockfdlist
Date:   Fri, 11 Jun 2021 18:15:10 +0800
Message-Id: <1623406510-50900-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ARRAY_SIZE instead of dividing sizeof array with sizeof an
element.

Clean up the following coccicheck warning:

./tools/usb/usbip/src/usbipd.c:536:19-20: WARNING: Use ARRAY_SIZE.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Add ARRAY_SIZE definition to usbip_common.h file.

 tools/usb/usbip/libsrc/usbip_common.h | 2 ++
 tools/usb/usbip/src/usbipd.c          | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/usb/usbip/libsrc/usbip_common.h b/tools/usb/usbip/libsrc/usbip_common.h
index 73a367a..4e12dc4 100644
--- a/tools/usb/usbip/libsrc/usbip_common.h
+++ b/tools/usb/usbip/libsrc/usbip_common.h
@@ -101,6 +101,8 @@
 		abort();				\
 	} while (0)
 
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
 struct usbip_usb_interface {
 	uint8_t bInterfaceClass;
 	uint8_t bInterfaceSubClass;
diff --git a/tools/usb/usbip/src/usbipd.c b/tools/usb/usbip/src/usbipd.c
index 48398a7..4826d13 100644
--- a/tools/usb/usbip/src/usbipd.c
+++ b/tools/usb/usbip/src/usbipd.c
@@ -532,8 +532,7 @@ static int do_standalone_mode(int daemonize, int ipv4, int ipv6)
 		usbip_driver_close(driver);
 		return -1;
 	}
-	nsockfd = listen_all_addrinfo(ai_head, sockfdlist,
-		sizeof(sockfdlist) / sizeof(*sockfdlist));
+	nsockfd = listen_all_addrinfo(ai_head, sockfdlist, ARRAY_SIZE(sockfdlist));
 	freeaddrinfo(ai_head);
 	if (nsockfd <= 0) {
 		err("failed to open a listening socket");
-- 
1.8.3.1

