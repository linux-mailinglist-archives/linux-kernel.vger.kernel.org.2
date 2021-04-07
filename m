Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4619C356876
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350371AbhDGJww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:52:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346429AbhDGJwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:52:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B06F7613B3;
        Wed,  7 Apr 2021 09:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617789147;
        bh=SRqq7OMycU3LZbxN0RrIQTSnklPCUMfYAGk8ECSLr+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QpZy7OMgVTImipxg+rsvfVLVhbgKXUAiJswbua89A68cjIrScXqkFlo+gEgysOECy
         NgtoN4rGadtWAvUBx0w3FUFdCAa4t7/6StxPne30PgNY9P+hddCSqNq/QXkQ7wTVpO
         9ouR3L2/BRb1qLiiVRi9WKS6KAbKZa77++WzkSpw1R43ZNeBuzArF5ciBByzLUGCGH
         RlBfsfXCp4gNgEQaSede3D1KZ8FuYJxORLQJy9/EXm9KrgfR8MWO1AVQBb3166RXOy
         DJBOrCo+F5HUzM+7gzRD2898GPgtYtznVgiBZK6pT9Mxf4dReiCzkx8KaT9mdkww95
         N7lmv5QcVN5kA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU4rE-0008Ik-D7; Wed, 07 Apr 2021 11:52:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 8/8] serial: core: return early on unsupported ioctls
Date:   Wed,  7 Apr 2021 11:52:08 +0200
Message-Id: <20210407095208.31838-9-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210407095208.31838-1-johan@kernel.org>
References: <20210407095208.31838-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers can return -ENOIOCTLCMD when an ioctl is not recognised to tell
the upper layers to continue looking for a handler.

This is not the case for the RS485 and ISO7816 ioctls whose handlers
should return -ENOTTY directly in case a serial driver does not
implement the corresponding methods.

Fixes: a5f276f10ff7 ("serial_core: Handle TIOC[GS]RS485 ioctls.")
Fixes: ad8c0eaa0a41 ("tty/serial_core: add ISO7816 infrastructure")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/serial_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 59336943a86f..87f7127b57e6 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1303,7 +1303,7 @@ static int uart_set_rs485_config(struct uart_port *port,
 	unsigned long flags;
 
 	if (!port->rs485_config)
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 
 	if (copy_from_user(&rs485, rs485_user, sizeof(*rs485_user)))
 		return -EFAULT;
@@ -1327,7 +1327,7 @@ static int uart_get_iso7816_config(struct uart_port *port,
 	struct serial_iso7816 aux;
 
 	if (!port->iso7816_config)
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 
 	spin_lock_irqsave(&port->lock, flags);
 	aux = port->iso7816;
@@ -1347,7 +1347,7 @@ static int uart_set_iso7816_config(struct uart_port *port,
 	unsigned long flags;
 
 	if (!port->iso7816_config)
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 
 	if (copy_from_user(&iso7816, iso7816_user, sizeof(*iso7816_user)))
 		return -EFAULT;
-- 
2.26.3

