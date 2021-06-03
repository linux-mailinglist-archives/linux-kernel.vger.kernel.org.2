Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE75E39A032
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFCLwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:52:51 -0400
Received: from mout01.posteo.de ([185.67.36.65]:51663 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229958AbhFCLwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:52:50 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 9434124002A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 13:51:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1622721064; bh=lIIqWrZEgUHD2YQOnbHsOFHvIImysoo2Lux0KcL3teE=;
        h=Date:From:To:Cc:Subject:From;
        b=F6kbh2388EVrYaqEFpwmgbWfHCYht66VkBE1s5wR4MAOmk5vpn/wlFExk5d9oslCn
         fC1/9CNeXrGjHm5Q4Qin1SsfkQdNER62Q4bNSOt31+rr7l5dALSQe6DEU+HSbKeDOs
         uO78b/dAQe9W4a2MiPqvcrZCX4ikIAUR6hlRSZyGMzARAL0qMpQZqWfb2Bp4Sz8DfJ
         ZxKUa090Qwh/vazdd04YDJXD7taeclXJb6HJhY8SrN0MYI5RXWU2w2kRu19WPNCaTA
         xa3ONDZ6ddc69vpdIdFki7Ink0PeCl6DVZbAm0bJQaxwxdPXawhUo4G5wKJDI8vpt7
         NXxtc931OuvcA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4FwkkH65Vcz6tmJ;
        Thu,  3 Jun 2021 13:51:03 +0200 (CEST)
Date:   Thu,  3 Jun 2021 11:51:02 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH v2] hwmon: corsair-psu: fix suspend behavior
Message-ID: <YLjCJiVtu5zgTabI@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During standby some PSUs turn off the microcontroller. A re-init is
required during resume or the microcontroller stays unresponsive.

Fixes: d115b51e0e56 ("hwmon: add Corsair PSU HID controller driver")
Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
Changes in v2:
  - corrected fixes commit
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

