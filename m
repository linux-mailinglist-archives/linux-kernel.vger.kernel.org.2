Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025EE3569AB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239936AbhDGK3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:29:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233482AbhDGK3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:29:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 465FC613A0;
        Wed,  7 Apr 2021 10:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791342;
        bh=tIq/LxC9O1wQTOdggYIlPgHa1zajHf0cAFFCHEXAskg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VmM87a0Lxl81462c00/4Qzg62Cq993slxV0Fl67/x1MLOxVD+czwSx721Me9o2l0k
         YXkdOtlQ10A0Dugc5bLYW0WGm3igTwRZbFpSjYi/9vHAp596l2IUZOp4y6fgjpfuoO
         Tnhj+JaHB7nAqgDZToCnMlBh7ABaRzQ3ICuU2cgWnCFSzL7mggz8snkVAQBHqJelAZ
         Uw8/WjkVqnFBB5Nof2bChDl6QuRWfOl8gc7azgtcoxjYssrSJSqwGap6j7cEoDp/v5
         xVL6oAGcWTx3/9PrkY2w3XmncCVOW6RAiVlTb7fvjvdW4ufrIaCLu7D3Bndo+O+OpB
         QtDmYmEqcJriQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5Qc-00004x-Rn; Wed, 07 Apr 2021 12:28:54 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/3] USB: cdc-acm: fix TIOCGSERIAL implementation
Date:   Wed,  7 Apr 2021 12:28:45 +0200
Message-Id: <20210407102845.32720-4-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210407102845.32720-1-johan@kernel.org>
References: <20210407102845.32720-1-johan@kernel.org>
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
interface is limited to eight bits and should be left unset when it is
not used.

Similarly, baud_base could be used to set the uart base clock when it
could not be detected, but might as well be left unset when it is not
known.

Fix the cdc-acm TIOCGSERIAL implementation by dropping its custom
interpretation of the unused xmit_fifo_size and baud_base fields, which
overflowed the former with the URB buffer size and set the latter to the
current line speed. Also return the port line number, which is the only
other value used besides the close parameters.

Fixes: 18c75720e667 ("USB: allow users to run setserial with cdc-acm")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/class/cdc-acm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 43e31dad4831..b74713518b3a 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -929,8 +929,7 @@ static int get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 {
 	struct acm *acm = tty->driver_data;
 
-	ss->xmit_fifo_size = acm->writesize;
-	ss->baud_base = le32_to_cpu(acm->line.dwDTERate);
+	ss->line = acm->minor;
 	ss->close_delay	= jiffies_to_msecs(acm->port.close_delay) / 10;
 	ss->closing_wait = acm->port.closing_wait == ASYNC_CLOSING_WAIT_NONE ?
 				ASYNC_CLOSING_WAIT_NONE :
-- 
2.26.3

