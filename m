Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411CC399CBC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 10:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhFCIkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 04:40:43 -0400
Received: from mailgw.kylinos.cn ([123.150.8.42]:45531 "EHLO nksmu.kylinos.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229611AbhFCIkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:40:42 -0400
X-UUID: 0c957269bb9e4c01b82befbc6c67934a-20210603
X-UUID: 0c957269bb9e4c01b82befbc6c67934a-20210603
X-User: luriwen@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by nksmu.kylinos.cn
        (envelope-from <luriwen@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 133540621; Thu, 03 Jun 2021 16:38:38 +0800
From:   Riwen Lu <luriwen@kylinos.cn>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Riwen Lu <luriwen@kylinos.cn>, Xin Chen <chenxin@kylinos.cn>
Subject: [PATCH v2] hwmon: (scpi-hwmon) shows the negative temperature properly
Date:   Thu,  3 Jun 2021 16:38:45 +0800
Message-Id: <20210603083845.569751-1-luriwen@kylinos.cn>
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
Changes since v1:
- Add judgment for sensor->info.class. If it is TEMPERATURE situation,
  return the sensor value as a signed value, otherwise return it as a
  unsigned value.
---
 drivers/hwmon/scpi-hwmon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
index 25aac40f2764..45a7e319143d 100644
--- a/drivers/hwmon/scpi-hwmon.c
+++ b/drivers/hwmon/scpi-hwmon.c
@@ -99,7 +99,10 @@ scpi_show_sensor(struct device *dev, struct device_attribute *attr, char *buf)
 
 	scpi_scale_reading(&value, sensor);
 
-	return sprintf(buf, "%llu\n", value);
+	if (sensor->info.class == TEMPERATURE)
+		return sprintf(buf, "%lld\n", value);
+	else
+		return sprintf(buf, "%llu\n", value);
 }
 
 static ssize_t
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
