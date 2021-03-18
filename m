Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0801F340949
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhCRPwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:52:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231648AbhCRPwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:52:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35DC564F40;
        Thu, 18 Mar 2021 15:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616082720;
        bh=M4E3BvFfJP/+cfDrdryeJREcm4+lpbukXe5ZikaLhv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MfXzBnl9oEGLOV/1dzcu+MGzrB9X/2r3O509gkDf+QRs7uxLmY+iA7EAKpj/SCzy8
         C5CEodM/Wo0LNkRthAMqTd0UbFLFq+1aE/F2Yhw4Vua4qLt/hpxsBXiHGhBFBa2Oqa
         62tNuUSk1mEamqVZSUZwdiKdc1Bf7bOlZhX0mBQ25u9GRv1iLyaVptdfwxq7ZBvmXR
         xGnpiISq4+/fjdgaPOaQwtT2Ey8j59hvWJnIB4XJ4zzcPnyiu6fxH6e8CxKK3huja2
         clA1PDlioMmEz8dBpBKfeibUe6hGbx4QosVb0BmZvqx5FizY8uZ9hFDRoRI11ELjsr
         vqltxk/tbaSkQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lMuwc-0005ni-ID; Thu, 18 Mar 2021 16:52:18 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 7/7] USB: cdc-acm: always claim data interface
Date:   Thu, 18 Mar 2021 16:52:02 +0100
Message-Id: <20210318155202.22230-8-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210318155202.22230-1-johan@kernel.org>
References: <20210318155202.22230-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to always claim the data interface and bail out if it's
already bound to another driver or isn't authorised.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/class/cdc-acm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 6991ffd66c5d..58c444f9db5e 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1486,7 +1486,11 @@ static int acm_probe(struct usb_interface *intf,
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
@@ -1508,6 +1512,7 @@ static int acm_probe(struct usb_interface *intf,
 		usb_set_intfdata(data_interface, NULL);
 		usb_driver_release_interface(&acm_driver, data_interface);
 	}
+err_remove_files:
 	if (acm->country_codes) {
 		device_remove_file(&acm->control->dev,
 				&dev_attr_wCountryCodes);
-- 
2.26.2

