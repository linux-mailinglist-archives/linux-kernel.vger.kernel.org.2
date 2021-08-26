Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4DF3F8098
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 04:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbhHZCmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 22:42:46 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:38954 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237045AbhHZCm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 22:42:26 -0400
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 40AD1806AC;
        Thu, 26 Aug 2021 14:41:24 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1629945684;
        bh=0rW2k728ciTrSnA12zXAq0w7JU6XO0g6n5WMUokHiQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=C8ciRDEfhweESW5s83/hW/uigWCVGihoXgN7eCTETR2jZk+dik4HtN+yLGX+6zcQt
         rVSJmnk71Y+lhpblFnI3z5VpGi/GYDrvVTZNWLPCiw3d4Orv1CSvTSwbdu20QOAxIJ
         YTbpF55mnHGnDrQOF1bn/fVr5RVqscm7HjvdeTTvBOpaEJhCurNa/RLfmdlQaubTFJ
         ELWsHQM9IRq66CE09QgDKWTK8kc5+hKlgxhOnbcDoGA9fAm78hQAZpt+U6I8ajmFZ9
         /jmTxbrokZUQOHcscxj38Iw9p6Pcsr3XHRDsPZsCgfeVsPb4acMjraT3g/npWXBhhK
         HW+5OipzHYuAA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6126ff540000>; Thu, 26 Aug 2021 14:41:24 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by pat.atlnz.lc (Postfix) with ESMTP id 1979A13ED4A;
        Thu, 26 Aug 2021 14:41:24 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 171B6284585; Thu, 26 Aug 2021 14:41:24 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 1/4] hwmon: (adt7470) Fix some style issues
Date:   Thu, 26 Aug 2021 14:41:18 +1200
Message-Id: <20210826024121.15665-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210826024121.15665-1-chris.packham@alliedtelesis.co.nz>
References: <20210826024121.15665-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=aqTM9hRV c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=MhDmnRu9jo8A:10 a=ERBDFvpX12xl-n7rS-AA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for the changes that follow fix up some existing style
issues.
Specifically:
- add blank line between variable declaration and code
- use strscpy instead of strlcpy
- remove unnecessary braces

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Changes in v2:
- new

 drivers/hwmon/adt7470.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 2e8feacccf84..3358ec58b977 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -174,6 +174,7 @@ struct adt7470_data {
 static inline int adt7470_read_word_data(struct i2c_client *client, u8 r=
eg)
 {
 	u16 foo;
+
 	foo =3D i2c_smbus_read_byte_data(client, reg);
 	foo |=3D ((u16)i2c_smbus_read_byte_data(client, reg + 1) << 8);
 	return foo;
@@ -1282,7 +1283,7 @@ static int adt7470_detect(struct i2c_client *client=
,
 	if (revision !=3D ADT7470_REVISION)
 		return -ENODEV;
=20
-	strlcpy(info->type, "adt7470", I2C_NAME_SIZE);
+	strscpy(info->type, "adt7470", I2C_NAME_SIZE);
=20
 	return 0;
 }
@@ -1331,9 +1332,8 @@ static int adt7470_probe(struct i2c_client *client)
=20
 	data->auto_update =3D kthread_run(adt7470_update_thread, client, "%s",
 					dev_name(hwmon_dev));
-	if (IS_ERR(data->auto_update)) {
+	if (IS_ERR(data->auto_update))
 		return PTR_ERR(data->auto_update);
-	}
=20
 	return 0;
 }
--=20
2.32.0

