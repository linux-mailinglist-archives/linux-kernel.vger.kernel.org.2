Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD2332DD91
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 00:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhCDXHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 18:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbhCDXHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 18:07:21 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831E9C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 15:07:19 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id e7so664630lft.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 15:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4xPZrQKI9DzyQgI8l1KHtECGn6OvKmEcjIaCH3tRIG0=;
        b=gp193NP4aQsovNv6sTt76j2EtGF5dS+erNhe/XKhkWD1fK9TUgG/v9bOtIKmCes6IJ
         eX28hhrl8od93drGWqI8d2Ja0M7vIz76V9ZPgHMjQYOTfvTnwQT4LLFKd5/l9NHLzrLi
         DfPiEzRtLrZlD7v6Psd2xvn4DM6r6vWBq4DCEtYxAi/GJYxHrMiJstJyFOHEiJAi96ZZ
         RsO0uMtqqMg05quPedHfRvZ4OV9YCIOM72frf4fSJX0FUut3BdgJJyXJbyoJGFi269pv
         A+wFKARPjxNCLYxZC5PVxgaEw5AHc/YO7key9LPTLAzgVH9bv3cLcqOIZ3eT/j9QsgAJ
         6HHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4xPZrQKI9DzyQgI8l1KHtECGn6OvKmEcjIaCH3tRIG0=;
        b=sCWdJFgVSt5+7Z049n6DKdIp+Os9wMk2o5AOdvsv1svTh9Zj9icRRynbBaG8aWFQah
         TNcLvJXv6R9qJu/es1DQSkFGVnLmPFVyCE7wWoTtpTMNMjmUWSddXwDSCQrKMDek9YoU
         Uo4FqTQMjWrZNjm7G49Qgs1t7Jn2LHtltcciJyHMv45yCyuBIYdxz2glQ8diXW6qE3qJ
         S5HEhBVipOs2p7/Eefqm/t/QuNgIqIMsp33IkHZ4FrRlGK9GsWVYvFyaZdeyJH9XYh3X
         ia1kojl/VJx8p1bUXMZw3EWazjzVxArpeA73Av52UVkUTD7NhadjeFcSBTiq25BChYDf
         zs2A==
X-Gm-Message-State: AOAM530F5OSMEbX96yuzR57dA9pAth2sHiGyZR1PExJFetXieprYxW0h
        DUjQS/9xTPzantulGXlfo0oZTns66QY=
X-Google-Smtp-Source: ABdhPJyFs+iZnPrdGgaBZhKn+g7iLdh1vBSF+AuDTfX76w0LSp9Kj6P0BekF17aSIyahVpPomhmUUw==
X-Received: by 2002:ac2:47f4:: with SMTP id b20mr3499410lfp.524.1614899238094;
        Thu, 04 Mar 2021 15:07:18 -0800 (PST)
Received: from localhost.localdomain (h-98-128-229-129.NA.cust.bahnhof.se. [98.128.229.129])
        by smtp.gmail.com with ESMTPSA id w8sm84825lft.44.2021.03.04.15.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 15:07:17 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] mfd: stmpe: Revert "Constify static struct resource"
Date:   Fri,  5 Mar 2021 00:07:09 +0100
Message-Id: <20210304230709.3217-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In stmpe_devices_init(), the start and end field of these structs are
modified, so they can not be const. Add a comment to those structs that
lacked it to reduce the risk that this happens again.

This reverts commit 8d7b3a6dac4eae22c58b0853696cbd256966741b.

Fixes: 8d7b3a6dac4e ("mfd: stmpe: Constify static struct resource")
Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
Changes
V1-V2: Add comments to the structs that they are dynamically modified
       Rewrite commit message.

V1: https://lore.kernel.org/lkml/20210302234710.74455-1-rikard.falkeborn@gmail.com/

 drivers/mfd/stmpe.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 90f3292230c9..1dd39483e7c1 100644
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
@@ -336,7 +336,8 @@ static const struct mfd_cell stmpe_gpio_cell_noirq = {
  * Keypad (1601, 2401, 2403)
  */
 
-static const struct resource stmpe_keypad_resources[] = {
+static struct resource stmpe_keypad_resources[] = {
+	/* Start and end filled dynamically */
 	{
 		.name	= "KEYPAD",
 		.flags	= IORESOURCE_IRQ,
@@ -357,7 +358,8 @@ static const struct mfd_cell stmpe_keypad_cell = {
 /*
  * PWM (1601, 2401, 2403)
  */
-static const struct resource stmpe_pwm_resources[] = {
+static struct resource stmpe_pwm_resources[] = {
+	/* Start and end filled dynamically */
 	{
 		.name	= "PWM0",
 		.flags	= IORESOURCE_IRQ,
@@ -445,7 +447,8 @@ static struct stmpe_variant_info stmpe801_noirq = {
  * Touchscreen (STMPE811 or STMPE610)
  */
 
-static const struct resource stmpe_ts_resources[] = {
+static struct resource stmpe_ts_resources[] = {
+	/* Start and end filled dynamically */
 	{
 		.name	= "TOUCH_DET",
 		.flags	= IORESOURCE_IRQ,
@@ -467,7 +470,8 @@ static const struct mfd_cell stmpe_ts_cell = {
  * ADC (STMPE811)
  */
 
-static const struct resource stmpe_adc_resources[] = {
+static struct resource stmpe_adc_resources[] = {
+	/* Start and end filled dynamically */
 	{
 		.name	= "STMPE_TEMP_SENS",
 		.flags	= IORESOURCE_IRQ,
-- 
2.30.1

