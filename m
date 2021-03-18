Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA0B340945
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhCRPw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:52:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231162AbhCRPwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:52:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2743364F2A;
        Thu, 18 Mar 2021 15:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616082720;
        bh=XCpyHJcikJIMvXUV+Xi8p6BJrS4vSE8cEJvypsVosz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RAnAbtHQjlgQ/a8838gvKTg9IMOJzO7m/Ls2MCQ22pBQHGktHwsUShiUVKpRhqY1w
         R3jxIybkImNdII/IN+YHN7Q5NiZGXK+P8loxcLHmhziHF78wPu7yD7YK+2TsZJHMUg
         XNwQ8vio2CU+nmPfSCXBxd/xAx2kvv51+nWpSRT0I3Jvs20p51eZ7j3EdBKCqagS0d
         Ly99jD7en6PWFpWXa34Zlw9K+lAPFKVgGwotpwcFXFTtWHy2iWkkqW02JPfHeyu7WM
         XCu+nCwoecZR5M9WnmK5mCOakIT/Pb3VbNIV8sNwu1NIB7Rom91GwVJ15Knox1glHE
         JXGRsT9IRI4Yg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lMuwc-0005nY-8S; Thu, 18 Mar 2021 16:52:18 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/7] USB: cdc-acm: drop redundant driver-data reset
Date:   Thu, 18 Mar 2021 16:51:59 +0100
Message-Id: <20210318155202.22230-5-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210318155202.22230-1-johan@kernel.org>
References: <20210318155202.22230-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to clear the interface driver data on failed probe (and
driver core will clear it anyway).

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
2.26.2

