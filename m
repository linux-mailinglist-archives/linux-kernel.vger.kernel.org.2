Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFBF3999F3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 07:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFCFZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 01:25:27 -0400
Received: from mout02.posteo.de ([185.67.36.66]:45303 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229765AbhFCFZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 01:25:26 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id A0F9D2400FD
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 07:23:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1622697820; bh=wABl0gIXHD83vUh96O7dBds8ys0Ab9hhQdDQP6Ecg44=;
        h=Date:From:To:Cc:Subject:From;
        b=H3f8ScJuqLpW3PxG/jt+bSyGFDPmuvss7d1SYLHsNNgJubg4BBDWyFQH6JlPM618V
         nLIa/AtF0o8Yvg/+ZjiJ1pvnfEJonESCXNxzIqXohf6TLmnc3pngdInmz096VNvTno
         73eChTRm124cTXa0BXBHT1YjFRqlVXvIr/kmOX8voigQMA2HuKKEZ2feP9UttnC5zz
         PZS9f7YKzhvaoZ3IwTq5A17tvTjbYPEUrwUmQOkpuoAqWDsE/e9J7NgRCQVNsC5k1S
         UfYEXyPx74Wl+308Bn2hCO4t6hzKSr4dkRi5i9KCnfTkqFBhj9qRQdLYnoMQZmx7Y/
         Yyw2ZmxcrW39g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4FwZ7H5Lvnz9rxD;
        Thu,  3 Jun 2021 07:23:39 +0200 (CEST)
Date:   Thu,  3 Jun 2021 05:23:38 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: corsair-psu: fix suspend behavior
Message-ID: <YLhnWiI9mI3l5u/s@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During standby some PSUs turn off the microcontroller. A re-init is
required during resume or the microcontroller stays unresponsive.

Fixes: 726c945ab2eb ("hwmon: (corsair-psu) Remove unneeded semicolons")
Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
 drivers/hwmon/corsair-psu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
index 02298b86b57b..731d5117f9f1 100644
--- a/drivers/hwmon/corsair-psu.c
+++ b/drivers/hwmon/corsair-psu.c
@@ -771,6 +771,16 @@ static int corsairpsu_raw_event(struct hid_device *hdev, struct hid_report *repo
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int corsairpsu_resume(struct hid_device *hdev)
+{
+	struct corsairpsu_data *priv = hid_get_drvdata(hdev);
+
+	/* some PSUs turn off the microcontroller during standby, so a reinit is required */
+	return corsairpsu_init(priv);
+}
+#endif
+
 static const struct hid_device_id corsairpsu_idtable[] = {
 	{ HID_USB_DEVICE(0x1b1c, 0x1c03) }, /* Corsair HX550i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c04) }, /* Corsair HX650i */
@@ -793,6 +803,10 @@ static struct hid_driver corsairpsu_driver = {
 	.probe		= corsairpsu_probe,
 	.remove		= corsairpsu_remove,
 	.raw_event	= corsairpsu_raw_event,
+#ifdef CONFIG_PM
+	.resume		= corsairpsu_resume,
+	.reset_resume	= corsairpsu_resume,
+#endif
 };
 module_hid_driver(corsairpsu_driver);
 
-- 
2.31.1

