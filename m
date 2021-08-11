Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF023E8927
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 06:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhHKESJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 00:18:09 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:53191 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhHKESI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 00:18:08 -0400
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D22E1806B6;
        Wed, 11 Aug 2021 16:17:42 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1628655462;
        bh=BEuPhmjjovy2ZrSiYCSp5bi3NVx+Dvendg0uKXkTPQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ynr/YgWyr2celmWyJ4f3LHk3fQb/NlOlwPSoGbzx0XFs/N/0Uotvj8+J71/xdaxVt
         S3ZlBgxyCLLPr+Sh90kfdalakmHTLHzoEloL5RwqGT8dtrfVIrr9iuT++/oGDonYjH
         Sq9X6k2vMu52tT12JFn75PTaiUG48BpSq2BSe26dZv467Xu+JvvqYVhcF+DWPj09YD
         rnidzefpKNW+8MnvmiIX4ntLt/xvYFDxlDH+AtjIWaUci3zQ9lsrYBklm8Pu+jPbXk
         uX4hDfyelJOU9Ubgxy+qNDYLambLnb9icbGT4E6gXlEpR/RBj77xnPybn9p7Te2ZjD
         OQAAbYSGIzHtw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B61134f660002>; Wed, 11 Aug 2021 16:17:42 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by pat.atlnz.lc (Postfix) with ESMTP id A4C4513EEBA;
        Wed, 11 Aug 2021 16:17:42 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id A3302280E9D; Wed, 11 Aug 2021 16:17:42 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 2/2] hwmon: (pmbus/bpa-rs600) Add workaround for incorrect Pin max
Date:   Wed, 11 Aug 2021 16:17:38 +1200
Message-Id: <20210811041738.15061-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811041738.15061-1-chris.packham@alliedtelesis.co.nz>
References: <20210811041738.15061-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=aqTM9hRV c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=MhDmnRu9jo8A:10 a=abd1TrhZvCHtb7_ZMfQA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPD-RS600 modules running firmware v5.70 misreport the MFR_PIN_MAX.
The indicate a maximum of 1640W instead of 700W. Detect the invalid
reading and return a sensible value instead.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/hwmon/pmbus/bpa-rs600.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/bpa-rs600.c b/drivers/hwmon/pmbus/bpa-rs=
600.c
index d495faa89799..f4baed9ce8a4 100644
--- a/drivers/hwmon/pmbus/bpa-rs600.c
+++ b/drivers/hwmon/pmbus/bpa-rs600.c
@@ -65,6 +65,24 @@ static int bpa_rs600_read_vin(struct i2c_client *clien=
t)
 	return ret;
 }
=20
+/*
+ * The firmware on some BPD-RS600 models incorrectly reports 1640W
+ * for MFR_PIN_MAX. Deal with this by returning a sensible value.
+ */
+static int bpa_rs600_read_pin_max(struct i2c_client *client)
+{
+	int ret;
+
+	ret =3D pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_PIN_MAX);
+	if (ret < 0)
+		return ret;
+
+	if (ret =3D=3D 0x0b34)
+		return 0x095e;
+
+	return ret;
+}
+
 static int bpa_rs600_read_word_data(struct i2c_client *client, int page,=
 int phase, int reg)
 {
 	int ret;
@@ -92,7 +110,8 @@ static int bpa_rs600_read_word_data(struct i2c_client =
*client, int page, int pha
 		ret =3D pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_IOUT_MAX);
 		break;
 	case PMBUS_PIN_OP_WARN_LIMIT:
-		ret =3D pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_PIN_MAX);
+	case PMBUS_MFR_PIN_MAX:
+		ret =3D bpa_rs600_read_pin_max(client);
 		break;
 	case PMBUS_POUT_OP_WARN_LIMIT:
 		ret =3D pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_POUT_MAX);
--=20
2.32.0

