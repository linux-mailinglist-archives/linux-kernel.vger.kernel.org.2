Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1473AC355
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 08:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhFRGSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 02:18:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58960 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbhFRGR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E0CAC21B50;
        Fri, 18 Jun 2021 06:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kvBWf2dKB23474z2mNWAGt+hhqaxZDHEgEl6Syx745Y=;
        b=MqZGJm3XcjT6owPhcwcO67vnTrkpgX0qgx8x0aoPh1Op1ytv3wU2A001SGWZI/+14Mfyyo
        VsA5mxwavHNVIDttbsG87G85v4w7yWqQS/KZvj0zvzO8o1qhstfcj0XyOG+7E6k96VAH/l
        O11ZaXrQ0NOxrNaS6/YzBl+jB7DYxMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996918;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kvBWf2dKB23474z2mNWAGt+hhqaxZDHEgEl6Syx745Y=;
        b=J7wLScobwEDB/+fWpyVtmWabwoKiC87bWYrT9dNtQD0yrHJVWpfFstPVWqCK+Px6c3dWVA
        IlI9oquJ2iY2m+Cg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B8699A3BC5;
        Fri, 18 Jun 2021 06:15:18 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 08/70] mxser: introduce enum mxser_must_hwid
Date:   Fri, 18 Jun 2021 08:14:14 +0200
Message-Id: <20210618061516.662-9-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provided the MUST HW ID is an enumeration, define one (enum
mxser_must_hwid) and use it in the code.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 1865f965334a..558bd4140ee1 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -178,11 +178,6 @@
 #define MXSER_PORTS		(MXSER_BOARDS * MXSER_PORTS_PER_BOARD)
 #define MXSER_ISR_PASS_LIMIT	100
 
-/*CheckIsMoxaMust return value*/
-#define MOXA_OTHER_UART		0x00
-#define MOXA_MUST_MU150_HWID	0x01
-#define MOXA_MUST_MU860_HWID	0x02
-
 #define WAKEUP_CHARS		256
 
 #define UART_MCR_AFE		0x20
@@ -199,6 +194,12 @@
 
 #define MXSER_HIGHBAUD	1
 
+enum mxser_must_hwid {
+	MOXA_OTHER_UART		= 0x00,
+	MOXA_MUST_MU150_HWID	= 0x01,
+	MOXA_MUST_MU860_HWID	= 0x02,
+};
+
 static const struct {
 	u8 type;
 	u8 fifo_size;
@@ -370,7 +371,7 @@ struct mxser_board {
 	unsigned long vector;
 	unsigned long vector_mask;
 
-	int must_hwid;
+	enum mxser_must_hwid must_hwid;
 	int uart_type;
 
 	struct mxser_port ports[MXSER_PORTS_PER_BOARD];
@@ -583,7 +584,7 @@ static void mxser_disable_must_rx_software_flow_control(unsigned long baseio)
 	outb(oldlcr, baseio + UART_LCR);
 }
 
-static int mxser_must_get_hwid(unsigned long io)
+static enum mxser_must_hwid mxser_must_get_hwid(unsigned long io)
 {
 	u8 oldmcr, hwid;
 	int i;
@@ -599,10 +600,10 @@ static int mxser_must_get_hwid(unsigned long io)
 	}
 
 	mxser_get_must_hardware_id(io, &hwid);
-	for (i = 1; i < UART_INFO_NUM; i++) { /* 0 = OTHER_UART */
+	for (i = 1; i < UART_INFO_NUM; i++) /* 0 = OTHER_UART */
 		if (hwid == Gpci_uart_info[i].type)
-			return (int)hwid;
-	}
+			return hwid;
+
 	return MOXA_OTHER_UART;
 }
 
-- 
2.32.0

