Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7253B34EA83
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhC3Ohm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:37:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231951AbhC3OhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:37:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD8C6619BD;
        Tue, 30 Mar 2021 14:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617115027;
        bh=7N5l3ZIfotiyDGJq6YGwcyxdCzpYtn6rXpIa367Go3Y=;
        h=From:To:Cc:Subject:Date:From;
        b=HcRRgjIrquW58c+zFBT5gMK5xmgyroMz/BfLYDySSGooyppWHSNR7k68zRsPYl8Pb
         5YHAyAjg90bz1JejMDBtkEJEJgzxjpvW5SQu2HNp3j8iG5+dTAABbNiciBtCbNHZeQ
         LtoJ1+sH7gyZ2SoqTowP+pYWzn+zzVATzALAqw6vqk/JRa0ydki/Mc6ISAKvd3uVY2
         ZEr4XLeJbWCFDSbyEVMEws4XxdKTlLaB6UA6XZdG9JR3mFRRE4HXmUiGKy06HFKZ03
         iSRekWgQb4ovMvyBtwR2iKr5VghQigyfflTB8qxj2t8oBO7ceIoHHsGiCx+XT9b8ch
         8j7eapmBL+YCw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lRFUm-0002Ma-CH; Tue, 30 Mar 2021 16:37:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: serial: xr: fix CSIZE handling
Date:   Tue, 30 Mar 2021 16:37:16 +0200
Message-Id: <20210330143716.9042-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XR21V141X does not have a 5- or 6-bit mode, but the current
implementation failed to properly restore the old setting when CS5 or
CS6 was requested. Instead an invalid request would be sent to the
device.

Fixes: c2d405aa86b4 ("USB: serial: add MaxLinear/Exar USB to Serial driver")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 0ca04906da4b..c59c8b47a120 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -467,6 +467,11 @@ static void xr_set_termios(struct tty_struct *tty,
 		termios->c_cflag &= ~CSIZE;
 		if (old_termios)
 			termios->c_cflag |= old_termios->c_cflag & CSIZE;
+		else
+			termios->c_cflag |= CS8;
+
+		if (C_CSIZE(tty) == CS7)
+			bits |= XR21V141X_UART_DATA_7;
 		else
 			bits |= XR21V141X_UART_DATA_8;
 		break;
-- 
2.26.3

