Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0551356A04
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351327AbhDGKlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:41:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351163AbhDGKkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:40:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6F8C613D0;
        Wed,  7 Apr 2021 10:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791990;
        bh=+FJZzX7snDQr2UxDp4rzmX4e+ZejfTdRGS0xesd6+yA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DLwCl/8WspoWZ9zZaou48rpF2O3b1CuB86Bn+aWBLnQtoWdhy3abnmQRaWGcThw+X
         LW8zKsQdAk55OtDldo/tJS306GJbNCICbZriYjfOWCAC48CJkZC+2CDcKTGfRIAUtC
         CN8zOrm2Sn9ymPKZ8IeF2xtNNnKreltuNYIBQdLPMp2s0IfN98o2ESUB4sgtFCP37M
         ZHi71EKyiZ/fbrgy5F1VfAneYshcl8mslZYJvtouscZKBIzPcDZyeAkdclUY7rmDwp
         0JM1820TDBQ07dboMDXYd5I9AvtH4IoOG6HceFa2cplRnEvfTgLWYaQQxXnEOPuT7x
         lMpuCEL7esNgw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5b5-0000FI-LV; Wed, 07 Apr 2021 12:39:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/24] USB: serial: usb_wwan: fix unprivileged TIOCCSERIAL
Date:   Wed,  7 Apr 2021 12:39:17 +0200
Message-Id: <20210407103925.829-17-johan@kernel.org>
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

A non-privileged user has only ever been able to set the since long
deprecated ASYNC_SPD flags and trying to change any other *supported*
feature should result in -EPERM being returned. Setting the current
values for any supported features should return success.

Fix the usb_wwan implementation which instead indicated that the
TIOCSSERIAL ioctl was not even implemented when a non-privileged user
set the current values.

Fixes: 02303f73373a ("usb-wwan: implement TIOCGSERIAL and TIOCSSERIAL to avoid blocking close(2)")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/usb_wwan.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
index 4e9c994a972a..e71c828682f5 100644
--- a/drivers/usb/serial/usb_wwan.c
+++ b/drivers/usb/serial/usb_wwan.c
@@ -166,8 +166,6 @@ int usb_wwan_set_serial_info(struct tty_struct *tty,
 		if ((close_delay != port->port.close_delay) ||
 		    (closing_wait != port->port.closing_wait))
 			retval = -EPERM;
-		else
-			retval = -EOPNOTSUPP;
 	} else {
 		port->port.close_delay  = close_delay;
 		port->port.closing_wait = closing_wait;
-- 
2.26.3

