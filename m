Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5BE356975
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350979AbhDGKYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:24:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234316AbhDGKX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:23:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BA3C6139C;
        Wed,  7 Apr 2021 10:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791030;
        bh=CeKm6ipfL9Qlfx+2An5KVum6+4Qfn5PtcZDf+8XmBU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NCpaqXin5Y4HXiCRsFp8/Te34bqn4cOyL7sioClnsfuVCMABQATTWQ8ZK2EXKIVmC
         vHPX/gxY/1KrJYdmgNuL10cq/PqyyMxGGX3RgLHSGPi48md7NHGlr0kjTzBHZNmI4P
         uUfVsLA5Tl/MJ6cR9izOOKkAVpz0Xw3/SDQGKvtLkyVvzE9R9jZmMvsQpjEnbz9Oyo
         Mb0YoNFt0VhI+gBpSj1x0YqE6hJhCyd5JXQlTzYnfKiydnRB9Igu9nks+N5GzxVWkb
         OFmdYFe26eTlg8njBFsx4w7wo31T+esVeX6r2WCDxQNjpm0ApMGjREC4YubTXMSrFt
         AAyo83pCnbQXw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5La-0008R9-Uu; Wed, 07 Apr 2021 12:23:42 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-staging@lists.linux.dev,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 04/16] staging: fwserial: fix TIOCGSERIAL implementation
Date:   Wed,  7 Apr 2021 12:23:22 +0200
Message-Id: <20210407102334.32361-5-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210407102334.32361-1-johan@kernel.org>
References: <20210407102334.32361-1-johan@kernel.org>
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

Fix the fwserial implementation by dropping its custom interpretation of
the unused xmit_fifo_size field, which was overflowed with the driver
FIFO size. Also leave the type and flags fields unset as these cannot be
changed.

The close_delay and closing_wait parameters returned by TIOCGSERIAL are
specified in centiseconds. The driver does not yet support changing
closing_wait, but let's report back the default value actually used (30
seconds).

Fixes: 7355ba3445f2 ("staging: fwserial: Add TTY-over-Firewire serial driver")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/staging/fwserial/fwserial.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index 2888b80a2c1a..0f4655d7d520 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -1218,13 +1218,12 @@ static int get_serial_info(struct tty_struct *tty,
 	struct fwtty_port *port = tty->driver_data;
 
 	mutex_lock(&port->port.mutex);
-	ss->type =  PORT_UNKNOWN;
-	ss->line =  port->port.tty->index;
-	ss->flags = port->port.flags;
-	ss->xmit_fifo_size = FWTTY_PORT_TXFIFO_LEN;
+	ss->line = port->index;
 	ss->baud_base = 400000000;
 	ss->close_delay = jiffies_to_msecs(port->port.close_delay) / 10;
+	ss->closing_wait = 3000;
 	mutex_unlock(&port->port.mutex);
+
 	return 0;
 }
 
-- 
2.26.3

