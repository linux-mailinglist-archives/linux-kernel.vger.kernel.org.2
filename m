Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904B630948B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 11:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhA3Kkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 05:40:31 -0500
Received: from lnfm1.sai.msu.ru ([93.180.26.255]:57731 "EHLO lnfm1.sai.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231184AbhA3KkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 05:40:24 -0500
Received: from dragon.sai.msu.ru (dragon.sai.msu.ru [93.180.26.172])
        by lnfm1.sai.msu.ru (8.14.1/8.12.8) with ESMTP id 10UAdAc3015774;
        Sat, 30 Jan 2021 13:39:15 +0300
Received: from oak.local (unknown [83.167.113.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by dragon.sai.msu.ru (Postfix) with ESMTPSA id 0AECEF176;
        Sat, 30 Jan 2021 13:39:11 +0300 (MSK)
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING),
        linux-kernel@vger.kernel.org (open list)
Cc:     matwey.kornilov@gmail.com,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] hwmon: lm75: Add another name for NXP LM75B to of_match list
Date:   Sat, 30 Jan 2021 13:38:23 +0300
Message-Id: <20210130103823.28914-2-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210130103823.28914-1-matwey@sai.msu.ru>
References: <20210130103823.28914-1-matwey@sai.msu.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NXP LM75B is compatible with original LM75A while it has improved
11-bit precision.

https://www.nxp.com/docs/en/data-sheet/LM75B.pdf

NXP LM75B support was added in

    799fc6021430 ("hwmon: (lm75) Add support for the NXP LM75B")

OF compatible string "national,lm75b" for LM75B was created in

    e97a45f1b460 ("hwmon: (lm75) Add OF device ID table")

Since the previous commit introduces "nxp,lm75a" compatible string
for LM75A, there is a reason to add another alias for LM75B.

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/hwmon/lm75.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 37dc903ebf54..6cd951e062f0 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -703,6 +703,10 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
 		.compatible = "nxp,lm75a",
 		.data = (void *)lm75b
 	},
+	{
+		.compatible = "nxp,lm75b",
+		.data = (void *)lm75b
+	},
 	{
 		.compatible = "maxim,max6625",
 		.data = (void *)max6625
-- 
2.26.2

