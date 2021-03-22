Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C652E3449DD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhCVPxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:53:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230445AbhCVPxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:53:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCFDD619AC;
        Mon, 22 Mar 2021 15:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616428394;
        bh=p9/L/RnAIz9Ft9DWD/UAt/UImgrzNAZ5kXDabwhbbog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AmDLfz0sAimC9K9jL5nqrYcoHNwbihdyfFW5tatowRlsZqw4ISqRLX4RLbM87dnE5
         BMRNGtMVfbtSC+ffOx432iXgPLhE06CdnDYzmWpsFbd3wVNV3gbu7C8zPv95XOzow9
         KPsWNd097AC84UN1mXT+JbiLw75g6TFneGIEtOnrD2XSfFCMzAfimd/QskQeHxDpa5
         Bc8ZmNuxKKy1yNxHhoMGsl3xQOONcMHLCh++Fx88oz+4/PEks1czur6o89S52w0q81
         ePNuIsPOZ3IsY9yhl6ymGwoaKmRXAu9Z/4QLwwlLnqJY/zTFtY++e1ZdccKMeqUUpc
         PePccX4LNpoNQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lOMs0-0002Zd-PN; Mon, 22 Mar 2021 16:53:32 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 3/8] USB: cdc-acm: drop redundant driver-data assignment
Date:   Mon, 22 Mar 2021 16:53:13 +0100
Message-Id: <20210322155318.9837-4-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210322155318.9837-1-johan@kernel.org>
References: <20210322155318.9837-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interface driver data has already been set by
usb_driver_claim_interface() so drop the redundant subsequent
assignment.

Acked-by: Oliver Neukum <oneukum@suse.com>
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
2.26.3

