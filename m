Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF34841ABE5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239986AbhI1Jca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239865AbhI1JcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:32:21 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383FAC061769;
        Tue, 28 Sep 2021 02:30:38 -0700 (PDT)
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 201DD6BF;
        Tue, 28 Sep 2021 02:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1632821030;
        bh=ZxYTBGMf5cIw6CXTGFSPXVUjDJpCAz1J+TK7EcfCnxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KrLB+A9L4btJVsG1iAWONbdqkvmpYXQZQSXywHbjdTTxXDeVIB0Pje3O9e+ALgULG
         0b2YA63vycTptTY5hMndh6zzg2xH0FejMCtrx1AQ5y0sFNNKJdsSyQzQ1kmMpC1Rle
         nbVguI1jOnsOw/jri+hf3fo2c5PtUDdSaRaLh5A8=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] hwmon: (pmbus/lm25066) Add offset coefficients
Date:   Tue, 28 Sep 2021 02:22:35 -0700
Message-Id: <20210928092242.30036-2-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928092242.30036-1-zev@bewilderbeest.net>
References: <20210928092242.30036-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the exception of the lm5066i, all the devices handled by this
driver had been missing their offset ('b') coefficients for direct
format readings.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/hwmon/pmbus/lm25066.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
index d209e0afc2ca..1a660c4cd19f 100644
--- a/drivers/hwmon/pmbus/lm25066.c
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -55,22 +55,27 @@ static struct __coeff lm25066_coeff[6][PSC_NUM_CLASSES + 2] = {
 	[lm25056] = {
 		[PSC_VOLTAGE_IN] = {
 			.m = 16296,
+			.b = 1343,
 			.R = -2,
 		},
 		[PSC_CURRENT_IN] = {
 			.m = 13797,
+			.b = -1833,
 			.R = -2,
 		},
 		[PSC_CURRENT_IN_L] = {
 			.m = 6726,
+			.b = -537,
 			.R = -2,
 		},
 		[PSC_POWER] = {
 			.m = 5501,
+			.b = -2908,
 			.R = -3,
 		},
 		[PSC_POWER_L] = {
 			.m = 26882,
+			.b = -5646,
 			.R = -4,
 		},
 		[PSC_TEMPERATURE] = {
@@ -82,26 +87,32 @@ static struct __coeff lm25066_coeff[6][PSC_NUM_CLASSES + 2] = {
 	[lm25066] = {
 		[PSC_VOLTAGE_IN] = {
 			.m = 22070,
+			.b = -1800,
 			.R = -2,
 		},
 		[PSC_VOLTAGE_OUT] = {
 			.m = 22070,
+			.b = -1800,
 			.R = -2,
 		},
 		[PSC_CURRENT_IN] = {
 			.m = 13661,
+			.b = -5200,
 			.R = -2,
 		},
 		[PSC_CURRENT_IN_L] = {
 			.m = 6852,
+			.b = -3100,
 			.R = -2,
 		},
 		[PSC_POWER] = {
 			.m = 736,
+			.b = -3300,
 			.R = -2,
 		},
 		[PSC_POWER_L] = {
 			.m = 369,
+			.b = -1900,
 			.R = -2,
 		},
 		[PSC_TEMPERATURE] = {
@@ -111,26 +122,32 @@ static struct __coeff lm25066_coeff[6][PSC_NUM_CLASSES + 2] = {
 	[lm5064] = {
 		[PSC_VOLTAGE_IN] = {
 			.m = 4611,
+			.b = -642,
 			.R = -2,
 		},
 		[PSC_VOLTAGE_OUT] = {
 			.m = 4621,
+			.b = 423,
 			.R = -2,
 		},
 		[PSC_CURRENT_IN] = {
 			.m = 10742,
+			.b = 1552,
 			.R = -2,
 		},
 		[PSC_CURRENT_IN_L] = {
 			.m = 5456,
+			.b = 2118,
 			.R = -2,
 		},
 		[PSC_POWER] = {
 			.m = 1204,
+			.b = 8524,
 			.R = -3,
 		},
 		[PSC_POWER_L] = {
 			.m = 612,
+			.b = 11202,
 			.R = -3,
 		},
 		[PSC_TEMPERATURE] = {
@@ -140,26 +157,32 @@ static struct __coeff lm25066_coeff[6][PSC_NUM_CLASSES + 2] = {
 	[lm5066] = {
 		[PSC_VOLTAGE_IN] = {
 			.m = 4587,
+			.b = -1200,
 			.R = -2,
 		},
 		[PSC_VOLTAGE_OUT] = {
 			.m = 4587,
+			.b = -2400,
 			.R = -2,
 		},
 		[PSC_CURRENT_IN] = {
 			.m = 10753,
+			.b = -1200,
 			.R = -2,
 		},
 		[PSC_CURRENT_IN_L] = {
 			.m = 5405,
+			.b = -600,
 			.R = -2,
 		},
 		[PSC_POWER] = {
 			.m = 1204,
+			.b = -6000,
 			.R = -3,
 		},
 		[PSC_POWER_L] = {
 			.m = 605,
+			.b = -8000,
 			.R = -3,
 		},
 		[PSC_TEMPERATURE] = {
-- 
2.33.0

