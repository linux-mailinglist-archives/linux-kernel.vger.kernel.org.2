Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F0941342A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbhIUNc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:32:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233231AbhIUNcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:32:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFD6B6109E;
        Tue, 21 Sep 2021 13:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632231085;
        bh=TUpkICjorOrJWgOQ0TRLVjF3PxXz2EgDQ3fqCrInApo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lYchrwkOpmtTYMgFhFj9zfdJBaz1q0Z9oxMPR70PGI+O7oMDJ0zK3Ec0asDKYhqe2
         C2/3IIik8dlSIPjrwiDyDEhs5K3AsJFlLUX5HGkrUY1GGIYOGKFtGLv4XJ70cqNSYN
         wjxktqFNc1NM4U/X3AgFXWizrzjQoRcSp0rJhOee4N5p1dKWKvlErr7+XXTv0xXMyC
         Qgoy/ctWGL0PrIRUstq8IalBxwguI2sXQGnu8w/+ekWuv+NEkv14Z30HQ+ZPJI3o3I
         2vk0Tshh46AcsPcF1zpNOzVeMdwA1NzgL03uHTbIUQuuSbbvcEnXOKOR7LXc9ttoEk
         asIaKQXMyUUZA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mSfrp-0003bN-A4; Tue, 21 Sep 2021 15:31:25 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Himadri Pandya <himadrispandya@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] USB: serial: kl5kusb105: clean up line-status handling
Date:   Tue, 21 Sep 2021 15:30:07 +0200
Message-Id: <20210921133009.13739-2-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210921133009.13739-1-johan@kernel.org>
References: <20210921133009.13739-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the line-status handling by dropping redundant initialisations
and returning early on errors.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/kl5kusb105.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/serial/kl5kusb105.c b/drivers/usb/serial/kl5kusb105.c
index 72d3920c9c48..7681671ddb79 100644
--- a/drivers/usb/serial/kl5kusb105.c
+++ b/drivers/usb/serial/kl5kusb105.c
@@ -172,8 +172,6 @@ static int klsi_105_get_line_state(struct usb_serial_port *port,
 	u8 status_buf[KLSI_STATUSBUF_LEN];
 	__u16 status;
 
-	status_buf[0] = 0xff;
-	status_buf[1] = 0xff;
 	rc = usb_control_msg_recv(port->serial->dev, 0,
 				  KL5KUSB105A_SIO_POLL,
 				  USB_TYPE_VENDOR | USB_DIR_IN,
@@ -184,16 +182,17 @@ static int klsi_105_get_line_state(struct usb_serial_port *port,
 				  GFP_KERNEL);
 	if (rc) {
 		dev_err(&port->dev, "reading line status failed: %d\n", rc);
-	} else {
-		status = get_unaligned_le16(status_buf);
+		return rc;
+	}
 
-		dev_dbg(&port->dev, "read status %02x %02x\n",
-			status_buf[0], status_buf[1]);
+	status = get_unaligned_le16(status_buf);
 
-		*line_state_p = klsi_105_status2linestate(status);
-	}
+	dev_dbg(&port->dev, "read status %02x %02x\n",
+		status_buf[0], status_buf[1]);
 
-	return rc;
+	*line_state_p = klsi_105_status2linestate(status);
+
+	return 0;
 }
 
 
-- 
2.32.0

