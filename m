Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C464944F1EC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 07:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbhKMG4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 01:56:49 -0500
Received: from mout02.posteo.de ([185.67.36.66]:57197 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229914AbhKMG4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 01:56:48 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id D8D08240101
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 07:53:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1636786434; bh=ReYgxVt/Tl+dgQ0DOmwaxXXVbeDYovdMr2t9IVlsrN4=;
        h=Date:From:To:Cc:Subject:From;
        b=GsGeAOKoO+TphW5U9/uqfVzVLSWoillTuvkrY6VxPEmtcRhKSOYdSPG4HIsmXK+0S
         2UI9OKeCNYwTC1sp/syaxtDE8TTJvtD2WMS5CKVGkkU4LKdhPxd6H93+bjIJ90UBL8
         FCWG+YT8BVBn6+KETK4q9gKAonHViKhRgqvT0WLm4r/SlWbq1qy/7P9+DkbfgQ6qyQ
         6dnTJS+dG0A78yjyjKru25dKFNn7BRfhRpd2vPs4z30mzxeMfdrXBbX4YpHx6mU7aN
         x3IdDYO9gS6CjIO2HR25SpToAk+GdUBzfDSnN/JhHE+W4urJn7DWz4FhH0d/7ksbJz
         78OBzn5gxardQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4HrmQ94Ts8z6tmh;
        Sat, 13 Nov 2021 07:53:53 +0100 (CET)
Date:   Sat, 13 Nov 2021 06:53:52 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: corsair-psu: fix plain integer used as NULL pointer
Message-ID: <YY9hAL8MZEQYLYPf@monster.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse warnings: (new ones prefixed by >>)
>> drivers/hwmon/corsair-psu.c:536:82: sparse: sparse: Using plain
   integer as NULL pointer

Fixes: d115b51e0e56 ("hwmon: add Corsair PSU HID controller driver")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
 drivers/hwmon/corsair-psu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
index 731d5117f9f1..14389fd7afb8 100644
--- a/drivers/hwmon/corsair-psu.c
+++ b/drivers/hwmon/corsair-psu.c
@@ -729,7 +729,7 @@ static int corsairpsu_probe(struct hid_device *hdev, const struct hid_device_id
 	corsairpsu_check_cmd_support(priv);
 
 	priv->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "corsairpsu", priv,
-							  &corsairpsu_chip_info, 0);
+							  &corsairpsu_chip_info, NULL);
 
 	if (IS_ERR(priv->hwmon_dev)) {
 		ret = PTR_ERR(priv->hwmon_dev);
-- 
2.33.1

