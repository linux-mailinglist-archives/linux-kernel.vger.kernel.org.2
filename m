Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F9135B2F1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 12:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbhDKKGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 06:06:00 -0400
Received: from mr85p00im-ztdg06021801.me.com ([17.58.23.195]:57618 "EHLO
        mr85p00im-ztdg06021801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229804AbhDKKFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 06:05:40 -0400
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Apr 2021 06:05:40 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1618135065;
        bh=QCAbgHJkS5myJMVGdfFVCZVIpCQ5c7NW+FDT6hRH450=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=QEoaVlG7D+mMLUiYKobdK4KhgwA2ci07SJ4Mz5M00wnHEc2L3HMfFuWB0NBECNCDs
         9uzY62EeHlUmYF7OWxoRXVPwe9lCaz/Nsql9g0VzOKZvBR43rqt1Jwz7WBodY8L+Xn
         YJlQV1mEZE1NO4IU9b4s3qpNzML+so2zhp6lrDlMvgvvkl5PvkavhdvoHgskpor8W2
         vhwI9d+659e+mHVyHvkibrsuq2R+caV9x6yHUi5huYaKaeCYWzRGRzzF38YkqEhfX6
         LrWwLH+4Erkg9OG3x+uACvNpFN4ANjoj5MyHwCnDjAR6UXI5fMZaxoyxQArVFaX5SY
         rX27epDov68lw==
Received: from icloud.com (dslb-090-186-183-050.090.186.pools.vodafone-ip.de [90.186.183.50])
        by mr85p00im-ztdg06021801.me.com (Postfix) with ESMTPSA id 4D0091802FF;
        Sun, 11 Apr 2021 09:57:44 +0000 (UTC)
Date:   Sun, 11 Apr 2021 11:57:41 +0200
From:   Sebastian Oechsle <setboolean@icloud.com>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (dell-smm) Add Dell Latitude E7440 to fan control
 whitelist
Message-ID: <20210411095741.zmllsuc7pevdipvy@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-11_04:2021-04-09,2021-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2104110077
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow manual PWM control on Dell Latitude E7440.

Signed-off-by: Sebastian Oechsle <setboolean@icloud.com>

Changes in v2:
- Fix spelling
- Fix format
---
 drivers/hwmon/dell-smm-hwmon.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index 73b9db9e3aab..2970892bed82 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1210,6 +1210,14 @@ static struct dmi_system_id i8k_whitelist_fan_control[] __initdata = {
 		},
 		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
 	},
+	{
+		.ident = "Dell Latitude E7440",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Latitude E7440"),
+		},
+		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
+	},
 	{ }
 };
 
-- 
2.31.1

