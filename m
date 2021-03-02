Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B451132B71F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357388AbhCCKtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbhCBX4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 18:56:11 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5ED5C061788
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 15:47:16 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id u4so26278491ljh.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 15:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LS4d4uUxDq7yhtpjLQE7kDOpsO4KYhMcEce+00T9U+s=;
        b=b2YvmtWceuUdn6lRyC69kZzsj1GrBVdKv/s37uBMpqnrZeFSFFX3v7i6xMxDXM0DR1
         3S5dN2pEfvAef3sPnfgVkmEU3K7V/vJq9ZpXQW43ps/9hu1KxRmJiYKJ3P1wDPufQdln
         b482GFvnPEz8YRgub0ODGDSMeNZWts5Z1KBKxazzoxwhkFFIIEr49PX7KisrzY4L8d29
         2DF1zgd6B1P/twHqi/XfuHR3dUcQjsFZdjpD7PTqTJty0smvB+kLU1cs4/8RagQVII2S
         lJGjneBExfZnY4mmoqynG7aZlywjm/znyxLx4Ppbl/Pkv8lbwfth9qPpS4zT1fvo0/eU
         bkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LS4d4uUxDq7yhtpjLQE7kDOpsO4KYhMcEce+00T9U+s=;
        b=Jl4pMd1T0yLvMY68VvRMQoek5+CGgBfRvH48kagZ5mPX4x3jyqzzh8V75Hk+U8jOf9
         9mAFR6ZsN7//Y3q7nKaI0tbH8ofk7d7gCDPY/f7Xv6tUeeNktwUP54a1AJTU+9+uez0q
         idobO9NX1cevpQlm65XUR3/W23TgjuBk6vC8sArkKpl7kxDKWctfY/kKB3VVv6RoP+3v
         flrCk4C7PpC+OTi8lKln3HUpE0ianLbyYHGsnQkBMVB5FekXhO3hvFqbsv3y/NNeTL5E
         hcPshXQNAl6qB2Zk0ugjNcLlT3947r2hhEjwOA5AiEE+t8KMmcAjsy0XLFqSy9WY04qs
         xIzQ==
X-Gm-Message-State: AOAM533qDrJOZdpxNdkXEDTB5e4kzIbASWoTrnHfi6UgMnPKuXgXzqc8
        4LV0Fh3Tx7ZVaEQROBaXzIE=
X-Google-Smtp-Source: ABdhPJy5L1J338j45dySxGdt1O0nFPc4P4bq9ZZ67C0FYOxtdRwp0t/z2lccEUEyzMGMCigXG4BIZw==
X-Received: by 2002:a2e:3c13:: with SMTP id j19mr13431079lja.130.1614728835186;
        Tue, 02 Mar 2021 15:47:15 -0800 (PST)
Received: from localhost.localdomain (h-98-128-229-129.NA.cust.bahnhof.se. [98.128.229.129])
        by smtp.gmail.com with ESMTPSA id j15sm1974359lfm.138.2021.03.02.15.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 15:47:14 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] mfd: stmpe: Revert "Constify static struct resource"
Date:   Wed,  3 Mar 2021 00:47:10 +0100
Message-Id: <20210302234710.74455-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy noted that constification of some static resource structs in
intel_quark_i2c_gpio.c were incorrect. It turns out there is another
change from the same series that is also incorrect in stmpe.c.
These structures are modified at init and can not be made const.

This reverts commit 8d7b3a6dac4eae22c58b0853696cbd256966741b.

Fixes: 8d7b3a6dac4e ("mfd: stmpe: Constify static struct resource")
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
I went through the series and this was the only additional issue I
found. Sorry about that.

 drivers/mfd/stmpe.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 90f3292230c9..1aee3b3253fc 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -312,7 +312,7 @@ EXPORT_SYMBOL_GPL(stmpe_set_altfunc);
  * GPIO (all variants)
  */
 
-static const struct resource stmpe_gpio_resources[] = {
+static struct resource stmpe_gpio_resources[] = {
 	/* Start and end filled dynamically */
 	{
 		.flags	= IORESOURCE_IRQ,
@@ -336,7 +336,7 @@ static const struct mfd_cell stmpe_gpio_cell_noirq = {
  * Keypad (1601, 2401, 2403)
  */
 
-static const struct resource stmpe_keypad_resources[] = {
+static struct resource stmpe_keypad_resources[] = {
 	{
 		.name	= "KEYPAD",
 		.flags	= IORESOURCE_IRQ,
@@ -357,7 +357,7 @@ static const struct mfd_cell stmpe_keypad_cell = {
 /*
  * PWM (1601, 2401, 2403)
  */
-static const struct resource stmpe_pwm_resources[] = {
+static struct resource stmpe_pwm_resources[] = {
 	{
 		.name	= "PWM0",
 		.flags	= IORESOURCE_IRQ,
@@ -445,7 +445,7 @@ static struct stmpe_variant_info stmpe801_noirq = {
  * Touchscreen (STMPE811 or STMPE610)
  */
 
-static const struct resource stmpe_ts_resources[] = {
+static struct resource stmpe_ts_resources[] = {
 	{
 		.name	= "TOUCH_DET",
 		.flags	= IORESOURCE_IRQ,
@@ -467,7 +467,7 @@ static const struct mfd_cell stmpe_ts_cell = {
  * ADC (STMPE811)
  */
 
-static const struct resource stmpe_adc_resources[] = {
+static struct resource stmpe_adc_resources[] = {
 	{
 		.name	= "STMPE_TEMP_SENS",
 		.flags	= IORESOURCE_IRQ,
-- 
2.30.1

