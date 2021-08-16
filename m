Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC613ED34F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 13:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbhHPLsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 07:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236345AbhHPLsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 07:48:16 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA1AC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:47:44 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q10so23205925wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=knUEmnO1k4ZgYhZBogunOk1c+b4Pve9rwE5RpxjJFcE=;
        b=vXdx6h0SCU+60D3hEFofqmhutL7U9O6b7k9gHtCj9naQAgsBqh68Oh71Vug7vp6u37
         neMOOk2O0bCjcRvsDTmPzgRj6TGbLeJLUp2UacyO8O7y9RvnB9WzHxfgVEN0n8Bqcp/P
         GLBAau/eUvF8NenapOgToTuKy/n2S9G7lzgrZhQdt+EQc4BxxJPnpfKGbTwDU+Tx8n6r
         g7DbVC3utt6cvgaq1n/bvkpVDN4hiOh0OJRU+PG3xitCLf/cECmVV5Vk7/n88h1fdsua
         bSzsnMUVpXabav6JlPzFJlooIyCi5qQZnXzUeQy3MFKhi6OGz20nVzXw58a6+b7mL5dY
         W0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=knUEmnO1k4ZgYhZBogunOk1c+b4Pve9rwE5RpxjJFcE=;
        b=Y7sSfpATzUTnA7S2qnBGg9ZTeppQXlfCHmvLX+6wgsCprwzHLcGP54LZUKLzwurA4Z
         VM+f1fAe9dp7cX04an7ZqrfY28i+4i/3ZtLsJYKdIdYx+YeoL187bQbLZI6+Tlw6sGMX
         EaH5r7WOu4q4PYs3uvch54I3kgGnKjrhSxW4q8EuFr8qveCk+QEAVRfgSkYR2DPJ1gIo
         bonfa49TwWBb2bXIyfdVo7ur3gaClPAF0VUnILRcgEaZa2NUKV8ZAtEdkKeBBZ0nAf+1
         K5GZqfBFRG/G1ZERBXK3LJN8dbfFYYLDHg5QnspMmM7DkqnxMQXtRB+HxZKg86P+ePWo
         Uiaw==
X-Gm-Message-State: AOAM531YfdxFlgklS9bcj4/lBxUF1dCGzJrzzVUCtanOzwoXxnyDM0lf
        mIJYZTGb5GNCI0/nMoR/rSjehA==
X-Google-Smtp-Source: ABdhPJzz7q1PCZh73Yoyo5WYrVJvwDk1zJ0RFi99UOOCtgYqbztVCCawUfRsrzUjqOB6YiKHbzIJ9A==
X-Received: by 2002:adf:e30c:: with SMTP id b12mr17649654wrj.347.1629114462905;
        Mon, 16 Aug 2021 04:47:42 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:e1b0:48c1:6199:9cb4])
        by smtp.gmail.com with ESMTPSA id h9sm11360769wrv.84.2021.08.16.04.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 04:47:42 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     andriy.shevchenko@linux.intel.com, akpm@linux-foundation.org
Cc:     jic23@kernel.org, linux-kernel@vger.kernel.org, ceggers@arri.de,
        lukasz.luba@arm.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, lars@metafoo.de, pmeerw@pmeerw.net,
        rui.zhang@intel.com, linux@roeck-us.net, miquel.raynal@bootlin.com,
        mcoquelin.stm32@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Subject: [PATCH v3 04/10] devfreq: Use HZ macros
Date:   Mon, 16 Aug 2021 13:47:26 +0200
Message-Id: <20210816114732.1834145-5-daniel.lezcano@linaro.org>
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

The new macro has an unsigned long type.

All the code is dealing with unsigned long and the code using the
macro is doing a coercitive cast to unsigned long.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Christian Eggers <ceggers@arri.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 28f3e0ba6cdd..85faa7a5c7d1 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -27,6 +27,7 @@
 #include <linux/hrtimer.h>
 #include <linux/of.h>
 #include <linux/pm_qos.h>
+#include <linux/units.h>
 #include "governor.h"
 
 #define CREATE_TRACE_POINTS
@@ -34,7 +35,6 @@
 
 #define IS_SUPPORTED_FLAG(f, name) ((f & DEVFREQ_GOV_FLAG_##name) ? true : false)
 #define IS_SUPPORTED_ATTR(f, name) ((f & DEVFREQ_GOV_ATTR_##name) ? true : false)
-#define HZ_PER_KHZ	1000
 
 static struct class *devfreq_class;
 static struct dentry *devfreq_debugfs;
-- 
2.25.1

