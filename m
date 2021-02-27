Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB95F326C8B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 10:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhB0Jfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 04:35:45 -0500
Received: from mout01.posteo.de ([185.67.36.65]:40753 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229835AbhB0Jfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 04:35:42 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id AA60C160062
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 10:34:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1614418484; bh=T3uT0JzZPYyjoGWasIVLI3FyG8lnKf8d/mRQUMH5fYA=;
        h=Date:From:To:Cc:Subject:From;
        b=TXlLfeWvygYLJQFG1nO723+G4Htz2DXqYmM6NbEnJT5G4s3zr+2J484U2VfCohtBb
         cADH617vqTA0XF6I/3knDd4rL4FgZBkcE+Jcjru3RGxRBoqfg6mCWvur692wThg8H5
         yQQwh9e4r1OLGSmziBhLUdvRN86bJ8WcaWz70bryMY8FsrYXnJNy7jbV5JJPWUPtDW
         V61WFBywanNH2Qh4OlPRpa8sVXfoDWEojgKmJyA6uMWOrTyEi3w3nse1vVz/ZYb3vm
         Fhd0BF0Qm4y28v62NaCEFs0mzDrKgbokYFz7Xz5/cWuaJwEccfIWzs2qX4MvmneazS
         3xUAQrKYuXhSg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4DnhFH63bYz6tmG;
        Sat, 27 Feb 2021 10:34:43 +0100 (CET)
Date:   Sat, 27 Feb 2021 10:34:42 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: corsair-psu: update calculation of LINEAR11 values
Message-ID: <YDoSMqFbgoTXyoru@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes the way how LINEAR11 values are calculated. The new method
increases the precision of 2-3 digits.

old method:
	corsairpsu-hid-3-1
	Adapter: HID adapter
	v_in:        230.00 V
	v_out +12v:   12.00 V
	v_out +5v:     5.00 V
	v_out +3.3v:   3.00 V
	psu fan:        0 RPM
	vrm temp:     +44.0°C
	case temp:    +37.0°C
	power total: 152.00 W
	power +12v:  112.00 W
	power +5v:    38.00 W
	power +3.3v:   5.00 W
	curr in:          N/A
	curr +12v:     9.00 A
	curr +5v:      7.00 A
	curr +3.3v:  1000.00 mA

new method:
	corsairpsu-hid-3-1
	Adapter: HID adapter
	v_in:        230.00 V
	v_out +12v:   12.16 V
	v_out +5v:     5.01 V
	v_out +3.3v:   3.30 V
	psu fan:        0 RPM
	vrm temp:     +44.5°C
	case temp:    +37.8°C
	power total: 148.00 W
	power +12v:  108.00 W
	power +5v:    37.00 W
	power +3.3v:   4.50 W
	curr in:          N/A
	curr +12v:     9.25 A
	curr +5v:      7.50 A
	curr +3.3v:    1.50 A

Co-developed-by: Jack Doan <me@jackdoan.com>
Signed-off-by: Jack Doan <me@jackdoan.com>
Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
 drivers/hwmon/corsair-psu.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
index 99494056f4bd..b0953eeeb2d3 100644
--- a/drivers/hwmon/corsair-psu.c
+++ b/drivers/hwmon/corsair-psu.c
@@ -119,27 +119,13 @@ struct corsairpsu_data {
 };
 
 /* some values are SMBus LINEAR11 data which need a conversion */
-static int corsairpsu_linear11_to_int(const int val)
+static int corsairpsu_linear11_to_int(const u16 val, const int scale)
 {
-	int exp = (val & 0xFFFF) >> 0x0B;
-	int mant = val & 0x7FF;
-	int i;
-
-	if (exp > 0x0F)
-		exp -= 0x20;
-	if (mant > 0x3FF)
-		mant -= 0x800;
-	if ((mant & 0x01) == 1)
-		++mant;
-	if (exp < 0) {
-		for (i = 0; i < -exp; ++i)
-			mant /= 2;
-	} else {
-		for (i = 0; i < exp; ++i)
-			mant *= 2;
-	}
+	const int exp = ((s16)val) >> 11;
+	const int mant = (((s16)(val & 0x7ff)) << 5) >> 5;
+	const int result = mant * scale;
 
-	return mant;
+	return (exp >= 0) ? (result << exp) : (result >> -exp);
 }
 
 static int corsairpsu_usb_cmd(struct corsairpsu_data *priv, u8 p0, u8 p1, u8 p2, void *data)
@@ -249,14 +235,14 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, l
 	case PSU_CMD_RAIL_AMPS:
 	case PSU_CMD_TEMP0:
 	case PSU_CMD_TEMP1:
-		*val = corsairpsu_linear11_to_int(tmp & 0xFFFF) * 1000;
+		*val = corsairpsu_linear11_to_int(tmp & 0xFFFF, 1000);
 		break;
 	case PSU_CMD_FAN:
-		*val = corsairpsu_linear11_to_int(tmp & 0xFFFF);
+		*val = corsairpsu_linear11_to_int(tmp & 0xFFFF, 1);
 		break;
 	case PSU_CMD_RAIL_WATTS:
 	case PSU_CMD_TOTAL_WATTS:
-		*val = corsairpsu_linear11_to_int(tmp & 0xFFFF) * 1000000;
+		*val = corsairpsu_linear11_to_int(tmp & 0xFFFF, 1000000);
 		break;
 	case PSU_CMD_TOTAL_UPTIME:
 	case PSU_CMD_UPTIME:
-- 
2.30.1

