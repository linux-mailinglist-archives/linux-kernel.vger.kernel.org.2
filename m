Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BA5356A2E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351457AbhDGKqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:46:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351346AbhDGKp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:45:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B96DC613A3;
        Wed,  7 Apr 2021 10:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617792346;
        bh=C4a/i1CuhCQyJSi3pONPclFagfGlFG4SMsYuXPQzoCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rhQ9OHuNQN/hF7NHqI5mlQ/Axu9RK8jSBEEMnJw4WuGkxxD1a17xFieim1EmZ4dzW
         HJMqoTeQnaLcTf6gbsVOqnhAo1lNsMZ29/Xgzfvl8uaAnWiipBe1G7S3vuMGonph6c
         vNKjLVWeei4kA4DMp7AW+cuEmfSH1SYt+AlcB8+Sp220NjEmoCNh1UBcrdICqgfpB6
         7enZJBd/JZ7NUkeUFvw921MYefT0cjzBOXUO5qE9L/iilLtTsJlf1htlxNyPfeioTC
         ydeouX2cSS6gE9ZvwNpScUwAOlq9b24Ft48ctnNn+jPPHyBC/BPi0IT37f8pOoryCE
         SNc59zLTo7Uog==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5gp-0000It-K9; Wed, 07 Apr 2021 12:45:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] USB: serial: ti_usb_3410_5052: switch to 30-second closing wait
Date:   Wed,  7 Apr 2021 12:45:29 +0200
Message-Id: <20210407104529.1110-5-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210407104529.1110-1-johan@kernel.org>
References: <20210407104529.1110-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using the system-wide default 30-second closing-wait timeout
instead of the driver specific 40-second timeout.

The timeout can be changed per port using TIOCSSERIAL (setserial) if
needed.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ti_usb_3410_5052.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_usb_3410_5052.c
index 35cc1be738ef..03839289d6c0 100644
--- a/drivers/usb/serial/ti_usb_3410_5052.c
+++ b/drivers/usb/serial/ti_usb_3410_5052.c
@@ -270,8 +270,6 @@ struct ti_firmware_header {
 
 #define TI_TRANSFER_TIMEOUT	2
 
-#define TI_DEFAULT_CLOSING_WAIT	4000		/* in .01 secs */
-
 /* read urb states */
 #define TI_READ_URB_RUNNING	0
 #define TI_READ_URB_STOPPING	1
@@ -602,7 +600,6 @@ static int ti_port_probe(struct usb_serial_port *port)
 		tport->tp_uart_base_addr = TI_UART1_BASE_ADDR;
 	else
 		tport->tp_uart_base_addr = TI_UART2_BASE_ADDR;
-	port->port.closing_wait = msecs_to_jiffies(10 * TI_DEFAULT_CLOSING_WAIT);
 	tport->tp_port = port;
 	tport->tp_tdev = usb_get_serial_data(port->serial);
 
-- 
2.26.3

