Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0EB458061
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 21:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbhKTUoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 15:44:05 -0500
Received: from o1.ptr2625.egauge.net ([167.89.112.53]:11660 "EHLO
        o1.ptr2625.egauge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbhKTUoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 15:44:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
        h=from:subject:mime-version:to:cc:content-transfer-encoding:
        content-type;
        s=sgd; bh=TX0xMK7GUHeUHHgqvA7VUH7LvFvvcMijgypAUYumTPY=;
        b=PRzV3HRumRhNL2QCdqPIgcQkEHl7J8k0T/kU4bVM6FG4z0bwmcpxJGN1oCyMGNOv6vB8
        lPiFvBZK3mcBHhsVtx2FPETym3neIwng/P9OyYYrmsG70cwnaXMkx9fejb9HxF0SE+mwXn
        h/1156OZuNC0HkgLunphzrkYnMWhKvLoqjal/A11k6jJqihtCkw7sZ0RUZGXk85sBtpYQB
        dtn8jT/M9jpgxl/8gGwYLUDWeIsxUcJVGyrxaDE/7BCoAAZLMQuiN4PMf9ErxmtGlJ8cPn
        HtFSHL/GB5ppAp7SpZA3aeXEjrtZIdjDkxBlBsOhY0swEVF9rdg5raNVqd0mcCCQ==
Received: by filterdrecv-7bf5c69d5-jxm6x with SMTP id filterdrecv-7bf5c69d5-jxm6x-1-61995D5B-7
        2021-11-20 20:40:59.145356176 +0000 UTC m=+6906061.958094009
Received: from pearl.egauge.net (unknown)
        by ismtpd0042p1las1.sendgrid.net (SG) with ESMTP
        id BPmmfSTPSjq3FPLcfaGSbQ
        Sat, 20 Nov 2021 20:40:59.074 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
        id CE177700297; Sat, 20 Nov 2021 13:40:56 -0700 (MST)
From:   David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH v2 1/2] hwmon: (sht4x) Fix EREMOTEIO errors
Date:   Sat, 20 Nov 2021 20:40:59 +0000 (UTC)
Message-Id: <20211120204053.2299501-1-davidm@egauge.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvNCdZvxvLzeFcCF9f?=
 =?us-ascii?Q?FHFLCDGCVt+b=2FJttFPlyMhyUXmh619RzI9X6vXj?=
 =?us-ascii?Q?tVRfRVk2hOKpdqteH4BxVGzEi6nqXjKTS3uZl1s?=
 =?us-ascii?Q?UQbKE0DfogGE+V=2FdKmmJEWhDBfHU3zNPLzkd+yA?=
 =?us-ascii?Q?slzaNLBzWKjnlUgdptfGg9IjrmjcQqSxXIHqAio?=
 =?us-ascii?Q?YKJpfJXtQ32ARL7iqj9OA=3D=3D?=
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

