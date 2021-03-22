Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898F73449E2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhCVPxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:53:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230450AbhCVPxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:53:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFB93619AD;
        Mon, 22 Mar 2021 15:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616428394;
        bh=VZ6mpIEVz/dYilkRg2l19PXHpiyaBPX/Ce0HWBs7Zwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I/zFRrZEZRZojLWcfZI5UhPw5GkYeL2P09Bq4fnQKiQME9XMzpR3ZVsyFA800/awi
         IMSfr34jZaCeyYarutOqUv60jaCY0j6TOUmlDq5BZjnFHTVrX+pY7dWyQDZyGz1E5W
         3aeVe8U2x6aENhnuDkyFUc3VXP5ZnrfiM4l9auF+dGx3XBEFfvOyphLKE402tuCri5
         0CdjyoRhhp9MsRzULtZ+PaKXixMOqRh5EWUGFkM5cH75jGOR7ci2NG2RSZCmsb9tvJ
         A8jRgp8J8redtN0vMhA0ZGuAyWuZ9CZduNux9iNlsE2JzuAoQ+C3hhose1G0ZgBAQd
         BaLMnXE1DBfDQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lOMs1-0002Zn-1s; Mon, 22 Mar 2021 16:53:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 6/8] USB: cdc-acm: use negation for NULL checks
Date:   Mon, 22 Mar 2021 16:53:16 +0100
Message-Id: <20210322155318.9837-7-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210322155318.9837-1-johan@kernel.org>
References: <20210322155318.9837-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use negation consistently throughout the driver for NULL checks.

Acked-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/class/cdc-acm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index e3c45f5880fc..6991ffd66c5d 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1323,7 +1323,7 @@ static int acm_probe(struct usb_interface *intf,
 	dev_dbg(&intf->dev, "interfaces are valid\n");
 
 	acm = kzalloc(sizeof(struct acm), GFP_KERNEL);
-	if (acm == NULL)
+	if (!acm)
 		return -ENOMEM;
 
 	tty_port_init(&acm->port);
@@ -1416,7 +1416,7 @@ static int acm_probe(struct usb_interface *intf,
 		struct acm_wb *snd = &(acm->wb[i]);
 
 		snd->urb = usb_alloc_urb(0, GFP_KERNEL);
-		if (snd->urb == NULL)
+		if (!snd->urb)
 			goto err_free_write_urbs;
 
 		if (usb_endpoint_xfer_int(epwrite))
-- 
2.26.3

