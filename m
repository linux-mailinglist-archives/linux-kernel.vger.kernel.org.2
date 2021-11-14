Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E7644F6F6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 06:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhKNFyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 00:54:46 -0500
Received: from smtpbg587.qq.com ([113.96.223.105]:39801 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhKNFyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 00:54:45 -0500
X-QQ-mid: bizesmtp48t1636869103tfeafvp8
Received: from localhost.localdomain (unknown [125.69.41.88])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 14 Nov 2021 13:51:41 +0800 (CST)
X-QQ-SSF: 01000000002000C0F000B00A0000000
X-QQ-FEAT: CHH+BzdEyPgmXcQhOFaHEkHcUuoCOG3fUPdZjTINBOPLGnBqnEnP38fZWnmnJ
        6+Cg8ri5Ksv/QRhUaBSKyH4u84btvYIfrbjikP4bQP1KLQrfS0CmOAW9lj53AwY0spy+P0o
        KtYhWhnJSeDCZXJ1kVwjP8usAUXOmc0TFg2fMogwd7YTOWzV1RprODDEiiu2qC8n+46k0Qr
        3eYni4MQEZ8Ob4MOx2AFrTzhuxeR0CPKBSiPaG+Myd54ckiX+u4lzagkOBy6EaZxhiYwcFh
        tb7d7yZOfDKhCBeqh0l4T/MQZlJ084SYYPXnfUgTL775mpmrtETwJzd8Byyq6cMQGI5ncNj
        XAdjgaCLcnOymMIinM=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     pawell@cadence.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] usb: cdnsp: Remove unneeded semicolon after `}'
Date:   Sun, 14 Nov 2021 13:51:40 +0800
Message-Id: <20211114055140.213945-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The semicolon after `}' is unneeded. So, just remove it.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/usb/cdns3/cdnsp-gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index 27df0c697897..05439e61ffc9 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -81,7 +81,7 @@ int cdnsp_find_next_ext_cap(void __iomem *base, u32 start, int id)
 		offset = HCC_EXT_CAPS(val) << 2;
 		if (!offset)
 			return 0;
-	};
+	}
 
 	do {
 		val = readl(base + offset);
-- 
2.33.0

