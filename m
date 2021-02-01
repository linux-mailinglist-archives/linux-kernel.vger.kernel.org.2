Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C6430B169
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 21:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhBAUJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 15:09:23 -0500
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:55342 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbhBAUJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 15:09:06 -0500
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 1932C10C3DD6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 20:59:56 +0100 (CET)
Received: from s645.loopia.se (unknown [172.22.191.6])
        by s807.loopia.se (Postfix) with ESMTP id EDC822E2C947;
        Mon,  1 Feb 2021 20:59:55 +0100 (CET)
Received: from s476.loopia.se (unknown [172.22.191.5])
        by s645.loopia.se (Postfix) with ESMTP id E23FD1579F76;
        Mon,  1 Feb 2021 20:59:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s499.loopia.se ([172.22.191.5])
        by s476.loopia.se (s476.loopia.se [172.22.190.16]) (amavisd-new, port 10024)
        with LMTP id eFwR5YIgP88x; Mon,  1 Feb 2021 20:59:55 +0100 (CET)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 155.4.131.176
Received: from localhost.localdomain (h-155-4-131-176.NA.cust.bahnhof.se [155.4.131.176])
        (Authenticated sender: carl@hgsystem.se)
        by s499.loopia.se (Postfix) with ESMTPSA id 3424F1CDE75B;
        Mon,  1 Feb 2021 20:59:55 +0100 (CET)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH 2/2] Remove unnecessary pmbus_clear_cache function call
Date:   Mon,  1 Feb 2021 20:59:29 +0100
Message-Id: <20210201195929.1200-3-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
In-Reply-To: <20210201195929.1200-1-erik.rosen@metormote.com>
References: <20210201195929.1200-1-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is no longer necessary to clear the cache to update the sensor value
from the chip.

Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
---
 drivers/hwmon/pmbus/lm25066.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
index c75a6bf39641..e9a66fd9e144 100644
--- a/drivers/hwmon/pmbus/lm25066.c
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -371,21 +371,18 @@ static int lm25066_write_word_data(struct i2c_client *client, int page, int reg,
 	case PMBUS_VIN_OV_WARN_LIMIT:
 		word = ((s16)word < 0) ? 0 : clamp_val(word, 0, data->rlimit);
 		ret = pmbus_write_word_data(client, 0, reg, word);
-		pmbus_clear_cache(client);
 		break;
 	case PMBUS_IIN_OC_WARN_LIMIT:
 		word = ((s16)word < 0) ? 0 : clamp_val(word, 0, data->rlimit);
 		ret = pmbus_write_word_data(client, 0,
 					    LM25066_MFR_IIN_OC_WARN_LIMIT,
 					    word);
-		pmbus_clear_cache(client);
 		break;
 	case PMBUS_PIN_OP_WARN_LIMIT:
 		word = ((s16)word < 0) ? 0 : clamp_val(word, 0, data->rlimit);
 		ret = pmbus_write_word_data(client, 0,
 					    LM25066_MFR_PIN_OP_WARN_LIMIT,
 					    word);
-		pmbus_clear_cache(client);
 		break;
 	case PMBUS_VIRT_VMON_UV_WARN_LIMIT:
 		/* Adjust from VIN coefficients (for LM25056) */
@@ -393,7 +390,6 @@ static int lm25066_write_word_data(struct i2c_client *client, int page, int reg,
 		word = ((s16)word < 0) ? 0 : clamp_val(word, 0, data->rlimit);
 		ret = pmbus_write_word_data(client, 0,
 					    LM25056_VAUX_UV_WARN_LIMIT, word);
-		pmbus_clear_cache(client);
 		break;
 	case PMBUS_VIRT_VMON_OV_WARN_LIMIT:
 		/* Adjust from VIN coefficients (for LM25056) */
@@ -401,7 +397,6 @@ static int lm25066_write_word_data(struct i2c_client *client, int page, int reg,
 		word = ((s16)word < 0) ? 0 : clamp_val(word, 0, data->rlimit);
 		ret = pmbus_write_word_data(client, 0,
 					    LM25056_VAUX_OV_WARN_LIMIT, word);
-		pmbus_clear_cache(client);
 		break;
 	case PMBUS_VIRT_RESET_PIN_HISTORY:
 		ret = pmbus_write_byte(client, 0, LM25066_CLEAR_PIN_PEAK);
-- 
2.20.1

