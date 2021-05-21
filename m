Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A848F38C6CC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbhEUMtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:49:01 -0400
Received: from mailgw.kylinos.cn ([123.150.8.42]:43804 "EHLO nksmu.kylinos.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234145AbhEUMs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:48:58 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 May 2021 08:48:37 EDT
X-UUID: c72d25bcf0b54f778f2a912c437cfc23-20210521
X-UUID: c72d25bcf0b54f778f2a912c437cfc23-20210521
X-User: luriwen@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by nksmu.kylinos.cn
        (envelope-from <luriwen@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1469929180; Fri, 21 May 2021 20:42:08 +0800
From:   Riwen Lu <luriwen@kylinos.cn>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Riwen Lu <luriwen@kylinos.cn>, Xin Chen <chenxin@kylinos.cn>
Subject: [PATCH v1] hwmon: (scpi-hwmon) shows the negative temperature properly
Date:   Fri, 21 May 2021 20:42:04 +0800
Message-Id: <20210521124204.22263-1-luriwen@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scpi hwmon shows the sub-zero temperature in an unsigned integer,
which would confuse the users when the machine works in low temperature
environment. This shows the sub-zero temperature in an signed value and
users can get it properly from sensors.

Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
Tested-by: Xin Chen <chenxin@kylinos.cn>
---
 drivers/hwmon/scpi-hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
index 25aac40f2764..583a600bc82d 100644
--- a/drivers/hwmon/scpi-hwmon.c
+++ b/drivers/hwmon/scpi-hwmon.c
@@ -99,7 +99,7 @@ scpi_show_sensor(struct device *dev, struct device_attribute *attr, char *buf)
 
 	scpi_scale_reading(&value, sensor);
 
-	return sprintf(buf, "%llu\n", value);
+	return sprintf(buf, "%lld\n", value);
 }
 
 static ssize_t
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
