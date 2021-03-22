Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D765D3449E3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhCVPxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:53:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230470AbhCVPxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:53:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4C18619B2;
        Mon, 22 Mar 2021 15:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616428395;
        bh=m9RkJRpOqNy6mEIOmx0QNTVYF98YnapfldKqE/duUTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dxXhSBstpwr3VjWNoywqxoziDh/NfCjfK1C/+6mMJEp5aIQaFSrhys/xM1VX9e4EQ
         v6AAUyDsBiHN0YyNbUZULSn/9VavVm7wwIklJBlxgnvchvbniAdGHaLa0Q6heovcpw
         sF8p92G5GTs8ztDjtzqel9EQFK4BZbUW+OzHcRVo4da58HtktZgWTCwaZgzDtNN4mU
         VmrL1zgbJa7iQP2fVy9cCtJeoPgT6NRayvBcnQVTX1dIoJnTZNph9kfPwBVkFiMWQ/
         AYfHF/kYy4OYh2cwDFYoAL1ACyN6Idtm2XbPPG306BMUqljNXDErQ651f6uUi7s90u
         Uw8anSRB9m/Lw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lOMs1-0002Zq-4d; Mon, 22 Mar 2021 16:53:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 7/8] USB: cdc-acm: always claim data interface
Date:   Mon, 22 Mar 2021 16:53:17 +0100
Message-Id: <20210322155318.9837-8-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210322155318.9837-1-johan@kernel.org>
References: <20210322155318.9837-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to always claim the data interface and bail out if binding
fails.

Note that the driver had a check to verify that the data interface was
not already bound to a driver but would not detect other failures (e.g.
if the interface was not authorised).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/class/cdc-acm.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 6991ffd66c5d..914486d0f68c 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1296,13 +1296,6 @@ static int acm_probe(struct usb_interface *intf,
 	if (!combined_interfaces && intf != control_interface)
 		return -ENODEV;
 
-	if (!combined_interfaces && usb_interface_claimed(data_interface)) {
-		/* valid in this context */
-		dev_dbg(&intf->dev, "The data interface isn't available\n");
-		return -EBUSY;
-	}
-
-
 	if (data_interface->cur_altsetting->desc.bNumEndpoints < 2 ||
 	    control_interface->cur_altsetting->desc.bNumEndpoints == 0)
 		return -EINVAL;
@@ -1486,7 +1479,11 @@ static int acm_probe(struct usb_interface *intf,
 	acm->line.bDataBits = 8;
 	acm_set_line(acm, &acm->line);
 
-	usb_driver_claim_interface(&acm_driver, data_interface, acm);
+	if (!acm->combined_interfaces) {
+		rv = usb_driver_claim_interface(&acm_driver, data_interface, acm);
+		if (rv)
+			goto err_remove_files;
+	}
 
 	tty_dev = tty_port_register_device(&acm->port, acm_tty_driver, minor,
 			&control_interface->dev);
@@ -1508,6 +1505,7 @@ static int acm_probe(struct usb_interface *intf,
 		usb_set_intfdata(data_interface, NULL);
 		usb_driver_release_interface(&acm_driver, data_interface);
 	}
+err_remove_files:
 	if (acm->country_codes) {
 		device_remove_file(&acm->control->dev,
 				&dev_attr_wCountryCodes);
-- 
2.26.3

