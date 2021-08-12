Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1873E9BFD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 03:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbhHLBkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 21:40:31 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:54314 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbhHLBk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 21:40:28 -0400
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 19360891B0;
        Thu, 12 Aug 2021 13:40:02 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1628732402;
        bh=0WP7JrE2n6pBRB3mxnojqVyrztEUucpnuivW8lNRDXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YoKcpSVwNFMYZmDZ6TG1LL4eLA5DgzXUgBeb7IrCvJkART4eaR4JAWjPgA1sqpxhP
         m326KOpCkysFvB/j1wCvnhCLPOS66iygCjLaTDYFervffa2HIHhC+poysxtsxvO4xa
         AGXf1O0iOtkSzsahGamEZ2fOTiGvU0hVIVdKTJwn5ZePGRJcUG7TMyDiELiR2f+B/R
         f/ubnXidn1uZoLQ89MFIbT5bfp85VSde+p8++mjKhbSnOP5iF/6xrmZSTkAlEILhaw
         XCf22jxj7eb/EFw1Z/NzBy719/yXQRpoaOS/nbi8PnYSO4hSupLvaeynKmAe1CtXt4
         uKNfZYEkBm1gA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B61147bf10001>; Thu, 12 Aug 2021 13:40:01 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by pat.atlnz.lc (Postfix) with ESMTP id E59F213EE8E;
        Thu, 12 Aug 2021 13:40:01 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id EBC38280E9D; Thu, 12 Aug 2021 13:40:01 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 1/2] hwmon: (pmbus/bpa-rs600) Don't use rated limits as warn limits
Date:   Thu, 12 Aug 2021 13:39:59 +1200
Message-Id: <20210812014000.26293-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210812014000.26293-1-chris.packham@alliedtelesis.co.nz>
References: <20210812014000.26293-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=aqTM9hRV c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=MhDmnRu9jo8A:10 a=jUjP_tmKNjQU_ALbfCsA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the initial implementation a number of PMBUS_x_WARN_LIMITs were
mapped to MFR fields. This was incorrect as these MFR limits reflect the
rated limit as opposed to a limit which will generate warning. Instead
return -ENXIO like we were already doing for other WARN_LIMITs.

Subsequently these rated limits have been exposed generically as new
fields in the sysfs ABI so the values are still available.

Fixes: 15b2703e5e02 ("hwmon: (pmbus) Add driver for BluTek BPA-RS600")
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - Reworked to remove the mapping of warning limits to rated limits.

 drivers/hwmon/pmbus/bpa-rs600.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/hwmon/pmbus/bpa-rs600.c b/drivers/hwmon/pmbus/bpa-rs=
600.c
index d205b41540ce..84dee86399cb 100644
--- a/drivers/hwmon/pmbus/bpa-rs600.c
+++ b/drivers/hwmon/pmbus/bpa-rs600.c
@@ -12,15 +12,6 @@
 #include <linux/pmbus.h>
 #include "pmbus.h"
=20
-#define BPARS600_MFR_VIN_MIN	0xa0
-#define BPARS600_MFR_VIN_MAX	0xa1
-#define BPARS600_MFR_IIN_MAX	0xa2
-#define BPARS600_MFR_PIN_MAX	0xa3
-#define BPARS600_MFR_VOUT_MIN	0xa4
-#define BPARS600_MFR_VOUT_MAX	0xa5
-#define BPARS600_MFR_IOUT_MAX	0xa6
-#define BPARS600_MFR_POUT_MAX	0xa7
-
 enum chips { bpa_rs600, bpd_rs600 };
=20
 static int bpa_rs600_read_byte_data(struct i2c_client *client, int page,=
 int reg)
@@ -83,29 +74,13 @@ static int bpa_rs600_read_word_data(struct i2c_client=
 *client, int page, int pha
=20
 	switch (reg) {
 	case PMBUS_VIN_UV_WARN_LIMIT:
-		ret =3D pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_VIN_MIN);
-		break;
 	case PMBUS_VIN_OV_WARN_LIMIT:
-		ret =3D pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_VIN_MAX);
-		break;
 	case PMBUS_VOUT_UV_WARN_LIMIT:
-		ret =3D pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_VOUT_MIN);
-		break;
 	case PMBUS_VOUT_OV_WARN_LIMIT:
-		ret =3D pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_VOUT_MAX);
-		break;
 	case PMBUS_IIN_OC_WARN_LIMIT:
-		ret =3D pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_IIN_MAX);
-		break;
 	case PMBUS_IOUT_OC_WARN_LIMIT:
-		ret =3D pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_IOUT_MAX);
-		break;
 	case PMBUS_PIN_OP_WARN_LIMIT:
-		ret =3D pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_PIN_MAX);
-		break;
 	case PMBUS_POUT_OP_WARN_LIMIT:
-		ret =3D pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_POUT_MAX);
-		break;
 	case PMBUS_VIN_UV_FAULT_LIMIT:
 	case PMBUS_VIN_OV_FAULT_LIMIT:
 	case PMBUS_VOUT_UV_FAULT_LIMIT:
--=20
2.32.0

