Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBEA03333E4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 04:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhCJDg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 22:36:59 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:49570 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhCJDg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 22:36:27 -0500
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7E1CB806B5;
        Wed, 10 Mar 2021 16:36:23 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1615347383;
        bh=7bckZETHXVmIMlRNKb3dK3NE3KdWhKUje9CIs3GHUcc=;
        h=From:To:Cc:Subject:Date;
        b=GUnjdf82sri+QL3BMM4alz3djQ1s0eMK+jvOXC1hT49SvHs+W4Suz4Qw2QsP6ejXZ
         ef/7NnX3Egqz+uTFPHYDEIVpvfHv+16MV8RRDLwzaX/W5iVqJtXfYVtHdADaZ8P+KD
         K/sM84x2sUcNMlOJ8Yc+5DjIy+8HH76uL7QCtG2zrYL3pQcw+5Gy6jS8ZhfD04ULHj
         +f0OyQFCtoPO09W8G0RwDHpG3k5wM4zspgJOph/bf916xMfV9BRgyDcKDpKXK7LUbd
         0C3chHpbiWOXz0vKhkvX4t+95GXfIeR/t3noDTWpw1BgXMbl3aIc9jbJ6IswBsMJqz
         0hy8wygEN0iSw==
Received: from smtp (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B60483eb70000>; Wed, 10 Mar 2021 16:36:23 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id B03D513EEFA;
        Wed, 10 Mar 2021 16:36:35 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 45B3E2840A0; Wed, 10 Mar 2021 16:36:23 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] hwmon: (adm9240): Don't re-read config/limits
Date:   Wed, 10 Mar 2021 16:36:18 +1300
Message-Id: <20210310033618.29354-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=C7uXNjH+ c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=dESyimp9J3IA:10 a=VwQbUJbxAAAA:8 a=l7mOSMfaaC0OoaFJrU8A:9 a=AjGcO6oz07-iQ99wixmX:22 a=BPzZvq435JnGatEyYwdK:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hwmon chip is configured either via sysfs or by an earlier boot
stage (e.g. bootloader/bios). In the sysfs case we already store the
configuration values before it's written to the device. Reading in the
configuration only needs to be done once at probe time to cover the
second case.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

This doesn't resolve my ongoing i2c issues[0] but avoiding unnecessary
i2c reads will help a bit (it'll certainly avoid errors where the
threshold spontaneously changes).

[0] - https://lore.kernel.org/lkml/8e0a88ba-01e9-9bc1-c78b-20f26ce27d12@a=
lliedtelesis.co.nz/

 drivers/hwmon/adm9240.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
index cc3e0184e720..7e1258b20b35 100644
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -128,7 +128,6 @@ struct adm9240_data {
 	struct mutex update_lock;
 	char valid;
 	unsigned long last_updated_measure;
-	unsigned long last_updated_config;
=20
 	u8 in[6];		/* ro	in0_input */
 	u8 in_max[6];		/* rw	in0_max */
@@ -282,21 +281,11 @@ static struct adm9240_data *adm9240_update_device(s=
truct device *dev)
 			return ERR_PTR(err);
 		}
 		data->last_updated_measure =3D jiffies;
-	}
-
-	/* minimum config reading cycle: 300 seconds */
-	if (time_after(jiffies, data->last_updated_config + (HZ * 300))
-			|| !data->valid) {
-		err =3D adm9240_update_config(data);
-		if (err < 0) {
-			data->valid =3D 0;
-			mutex_unlock(&data->update_lock);
-			return ERR_PTR(err);
-		}
-		data->last_updated_config =3D jiffies;
 		data->valid =3D 1;
 	}
+
 	mutex_unlock(&data->update_lock);
+
 	return data;
 }
=20
@@ -855,7 +844,15 @@ static int adm9240_probe(struct i2c_client *new_clie=
nt)
 							   new_client->name,
 							   data,
 							   adm9240_groups);
-	return PTR_ERR_OR_ZERO(hwmon_dev);
+	if (IS_ERR(hwmon_dev))
+		return PTR_ERR(hwmon_dev);
+
+	/* pull in configuration from an earlier boot stage */
+	err =3D adm9240_update_config(data);
+	if (err < 0)
+		return err;
+
+	return 0;
 }
=20
 static const struct i2c_device_id adm9240_id[] =3D {
--=20
2.30.1

