Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908E43D98FC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 00:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhG1WmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 18:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhG1WmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 18:42:04 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC46C061757;
        Wed, 28 Jul 2021 15:42:01 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id k13so2561562qth.10;
        Wed, 28 Jul 2021 15:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lo6hJcKFoOWYBZDIf76dR7Ki7GsgeuexsbCvJNO4vMw=;
        b=ijl2ObOh8q3fsDwVG6VXe2+FaZvZ8bSlsu54YntjpMDRxWU3USvH88HwEma8gSvuCL
         nBECTfLcG2r9bmA9iFOzLRsu6+qocLm5hsVe0YkWrKKfZTkzaYZMCyhPfBYc5MSm/Xbk
         hd7zX31XSHvcmGD8Ltd+gDjCkVaTvvuAP8QUgDNsHLjdva4rz0wvUp5eLpw8pnooOs3C
         eHTm5d/SxCJppKzW/4pjOVuucuePEqrZcep637yjbXIIvKVtZtIXlOEDTVuwT6fm5B13
         kOfX8k2TaZ7hZdRh46J2bdS4BGg+VWEpzpXxxUAHHWkSUsfdDKxxZZFPz159ZmXADKQ6
         i+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lo6hJcKFoOWYBZDIf76dR7Ki7GsgeuexsbCvJNO4vMw=;
        b=LMXtFxnaW4+TTolUoYnw5enIbqTiub9TPj4gr7/5xbujf5Z8TCV/L2Y6zjnC5UEf+X
         OzLGqo36UASTZKH/2EpO4Ia6GcvFxNjCpfJlrliq72kC5VdBbjbO+EZg1P6klcGi9OB+
         CjQ8Pgodbdi6dT+B7cnryQQPGg+tmG+vyArZUgJrZmoixMkStKcjbXc6SLG0AfgtE++p
         OPhNHBUtU6gtTLXwH9cg48D/NGmtvjbTCnyCKq1dcVzhkEtKtWyco2uypDinKNZMynwT
         uhf8NMqZITEiVcooUIBhGiKHIrnkBLxiXGzDMc/agszeiDYMHje4c9o1E0HixSov28kT
         mgGA==
X-Gm-Message-State: AOAM533Z3zV8/FpDtYr6bNho/s+RDv1VuRRGfKIaLXLLDJZ96PzO98iN
        +9F85/pRlBvY4DW5acby9Ws=
X-Google-Smtp-Source: ABdhPJx2vFHhf1ktZr9V68JrQiQ8eh4jMSsWuU7O5laqLi7ZQ9dRsiGF/++ftGz8nbKzPIzXHyUF3g==
X-Received: by 2002:ac8:7d52:: with SMTP id h18mr1692658qtb.179.1627512120031;
        Wed, 28 Jul 2021 15:42:00 -0700 (PDT)
Received: from fstone04p1.aus.stglabs.ibm.com ([129.41.86.7])
        by smtp.gmail.com with ESMTPSA id u11sm730297qkk.72.2021.07.28.15.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 15:41:59 -0700 (PDT)
From:   Brandon Wyman <bjwyman@gmail.com>
To:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Cc:     "B. J. Wyman" <bjwyman@gmail.com>
Subject: [PATCH] hwmon: (pmbus/ibm-cffps) Fix write bits for LED control
Date:   Wed, 28 Jul 2021 22:41:40 +0000
Message-Id: <20210728224140.3672294-1-bjwyman@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "B. J. Wyman" <bjwyman@gmail.com>

When doing a PMBus write for the LED control on the IBM Common Form
Factor Power Supplies (ibm-cffps), the DAh command requires that bit 7
be low and bit 6 be high in order to indicate that you are truly
attempting to do a write.

Signed-off-by: B. J. Wyman <bjwyman@gmail.com>
---
 drivers/hwmon/pmbus/ibm-cffps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
index 5668d8305b78..df712ce4b164 100644
--- a/drivers/hwmon/pmbus/ibm-cffps.c
+++ b/drivers/hwmon/pmbus/ibm-cffps.c
@@ -50,9 +50,9 @@
 #define CFFPS_MFR_VAUX_FAULT			BIT(6)
 #define CFFPS_MFR_CURRENT_SHARE_WARNING		BIT(7)
 
-#define CFFPS_LED_BLINK				BIT(0)
-#define CFFPS_LED_ON				BIT(1)
-#define CFFPS_LED_OFF				BIT(2)
+#define CFFPS_LED_BLINK				(BIT(0) | BIT(6))
+#define CFFPS_LED_ON				(BIT(1) | BIT(6))
+#define CFFPS_LED_OFF				(BIT(2) | BIT(6))
 #define CFFPS_BLINK_RATE_MS			250
 
 enum {
-- 
2.25.1

