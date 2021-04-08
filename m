Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FEE358469
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhDHNQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:16:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229741AbhDHNQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:16:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABB46610A6;
        Thu,  8 Apr 2021 13:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617887776;
        bh=Ke8qJp63FlrDKDKHCYuGMZj07d+yIBbFrD3Dth06hL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jHwfFrlkbHn+WMgp14S6HZHTsLHGmFqkiPf+9c6SGy+kbBYPRSnuIxOxpntjuYlfU
         t//gO9AFUei9CCI80rz74Rvek5iBOiIY1FP10SYQ3+vcvX4FQf21KA9f5tK9KlR/2U
         KWH1eafGWbknFjGabCfz8txGxGIAurd/eessMyzmk8fLo0W0p23EQl9rKP+NX2rr/3
         ph/ltF07dICiu/4H9dew44o6BgjWbi92z7fYlRNyvCrcm+BshUmGC82P8m1QfGVDp3
         MMU8P1Zq5dHxcNilwe02d0egrLb0RdO1/1UerEuafB/XkTIbnHECKdZUnUTpG3vdWw
         SsbVQHGIVaMQg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lUUW4-0007Hm-KH; Thu, 08 Apr 2021 15:16:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 3/3] USB: cdc-acm: fix TIOCGSERIAL implementation
Date:   Thu,  8 Apr 2021 15:16:02 +0200
Message-Id: <20210408131602.27956-4-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210408131602.27956-1-johan@kernel.org>
References: <20210408131602.27956-1-johan@kernel.org>
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

Similarly, baud_base could be used to set the UART base clock when it
could not be detected, but might as well be left unset when it is not
known (which is the case for CDC).

Fix the cdc-acm TIOCGSERIAL implementation by dropping its custom
interpretation of the unused xmit_fifo_size and baud_base fields, which
overflowed the former with the URB buffer size and set the latter to the
current line speed. Also return the port line number, which is the only
other value used besides the close parameters.

Note that the current line speed can still be retrieved through the
standard termios interfaces.

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

