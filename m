Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00AD45849E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 17:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbhKUQKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 11:10:09 -0500
Received: from o1.ptr2625.egauge.net ([167.89.112.53]:27954 "EHLO
        o1.ptr2625.egauge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhKUQKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 11:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
        h=from:subject:mime-version:to:cc:content-transfer-encoding:
        content-type;
        s=sgd; bh=+6eAYYS1zGVdyeCag4dsRhNxxP3Pce/RMzvHMKYoPqE=;
        b=nTPVZH6o+ZW9I9tfGdVfYEgbjIAUExRCJBMSg6UCg/Ix8TkvzMYoevySFpdaHjJZPzco
        iQW+4hh1aQlhjquMgp7pyvgykdUI3me/30To/VWbGDrnN566xU2HLyKvUQuYEDzDmkXP/Q
        kWrrHstS5QSUbe0ek3ScgKKFI6c+5RmirgP+rI4zc3oUGPGX4bDWV5e/d0kNCYnX/kTf4z
        a6u6bab3k+Y8k+IPXRO6xoGTQ5vQCqDnqk5KcfcMRq0l0sNJGU+Vx8VrHoNq3UTvGWvHIO
        QeJFl7oybCDtefJkpuQFWpQwmb25hGGasL4Hs9tBnseCw5TrKQQKjMg2Bsa3lXuQ==
Received: by filterdrecv-7bf5c69d5-ckn2p with SMTP id filterdrecv-7bf5c69d5-ckn2p-1-619A6EA6-2D
        2021-11-21 16:07:02.407210084 +0000 UTC m=+6976002.270461382
Received: from pearl.egauge.net (unknown)
        by geopod-ismtpd-3-0 (SG)
        with ESMTP
        id L3hssTnOT82k7db98nqgig
        Sun, 21 Nov 2021 16:07:02.265 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
        id BC11B700479; Sun, 21 Nov 2021 09:07:01 -0700 (MST)
From:   David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH] hwmon: (sht4x) Add device tree match table
Date:   Sun, 21 Nov 2021 16:07:02 +0000 (UTC)
Message-Id: <20211121160637.2312106-1-davidm@egauge.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvBjwDxJhsTdt2+w8T?=
 =?us-ascii?Q?2ZJXZyNCtjHkCjO0qDnyrd+XD1XbSrphSwxu8yj?=
 =?us-ascii?Q?BJg8T79lJC5LOMlgOvQs0XDpEhYnzOMaaGe1V24?=
 =?us-ascii?Q?e3NYVr9bGht5DcoUoJiLd2l=2FswBKhAIecZ=2FUMSh?=
 =?us-ascii?Q?HobQPisPycWHOJfbW16MAkZqENAFiVzFPNJR0Hn?=
 =?us-ascii?Q?niMde8zuApU+kaNTR+S9w=3D=3D?=
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Navin Sankar Velliangiri <navin@linumiz.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Mosberger-Tang <davidm@egauge.net>
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables automatic loading of the sht4x module via a device
tree table entry.

Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
---
 drivers/hwmon/sht4x.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwmon/sht4x.c b/drivers/hwmon/sht4x.c
index 3415d7a0e0fc..6e53d81e32d4 100644
--- a/drivers/hwmon/sht4x.c
+++ b/drivers/hwmon/sht4x.c
@@ -281,9 +281,16 @@ static const struct i2c_device_id sht4x_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, sht4x_id);
 
+static const struct of_device_id sht4x_of_match[] = {
+	{ .compatible = "sensirion,sht4x" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sht4x_of_match);
+
 static struct i2c_driver sht4x_driver = {
 	.driver = {
 		.name = "sht4x",
+		.of_match_table = sht4x_of_match
 	},
 	.probe		= sht4x_probe,
 	.id_table	= sht4x_id,
-- 
2.25.1

