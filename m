Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91A531D48A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 05:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhBQEOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 23:14:39 -0500
Received: from mx1.riseup.net ([198.252.153.129]:33054 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231309AbhBQELj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 23:11:39 -0500
X-Greylist: delayed 622 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Feb 2021 23:11:39 EST
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4DgPHy6Z42zFmZ6;
        Tue, 16 Feb 2021 20:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1613534433; bh=FD3e/+jSIULzeMz09OgJLK0Zn/aDyCz7FT+cgyFWFec=;
        h=From:To:Cc:Subject:Date:From;
        b=Lt8yqxVXgonICxHN0bV2iPeyTRD/fePiYxitw3q//07uYZUbpDFOKurA+xHfSQS0p
         oL8i7tS9fANIZ+9B4pDW5nKYWevpbg7m0jW062Y0E0Mk1k04ne1LPNJkPsT4QeDQHG
         LjSJiag0Uejbm2CfA8QAtvZCWAh5QTjGMJI5GTzA=
X-Riseup-User-ID: 9DD0B2EC7AC93C4AE13A1398BA6F6FD14B020A67085F042A3413A2F8DCA6EBF9
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4DgPHm2Jmzz5vdK;
        Tue, 16 Feb 2021 20:00:04 -0800 (PST)
From:   Sean Behan <codebam@riseup.net>
Cc:     codebam@riseup.net, nathan@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remove unused variable driver_desc
Date:   Tue, 16 Feb 2021 22:59:51 -0500
Message-Id: <20210217035953.192959-1-codebam@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

