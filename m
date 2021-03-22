Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BEF3449DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhCVPxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:53:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230240AbhCVPxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:53:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B77D3619AA;
        Mon, 22 Mar 2021 15:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616428394;
        bh=amt4EOUNrN/3n/C6UUQwCgfx7XJdgceD5wYMZTIbcm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fHclThhD9o4ZFHtkNc7Mn1LGuR7y0Dod/DzEJc+AEmrhPH0ij8zF0brGz9JNCGux1
         75R1ksXtQfKXo/KnGJN37WpgsvfB3lSPEjHQCCxy698/G5M32XrFrgl1x+Q3ZssjR0
         C4S5v5yvNE6rGmjkSWf1EQcLWL/UVQsLkwXASlpmcA/tx/bQ4IvR5iOF5e3BqVmM2o
         KLGfXVtx55zwcqp1DwU+JY2mex71Z9UPDKTh6kjZY/xRnSOVZc0FhXselSSLWTdQx7
         ZsKTaekftNJBtU1ikbY/FuO0gJLPp5b4SdrOVpDHvHOKGGqtuta+jJIhWY11MFzVQq
         XjTsDdOcLo7nA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lOMs0-0002Zf-SO; Mon, 22 Mar 2021 16:53:32 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 4/8] USB: cdc-acm: drop redundant driver-data reset
Date:   Mon, 22 Mar 2021 16:53:14 +0100
Message-Id: <20210322155318.9837-5-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210322155318.9837-1-johan@kernel.org>
References: <20210322155318.9837-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to clear the interface driver data on failed probe (and
driver core will clear it anyway).

Acked-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/class/cdc-acm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 36dd1e05e455..682772b8a4f7 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1515,7 +1515,6 @@ static int acm_probe(struct usb_interface *intf,
 	}
 	device_remove_file(&acm->control->dev, &dev_attr_bmCapabilities);
 alloc_fail5:
-	usb_set_intfdata(intf, NULL);
 	for (i = 0; i < ACM_NW; i++)
 		usb_free_urb(acm->wb[i].urb);
 alloc_fail4:
-- 
2.26.3

