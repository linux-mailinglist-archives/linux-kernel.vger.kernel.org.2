Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC06933E842
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 05:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhCQEDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 00:03:10 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:58910 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhCQECm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 00:02:42 -0400
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 79B5A891AC;
        Wed, 17 Mar 2021 17:02:38 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1615953758;
        bh=a12K+zPEEqvbw+kTBYtvqlFNXVyI1grN/iZTS6bw8WE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fVPPvTaoj0/nkQ/XrnSPon1P+dLtsOSTqs6KTKAhDji+CNUrYolZZhB9QJjAcxV1w
         ac4mgERp7LaSS93S4ISR9vuvCJO5xHuhWqge1HiPUsl8p+2Mby8zCK4x35+fp/MJjA
         QVBGic2wFudLK+jN5nOu5HP+Bfy9K9XyQ0Nt35JyQbMK1UiyhRYMLBBh6FMB4TQbN8
         oOZpCkwr46I+kvJfADvwCj9UU3mhPr3Es7jAUKJf2Lm+UX7e9jQyrvX86sGFoY7JFl
         yenXB8UQkhreADWBSzkbsCUmN4pyOWC/2tlMVqGR/s+HgCEBJvA7wQXgECHDDCe3SM
         9Hh0U1U+5djsQ==
Received: from smtp (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B60517f5e0001>; Wed, 17 Mar 2021 17:02:38 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 5538D13EF0D;
        Wed, 17 Mar 2021 17:02:52 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 3F8FE28408F; Wed, 17 Mar 2021 17:02:38 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net
Cc:     devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 2/3] hwmon: (pmbus): Replace - with _ in device names before registration
Date:   Wed, 17 Mar 2021 17:02:30 +1300
Message-Id: <20210317040231.21490-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210317040231.21490-1-chris.packham@alliedtelesis.co.nz>
References: <20210317040231.21490-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=GfppYjfL c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=dESyimp9J3IA:10 a=1n-tqguRmQ2sXLlbPzAA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hwmon sysfs ABI requires that the `name` property doesn't include
any dashes. But when the pmbus code picks the name up from the device
tree it quite often does. Replace '-' with '_' before registering the
device.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v3:
    - None
    Changes in v2:
    - New

 drivers/hwmon/pmbus/pmbus_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus=
_core.c
index aadea85fe630..7d2f8f032314 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2557,6 +2557,7 @@ int pmbus_do_probe(struct i2c_client *client, struc=
t pmbus_driver_info *info)
 	struct pmbus_data *data;
 	size_t groups_num =3D 0;
 	int ret;
+	char *name;
=20
 	if (!info)
 		return -ENODEV;
@@ -2606,10 +2607,15 @@ int pmbus_do_probe(struct i2c_client *client, str=
uct pmbus_driver_info *info)
 		return -ENODEV;
 	}
=20
+	name =3D devm_kstrdup(dev, client->name, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+	strreplace(name, '-', '_');
+
 	data->groups[0] =3D &data->group;
 	memcpy(data->groups + 1, info->groups, sizeof(void *) * groups_num);
 	data->hwmon_dev =3D devm_hwmon_device_register_with_groups(dev,
-					client->name, data, data->groups);
+					name, data, data->groups);
 	if (IS_ERR(data->hwmon_dev)) {
 		dev_err(dev, "Failed to register hwmon device\n");
 		return PTR_ERR(data->hwmon_dev);
--=20
2.30.2

