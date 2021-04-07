Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55523569E3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351200AbhDGKkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234506AbhDGKj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:39:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F282613A9;
        Wed,  7 Apr 2021 10:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791990;
        bh=jtUsuzlU0E4vfBqSt1CNWV6/2Th2tlLbmiKV+LWNhRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l4sb8gNFsAhnaUV+Aaca120tvHHCaofGjSvlzn/oZIxHlkPo/eBfBKqW1JO+538Pr
         iTr6ijmvjF8x4MvHqc22LKHdK6yaCRo2ziSYVVrmfMan9FovCP1GzI+76kvM3dvTVv
         Xj7OwsS7XbXBJl+Hy0YDVM0ryUUPxEIjxRHT3olE3WQmBwW8GGBZ9Yl0DTQnX7VCBk
         myWE+GtjkJDrjIfcetpjvybs/mjKH7AyM9ihuH33KovQdxyEpvCq+7mJrIw2C5u3cx
         SEwzwGMptwoxQVffJSkeBWGRT1LLXN27lTcpNyd6Zu9WzOG5nquFv6z/IAW2LFtwk7
         aRss/1F8gYfsg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5b4-0000Eb-Cf; Wed, 07 Apr 2021 12:39:42 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/24] USB: serial: f81232: fix TIOCGSERIAL implementation
Date:   Wed,  7 Apr 2021 12:39:03 +0200
Message-Id: <20210407103925.829-3-johan@kernel.org>
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

The port parameter is used to set the I/O port and does not make any
sense to use for USB serial devices.

The close_delay and closing_wait parameters returned by TIOCGSERIAL are
specified in centiseconds. The driver does not yet support changing
these, but let's report back the default values actually used (0.5 and
30 seconds, respectively).

Fixes: aac1fc386fa1 ("USB: serial: add Fintek F81232 usb to serial driver")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/f81232.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 6a8f39147d8e..af0fe2a82eb2 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -828,8 +828,10 @@ static int f81232_get_serial_info(struct tty_struct *tty,
 
 	ss->type = PORT_16550A;
 	ss->line = port->minor;
-	ss->port = port->port_number;
 	ss->baud_base = priv->baud_base;
+	ss->close_delay = 50;
+	ss->closing_wait = 3000;
+
 	return 0;
 }
 
-- 
2.26.3

