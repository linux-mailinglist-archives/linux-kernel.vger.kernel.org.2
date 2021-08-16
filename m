Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B5A3ED354
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 13:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbhHPLsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 07:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236484AbhHPLsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 07:48:23 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E25C0617AD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:47:51 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so7989148wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z9OPtraZwdqyNTWvuvDWK69DLDoJjjAe8H2+GzaDsys=;
        b=uPQnVVp41xPZQ5uWDdggHcsCD4OC3E3VRC8Mx9xRkMcKxqZUu77Sh035qU/HUpXb4o
         TQ69NyiToW1a9KMQGJ9wJXgGUDE4fWWt1ZsGdv68Mp4/45s+bmf0oZnjZ1eEO4FeESym
         50X3p9eWxm7FVqeg80ThX2R4qhhl98hnx/zoAbOUfpFR7P42cCmfCOhZohUIojgej7sR
         K13NvorCJmiNRMSQ9wtrlP81KURnI/65+J0TwUhEiZuOYz8MJpS5muLyfZyJK/uQncXa
         nHPU3A4Kf3xP7/4GhahMMOjrJLNBeNoWWUQ0ce1m4CxOgouFLYM3F9f3pZCo/oe8DKOs
         BCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z9OPtraZwdqyNTWvuvDWK69DLDoJjjAe8H2+GzaDsys=;
        b=liUTR4+O9ORoBB93amFdkafA4tC9JoExLeoXxnGxvlqwGV98d4b9M/PGy5HspDoilL
         SF8ecduhHGdJZ1jijinznTi0aA1PCu7jF4OSvRBEBvIQ0oNWLlwQbKBZAQ6K+ps0TYwV
         X357eJ8Uzyx2wYOZY6sFFWGnHmoEMTStL3bFjE5lL+vZi52E9BRw1Uma82r0rO6B0C9V
         +uGkF7LkzVKtzpY7iz6ccJpmHUEDM5YiixLPp6NM0F+NVWtm91X+aeb/bJ2ncbYR8ca3
         SkRhyTuHfzl7QHeQUxvKhFQoWgt7f1Tf6kQipbwJzpRyWxlIzJHyWQdu5TJ/hSKAB9JT
         yZJA==
X-Gm-Message-State: AOAM5318lNuyCjsHHsiZhXQ0S2QnzquTMIH9r1XfWxlDwTsODsim0uL4
        Ug0Oub0AY2yPUFBbpmxVRLngug==
X-Google-Smtp-Source: ABdhPJxu/ADJmloOWi0AEilB3j0NI4PMKAQkNmqwdzfWMhKM0cZsto3Ub7DssI2ZBYp1zCgDkQkpSQ==
X-Received: by 2002:a1c:7719:: with SMTP id t25mr14935185wmi.130.1629114470103;
        Mon, 16 Aug 2021 04:47:50 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:e1b0:48c1:6199:9cb4])
        by smtp.gmail.com with ESMTPSA id h9sm11360769wrv.84.2021.08.16.04.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 04:47:49 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     andriy.shevchenko@linux.intel.com, akpm@linux-foundation.org
Cc:     jic23@kernel.org, linux-kernel@vger.kernel.org, ceggers@arri.de,
        lukasz.luba@arm.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, lars@metafoo.de, pmeerw@pmeerw.net,
        rui.zhang@intel.com, linux@roeck-us.net, miquel.raynal@bootlin.com,
        mcoquelin.stm32@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Subject: [PATCH v3 09/10] mtd/drivers/nand: Use HZ macros
Date:   Mon, 16 Aug 2021 13:47:31 +0200
Message-Id: <20210816114732.1834145-10-daniel.lezcano@linaro.org>
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

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mtd/nand/raw/intel-nand-controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/intel-nand-controller.c b/drivers/mtd/nand/raw/intel-nand-controller.c
index 8b49fd56cf96..709f0402fbae 100644
--- a/drivers/mtd/nand/raw/intel-nand-controller.c
+++ b/drivers/mtd/nand/raw/intel-nand-controller.c
@@ -20,6 +20,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/units.h>
 #include <asm/unaligned.h>
 
 #define EBU_CLC			0x000
@@ -102,7 +103,6 @@
 
 #define MAX_CS	2
 
-#define HZ_PER_MHZ	1000000L
 #define USEC_PER_SEC	1000000L
 
 struct ebu_nand_cs {
-- 
2.25.1

