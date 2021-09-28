Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACF541ABE6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239998AbhI1Jcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:32:33 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:60137 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239844AbhI1JcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:32:21 -0400
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id D6014B1A;
        Tue, 28 Sep 2021 02:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1632821031;
        bh=VBdqx6jas8pIr1PD+ePFPfJwfr9ZGcfTFBf3b03vzMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IYqp4fdlsX9u7Kdm5JsrtWc9pNTpze+dy9xFIgnDhkYNJaXESIsHmjSTvRKcucaFU
         tyC8mLEk6sOBuqPasKw1HQxa8pJMca3JbWeyl33mXW8vhkdRa++qRg5uYrD4Oq/DBD
         wMfczRyxJfzlZiCjgfMpD67kuj9sU8TV/zjyqclg=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] hwmon: (pmbus/lm25066) Avoid forward declaration of lm25066_id
Date:   Tue, 28 Sep 2021 02:22:37 -0700
Message-Id: <20210928092242.30036-4-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928092242.30036-1-zev@bewilderbeest.net>
References: <20210928092242.30036-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reordering things to put the table before the probe function
eliminates the need for it.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/hwmon/pmbus/lm25066.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
index 3616705aafde..4dc003ff859e 100644
--- a/drivers/hwmon/pmbus/lm25066.c
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -234,8 +234,6 @@ struct lm25066_data {
 
 #define to_lm25066_data(x)  container_of(x, struct lm25066_data, info)
 
-static const struct i2c_device_id lm25066_id[];
-
 static int lm25066_read_word_data(struct i2c_client *client, int page,
 				  int phase, int reg)
 {
@@ -436,6 +434,16 @@ static int lm25066_write_word_data(struct i2c_client *client, int page, int reg,
 	return ret;
 }
 
+static const struct i2c_device_id lm25066_id[] = {
+	{"lm25056", lm25056},
+	{"lm25066", lm25066},
+	{"lm5064", lm5064},
+	{"lm5066", lm5066},
+	{"lm5066i", lm5066i},
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lm25066_id);
+
 static int lm25066_probe(struct i2c_client *client)
 {
 	int config;
@@ -509,17 +517,6 @@ static int lm25066_probe(struct i2c_client *client)
 	return pmbus_do_probe(client, info);
 }
 
-static const struct i2c_device_id lm25066_id[] = {
-	{"lm25056", lm25056},
-	{"lm25066", lm25066},
-	{"lm5064", lm5064},
-	{"lm5066", lm5066},
-	{"lm5066i", lm5066i},
-	{ }
-};
-
-MODULE_DEVICE_TABLE(i2c, lm25066_id);
-
 /* This is the driver that will be inserted */
 static struct i2c_driver lm25066_driver = {
 	.driver = {
-- 
2.33.0

