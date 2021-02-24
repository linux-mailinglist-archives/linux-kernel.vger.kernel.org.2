Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221253240C4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238625AbhBXPZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbhBXOqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:46:42 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E086C061356
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:42:45 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n4so612689wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=65QKSsy3lkCh0TOg3Qv5eqQsbUSxRJSlb8pGltzsbn8=;
        b=aOA3X1qA/raiSVC1ONzrW+LerPrW/uegK5wztMiPKpR4vtgB/F+yAaSbciq1EvjRSh
         FOdC/O/q7THZDizqc/NnyhjJmS23bM3YuMcLqP5zPyvvUDRKoGrk/dtBqHxHK5mrW23F
         AuZOKuCPrbA+B3eyK+EjBJ6u0PfzHZER8tL/j51qvj3MTwj6kiSMLnDJeb9jKwP4rAaA
         jKCtIZ1dgXiSsII+pIKTSqplrMcvPhG+5hAwFZ+YzJCUG8amw/iU4iNZziUQqj8wfsh3
         B6YyMmZnDwRwpEv7ogeHvRG4Wp9Tbuee6HSBbLQGGB3IyRlp+5wb1Eaw9Vd6JqpT1kTE
         7y7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=65QKSsy3lkCh0TOg3Qv5eqQsbUSxRJSlb8pGltzsbn8=;
        b=SgJMiQcKzD10UatMOTyhjpHZGaQVU13rPU+2/eE4piCQHfjO3JPwQDa+gemAPDRFaO
         Eh3hHFAni6JuxcuME/o+0cHi5I6m8dl4Xvpv78tyiA2Jndd8h5WT/naapZlC+7HCeP8e
         sU9cjtRxkScXeu1+WsK3XehQulPDNqpNZk6ce5/K/WlIA35rfCVDEYz1xKLnA7Jf4FjQ
         gL5xYVTon7Vste+sAYlaB8pvOOV1U5Tme3bibtaE1KBmYh4n8a2DpqT79tw69ehlw9V0
         3oRiEoQgV9bKycojl4kfnsh5ldIjoPJXMpnLvQzjsJr/r31VFI7BW3QWGrheqNp7ig4v
         SC2A==
X-Gm-Message-State: AOAM531WFwUTTqvZaSPtUBn9f2zPXflH0rxHPmcLJMAkyo/kFtT7+PNa
        Kflb+pvoioaym0z8nweI5iRPNw==
X-Google-Smtp-Source: ABdhPJzN3c+DDio3HKnmVyPDga3bjriwu8sVoanEINW7bsZeHkd6/eck/wyCN4/4JqOwOcO1iyGKUg==
X-Received: by 2002:a1c:20c7:: with SMTP id g190mr4040398wmg.156.1614177763949;
        Wed, 24 Feb 2021 06:42:43 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-157-252.adsl.proxad.net. [82.252.157.252])
        by smtp.gmail.com with ESMTPSA id p3sm4170669wro.55.2021.02.24.06.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 06:42:43 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org (open list:OMNIVISION OV02A10 SENSOR DRIVER)
Subject: [PATCH v2 7/9] i2c/drivers/ov02q10: Use HZ macros
Date:   Wed, 24 Feb 2021 15:42:17 +0100
Message-Id: <20210224144222.23762-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210224144222.23762-1-daniel.lezcano@linaro.org>
References: <20210224144222.23762-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HZ unit conversion macros are available in units.h, use them and
remove the duplicate definition.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/media/i2c/ov02a10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov02a10.c b/drivers/media/i2c/ov02a10.c
index 8683ffd3287a..59a34e59774e 100644
--- a/drivers/media/i2c/ov02a10.c
+++ b/drivers/media/i2c/ov02a10.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/units.h>
 #include <media/media-entity.h>
 #include <media/v4l2-async.h>
 #include <media/v4l2-ctrls.h>
@@ -64,7 +65,6 @@
 /* Test pattern control */
 #define OV02A10_REG_TEST_PATTERN			0xb6
 
-#define HZ_PER_MHZ					1000000L
 #define OV02A10_LINK_FREQ_390MHZ			(390 * HZ_PER_MHZ)
 #define OV02A10_ECLK_FREQ				(24 * HZ_PER_MHZ)
 
-- 
2.17.1

