Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846F638D967
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 09:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhEWHM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 03:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbhEWHM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 03:12:28 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4585EC061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 00:11:02 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e22so2006469pgv.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 00:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TJgZRkX5vTrH1LZZAmFcym9hY6GUzsmkQfNDTfOdHJI=;
        b=ZjvMDVP/5gZ+Q3EIQXmGBxO0G2MGtv/Y1v7v2iKveC4hPou+lMSCIyaPmdUpyt+hZF
         YEGGhTlKzUsN38KiNPjEf2uhe1ThMckZrjuOrzlThPjPIZJIKCK7Hl+LsTCmijBMdukO
         v5BB/+BalNcV9am2YopSCDcMh3KE0o2PBKH3UkN7CjpLagGreN7BqwlLQ9c1JJDKbehA
         OFSOafsBwvWD8cRklrONetr746yeUCa7VWA1DlAxPAgHEjdvmdc0C3FC4hvqU6v+o4Ti
         02ad2tMpWmdBTnFbhJl6PfE6iNI1xD/FXIOBuBXF3f+r3JgvGDtNhH1fhWnCWVjaWxlc
         SF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TJgZRkX5vTrH1LZZAmFcym9hY6GUzsmkQfNDTfOdHJI=;
        b=tVOgmxlrsRn4NS0+nhP/4qbgq9MGITrYvfG0sU2kiQa84ziSyrCGC5wnfpFjPCV3CW
         D7JPdUHS68nMY25Fqp2jffABSRAw0xwTeXyQYbuwXKt8DcQns6dPUuG+DCsXbVo8sx4g
         y6exFqDeaGLs5Y/K58Jb6w8KdXJB7unW7wQS2WoxP9frSUYYsJLriiAMLLFn0ob40sFj
         2YA/EOnlBottQBextiJVrwk8zPniE1fCrDHPR2jyp52G1bmD5BGlU8s6YuTH5uZrJRuf
         3LTUrqDDNNy7ybqsN7Gc5kLnBLOOCb4Oo/t0N267wks9645ynwynGK7PGsW7hKRgjZRs
         HoAQ==
X-Gm-Message-State: AOAM532gjbmw56DZZDU2PLfb6NXX1dDhDKLenf8TZTfowlxuyVQOD6AI
        vv0aUGImUzwsu6HWfiRbNAiA1Q==
X-Google-Smtp-Source: ABdhPJxGeAJKjHHJ8s3AK1DVIUtUFNJsuJXwEeUxVOAeL3pJDorhrdepmRevn8pW4kw0f7ZdPAGidQ==
X-Received: by 2002:a63:fc11:: with SMTP id j17mr7336724pgi.355.1621753861770;
        Sun, 23 May 2021 00:11:01 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id f80sm7841504pfa.160.2021.05.23.00.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 00:11:01 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-power@fi.rohmeurope.com,
        Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: bd71828: Fix .n_voltages settings
Date:   Sun, 23 May 2021 15:10:45 +0800
Message-Id: <20210523071045.2168904-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210523071045.2168904-1-axel.lin@ingics.com>
References: <20210523071045.2168904-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current .n_voltages settings do not cover the latest 2 valid selectors,
so it fails to set voltage for the hightest voltage support.
The latest linear range has step_uV = 0, so it does not matter if we
count the .n_voltages to maximum selector + 1 or the first selector of
latest linear range + 1.
To simplify calculating the n_voltages, let's just set the
.n_voltages to maximum selector + 1.

Fixes: 522498f8cb8c ("regulator: bd71828: Basic support for ROHM bd71828 PMIC regulators")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 include/linux/mfd/rohm-bd71828.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mfd/rohm-bd71828.h b/include/linux/mfd/rohm-bd71828.h
index c7ab69c87ee8..3b5f3a7db4bd 100644
--- a/include/linux/mfd/rohm-bd71828.h
+++ b/include/linux/mfd/rohm-bd71828.h
@@ -26,11 +26,11 @@ enum {
 	BD71828_REGULATOR_AMOUNT,
 };
 
-#define BD71828_BUCK1267_VOLTS		0xEF
-#define BD71828_BUCK3_VOLTS		0x10
-#define BD71828_BUCK4_VOLTS		0x20
-#define BD71828_BUCK5_VOLTS		0x10
-#define BD71828_LDO_VOLTS		0x32
+#define BD71828_BUCK1267_VOLTS		0x100
+#define BD71828_BUCK3_VOLTS		0x20
+#define BD71828_BUCK4_VOLTS		0x40
+#define BD71828_BUCK5_VOLTS		0x20
+#define BD71828_LDO_VOLTS		0x40
 /* LDO6 is fixed 1.8V voltage */
 #define BD71828_LDO_6_VOLTAGE		1800000
 
-- 
2.25.1

