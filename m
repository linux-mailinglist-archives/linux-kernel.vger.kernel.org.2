Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F7C3240B9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbhBXPW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbhBXOnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:43:40 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C6FC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:42:34 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l12so2141743wry.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hBk34eZA5hEuiVpSg2GolP2X/Gt6H9KObB/sQwism5Q=;
        b=c6KlnMgo2WJkdnSgGO95I+6VeX2hAvlcO2ZRJ+FKvVEmm312Gd7KO1l/CWkleyCv1f
         ixrlBEnUvn5+SJhgSy/C3fijbW4UhYQAKo9EbATiW1Y+U3nxHYN/husx+9Vgv0TAX19m
         2Bpu+91We4k+bIXOpRKRKZtrXeHTujidUe9GoQXLd2W3+n4kJzATVcMc50fwkOAJuqQi
         ZA200PG44K1UVff/s3heH+X+7a2SGcOFstD6r9Ew9vSE7m4niWkbyRYhVgf865+MKFS3
         pL+DmZezg3FCXEELrHh8Fq71lLCTKr6OKn3OYd+VDrCMm9OEfCKasUWYDAjZ94GGJbLF
         AALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hBk34eZA5hEuiVpSg2GolP2X/Gt6H9KObB/sQwism5Q=;
        b=UWZ2ovo5ZpdLxzU5qp1yU+mFlbFasgUwuu/wTf6Z7dNynbCxvMw/OaOZTi1/D22+tV
         osKzswU+lYQSEydgKUPKiMXG3glWuZ+Cbgun3gdnqV1WvuhewRZuDX8Uu6siGCASpFtt
         mu9mPWI27BV9RhYm2P9An09P5RPO7YZCGpk0sGygb5oMrB3+pMKTEd9wOqY9MAdOD+J8
         mw6YhcA2eqlz5uGG1iPi/PG0Y6xDoLBl3ys3UHlrv3zM5Ea3ENqqHU+i5rujxRt8CPxW
         a7g57ejEiQKUw5/wrqGApx9jtUlG9ykewiVFIPgdHd2orGzlsRaBjjUnz1itlcZs+uL1
         4nJw==
X-Gm-Message-State: AOAM532JwGj3JFExIA54OrU4A+1KHe5U23Ujva3zRyAGkdUOa+mnCD5/
        6m+Y8ZkNh/1OU+t5DwhvgtyRYA==
X-Google-Smtp-Source: ABdhPJwINoEaqlkd8fuyvufdsaEbPTffAFayhis3JV4Fm4pM8u+BMDQZisHkWofZ5IkQefKSiPgY6g==
X-Received: by 2002:a5d:62ce:: with SMTP id o14mr32065335wrv.174.1614177753224;
        Wed, 24 Feb 2021 06:42:33 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-157-252.adsl.proxad.net. [82.252.157.252])
        by smtp.gmail.com with ESMTPSA id p3sm4170669wro.55.2021.02.24.06.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 06:42:32 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, Christian Eggers <ceggers@arri.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v2 1/9] units: Add the HZ macros
Date:   Wed, 24 Feb 2021 15:42:11 +0100
Message-Id: <20210224144222.23762-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macros for the unit conversion for frequency are duplicated in
different places.

Provide these macros in the 'units' header, so they can be reused.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Christian Eggers <ceggers@arri.de>
Reviewed-by: Andy Shevchenko <Andy.Shevchenko@gmail.com>
---
 include/linux/units.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/units.h b/include/linux/units.h
index dcc30a53fa93..218ec0d314b6 100644
--- a/include/linux/units.h
+++ b/include/linux/units.h
@@ -4,6 +4,10 @@
 
 #include <linux/math.h>
 
+#define HZ_PER_KHZ		1000L
+#define KHZ_PER_MHZ		1000L
+#define HZ_PER_MHZ		1000000L
+
 #define MILLIWATT_PER_WATT	1000L
 #define MICROWATT_PER_MILLIWATT	1000L
 #define MICROWATT_PER_WATT	1000000L
-- 
2.17.1

