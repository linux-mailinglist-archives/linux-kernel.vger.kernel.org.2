Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC1934BA32
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 00:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhC0X2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 19:28:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48440 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhC0X1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 19:27:46 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lQILI-0006kl-8g; Sat, 27 Mar 2021 23:27:44 +0000
From:   Colin King <colin.king@canonical.com>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: serial: iuu_phoenix: remove redundant variable 'error'
Date:   Sat, 27 Mar 2021 23:27:44 +0000
Message-Id: <20210327232744.26237-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable error is initialized to 0 and is set to 1 this
value is never read as it is on an immediate return path. The
only read of error is to check it is 0 and this check is always
true at that point of the code. The variable is redundant and
can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/serial/iuu_phoenix.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/serial/iuu_phoenix.c b/drivers/usb/serial/iuu_phoenix.c
index 093afd67a664..19753611e7b0 100644
--- a/drivers/usb/serial/iuu_phoenix.c
+++ b/drivers/usb/serial/iuu_phoenix.c
@@ -643,7 +643,6 @@ static void iuu_uart_read_callback(struct urb *urb)
 	struct iuu_private *priv = usb_get_serial_port_data(port);
 	unsigned long flags;
 	int status = urb->status;
-	int error = 0;
 	int len = 0;
 	unsigned char *data = urb->transfer_buffer;
 	priv->poll++;
@@ -660,12 +659,11 @@ static void iuu_uart_read_callback(struct urb *urb)
 	if (urb->actual_length > 1) {
 		dev_dbg(&port->dev, "%s - urb->actual_length = %i\n", __func__,
 		    urb->actual_length);
-		error = 1;
 		return;
 	}
 	/* if len > 0 call readbuf */
 
-	if (len > 0 && error == 0) {
+	if (len > 0) {
 		dev_dbg(&port->dev, "%s - call read buf - len to read is %i\n",
 			__func__, len);
 		status = iuu_read_buf(port, len);
-- 
2.30.2

