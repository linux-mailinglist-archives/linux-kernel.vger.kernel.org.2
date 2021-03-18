Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1800C340946
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhCRPw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:52:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231225AbhCRPwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:52:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F9E264F38;
        Thu, 18 Mar 2021 15:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616082720;
        bh=invk8uhjFwTQ4535wzfeJv1w5fOcdHfeU/XjQ+K0Ngc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pv/ODodkYSZgjSCx+NfSNT6vVUQhqyCjq50BqY5PlrrILQpB1l7NTl0a9AYfF/vIV
         eDf2Su3fEQTv8R2Vr7P9tDjbgtVdtu12Nxail2GhgjPyuf/wN41jCt/kJUNo51RVFv
         kAdMIitXQm7y6cHGYPzuLAAfzJ0Lgx8tLKW2dFSK4XHNBFMnzfTmebKSu+yXKH+o/M
         056khjKa9oz+pQw9r7qeWOm2V/jBmLm78g71dtsv8mAG157Pe2UcSh614y/uK5iYFx
         6zBFHzghlQUk2rZs89xs7ktwDAK52eyseD/4g+n/K6sINfslP6ggGvcSz3egHO+r7x
         4GWYDziV8T9hQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lMuwc-0005nf-FN; Thu, 18 Mar 2021 16:52:18 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 6/7] USB: cdc-acm: use negation for NULL checks
Date:   Thu, 18 Mar 2021 16:52:01 +0100
Message-Id: <20210318155202.22230-7-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210318155202.22230-1-johan@kernel.org>
References: <20210318155202.22230-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use negation consistently throughout the driver for NULL checks.

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
2.26.2

