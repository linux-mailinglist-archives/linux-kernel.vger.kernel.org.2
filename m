Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13268340941
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhCRPwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:52:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230477AbhCRPwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:52:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2240B64EF6;
        Thu, 18 Mar 2021 15:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616082720;
        bh=+yNLBBpLQUesjQU9zH7hMX1JnxqzSjRK9z0Q3x+/JT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hVkNpbIwu3KUht+BSIMxlDTC66nH0LJJuUUmJFIL7HUp2E/3BIAVCIiIdl+KZWL32
         75kEEJs0ed7sfGdKrmvkXXNuW5ZmZrJqBBvXFv1xbL76b2xCYDl4Q4ex2z6UK6ju8l
         s1M0UCPiit+PEpct2Hep2Y8PnnZ8LMju98XYk36b+49QEjgtIOcIKvYdu5NzMbbwSN
         +k+CpG6F/C6GfKTCATfZU9790yVkJBNpGRDtlcdaZD4cYosu7pwr341/7x7+WcTAuT
         K6lhxUBDiWGyN7zqfk94vaKC8gsoKUM+HYpVDZoQw4ulkDDEHdphfPyKy04BZvtSDm
         djxfSDunEu1Xg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lMuwc-0005nU-5r; Thu, 18 Mar 2021 16:52:18 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/7] USB: cdc-acm: drop redundant driver-data assignment
Date:   Thu, 18 Mar 2021 16:51:58 +0100
Message-Id: <20210318155202.22230-4-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210318155202.22230-1-johan@kernel.org>
References: <20210318155202.22230-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interface driver data has already been set by
usb_driver_claim_interface() so drop the redundant subsequent
assignment.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/class/cdc-acm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index dfc2480add91..36dd1e05e455 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1487,7 +1487,6 @@ static int acm_probe(struct usb_interface *intf,
 	acm_set_line(acm, &acm->line);
 
 	usb_driver_claim_interface(&acm_driver, data_interface, acm);
-	usb_set_intfdata(data_interface, acm);
 
 	tty_dev = tty_port_register_device(&acm->port, acm_tty_driver, minor,
 			&control_interface->dev);
-- 
2.26.2

