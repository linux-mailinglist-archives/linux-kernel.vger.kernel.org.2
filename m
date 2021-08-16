Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34813ED34E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 13:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbhHPLsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 07:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236083AbhHPLsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 07:48:14 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4072C061796
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:47:42 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k29so23147735wrd.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OeivT2HkZhKQZOkI3pOohzYJkuxhk+iICvVlwTsBa58=;
        b=LtTbXOZzvzlpG0cXKVd4Kxtrc2uZIXBD13HiV2D0HYL2mJlyxVrrIXeFvw1qgjn8+M
         KYWoV582v3MIq6YYDR67FokUw7LQ+Epbytjy+PM2GgKdSdz0KS68cfZQEb1Rpn46YtK/
         MAPUQCTfFn5eVgrwfReiYsBeKCz+azNb2i1GmvtckbPcF2bD1kVYKLf9IXALjpul+Cuj
         nGF8oRYhdRuFBBIlyl+96OHVfEgvQHKW/1r3CEIvNJlAZKZI7Y1bKiYuLBq1DbpSUmVR
         vsGYEas9gWCUaXJqYnL2jYZLI84Q1PI9brph8diDfeh8m6nzs8DwRb3q9m3orHe310nC
         EuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OeivT2HkZhKQZOkI3pOohzYJkuxhk+iICvVlwTsBa58=;
        b=joH+VWoRdMqy7UpBpPwvou1mWAcoSIdh9XFeBTRHtGfawEUlyQxOknhoWkF9QPEzaY
         Fc9aNBPHhSKgbxPXhBq7TrRM48IKeDMAMEYcIs7tF8VxvKzcOBfMbqAF7IG1mYrK6XyO
         oUmbvlPuMIllU4n9eDA/ZaAm0i1y/6sp39l+X0+Tt3emoBfF6zR4/QN/fBSjXZdzkieS
         fpvvULoz+DT+NL8NSmZ/lxrd/8Nv0qCNCPnhjndMZNzjMkoBQFUrD/Epk4MJ+H/1mB87
         tOPvi8FtDh5ebdR5bsd0ZR0IUAh4NPqSjxg8kaPh+i66bMoOXD07URf/DU8ozNxg0l8q
         3GlA==
X-Gm-Message-State: AOAM5300/QWl/CJ0jRoI4Hx4M+ubulPCkHMiAz385a71OVNEZj8F7zzO
        3+qsotlOD+3EAJobLvNOihWcOQ==
X-Google-Smtp-Source: ABdhPJyvP3SJg3jxmrAE6kqTAOqFIE7EQO5dDY/eYNTTri8UbjNy1RVcblxBIkal3oKLUbBO1d5UoA==
X-Received: by 2002:a5d:60cd:: with SMTP id x13mr17808650wrt.375.1629114461494;
        Mon, 16 Aug 2021 04:47:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:e1b0:48c1:6199:9cb4])
        by smtp.gmail.com with ESMTPSA id h9sm11360769wrv.84.2021.08.16.04.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 04:47:41 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     andriy.shevchenko@linux.intel.com, akpm@linux-foundation.org
Cc:     jic23@kernel.org, linux-kernel@vger.kernel.org, ceggers@arri.de,
        lukasz.luba@arm.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, lars@metafoo.de, pmeerw@pmeerw.net,
        rui.zhang@intel.com, linux@roeck-us.net, miquel.raynal@bootlin.com,
        mcoquelin.stm32@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Subject: [PATCH v3 03/10] thermal/drivers/devfreq_cooling: Use HZ macros
Date:   Mon, 16 Aug 2021 13:47:25 +0200
Message-Id: <20210816114732.1834145-4-daniel.lezcano@linaro.org>
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

The new macro uses a unsigned long type which is already the type in
the current code via the 'freq' variable.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Christian Eggers <ceggers@arri.de>
---
 drivers/thermal/devfreq_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 5a86cffd78f6..4310cb342a9f 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -18,10 +18,10 @@
 #include <linux/pm_opp.h>
 #include <linux/pm_qos.h>
 #include <linux/thermal.h>
+#include <linux/units.h>
 
 #include <trace/events/thermal.h>
 
-#define HZ_PER_KHZ		1000
 #define SCALE_ERROR_MITIGATION	100
 
 /**
-- 
2.25.1

