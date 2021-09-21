Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5858B41342D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbhIUNdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:33:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233193AbhIUNcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:32:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E55BA6115A;
        Tue, 21 Sep 2021 13:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632231085;
        bh=prOPIYWELr6nmKB42YtpCDelWSZ0w61BxUEMc2pOTJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vnyb4xBYTqQ2IrnY850MvsQxkxndpcVGwEqfoidzrLyi6bfA8NQXbhsQPs67lNGPT
         //hxuyYbViPZEoVExLby63fq3qtiOsAAiTCMMfr4HOD4dlZzwx/IzIhB+fPfc9qQap
         S7QmrfeZyUPDAjThLMkhd50n8IWkkmsLfQY7Ste04FvFE7kykkmQIo8TxPC6NYiqFo
         8OBdBshBxU2fG4hDjAk2KV3lxpEQVppA/W3Qz00xea40DyuEl8XS18cYmoiTLW46VD
         J0L7zpiWE4/6POcIi9XX2CDiUv7kFKebCyD31Zk6qfvwdP2TjwiB93bivITU86r/8V
         H5bHRwT27xKDw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mSfrp-0003bP-D3; Tue, 21 Sep 2021 15:31:25 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Himadri Pandya <himadrispandya@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] USB: serial: kl5kusb105: simplify line-status handling
Date:   Tue, 21 Sep 2021 15:30:08 +0200
Message-Id: <20210921133009.13739-3-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210921133009.13739-1-johan@kernel.org>
References: <20210921133009.13739-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver is using usb_control_msg_recv(), the line status
handling can be simplified further by reading directly into the status
variable and doing the endian conversion in place.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/kl5kusb105.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/serial/kl5kusb105.c b/drivers/usb/serial/kl5kusb105.c
index 7681671ddb79..99dffbdd3142 100644
--- a/drivers/usb/serial/kl5kusb105.c
+++ b/drivers/usb/serial/kl5kusb105.c
@@ -163,21 +163,18 @@ static unsigned long klsi_105_status2linestate(const __u16 status)
  * Read line control via vendor command and return result through
  * *line_state_p
  */
-/* It seems that the status buffer has always only 2 bytes length */
-#define KLSI_STATUSBUF_LEN	2
 static int klsi_105_get_line_state(struct usb_serial_port *port,
 				   unsigned long *line_state_p)
 {
+	u16 status;
 	int rc;
-	u8 status_buf[KLSI_STATUSBUF_LEN];
-	__u16 status;
 
 	rc = usb_control_msg_recv(port->serial->dev, 0,
 				  KL5KUSB105A_SIO_POLL,
 				  USB_TYPE_VENDOR | USB_DIR_IN,
 				  0, /* value */
 				  0, /* index */
-				  status_buf, KLSI_STATUSBUF_LEN,
+				  &status, sizeof(status),
 				  10000,
 				  GFP_KERNEL);
 	if (rc) {
@@ -185,10 +182,9 @@ static int klsi_105_get_line_state(struct usb_serial_port *port,
 		return rc;
 	}
 
-	status = get_unaligned_le16(status_buf);
+	le16_to_cpus(&status);
 
-	dev_dbg(&port->dev, "read status %02x %02x\n",
-		status_buf[0], status_buf[1]);
+	dev_dbg(&port->dev, "read status %04x\n", status);
 
 	*line_state_p = klsi_105_status2linestate(status);
 
-- 
2.32.0

