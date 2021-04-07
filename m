Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862E0356A00
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351352AbhDGKkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:40:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351092AbhDGKkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:40:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E5D4613E1;
        Wed,  7 Apr 2021 10:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791990;
        bh=J7A9LOi+J2merRNWLKmFzr4cbMWHH3iYqNceVJSnJbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cy3jl1yNwqSfbBcwnF2F6zTzde5lBZ+TFvnHo73GkTrPVwlqvJGVfmNZug0gDqROG
         cAhkH35c/6AzOMz0i8O4493vCDLrDho0gUS08Su3b2+JKrvaEyBMFKRJvJD5pA6irB
         AqD3v71C5KPoBmmhALTaFx2nvwssg9uYAlZBVSFul75T1eDwT4LUbtUeW5536e/QYr
         2QIpurNE6JhyrDkm7axabUx85qlPII99QTrjbnWSXXytJoMYr8+0uKVZzWS/T/5yKs
         JbgNHc8MNXdbaELGd2hU2zhN+QoOs/SOCxb/oYpFug036KZTtx/Rrni7xRC5VO6Xw2
         3xUqKFftWnT1A==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5b5-0000F9-Cr; Wed, 07 Apr 2021 12:39:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/24] USB: serial: ti_usb_3410_5052: fix TIOCGSERIAL implementation
Date:   Wed,  7 Apr 2021 12:39:14 +0200
Message-Id: <20210407103925.829-14-johan@kernel.org>
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

The xmit_fifo_size parameter could be used to set the hardware transmit
fifo size of a legacy UART when it could not be detected, but the
interface is limited to eight bits and should be left unset when not
used.

The close_delay and closing_wait parameters returned by TIOCGSERIAL are
specified in centiseconds. The driver does not yet support changing
close_delay, but let's report back the default value actually used (0.5
seconds).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ti_usb_3410_5052.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_usb_3410_5052.c
index 7252b0ce75a6..4b497c1e850b 100644
--- a/drivers/usb/serial/ti_usb_3410_5052.c
+++ b/drivers/usb/serial/ti_usb_3410_5052.c
@@ -1406,10 +1406,10 @@ static int ti_get_serial_info(struct tty_struct *tty,
 
 	ss->type = PORT_16550A;
 	ss->line = port->minor;
-	ss->port = port->port_number;
-	ss->xmit_fifo_size = kfifo_size(&port->write_fifo);
 	ss->baud_base = tport->tp_tdev->td_is_3410 ? 921600 : 460800;
+	ss->close_delay = 50;
 	ss->closing_wait = cwait;
+
 	return 0;
 }
 
-- 
2.26.3

