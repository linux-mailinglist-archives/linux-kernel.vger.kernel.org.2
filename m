Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D1531DB6B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 15:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbhBQOZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 09:25:42 -0500
Received: from mx1.riseup.net ([198.252.153.129]:46300 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233418AbhBQOZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 09:25:41 -0500
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4Dgg8B5g07zFsdg;
        Wed, 17 Feb 2021 06:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1613571866; bh=IvnMCcmHCehGjNcRNbIEXbEAqemDFdZA+8ZJfN+1v/4=;
        h=From:To:Cc:Subject:Date:From;
        b=oa67nUtDN1Dm8+cAmsXGdRoSLrI8fUwq6FE4ZSJ/dmlg36BJjdKmQLEqEpaAjpYo8
         +bLt55VkNwndf6mIz2RnsXY2ua0Q1KiUgVWvB239Bep9Z2jPX9p6uTYPfFEaTzYf63
         PNEcqXULwy19U/hP7ghbWqbmo9SloNQBaeV+cD2Q=
X-Riseup-User-ID: 63C4401FEF5013B3DFBAE15EC29B9EB16668EE0B6C5B9DA2BBE993DAA83FB869
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4Dgg894VZcz20Rp;
        Wed, 17 Feb 2021 06:24:25 -0800 (PST)
From:   Sean Behan <codebam@riseup.net>
Cc:     codebam@riseup.net, nathan@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: emxx_udc: remove unused variable driver_desc
Date:   Wed, 17 Feb 2021 09:24:17 -0500
Message-Id: <20210217142420.7350-1-codebam@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1, there is a warning that this variable is unused.

It is not used so remove it to fix the warning.

Thanks to nathan@kernel.org for helping me submit my first patch.

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

