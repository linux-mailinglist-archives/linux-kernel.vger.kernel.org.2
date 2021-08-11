Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA3F3E95B3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 18:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhHKQQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 12:16:16 -0400
Received: from mail.ispras.ru ([83.149.199.84]:32874 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhHKQQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 12:16:14 -0400
Received: from kleverstation.intra.ispras.ru (unknown [10.10.2.220])
        by mail.ispras.ru (Postfix) with ESMTPS id 359C2407625F;
        Wed, 11 Aug 2021 16:15:49 +0000 (UTC)
From:   Nadezda Lutovinova <lutovinova@ispras.ru>
To:     Marc Hulsman <m.hulsman@tudelft.nl>
Cc:     Nadezda Lutovinova <lutovinova@ispras.ru>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rudolf Marek <r.marek@assembler.cz>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] hwmon: Correct the error handling in w83793.c, w83791d.c, w83792d.c
Date:   Wed, 11 Aug 2021 19:15:15 +0300
Message-Id: <20210811161515.17842-2-lutovinova@ispras.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210811161515.17842-1-lutovinova@ispras.ru>
References: <20210811161515.17842-1-lutovinova@ispras.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If driver read tmp (or val) value sufficient for 
(tmp & 0x08) && (!(tmp & 0x80)) && ((tmp & 0x7) == ((tmp >> 4) & 0x7))
from device then Null pointer dereference occurs. 
(It is possible if tmp = 0b0xyz1xyz, where same literals mean same numbers)

The patch adds checking if data->lm75[0] is NULL.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Nadezda Lutovinova <lutovinova@ispras.ru>
---
 drivers/hwmon/w83791d.c | 2 +-
 drivers/hwmon/w83792d.c | 2 +-
 drivers/hwmon/w83793.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
index 37b25a1474c4..8b30bbfafaa7 100644
--- a/drivers/hwmon/w83791d.c
+++ b/drivers/hwmon/w83791d.c
@@ -1284,7 +1284,7 @@ static int w83791d_detect_subclients(struct i2c_client *client)
 		data->lm75[0] = devm_i2c_new_dummy_device(&client->dev, adapter,
 							  0x48 + (val & 0x7));
 	if (!(val & 0x80)) {
-		if (!IS_ERR(data->lm75[0]) &&
+		if (!IS_ERR_OR_NULL(data->lm75[0]) &&
 				((val & 0x7) == ((val >> 4) & 0x7))) {
 			dev_err(&client->dev,
 				"duplicate addresses 0x%x, "
diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
index abd5c3a722b9..85ae12d950e1 100644
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -950,7 +950,7 @@ w83792d_detect_subclients(struct i2c_client *new_client)
 		data->lm75[0] = devm_i2c_new_dummy_device(&new_client->dev, adapter,
 							  0x48 + (val & 0x7));
 	if (!(val & 0x80)) {
-		if (!IS_ERR(data->lm75[0]) &&
+		if (!IS_ERR_OR_NULL(data->lm75[0]) &&
 			((val & 0x7) == ((val >> 4) & 0x7))) {
 			dev_err(&new_client->dev,
 				"duplicate addresses 0x%x, use force_subclient\n",
diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index e7d0484eabe4..9d8c44e2fa6e 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -1590,7 +1590,7 @@ w83793_detect_subclients(struct i2c_client *client)
 		data->lm75[0] = devm_i2c_new_dummy_device(&client->dev, adapter,
 							  0x48 + (tmp & 0x7));
 	if (!(tmp & 0x80)) {
-		if (!IS_ERR(data->lm75[0])
+		if (!IS_ERR_OR_NULL(data->lm75[0])
 		    && ((tmp & 0x7) == ((tmp >> 4) & 0x7))) {
 			dev_err(&client->dev,
 				"duplicate addresses 0x%x, "
-- 
2.17.1

