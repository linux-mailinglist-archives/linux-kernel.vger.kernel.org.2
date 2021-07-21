Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1153D1446
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 18:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhGUPzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 11:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhGUPy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 11:54:59 -0400
X-Greylist: delayed 1060 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Jul 2021 09:35:33 PDT
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024F2C0613C1;
        Wed, 21 Jul 2021 09:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=XoZ4bSdSiVXYEMiyILsHY2KE5sWlXgaZX7yRUZoPcck=; b=3g
        tbqDKILXrYqBjqGDs6j4QRFqdIac6DeMBmXqHneSfk6qy/b+O1hCJR3JErKO4LYp7GpfVf2PSif9/
        4ubi+rF40ui84MKkjTnKNghVyXtky52kyk5XbW0dkwxXUOI6yQKsan0kQzJKHI0vZhe9sM4YTeGa4
        1+t/DMgbTntPP7zpmPKzpBDPLbghYbJKjporVeXyJSb0IX7G+9YZd22dTL9XyMbjRl6YKoa9ISUZ/
        DYMazvT7SPpGL6ks0iMpjYUbDOBHuaebYLmRpn43CT9oV4q4n47JK1mT8vV0Rs1L/dSZizXXIEAIE
        qa5SU8IlAuANtNmsAOxtViSPX69vqIkA==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1m6Eus-00029F-5z; Wed, 21 Jul 2021 17:17:50 +0100
From:   John Keeping <john@metanate.com>
To:     linux-usb@vger.kernel.org
Cc:     John Keeping <john@metanate.com>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] USB: serial: cp210x: add ID for CEL EM3588 USB ZigBee stick
Date:   Wed, 21 Jul 2021 17:17:45 +0100
Message-Id: <20210721161745.2101328-1-john@metanate.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the USB serial device ID for the CEL ZigBee EM3588 radio stick.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/usb/serial/cp210x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index ee595d1bea0a..bea89ba58280 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -155,6 +155,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x10C4, 0x89A4) }, /* CESINEL FTBC Flexible Thyristor Bridge Controller */
 	{ USB_DEVICE(0x10C4, 0x89FB) }, /* Qivicon ZigBee USB Radio Stick */
 	{ USB_DEVICE(0x10C4, 0x8A2A) }, /* HubZ dual ZigBee and Z-Wave dongle */
+	{ USB_DEVICE(0x10C4, 0x8A5B) }, /* CEL EM3588 ZigBee USB Stick */
 	{ USB_DEVICE(0x10C4, 0x8A5E) }, /* CEL EM3588 ZigBee USB Stick Long Range */
 	{ USB_DEVICE(0x10C4, 0x8B34) }, /* Qivicon ZigBee USB Radio Stick */
 	{ USB_DEVICE(0x10C4, 0xEA60) }, /* Silicon Labs factory default */
-- 
2.32.0

