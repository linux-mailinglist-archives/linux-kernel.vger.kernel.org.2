Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB7D41ABE4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239977AbhI1Jc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239872AbhI1JcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:32:21 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38445C06176A;
        Tue, 28 Sep 2021 02:30:38 -0700 (PDT)
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 8E31BC20;
        Tue, 28 Sep 2021 02:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1632821031;
        bh=4P1wdSQkXGcDVZjSddgG/Ut0TaQpsgcZ1xCEifRgdLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SXKRjKb68YYJoMFO3J1WS1iQQIDZRigDhx/NvjvXE2QzSUyo/wyRPBiDY94J73QLm
         D32qEWdfU1WQIgwyUsFqXchiZ6s0T5J6RUWRNHpXf3kJt/8bSyJOlfm/jSqePwgfGe
         k+gPbM71LrCV75fA+Yvgm4h58kNG8TlH0IOpgVbA=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] hwmon: (pmbus/lm25066) Mark lm25066_coeff array const
Date:   Tue, 28 Sep 2021 02:22:39 -0700
Message-Id: <20210928092242.30036-6-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928092242.30036-1-zev@bewilderbeest.net>
References: <20210928092242.30036-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/hwmon/pmbus/lm25066.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
index 1ff5407b6977..dbbf8571c437 100644
--- a/drivers/hwmon/pmbus/lm25066.c
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -51,7 +51,7 @@ struct __coeff {
 #define PSC_CURRENT_IN_L	(PSC_NUM_CLASSES)
 #define PSC_POWER_L		(PSC_NUM_CLASSES + 1)
 
-static struct __coeff lm25066_coeff[][PSC_NUM_CLASSES + 2] = {
+static const struct __coeff lm25066_coeff[][PSC_NUM_CLASSES + 2] = {
 	[lm25056] = {
 		[PSC_VOLTAGE_IN] = {
 			.m = 16296,
@@ -449,7 +449,7 @@ static int lm25066_probe(struct i2c_client *client)
 	int config;
 	struct lm25066_data *data;
 	struct pmbus_driver_info *info;
-	struct __coeff *coeff;
+	const struct __coeff *coeff;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_READ_BYTE_DATA))
-- 
2.33.0

