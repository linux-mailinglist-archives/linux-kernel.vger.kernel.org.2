Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D063AC370
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 08:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbhFRGSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 02:18:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59682 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbhFRGRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6F6E821B53;
        Fri, 18 Jun 2021 06:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IW0m4vxKEyvIv3zdEh/UnHi6Ya53RIfjQkPGMTKdkuE=;
        b=MSCadmFMaPY4cHFBSPtiQZJWrYEpjHaZFPUDg+bWWKCuVfaz6KVW6u1+ZXsU5T2YRY5SVJ
        6Hr3DIPtUzwrPDgak1F/VBc+hR+eMEG9rvRALYQ8YLyhKb5hQBqhnTAECUNZX6XbI0tzh1
        lio8rQtzHjvfF0pG9qOXrTsxUkerDOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996921;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IW0m4vxKEyvIv3zdEh/UnHi6Ya53RIfjQkPGMTKdkuE=;
        b=xjEcWJi3ADY7OrCF2NBB8r64Ab4svENOalTUQE59fupXJwkFVZ9flSZt39mPHKgnw9b87a
        F28oluefxClJj1DA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 42F61A3BBA;
        Fri, 18 Jun 2021 06:15:21 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 20/70] mxser: drop UART_MCR_AFE and UART_LSR_SPECIAL defines
Date:   Fri, 18 Jun 2021 08:14:26 +0200
Message-Id: <20210618061516.662-21-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* UART_MCR_AFE is a redefinition of serial_reg.h's one.
* UART_LSR_SPECIAL is a redefinition of serial_reg.h's
  UART_LSR_BRK_ERROR_BITS.

So remove both and replace the latter uses by already defined
UART_LSR_BRK_ERROR_BITS.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 53136a7d92b1..79d7cecb7765 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -180,9 +180,6 @@
 
 #define WAKEUP_CHARS		256
 
-#define UART_MCR_AFE		0x20
-#define UART_LSR_SPECIAL	0x1E
-
 #define PCI_DEVICE_ID_POS104UL	0x1044
 #define PCI_DEVICE_ID_CB108	0x1080
 #define PCI_DEVICE_ID_CP102UF	0x1023
@@ -2063,7 +2060,7 @@ static bool mxser_receive_chars_new(struct tty_struct *tty,
 
 	if (hwid == MOXA_OTHER_UART)
 		return false;
-	if (status & UART_LSR_SPECIAL)
+	if (status & UART_LSR_BRK_ERROR_BITS)
 		return false;
 	if (hwid == MOXA_MUST_MU860_HWID && (status & MOXA_MUST_LSR_RERR))
 		return false;
@@ -2108,7 +2105,7 @@ static u8 mxser_receive_chars_old(struct tty_struct *tty,
 				break;
 		} else {
 			char flag = 0;
-			if (status & UART_LSR_SPECIAL) {
+			if (status & UART_LSR_BRK_ERROR_BITS) {
 				if (status & UART_LSR_BI) {
 					flag = TTY_BREAK;
 					port->icount.brk++;
-- 
2.32.0

