Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282883BB8F8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 10:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhGEIXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 04:23:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230289AbhGEIXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 04:23:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D965E613F3;
        Mon,  5 Jul 2021 08:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625473240;
        bh=bgLcqTz9o4lYB5u8sjeXDFM4o4ON74W5K6VG/Pp0/Uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RtgzptFTT1aNm24tl2+bkW1ZM9BkFh+rRG+M9/107fbR7pWW1sjqgkybqmv2peYtK
         EvdgHjbFSDVkQL8SACCBefdcS/kn3cwamFrTsg87124P796EZYd7cIYfLWT0wruzvV
         IItAHv9pGru8B4U76P0Cs5qTC7cXUlrsEv1NSI/HNtUFoDrTD2zrmPGs3E9vwhJgT+
         NHo34UKnRY6C3zbxEimtG4pkUXNysnb1XZ9IqBCC6MZuGBIGeJMEWJcEJiV1eTyI/Y
         R3X0QAt5+0pu+pi2LuaTKhb1781I9uzlQgtFSiYehIYAT2gu1PlcfdbuSYW79jOPKW
         lHfX8Z40J++dA==
Received: from johan by xi with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1m0JqF-0004m1-Fb; Mon, 05 Jul 2021 10:20:35 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] USB: serial: cp210x: clean up type detection
Date:   Mon,  5 Jul 2021 10:20:14 +0200
Message-Id: <20210705082015.18286-6-johan@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210705082015.18286-1-johan@kernel.org>
References: <20210705082015.18286-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up attach somewhat by moving type detection into the quirk helper
and giving it a more generic name.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/cp210x.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 6e027e2a02ad..6aaf54f16f8c 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -2091,11 +2091,21 @@ static int cp210x_get_fw_version(struct usb_serial *serial, u16 value)
 	return 0;
 }
 
-static void cp210x_determine_quirks(struct usb_serial *serial)
+static void cp210x_determine_type(struct usb_serial *serial)
 {
 	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
 	int ret;
 
+	ret = cp210x_read_vendor_block(serial, REQTYPE_DEVICE_TO_HOST,
+			CP210X_GET_PARTNUM, &priv->partnum,
+			sizeof(priv->partnum));
+	if (ret < 0) {
+		dev_warn(&serial->interface->dev,
+				"querying part number failed\n");
+		priv->partnum = CP210X_PARTNUM_UNKNOWN;
+		return;
+	}
+
 	switch (priv->partnum) {
 	case CP210X_PARTNUM_CP2102N_QFN28:
 	case CP210X_PARTNUM_CP2102N_QFN24:
@@ -2120,18 +2130,9 @@ static int cp210x_attach(struct usb_serial *serial)
 	if (!priv)
 		return -ENOMEM;
 
-	result = cp210x_read_vendor_block(serial, REQTYPE_DEVICE_TO_HOST,
-					  CP210X_GET_PARTNUM, &priv->partnum,
-					  sizeof(priv->partnum));
-	if (result < 0) {
-		dev_warn(&serial->interface->dev,
-			 "querying part number failed\n");
-		priv->partnum = CP210X_PARTNUM_UNKNOWN;
-	}
-
 	usb_set_serial_data(serial, priv);
 
-	cp210x_determine_quirks(serial);
+	cp210x_determine_type(serial);
 	cp210x_init_max_speed(serial);
 
 	result = cp210x_gpio_init(serial);
-- 
2.31.1

