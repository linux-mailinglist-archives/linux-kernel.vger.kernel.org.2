Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214643AC3B0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 08:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbhFRGVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 02:21:16 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59712 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbhFRGR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:58 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5AEB721B69;
        Fri, 18 Jun 2021 06:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CK9asDX+0HN+MlTN5oiFj4ZLf6QXVNvLkxkc/oS6vnE=;
        b=fTBrdwVKJqnnsxn9np4b6XWwjX582JTHvkRxWZBDQOTmWScCXarOp1AZhmTx0rU0AqPCD8
        fEBx0zOXCa/gJQKIV2xOT+Dzgstpd21tLrNTPWLjFX5cI17sEI/Dc+Aq7nJnhSZzzBpGo8
        f0RROkapSjrSSMIBheua9fMJOqU6I2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996930;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CK9asDX+0HN+MlTN5oiFj4ZLf6QXVNvLkxkc/oS6vnE=;
        b=DQnBimBg4nvgrOXRiAzfDD++xUOUweHVw2rFHeR824vXbPkDCyLHLY42PH/ry/N6jAjZHd
        20R4pDPoiL7FVEBA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 33D9AA3B9F;
        Fri, 18 Jun 2021 06:15:30 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 62/70] mxser: fix typos around enhanced mode
Date:   Fri, 18 Jun 2021 08:15:08 +0200
Message-Id: <20210618061516.662-63-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling of "enhanced" in macros and comments around them.

While "enchance" comes from the original Moxa's driver, I don't think it
was meant to be that. From the context, they obviously mean "enhanced".

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index c8ba062d8824..54b9a9c7c9e9 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -64,23 +64,23 @@
 /*
  * Follow just what Moxa Must chip defines.
  *
- * When LCR register (offset 0x03) writes the following value, the Must chip
- * will enter enchance mode. And write value on EFR (offset 0x02) bit 6,7 to
+ * When LCR register (offset 0x03) is written the following value, the Must chip
+ * will enter enhanced mode. And a write to EFR (offset 0x02) bit 6,7 will
  * change bank.
  */
-#define MOXA_MUST_ENTER_ENCHANCE	0xBF
+#define MOXA_MUST_ENTER_ENHANCED	0xBF
 
-/* when enhance mode enabled, access on general bank register */
+/* when enhanced mode is enabled, access to general bank register */
 #define MOXA_MUST_GDL_REGISTER		0x07
 #define MOXA_MUST_GDL_MASK		0x7F
 #define MOXA_MUST_GDL_HAS_BAD_DATA	0x80
 
 #define MOXA_MUST_LSR_RERR		0x80	/* error in receive FIFO */
-/* enchance register bank select and enchance mode setting register */
-/* when LCR register equals to 0xBF */
+/* enhanced register bank select and enhanced mode setting register */
+/* This works only when LCR register equals to 0xBF */
 #define MOXA_MUST_EFR_REGISTER		0x02
-#define MOXA_MUST_EFR_EFRB_ENABLE	0x10 /* enchance mode enable */
-/* enchance register bank set 0, 1, 2 */
+#define MOXA_MUST_EFR_EFRB_ENABLE	0x10 /* enhanced mode enable */
+/* enhanced register bank set 0, 1, 2 */
 #define MOXA_MUST_EFR_BANK0		0x00
 #define MOXA_MUST_EFR_BANK1		0x40
 #define MOXA_MUST_EFR_BANK2		0x80
@@ -287,7 +287,7 @@ static u8 __mxser_must_set_EFR(unsigned long baseio, u8 clear, u8 set,
 	u8 oldlcr, efr;
 
 	oldlcr = inb(baseio + UART_LCR);
-	outb(MOXA_MUST_ENTER_ENCHANCE, baseio + UART_LCR);
+	outb(MOXA_MUST_ENTER_ENHANCED, baseio + UART_LCR);
 
 	efr = inb(baseio + MOXA_MUST_EFR_REGISTER);
 	efr &= ~clear;
-- 
2.32.0

