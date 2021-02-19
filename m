Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0587D31F440
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 04:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhBSDmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 22:42:21 -0500
Received: from mx1.riseup.net ([198.252.153.129]:50470 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhBSDmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 22:42:19 -0500
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4DhcnZ5Ny0zFgPh;
        Thu, 18 Feb 2021 19:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1613706098; bh=onlPDPh+CMzihdO950TwRXvU1Wd+ycLugdfUSx65AoM=;
        h=From:To:Cc:Subject:Date:From;
        b=scyZcXI6QvgGolMNnkVCBUE6Bc3f5vIOqkRA3Ws1VqIwQTxpPoT3UpSnfHHYGFfqA
         xkDrJPlGnDi6iT13XT5GsGI5LX4G/yxmDTByFDMdKBRXK0LduLAYcP6f0CTHbTORHj
         xKFSkAM6Bc5dZ07oskw9sLBjNq6youDhFAgFLbPU=
X-Riseup-User-ID: 27878FF40E0A2A2210BD8C71A7C41EE05F9AD8BAE4950CB16B4F471D07FB40AF
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4DhcnK0y1Pz1yPN;
        Thu, 18 Feb 2021 19:41:25 -0800 (PST)
From:   Sean Behan <codebam@riseup.net>
Cc:     codebam@riseup.net, nathan@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: emxx_udc: remove unused variable driver_desc
Date:   Thu, 18 Feb 2021 22:41:07 -0500
Message-Id: <20210219034109.13036-1-codebam@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sean Behan <codebam@riseup.net>
---
 drivers/staging/emxx_udc/emxx_udc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 3536c03ff523..741147a4f0fe 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -38,7 +38,6 @@ static struct gpio_desc *vbus_gpio;
 static int vbus_irq;
 
 static const char	driver_name[] = "emxx_udc";
-static const char	driver_desc[] = DRIVER_DESC;
 
 /*===========================================================================*/
 /* Prototype */
-- 
2.29.2

