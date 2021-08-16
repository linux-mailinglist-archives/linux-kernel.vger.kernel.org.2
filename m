Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586013ED351
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 13:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbhHPLs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 07:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236406AbhHPLsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 07:48:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D90C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:47:47 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so9968714wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M6btCPRs49rCPU3vKX+Bw5LucatLQc2bLqeWkxoAeig=;
        b=Xd1oNA5iTzDFPwnROnK6pUurA/mF4MEVxlEqqnjO1DoxDbYP/LJzkA1uIq/ZeXMrvQ
         t9B8V99EfyrSAzZ91cLB04EB6ENTP3LYqZsimRsZs00m8M9Etyetf68PcxnND/oS7ru6
         aimcsdN5qxsYfFjSr/63GQGLmE/vXoy3xKtL0m6RLZuhz/HAh5ZCGFvFf+yCcOqV5mNs
         AD14GvQ1VxYitvUHAnwzLhtKt6wl0bxpw+xNozN5WPW7AWBkDU/AgFlIZgUqclOk0grB
         OYzVXlUlO5q4tjrlXc2k17UwEGlrvm2nhzfLZQnyca+P3YWU0HuLJXXfuJ5cTOq8l0z5
         kVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M6btCPRs49rCPU3vKX+Bw5LucatLQc2bLqeWkxoAeig=;
        b=AfytCGe6M2YVG97nLID8/IAwCpMRxxQh2mkUw5aT2o+5eO2Mt1hcK7SOB8nu1Y3FLi
         rlq6fO6TdzXgUaiGP3YipRlhUCdj4VLjG3Va0xpkW4Xg3Qx+e6G6eSIWdmlVTKXZvyxr
         HZOWQW1TgjEHOHwxsWoxseP0n28DsxDhNmc0z/sX5Ne1cM04n/RpD82HU13LRd8xFhjB
         Rb4F5cnIVGtpeZYuVLYaPPh10kj/Z/W/K86x6QQQKeFqJ9DdPZ/OZWWIVvDo0NFR/zYM
         grDgbqAEYJiaAg5uWLhZ5g2Dh4f56KvjA3HmyXv4bWNv58aNXV9ZOeS7Xwwi0DPso0/L
         C4WQ==
X-Gm-Message-State: AOAM530jZ2yV/URTdFz6un+X3ZXbhGig4vfX6Vcsnk68lTISLU1R/DV8
        StbG7q4+p4D1VYqvTVstWaj/CQ==
X-Google-Smtp-Source: ABdhPJzTBtrv3H/SujtUzcWvj04X0brCCgGmx/psQUQiuxii1RBiC6F1PTeDdgg2ytcdcx8+ZKUv4w==
X-Received: by 2002:a05:600c:3212:: with SMTP id r18mr14773099wmp.161.1629114465746;
        Mon, 16 Aug 2021 04:47:45 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:e1b0:48c1:6199:9cb4])
        by smtp.gmail.com with ESMTPSA id h9sm11360769wrv.84.2021.08.16.04.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 04:47:45 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     andriy.shevchenko@linux.intel.com, akpm@linux-foundation.org
Cc:     jic23@kernel.org, linux-kernel@vger.kernel.org, ceggers@arri.de,
        lukasz.luba@arm.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, lars@metafoo.de, pmeerw@pmeerw.net,
        rui.zhang@intel.com, linux@roeck-us.net, miquel.raynal@bootlin.com,
        mcoquelin.stm32@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Subject: [PATCH v3 06/10] hwmon/drivers/mr75203: Use HZ macros
Date:   Mon, 16 Aug 2021 13:47:28 +0200
Message-Id: <20210816114732.1834145-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816114732.1834145-1-daniel.lezcano@linaro.org>
References: <20210816114732.1834145-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HZ unit conversion macros are available in units.h, use them and
remove the duplicate definition.

The new macro is an unsigned long. The code dealing with it is
considering as an unsigned long also.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Christian Eggers <ceggers@arri.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/mr75203.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 18da5a25e89a..868243dba1ee 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -17,6 +17,7 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
+#include <linux/units.h>
 
 /* PVT Common register */
 #define PVT_IP_CONFIG	0x04
@@ -37,7 +38,6 @@
 #define CLK_SYNTH_EN		BIT(24)
 #define CLK_SYS_CYCLES_MAX	514
 #define CLK_SYS_CYCLES_MIN	2
-#define HZ_PER_MHZ		1000000L
 
 #define SDIF_DISABLE	0x04
 
-- 
2.25.1

