Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F1E3ED34C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 13:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbhHPLsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 07:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236242AbhHPLsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 07:48:11 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDB6C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:47:40 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f5so23108737wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eM0vLatuE1q0NehjvdsYjFHrIkZvf8jD/sX/vIBFdTg=;
        b=zaqVWqA6yxquy+epHcUXgaNp4mPoyitoYcwN60HNf+Uinc2NC3UOgw/DjH7QXFdwFB
         2lSy69Bt0wLtxUXRWlU14Mn5u27r8R3+b64RBDn/yQdexiCx/4le7A26b7enapGOmMjH
         zcWjCnvHIMjTNhvsLvK4zvt9DXjxSw/3257QSR3UqB2OSE61Ns0rRrY8JVsZNZWUWjko
         e+IQ+fKFUvAfkegO5I39ytM9jTaOYCJLrxAjTpRXtqcNrf1jEobSV4iugn4yPzk3O1r5
         33m1wqBetKnRk+tvi4JxiHm6z9oqPxyOdu+n4/BLdI6hE146KE2nDTbKF5yO7nwuKeWZ
         0Agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eM0vLatuE1q0NehjvdsYjFHrIkZvf8jD/sX/vIBFdTg=;
        b=MSet+LmjYJxz5SN0Go4cVkiNawLaRxfpxHGZWvsdDw1PhsEM5zSDJ4FANi1Jdbx/O/
         Lic0K4QpdLMV+r4OvmI/3bnSUMROk5xIcbmvCi30stIv3vGt8KWzmm/dN6Lcyr9pvAqJ
         QR9WOh07BUs74XtSsTnraq7en3ru2paKsUziT6Tn3jwsUCL1XKbiQJxChXkEhR9Gp6pB
         pJGszDIvShjm41FNvZp1M0S+GAZiwLMdmPgSdNzWwtgJUfpRrRovYYKoPMzYdil0sFAv
         rD2ueKJ8vwGqleU23jmlLc5s73IFfRq8ljEw1OLMjaw1fobr9PiEuZ2HSg0qEyLARsKR
         qE3A==
X-Gm-Message-State: AOAM5334nzMXVmJKROC7J4Vb/suazxAKzBRKEhL2uvxSgZc1U0sxL+FH
        9MG8AYFHQM5FZSEsEwGPxTTaBA==
X-Google-Smtp-Source: ABdhPJwiT5+TEXlKXKkwrtltlIR8dJ0PW31j2UoOmPGGg+5EXVK1hcyEG+Bv0uHxUkc2gKxKRWujNA==
X-Received: by 2002:adf:f403:: with SMTP id g3mr18261267wro.222.1629114458688;
        Mon, 16 Aug 2021 04:47:38 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:e1b0:48c1:6199:9cb4])
        by smtp.gmail.com with ESMTPSA id h9sm11360769wrv.84.2021.08.16.04.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 04:47:38 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     andriy.shevchenko@linux.intel.com, akpm@linux-foundation.org
Cc:     jic23@kernel.org, linux-kernel@vger.kernel.org, ceggers@arri.de,
        lukasz.luba@arm.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, lars@metafoo.de, pmeerw@pmeerw.net,
        rui.zhang@intel.com, linux@roeck-us.net, miquel.raynal@bootlin.com,
        mcoquelin.stm32@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Subject: [PATCH v3 01/10] units: Change from 'L' to 'UL'
Date:   Mon, 16 Aug 2021 13:47:23 +0200
Message-Id: <20210816114732.1834145-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816114732.1834145-1-daniel.lezcano@linaro.org>
References: <20210816114732.1834145-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The users of the macros are safe to be assigned with an unsigned
instead of signed as the variables using them are themselves unsigned.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/units.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/units.h b/include/linux/units.h
index dcc30a53fa93..ff51d3cfc6a0 100644
--- a/include/linux/units.h
+++ b/include/linux/units.h
@@ -4,9 +4,9 @@
 
 #include <linux/math.h>
 
-#define MILLIWATT_PER_WATT	1000L
-#define MICROWATT_PER_MILLIWATT	1000L
-#define MICROWATT_PER_WATT	1000000L
+#define MILLIWATT_PER_WATT	1000UL
+#define MICROWATT_PER_MILLIWATT	1000UL
+#define MICROWATT_PER_WATT	1000000UL
 
 #define ABSOLUTE_ZERO_MILLICELSIUS -273150
 
-- 
2.25.1

