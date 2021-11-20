Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D73458078
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 22:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbhKTVcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 16:32:06 -0500
Received: from o1.ptr2625.egauge.net ([167.89.112.53]:32378 "EHLO
        o1.ptr2625.egauge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbhKTVcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 16:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
        h=from:subject:in-reply-to:references:mime-version:reply-to:to:cc:
        content-transfer-encoding:content-type;
        s=sgd; bh=TX0xMK7GUHeUHHgqvA7VUH7LvFvvcMijgypAUYumTPY=;
        b=Rg/vYNUkq/hnv6UwFuocRuZDYx0CFfHICROe52WcHWmFbkfGFdxgALA7v55DN6I3l4gM
        12Yjd5jQAbBGye2rEhvnKMWwHNCjxH+VweDztQCmhDCCcw+t1i5Yj/PW0A4YD3WXR2pRCQ
        hsuVwJQQerG+Qrr2Qf5uizGCVa/qkcmyROmCcfuP7PavuntbaE4dSyHISkBcpn/GAy0dtt
        twRBZ4uFC0aY+ged+X9xEBgNAW09uWcpA9gZUe1XY1nU3+PPUiZw4MPvbyy0YwteKV7YVv
        Wk/g6wapuM1P0kwRqQRPYDTwHlcuGQsw3lhUnGECWFWMDaimE6FYtq8cid8WScRA==
Received: by filterdrecv-canary-69c6c696bc-fss6r with SMTP id filterdrecv-canary-69c6c696bc-fss6r-1-61996897-23
        2021-11-20 21:28:55.881383079 +0000 UTC m=+6990229.654244211
Received: from pearl.egauge.net (unknown)
        by ismtpd0042p1las1.sendgrid.net (SG) with ESMTP
        id NP0wzBxORW6e9o_h0ReiXg
        Sat, 20 Nov 2021 21:28:55.766 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
        id 45037700297; Sat, 20 Nov 2021 14:28:55 -0700 (MST)
From:   David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH v3] hwmon: (sht4x) Fix EREMOTEIO errors
Date:   Sat, 20 Nov 2021 21:28:56 +0000 (UTC)
Message-Id: <20211120212849.2300854-2-davidm@egauge.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211120212849.2300854-1-davidm@egauge.net>
References: <20211120204053.2299501-1-davidm@egauge.net>
 <20211120212849.2300854-1-davidm@egauge.net>
MIME-Version: 1.0
Reply-To: davidm@egauge.net
X-SG-EID: =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvKwOrAY0G9qny3z3+?=
 =?us-ascii?Q?QYKFSj01SqpE+eLfFBlUZ0z2aLIJ46D1fxqWaig?=
 =?us-ascii?Q?Y5juECAfTAPIuH15dEMOeF+cLURxBHQs5kjPk77?=
 =?us-ascii?Q?XowikLT6jzcwWAQPSTlhjOMnn37Td0EMkPKWula?=
 =?us-ascii?Q?rdyz+hiG7TK=2FreNFDBFSdewHrns3lLQEm2tL7q0?=
 =?us-ascii?Q?MSQP5g2=2FslTY9OcGPoRcA=3D=3D?=
To:     Navin Sankar Velliangiri <navin@linumiz.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Mosberger-Tang <davidm@egauge.net>
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per datasheet, SHT4x may need up to 8.2ms for a "high repeatability"
measurement to complete.  Attempting to read the result too early
triggers a NAK which then causes an EREMOTEIO error.

This behavior has been confirmed with a logic analyzer while running
the I2C bus at only 40kHz.  The low frequency precludes any
signal-integrity issues, which was also confirmed by the absence of
any CRC8 errors.  In this configuration, a NAK occurred on any read
that followed the measurement command within less than 8.2ms.

Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
---
 drivers/hwmon/sht4x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/sht4x.c b/drivers/hwmon/sht4x.c
index 09c2a0b06444..3415d7a0e0fc 100644
--- a/drivers/hwmon/sht4x.c
+++ b/drivers/hwmon/sht4x.c
@@ -23,7 +23,7 @@
 /*
  * I2C command delays (in microseconds)
  */
-#define SHT4X_MEAS_DELAY	1000
+#define SHT4X_MEAS_DELAY_HPM	8200	/* see t_MEAS,h in datasheet */
 #define SHT4X_DELAY_EXTRA	10000
 
 /*
@@ -90,7 +90,7 @@ static int sht4x_read_values(struct sht4x_data *data)
 	if (ret < 0)
 		goto unlock;
 
-	usleep_range(SHT4X_MEAS_DELAY, SHT4X_MEAS_DELAY + SHT4X_DELAY_EXTRA);
+	usleep_range(SHT4X_MEAS_DELAY_HPM, SHT4X_MEAS_DELAY_HPM + SHT4X_DELAY_EXTRA);
 
 	ret = i2c_master_recv(client, raw_data, SHT4X_RESPONSE_LENGTH);
 	if (ret != SHT4X_RESPONSE_LENGTH) {
-- 
2.25.1

