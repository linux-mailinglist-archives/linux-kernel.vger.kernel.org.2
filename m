Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA7C4536C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 17:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238805AbhKPQHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 11:07:37 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:45788 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238820AbhKPQGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 11:06:52 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AG7FCiW005416;
        Tue, 16 Nov 2021 10:03:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=wtR/S16kh0dxL/tCa9AfNyWpssNmTbifcATxl0gQQlc=;
 b=Vu26Wqd0p9YjAL+2Xk+tS+ZtAkuJBI0aHGrTqugA6Zs2ztS+zxWL/UlGFBTPVKFJTbfU
 xkJRrLF5njYhghckKhZO1uyI8dmmOIiNvQ+IEOoRZvxW60kNU0K+f08oUPLn91DsmtHR
 s91yp7Xh1AdSfsKWN2Jj1ZvyEL4HkgP82NAKQYJfe05CSlWJz5NIUg9d6goZeaUGTuY4
 0Y7cuS5VQZiQ5cje9sxvNxT99cib6jt7L+p88Fb31tvx9v6Kd9YncKLZZdYgoCYAhnEu
 B7PanAhH0VJEDW3VLTHKoUFpla5Q7XWUJ4mHOxOUw1DgmfbmotvkQLvWrwWiQmyYi5aX Jw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cbdjgt241-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Nov 2021 10:03:47 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 16 Nov
 2021 16:03:41 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 16 Nov 2021 16:03:41 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9D49D11DB;
        Tue, 16 Nov 2021 16:03:41 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mfd: arizona: Add missing statics to the of_match_tables
Date:   Tue, 16 Nov 2021 16:03:41 +0000
Message-ID: <20211116160341.27865-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: An8gWad6DQQep5Fe82vwer8UfYvi9pnq
X-Proofpoint-GUID: An8gWad6DQQep5Fe82vwer8UfYvi9pnq
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the match tables were split for I2C and SPI a static should have
been added since the tables are no longer exported.

Fixes: 3f65555c417c ("mfd: arizona: Split of_match table into I2C and SPI versions")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/arizona-i2c.c | 2 +-
 drivers/mfd/arizona-spi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/arizona-i2c.c b/drivers/mfd/arizona-i2c.c
index 3ed810e81f631..6d83e6b9a692d 100644
--- a/drivers/mfd/arizona-i2c.c
+++ b/drivers/mfd/arizona-i2c.c
@@ -105,7 +105,7 @@ static const struct i2c_device_id arizona_i2c_id[] = {
 MODULE_DEVICE_TABLE(i2c, arizona_i2c_id);
 
 #ifdef CONFIG_OF
-const struct of_device_id arizona_i2c_of_match[] = {
+static const struct of_device_id arizona_i2c_of_match[] = {
 	{ .compatible = "wlf,wm5102", .data = (void *)WM5102 },
 	{ .compatible = "wlf,wm5110", .data = (void *)WM5110 },
 	{ .compatible = "wlf,wm8280", .data = (void *)WM8280 },
diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
index 9fe06dda37829..98c87d3bd00fa 100644
--- a/drivers/mfd/arizona-spi.c
+++ b/drivers/mfd/arizona-spi.c
@@ -226,7 +226,7 @@ static const struct spi_device_id arizona_spi_ids[] = {
 MODULE_DEVICE_TABLE(spi, arizona_spi_ids);
 
 #ifdef CONFIG_OF
-const struct of_device_id arizona_spi_of_match[] = {
+static const struct of_device_id arizona_spi_of_match[] = {
 	{ .compatible = "wlf,wm5102", .data = (void *)WM5102 },
 	{ .compatible = "wlf,wm5110", .data = (void *)WM5110 },
 	{ .compatible = "wlf,wm8280", .data = (void *)WM8280 },
-- 
2.11.0

