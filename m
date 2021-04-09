Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB5B35A257
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 17:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbhDIPw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 11:52:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232796AbhDIPwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 11:52:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 417FC610F9;
        Fri,  9 Apr 2021 15:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617983560;
        bh=82cgrefX/1Sq3u/fNHOVvK3ccx9ryULBHZgyjXXTGvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rXRNWoKlgSnY+YvO3196DBXdlsJkxlJ3y0cq7OQ1vLKtaCFfgselqQXlRk71NCWhx
         psP6t4NFEReUYAwVrKnzl3Z7Cw/SzwRIj+GGmRTtlXNBSEJJwOjv+enpjeb7pOMVe9
         uNobdy4oxRc93+r2eJNM7Aub2whSoopuKGqh2UBKukmlMa6UG8b7FnVw67k08Y2fLY
         3WS9bcjQkgLOkK8Ex1l/BNOglsHwK1zAxNQSjNeyGcBHfyGZ8UuLXT0R02qPtl3NPd
         glocUU25hFz6ZqdC0YsvL+e+7t95SzR8We1aGZ7NaOkAi9m/Yj/+9QaXBNiE2LERil
         GkT0K/0J43AYA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lUtQz-0008Ip-W5; Fri, 09 Apr 2021 17:52:38 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Pho Tran <photranvan0712@gmail.com>, Hung.Nguyen@silabs.com,
        Tung.Pham@silabs.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] USB: serial: cp210x: add gpio-configuration debug printk
Date:   Fri,  9 Apr 2021 17:52:16 +0200
Message-Id: <20210409155216.31867-3-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210409155216.31867-1-johan@kernel.org>
References: <20210409155216.31867-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a debug printk to dump the GPIO configuration stored in EEPROM
during probe.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/cp210x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index ceb3a656a075..ee595d1bea0a 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -1543,10 +1543,16 @@ static int cp210x_gpio_init_valid_mask(struct gpio_chip *gc,
 {
 	struct usb_serial *serial = gpiochip_get_data(gc);
 	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
+	struct device *dev = &serial->interface->dev;
 	unsigned long altfunc_mask = priv->gpio_altfunc;
 
 	bitmap_complement(valid_mask, &altfunc_mask, ngpios);
 
+	if (bitmap_empty(valid_mask, ngpios))
+		dev_dbg(dev, "no pin configured for GPIO\n");
+	else
+		dev_dbg(dev, "GPIO.%*pbl configured for GPIO\n", ngpios,
+				valid_mask);
 	return 0;
 }
 
-- 
2.26.3

