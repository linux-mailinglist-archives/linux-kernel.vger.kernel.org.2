Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D683B0DBE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 21:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhFVToZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 15:44:25 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:42080 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbhFVToN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 15:44:13 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d82 with ME
        id LKdq2500821Fzsu03Kdq5B; Tue, 22 Jun 2021 21:37:52 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 22 Jun 2021 21:37:52 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     pawell@cadence.com, gregkh@linuxfoundation.org, peter.chen@nxp.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] usb: cdnsp: Fix the IMAN_IE_SET and IMAN_IE_CLEAR macro.
Date:   Tue, 22 Jun 2021 21:37:48 +0200
Message-Id: <d12bfcc9cbffb89e27b120668821b3c4f09b6755.1624390584.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMAN_IE is BIT(1), so these macro are respectively equivalent to BIT(1)
and 0, whatever the value of 'p'.

The purpose was to set and reset a single bit in 'p'.
Fix these macros to do that correctly.

Fixes: e93e58d27402 ("usb: cdnsp: Device side header file for CDNSP driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is speculative. It is not tested.
Please, review with care.

Actually, the usage of these macros is:
   readl(somewhere)
   set or reset the IMAN_IE bit
   write(somewhere)
So it is likely that we want to preserve the other bits read. Otherwise,
the code could be much simpler.
---
 drivers/usb/cdns3/cdnsp-gadget.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gadget.h
index 783ca8ffde00..f740fa6089d8 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.h
+++ b/drivers/usb/cdns3/cdnsp-gadget.h
@@ -383,8 +383,8 @@ struct cdnsp_intr_reg {
 #define IMAN_IE			BIT(1)
 #define IMAN_IP			BIT(0)
 /* bits 2:31 need to be preserved */
-#define IMAN_IE_SET(p)		(((p) & IMAN_IE) | 0x2)
-#define IMAN_IE_CLEAR(p)	(((p) & IMAN_IE) & ~(0x2))
+#define IMAN_IE_SET(p)		((p) | IMAN_IE)
+#define IMAN_IE_CLEAR(p)	((p) & ~IMAN_IE)
 
 /* IMOD - Interrupter Moderation Register - irq_control bitmasks. */
 /*
-- 
2.30.2

