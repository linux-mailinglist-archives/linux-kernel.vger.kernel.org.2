Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7353E892C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 06:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbhHKESM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 00:18:12 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:53188 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhHKESJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 00:18:09 -0400
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id AD978806B5;
        Wed, 11 Aug 2021 16:17:42 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1628655462;
        bh=zY/r5/Mbf6X14pD7Q4jPjaZwhXArLWVqXzVJzNwZMD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=n2q5mC5f/4dGfD0eJ+3NfksrxKujfHz1eXp8fRCstlAqu+gQciqag2mBZi7i2vIYf
         LpSRNNhxGXUmtogt5SB+iqmTJIyxKyUATMph4zroqXX8HErFXtn7vsSElKDlJV/Bhf
         q3g8W90Xsn4qgyoftTND2G9wrea4N0nUeFUFWxjX2IKuXJ/Sarsk+hfYJ8ZGht1Y9k
         aJUJc4TM1qpbWH5fHtw8n/HYYGU2Gjh1fpLLFPYAuRqTx0VgM1kjpjzV0smNi6IBvC
         SSUYnKBltFFO/8d9hBu6DUlGuQuHNjfExVA+qTNxwVYhgg4Q/DCvI34l8FfMGK0SUX
         lUTZyj+n8Qnpg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B61134f660001>; Wed, 11 Aug 2021 16:17:42 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by pat.atlnz.lc (Postfix) with ESMTP id 814B413EEBA;
        Wed, 11 Aug 2021 16:17:42 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 7FA6C280E9D; Wed, 11 Aug 2021 16:17:42 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 1/2] hwmon: (pmbus/bpa-rs600) Remove duplicate defininitions
Date:   Wed, 11 Aug 2021 16:17:37 +1200
Message-Id: <20210811041738.15061-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811041738.15061-1-chris.packham@alliedtelesis.co.nz>
References: <20210811041738.15061-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=aqTM9hRV c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=MhDmnRu9jo8A:10 a=pxMBM-NojlBncj9kh8YA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 787c095edaa9 ("hwmon: (pmbus/core) Add support for rated
attributes") added definitions for MFR_VIN_MIN etc so we can remove the
local definitions of these from the bpa-rs600 driver.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/hwmon/pmbus/bpa-rs600.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/hwmon/pmbus/bpa-rs600.c b/drivers/hwmon/pmbus/bpa-rs=
600.c
index d205b41540ce..d495faa89799 100644
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
@@ -83,28 +74,28 @@ static int bpa_rs600_read_word_data(struct i2c_client=
 *client, int page, int pha
=20
 	switch (reg) {
 	case PMBUS_VIN_UV_WARN_LIMIT:
-		ret =3D pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_VIN_MIN);
+		ret =3D pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_VIN_MIN);
 		break;
 	case PMBUS_VIN_OV_WARN_LIMIT:
-		ret =3D pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_VIN_MAX);
+		ret =3D pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_VIN_MAX);
 		break;
 	case PMBUS_VOUT_UV_WARN_LIMIT:
-		ret =3D pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_VOUT_MIN);
+		ret =3D pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_VOUT_MIN);
 		break;
 	case PMBUS_VOUT_OV_WARN_LIMIT:
-		ret =3D pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_VOUT_MAX);
+		ret =3D pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_VOUT_MAX);
 		break;
 	case PMBUS_IIN_OC_WARN_LIMIT:
-		ret =3D pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_IIN_MAX);
+		ret =3D pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_IIN_MAX);
 		break;
 	case PMBUS_IOUT_OC_WARN_LIMIT:
-		ret =3D pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_IOUT_MAX);
+		ret =3D pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_IOUT_MAX);
 		break;
 	case PMBUS_PIN_OP_WARN_LIMIT:
-		ret =3D pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_PIN_MAX);
+		ret =3D pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_PIN_MAX);
 		break;
 	case PMBUS_POUT_OP_WARN_LIMIT:
-		ret =3D pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_POUT_MAX);
+		ret =3D pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_POUT_MAX);
 		break;
 	case PMBUS_VIN_UV_FAULT_LIMIT:
 	case PMBUS_VIN_OV_FAULT_LIMIT:
--=20
2.32.0

