Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15921356A2A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351426AbhDGKqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351337AbhDGKp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:45:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2DAD61359;
        Wed,  7 Apr 2021 10:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617792346;
        bh=tuhj7jh5AU83zBF8kyzmCMl/L2g7M5sJe4u25kmtwfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oc3+6DQV0+WNooqsfOO5Oof9wpsIZfryhnpcQAcvVpZGq/3yX0bHoQmzowSh18F7Q
         DbKU5TU54PdFVPRE14ZzekGlT+PWfiNQN3vy03vU1HZv5ez6KVZs8xcJiVQxHgxqUh
         IpWvWWb2EWjX7FgHUMU+WP/XtgheKXXy0f1S51NYF6ze+gY+b5kkuUkGqVUmBiavXa
         LsUsUvIO3DMDmQ0NWgJRGPzXU0BcLkFUnFoqnS/l7rk5yMXi1PD2DTiipgJdcvpRfU
         kgNbnHdThRj/VvwA5kOqLo1DNCngS/9Nnbd+99QqABt1eA+niC4xR8CZk6ShVH5iiT
         exFX2ggCRj6Fg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5gp-0000Ik-D9; Wed, 07 Apr 2021 12:45:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] USB: serial: io_ti: drop closing_wait module parameter
Date:   Wed,  7 Apr 2021 12:45:26 +0200
Message-Id: <20210407104529.1110-2-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210407104529.1110-1-johan@kernel.org>
References: <20210407104529.1110-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all USB serial drivers supports setting the closing_wait
parameter through TIOCSSERIAL (setserial) it's time to drop the
corresponding io_ti module parameter.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/io_ti.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
index f548cdbf0a51..6eff0e5a7545 100644
--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -211,7 +211,6 @@ static const struct usb_device_id id_table_combined[] = {
 
 MODULE_DEVICE_TABLE(usb, id_table_combined);
 
-static int closing_wait = EDGE_CLOSING_WAIT;
 static bool ignore_cpu_rev;
 static int default_uart_mode;		/* RS232 */
 
@@ -2593,7 +2592,7 @@ static int edge_port_probe(struct usb_serial_port *port)
 	if (ret)
 		goto err;
 
-	port->port.closing_wait = msecs_to_jiffies(closing_wait * 10);
+	port->port.closing_wait = msecs_to_jiffies(EDGE_CLOSING_WAIT * 10);
 	port->port.drain_delay = 1;
 
 	return 0;
@@ -2759,9 +2758,6 @@ MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 MODULE_FIRMWARE("edgeport/down3.bin");
 
-module_param(closing_wait, int, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(closing_wait, "Maximum wait for data to drain, in .01 secs");
-
 module_param(ignore_cpu_rev, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(ignore_cpu_rev,
 			"Ignore the cpu revision when connecting to a device");
-- 
2.26.3

