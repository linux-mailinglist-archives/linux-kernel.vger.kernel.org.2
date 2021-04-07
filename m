Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95711356A27
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351377AbhDGKqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:46:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351331AbhDGKp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:45:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB8C061242;
        Wed,  7 Apr 2021 10:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617792346;
        bh=5RpLl+K2zJzuTo57KUNBM+mnePq192jK+8wSyGK2u6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GZiVEOuxtUBWHEYZckzaCPEPhHFuYWnYOW4TGgT3OKXC/H154AQqy/e9Ib6vAOyTp
         0qW+SOJIMkjEu5HZE+hZxP2/Z0DiiWxdbBazw9Fjg/jBsyjJ7JHrcIcjMoajW8Y8em
         +eeZaTtRA+QN65qknjGyK403PYIMKXlboYzhmqRf2wTlXjlTmW50/iXxW+nL0lCPVO
         9iO/vCW/pw4uZufZeJKNbSUDy3GYKPUcQSgFfnoz3tA8OPj6jlSGJjKraBDO/uKem2
         ShAtxX3BMFMJxq/ADI9+qMWMH2rPrSgDeicPHiihns1pBkOwDchYed1Z0gh6mQPEG2
         b9BVF6TKcNmXw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5gp-0000In-FW; Wed, 07 Apr 2021 12:45:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] USB: serial: io_ti: switch to 30-second closing wait
Date:   Wed,  7 Apr 2021 12:45:27 +0200
Message-Id: <20210407104529.1110-3-johan@kernel.org>
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
 drivers/usb/serial/io_ti.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
index 6eff0e5a7545..75325c2b295e 100644
--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -60,8 +60,6 @@
 #define EDGE_READ_URB_STOPPING	1
 #define EDGE_READ_URB_STOPPED	2
 
-#define EDGE_CLOSING_WAIT	4000	/* in .01 sec */
-
 
 /* Product information read from the Edgeport */
 struct product_info {
@@ -2592,7 +2590,6 @@ static int edge_port_probe(struct usb_serial_port *port)
 	if (ret)
 		goto err;
 
-	port->port.closing_wait = msecs_to_jiffies(EDGE_CLOSING_WAIT * 10);
 	port->port.drain_delay = 1;
 
 	return 0;
-- 
2.26.3

