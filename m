Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCA63569FE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351319AbhDGKkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:40:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234888AbhDGKkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:40:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2785F613C6;
        Wed,  7 Apr 2021 10:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791990;
        bh=LIcRc7NYbE0x58pDWh179Yiiu/bA6nM3mAum4rSZ6K8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NScENpAnjzvxauWoRJWyrjJrKvw+wYzXWqDX3f5vtQq7qd65bLoRtY27PEmgyAX1+
         kJWSr0WKJzMc8Hpe7zqRxdsKiekwqQIYihWSuIeUm3LiXABFjFcEMHufg3ANwuxqc+
         fTJhCAZJ4Y28D9Zm45aaTnm82/7zcnK0WQYOBa6hhboVXUWCfjmKVm2EAyrE+4kqGO
         gz3HYdzOCuiel2LUGdefsYX4tQTTV66Qzs+y3BFHOnx4MYQFGBN4hFd1WzlKeKsV0R
         5EPMQJTZV4HtVWoiYAkY+wrxaeo/tR9A5YWmjmNA3Qgo/rI8OKeY5avFEfqJoNw8NB
         MPe2wjoMTKHhw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5b5-0000Ex-0b; Wed, 07 Apr 2021 12:39:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/24] USB: serial: opticon: fix TIOCGSERIAL implementation
Date:   Wed,  7 Apr 2021 12:39:10 +0200
Message-Id: <20210407103925.829-10-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210407103925.829-1-johan@kernel.org>
References: <20210407103925.829-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TIOCSSERIAL is a horrid, underspecified, legacy interface which for most
serial devices is only useful for setting the close_delay and
closing_wait parameters.

The xmit_fifo_size parameter could be used to set the hardware transmit
fifo size of a legacy UART when it could not be detected, but the
interface is limited to eight bits and should be left unset when not
used.

Similarly, baud_base could be used to set the UART base clock when it
could not be detected but might as well be left unset when it is not
known.

The close_delay and closing_wait parameters returned by TIOCGSERIAL are
specified in centiseconds (not jiffies). The driver does not yet support
changing these, but let's report back the default values actually used
(0.5 and 30 seconds, respectively).

Fixes: faac64ad9c7b ("USB: serial: opticon: add serial line ioctls")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/opticon.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/serial/opticon.c b/drivers/usb/serial/opticon.c
index eecb72aef83e..1c7e5dc2c272 100644
--- a/drivers/usb/serial/opticon.c
+++ b/drivers/usb/serial/opticon.c
@@ -360,12 +360,9 @@ static int get_serial_info(struct tty_struct *tty,
 	/* fake emulate a 16550 uart to make userspace code happy */
 	ss->type		= PORT_16550A;
 	ss->line		= port->minor;
-	ss->port		= 0;
-	ss->irq			= 0;
-	ss->xmit_fifo_size	= 1024;
-	ss->baud_base		= 9600;
-	ss->close_delay		= 5*HZ;
-	ss->closing_wait	= 30*HZ;
+	ss->close_delay		= 50;
+	ss->closing_wait	= 3000;
+
 	return 0;
 }
 
-- 
2.26.3

