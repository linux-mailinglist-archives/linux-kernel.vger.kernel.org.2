Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF1431DB5A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 15:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhBQOWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 09:22:16 -0500
Received: from mx1.riseup.net ([198.252.153.129]:44712 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233429AbhBQOWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 09:22:13 -0500
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4Dgg4s0RpBzFq23;
        Wed, 17 Feb 2021 06:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1613571693; bh=u27Lmkch+nLAvkxu4mMmLX/k/KYjiLg3s+1a0hp5aaQ=;
        h=From:To:Cc:Subject:Date:From;
        b=l0imE2kCPxvZkf9syb4FzORAKYgtsQply9XrkYmI4StSmBX/ErJrxcZjSw8Xjj02/
         ICzs/pRDzwWRhi3/Y8NvRJWITWlED8wraFGr+Q4+GtjFKr8laxPr5U9HwWsEi5wZTw
         NKDmqStQZcvREtG0ZoTGyqj61NgRX0OOAGewT/MI=
X-Riseup-User-ID: D64CE3937C4F71BCD8F1ECFC31DB49ABD2AC12BB883715A829BDA0B93E3618FF
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4Dgg4m147lz5vNX;
        Wed, 17 Feb 2021 06:21:28 -0800 (PST)
From:   Sean Behan <codebam@riseup.net>
Cc:     codebam@riseup.net, nathan@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: emxx_udc: remove unused variable driver_desc
Date:   Wed, 17 Feb 2021 09:21:15 -0500
Message-Id: <20210217142118.7107-1-codebam@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1 (or however you found it), there is a warning
that this variable is unused.

It is not used so remove it to fix the warning.

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

