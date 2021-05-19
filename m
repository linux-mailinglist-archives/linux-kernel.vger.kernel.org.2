Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB67388A72
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345174AbhESJWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:22:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344923AbhESJVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:21:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 302DC60FE4;
        Wed, 19 May 2021 09:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621416029;
        bh=/hEn/ktVhek3gXcDSTDRdiw8v0mvpRq4JJ0XqdB9C7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IyZ/j7Uus5AVy/kFKS7h+/+STy0D7dFxtDtx0r+oyKxbiNkFHC02Vf4YFDqlj3pKf
         ci9+Hsf+Cp31z8ysSsh1nVcrskKvGx0VTGKKGsrVriYBLQZi7wY/zPMnWlCVvdFy/+
         UCdAxNVLqy95Y5urMUDLp6L/vsQTxLvMDuBUdRqVzqhqJ9/h497cgaNt6r+S1UXMfE
         jWOP9BE5vHvyafzbWfTQqj6OnyEoPEpzZfAoqTcFgn2KX/JPEJdEqMqa7V7DFHN4MU
         baWMFBJrd2GBOSAXTHyYqgYJoJdMIIqAlGRQ5y7h7NEZFPr0jSuiSAkpOFsemFdLEu
         B796JLELGzZRg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ljINQ-0002Yj-Sy; Wed, 19 May 2021 11:20:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] USB: serial: mos7840: drop buffer-callback return-value comments
Date:   Wed, 19 May 2021 11:20:05 +0200
Message-Id: <20210519092006.9775-6-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210519092006.9775-1-johan@kernel.org>
References: <20210519092006.9775-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver write_room and chars_in_buffer callbacks used to incorrectly
return a negative errno in case they were called with a NULL port
driver-data pointer or if some other always-true sanity checks failed.

The bogus sanity checks were later removed by commit ce039bd4b21f ("USB:
serial: mos7840: drop paranoid port checks") and 7b2faede671a ("USB:
serial: mos7840: drop port driver data accessors") but the
function-header comments were never updated to match.

Drop the outdated return-value comments.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/mos7840.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index b22ccbd98998..d7fe33ca73e4 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -730,9 +730,6 @@ static int mos7840_open(struct tty_struct *tty, struct usb_serial_port *port)
  *	this function is called by the tty driver when it wants to know how many
  *	bytes of data we currently have outstanding in the port (data that has
  *	been written, but hasn't made it out the port yet)
- *	If successful, we return the number of bytes left to be written in the
- *	system,
- *	Otherwise we return zero.
  *****************************************************************************/
 
 static unsigned int mos7840_chars_in_buffer(struct tty_struct *tty)
@@ -814,8 +811,6 @@ static void mos7840_break(struct tty_struct *tty, int break_state)
  * mos7840_write_room
  *	this function is called by the tty driver when it wants to know how many
  *	bytes of data we can accept for a specific port.
- *	If successful, we return the amount of room that we have for this port
- *	Otherwise we return a negative error number.
  *****************************************************************************/
 
 static unsigned int mos7840_write_room(struct tty_struct *tty)
-- 
2.26.3

