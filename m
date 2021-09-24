Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5DD416EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 11:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245199AbhIXJcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 05:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245154AbhIXJcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 05:32:08 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E64C061574;
        Fri, 24 Sep 2021 02:30:35 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id b15so36970059lfe.7;
        Fri, 24 Sep 2021 02:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NuXMIMygOyCJoafI24dAFWyoJT94ScKf6Ijbd2Ke7LA=;
        b=I12jm2CyFr0LlT8kXlEp5RhbD5uPEoiAXx073LisGPAj0kRZmfFnR3D97+bNZQi/Fc
         8ccVzVBgMMXLlF0IJOopas10nG1MsnagIX50EOnlxCZKLpg5jzxN2Hf4N8gG+ZKAqcor
         12RpB/N2pdRTYHCQYnXLRMXMW7gW7/y0IfF18ZAvdG0QE9SsshbmpoG3kWpGh46OrU+6
         WOwdncwfc0sgrOsguZJH6LktmPgF4Kz99pMOejNSBZ1W4+D8MM5coz9KQbpLXptKZ134
         ZDTfHjlkDfbnxo8o8kDQhWZLJzAirLhWTEHWjWjKOy4aOSoDNvDeb9T9f/y6uj8ab0X5
         yUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NuXMIMygOyCJoafI24dAFWyoJT94ScKf6Ijbd2Ke7LA=;
        b=2rLmXAIZk+mqXPAVaw+Z6mXfqBIkGH1o/qYJVmVr2GPzljbfIQ+B2e9E70UQI8whto
         Hhoooad3/e+ZffCnrmQpLjLlSkq5QEmhYINzuFZFEtRPovinoUbZNBS3hXFzxe+eTx1K
         ygo4/cna7QB2/3d7opBmdRdP3oxnF8xmGKaVFrpEX7d/o0d1/EUEkFZPBFi6T729rLVN
         bKdYpcCQzh0HZMc7QmBuA29jfgaVAJkWxtga/0C6SwjX/PcVwyXFrs+Wh8R4UwUqqM1I
         dXrHp1J20w/bRnlydrtBCqGF/XplkL2mFEw+q7tdncCuISnFFN3evUYICvq4lyvCvvwY
         P3Mg==
X-Gm-Message-State: AOAM5324zzZLMYjy6HUPSjqKxLsCzdZKrUW+at3RO7mspDq8Q14ZSRx9
        797CtbWinyMcV/zQCsk4Js4Nc42Agbk=
X-Google-Smtp-Source: ABdhPJyJSQCvgdwf5ETIm1R83V+hBrwN1lOQ6BSfLubMcU+Qy9jPWlhEcxwg17ek7V+W0/ttWoFZzg==
X-Received: by 2002:a2e:bc27:: with SMTP id b39mr1772084ljf.78.1632475834114;
        Fri, 24 Sep 2021 02:30:34 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id o20sm342611lfu.29.2021.09.24.02.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 02:30:33 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id 18O9UUv6026131;
        Fri, 24 Sep 2021 12:30:31 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 18O9UUoc026130;
        Fri, 24 Sep 2021 12:30:30 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Paul Fertser <fercerpav@gmail.com>
Subject: [PATCH v3 3/3] hwmon: tmp421: fix rounding for negative values
Date:   Fri, 24 Sep 2021 12:30:11 +0300
Message-Id: <20210924093011.26083-3-fercerpav@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210924093011.26083-1-fercerpav@gmail.com>
References: <20210924022020.GA3032273@roeck-us.net>
 <20210924093011.26083-1-fercerpav@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Old code produces -24999 for 0b1110011100000000 input in standard format due to
always rounding up rather than "away from zero".

Use the common macro for division, unify and simplify the conversion code along
the way.

Fixes: 9410700b881f ("hwmon: Add driver for Texas Instruments TMP421/422/423 sensor chips")
Signed-off-by: Paul Fertser <fercerpav@gmail.com>
---

Changes from v2:
 - Add Fixes: tag

Changes from v1:
 - Trivial rebase

 drivers/hwmon/tmp421.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
index 3a789f21188c..85f5f0eb3d2e 100644
--- a/drivers/hwmon/tmp421.c
+++ b/drivers/hwmon/tmp421.c
@@ -100,23 +100,17 @@ struct tmp421_data {
 	s16 temp[4];
 };
 
-static int temp_from_s16(s16 reg)
+static int temp_from_raw(u16 reg, bool extended)
 {
 	/* Mask out status bits */
 	int temp = reg & ~0xf;
 
-	return (temp * 1000 + 128) / 256;
-}
-
-static int temp_from_u16(u16 reg)
-{
-	/* Mask out status bits */
-	int temp = reg & ~0xf;
-
-	/* Add offset for extended temperature range. */
-	temp -= 64 * 256;
+	if (extended)
+		temp = temp - 64 * 256;
+	else
+		temp = (s16)temp;
 
-	return (temp * 1000 + 128) / 256;
+	return DIV_ROUND_CLOSEST(temp * 1000, 256);
 }
 
 static int tmp421_update_device(struct tmp421_data *data)
@@ -175,10 +169,8 @@ static int tmp421_read(struct device *dev, enum hwmon_sensor_types type,
 
 	switch (attr) {
 	case hwmon_temp_input:
-		if (tmp421->config & TMP421_CONFIG_RANGE)
-			*val = temp_from_u16(tmp421->temp[channel]);
-		else
-			*val = temp_from_s16(tmp421->temp[channel]);
+		*val = temp_from_raw(tmp421->temp[channel],
+				     tmp421->config & TMP421_CONFIG_RANGE);
 		return 0;
 	case hwmon_temp_fault:
 		/*
-- 
2.17.1

