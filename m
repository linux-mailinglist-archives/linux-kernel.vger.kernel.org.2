Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15FF3C1B5A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 00:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhGHWJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 18:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhGHWJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 18:09:09 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5CBC061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 15:06:26 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id ABA1C80719;
        Fri,  9 Jul 2021 10:06:23 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1625781983;
        bh=sBRB0Nuc+nWL4ZG5Reyu9Ge8Sg/kecBZKOXgpD3yAqs=;
        h=From:To:Cc:Subject:Date;
        b=U7QoTuBEpTdEn2HecinibcX3F12t8YCV2OhSccEsTaEDWCtJCyDU6Kef92TmMIblQ
         PPcZdCzC1DZuHYTOGJar5rX3M+q8gYRvEz2eMGZ/xQldf0xr6GlQ5yVy+g2rFhADxI
         6YujXT9n4d12HoAkX7FRoe6aHsSXAN3G1vktwpY8Ad9x2W/TMPTMzjZvFs7p5rT25E
         PIFkGHfdCpHtSNTcTntTMK3uAcFh2qLegap+ndl+xGtnmGHAgdEU1zKb5VvoAa0a9o
         FGelFJyCFquMxLFw1Qa0yYgSYVKX1tITXR17DqAy98uvEqr1/JCTdF9uGK05CIlx6n
         gZsedrnhO9vlA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B60e776df0000>; Fri, 09 Jul 2021 10:06:23 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by pat.atlnz.lc (Postfix) with ESMTP id 80E9A13ED8E;
        Fri,  9 Jul 2021 10:06:23 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 7C798280055; Fri,  9 Jul 2021 10:06:23 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] hwmon: (pmbus/bpa-rs600): Support BPD-RS600
Date:   Fri,  9 Jul 2021 10:06:18 +1200
Message-Id: <20210708220618.23576-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Sr3uF8G0 c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=e_q4qTt1xDgA:10 a=M5HzeCQB0xmgccp7If8A:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BPD-RS600 is the DC version of the BPA-RS600. The PMBUS interface is
the same between the two models. Keep the same compatible string but
accept either BPA-RS600 or BPD-RS600 in the PMBUS_MFR_MODEL.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/hwmon/pmbus/bpa-rs600.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/pmbus/bpa-rs600.c b/drivers/hwmon/pmbus/bpa-rs=
600.c
index 2be69fedfa36..d205b41540ce 100644
--- a/drivers/hwmon/pmbus/bpa-rs600.c
+++ b/drivers/hwmon/pmbus/bpa-rs600.c
@@ -21,6 +21,8 @@
 #define BPARS600_MFR_IOUT_MAX	0xa6
 #define BPARS600_MFR_POUT_MAX	0xa7
=20
+enum chips { bpa_rs600, bpd_rs600 };
+
 static int bpa_rs600_read_byte_data(struct i2c_client *client, int page,=
 int reg)
 {
 	int ret;
@@ -146,11 +148,19 @@ static struct pmbus_driver_info bpa_rs600_info =3D =
{
 	.read_word_data =3D bpa_rs600_read_word_data,
 };
=20
+static const struct i2c_device_id bpa_rs600_id[] =3D {
+	{ "bpa-rs600", bpa_rs600 },
+	{ "bpd-rs600", bpd_rs600 },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, bpa_rs600_id);
+
 static int bpa_rs600_probe(struct i2c_client *client)
 {
 	struct device *dev =3D &client->dev;
 	u8 buf[I2C_SMBUS_BLOCK_MAX + 1];
 	int ret;
+	const struct i2c_device_id *mid;
=20
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_READ_BYTE_DATA
@@ -164,7 +174,11 @@ static int bpa_rs600_probe(struct i2c_client *client=
)
 		return ret;
 	}
=20
-	if (strncmp(buf, "BPA-RS600", 8)) {
+	for (mid =3D bpa_rs600_id; mid->name[0]; mid++) {
+		if (!strncasecmp(buf, mid->name, strlen(mid->name)))
+			break;
+	}
+	if (!mid->name[0]) {
 		buf[ret] =3D '\0';
 		dev_err(dev, "Unsupported Manufacturer Model '%s'\n", buf);
 		return -ENODEV;
@@ -173,12 +187,6 @@ static int bpa_rs600_probe(struct i2c_client *client=
)
 	return pmbus_do_probe(client, &bpa_rs600_info);
 }
=20
-static const struct i2c_device_id bpa_rs600_id[] =3D {
-	{ "bpars600", 0 },
-	{},
-};
-MODULE_DEVICE_TABLE(i2c, bpa_rs600_id);
-
 static const struct of_device_id __maybe_unused bpa_rs600_of_match[] =3D=
 {
 	{ .compatible =3D "blutek,bpa-rs600" },
 	{},
--=20
2.32.0

