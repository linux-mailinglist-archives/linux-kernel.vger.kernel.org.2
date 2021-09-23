Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E00415B57
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 11:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbhIWJtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 05:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240254AbhIWJtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 05:49:50 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCADC061574;
        Thu, 23 Sep 2021 02:48:18 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y28so24215640lfb.0;
        Thu, 23 Sep 2021 02:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3DhcYaQjtBUeMgP9Er6Q2XSMZ/Ffw7lDrN0rOmCGxAk=;
        b=V/MlctzG407+wt31yapTkE6DarL6GZbZKftO6pBWW9f1Ov+go4ZGOqlIP+Vg+kVPbq
         WSoTQDb6/AACr3uqfc1YFyjp2phlNrim5G65+eZSivsNcUgVwCE5+jYSXUXpHf72zyse
         8nkALs8nlkIuflFBYC7wiPx8QAuKh/FULdW0LahCZE7Jl6KfK09yHV0XIybidXobSjQP
         lHd6ij0EswZ7sT2wtHNYExG+drZ47JZpTsxsOAx+TnXxyyISr0qLmQlKfhaG3K1e3vcD
         l51TBHg4kbaVV87222Ukt6Tw7S1IBF4AEPc9oy671WaAeZNoqp5VVkdHxfbO2Cio9ljU
         Jr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3DhcYaQjtBUeMgP9Er6Q2XSMZ/Ffw7lDrN0rOmCGxAk=;
        b=qRGs9NkMUZ0zH4QsiQK+pknSO0uWXJ9e4BZaNhcC0Qp53xehDorF/ud9QLYSCJWmeV
         o7ovlgz85ylFfrKZSA9sHf6KkbaS4vYA8ctKk4o2FubhRni0h+5CP5NCBJZ2xul0VgXy
         kwuF1IXHZ7LPA5HG/HymvvxFBhTUgx7Y5l1nSk6hl3B8Su/9dGL1YoaFmYZrBF10sF5w
         O92QpyQlNWSl8W6NAmMqaMewqBZtkngMRI/DCw9uu9tyuVlsQlAgPtXQdbUyiW9wR8kS
         z4ddDOf3fYz8vNqTgP3E9Duy0PnOlghQY/t88aXeGctUSEhPe20Ko2+1iHbv8f2EFdAc
         fJ3g==
X-Gm-Message-State: AOAM531j867ihSBL6+vAzhDssoHAjyQbHMs3e6SN1Aj8ril0ghlbve+6
        iCZQ8AhdOL9dFlLzT/W6nTZiaIdT1g0=
X-Google-Smtp-Source: ABdhPJwrZfZvm7K4bRWaf2hGqNvKt1D6mDV3XAJmRzQKLK1zzQtmu81a/FmItp+ArBrW58mhlvwY2g==
X-Received: by 2002:a2e:3916:: with SMTP id g22mr4061563lja.417.1632390497018;
        Thu, 23 Sep 2021 02:48:17 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id w16sm410640lfe.37.2021.09.23.02.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 02:48:16 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id 18N9mDSd023377;
        Thu, 23 Sep 2021 12:48:14 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 18N9mD7k023376;
        Thu, 23 Sep 2021 12:48:13 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Paul Fertser <fercerpav@gmail.com>
Subject: [PATCH v2 2/3] hwmon: tmp421: report /PVLD condition
Date:   Thu, 23 Sep 2021 12:48:00 +0300
Message-Id: <20210923094801.23332-2-fercerpav@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210923094801.23332-1-fercerpav@gmail.com>
References: <20210922155323.GA3205709@roeck-us.net>
 <20210923094801.23332-1-fercerpav@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For both local and remote sensors all the supported ICs can report an
"undervoltage lockout" condition which means the conversion wasn't
properly performed due to insufficient power supply voltage and so the
measurement results can't be trusted.

Signed-off-by: Paul Fertser <fercerpav@gmail.com>
---

Changes from v1:
 - Trivial rebase

 drivers/hwmon/tmp421.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
index 63cb6badb478..9f0a4db695db 100644
--- a/drivers/hwmon/tmp421.c
+++ b/drivers/hwmon/tmp421.c
@@ -182,10 +182,10 @@ static int tmp421_read(struct device *dev, enum hwmon_sensor_types type,
 		return 0;
 	case hwmon_temp_fault:
 		/*
-		 * The OPEN bit signals a fault. This is bit 0 of the temperature
-		 * register (low byte).
+		 * Any of OPEN or /PVLD bits indicate a hardware mulfunction
+		 * and the conversion result may be incorrect
 		 */
-		*val = tmp421->temp[channel] & 0x01;
+		*val = !!(tmp421->temp[channel] & 0x03);
 		return 0;
 	default:
 		return -EOPNOTSUPP;
@@ -198,9 +198,6 @@ static umode_t tmp421_is_visible(const void *data, enum hwmon_sensor_types type,
 {
 	switch (attr) {
 	case hwmon_temp_fault:
-		if (channel == 0)
-			return 0;
-		return 0444;
 	case hwmon_temp_input:
 		return 0444;
 	default:
-- 
2.17.1

