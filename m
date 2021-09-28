Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF5A41ABDB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239945AbhI1JcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239858AbhI1JcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:32:21 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83241C061765;
        Tue, 28 Sep 2021 02:30:38 -0700 (PDT)
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 750A68C0;
        Tue, 28 Sep 2021 02:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1632821030;
        bh=70fCqkVY3hCEpVjRYy+pHiM6jsyO/PA2U039v04eomg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aTxb4lgNmJSyWNkMVEA0GmCNexMqlnuXDoaxUrKIsKPaobBgZ9/4brOkpVl7ia8yK
         e4tWOg2gTd4+XoaOW1++3KC28ljK+1H0sh9qq5487U3vkAR+C2WD/u2Df2Jjt6r6/u
         ZJliqvn73+++zD3N7ORaVvQ2pryMERNANNHhNGxw=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] hwmon: (pmbus/lm25066) Adjust lm25066 PSC_CURRENT_IN_L mantissa
Date:   Tue, 28 Sep 2021 02:22:36 -0700
Message-Id: <20210928092242.30036-3-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928092242.30036-1-zev@bewilderbeest.net>
References: <20210928092242.30036-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least as of Revision J, the datasheet has a slightly different
value than what we'd had in the driver.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/hwmon/pmbus/lm25066.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
index 1a660c4cd19f..3616705aafde 100644
--- a/drivers/hwmon/pmbus/lm25066.c
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -101,7 +101,7 @@ static struct __coeff lm25066_coeff[6][PSC_NUM_CLASSES + 2] = {
 			.R = -2,
 		},
 		[PSC_CURRENT_IN_L] = {
-			.m = 6852,
+			.m = 6854,
 			.b = -3100,
 			.R = -2,
 		},
-- 
2.33.0

