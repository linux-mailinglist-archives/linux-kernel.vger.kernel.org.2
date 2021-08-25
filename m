Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBD63F7E89
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 00:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbhHYW0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 18:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbhHYW0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 18:26:05 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36585C0613D9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:25:19 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id f34-20020a05622a1a2200b0029c338949c1so615559qtb.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=fT/uiX9DJiKWLSrGSaUNQbEmdVHwY+0Iq88fa/vtsiw=;
        b=SnTQ1ly+r0hm+ryHx+ivlRgBcYtv2HN0O/wMKbA6Plz8rGu8wDd/AWD4Z0QgcIl/ME
         0BrG5+grIN4eYXURMHvCWiHQdIPFwamLf6FSFlN8N4JqIbTJ2npI1ikFCOzTWeF76pon
         062ZuXCHX6/0CBPUVlllMqqHi0LRdV+iROcoXZ4snvAB4SQqKQziDOX+mEqY6JZ0aHAS
         pGsN9drTuW3pMIRpXsKyfWYrwrX7Zt4c7/ifMEolUUaLU7ISGI5FkJFlqg7rMzY4tyjU
         GbUpwsoKimW8t51tIV4zbZpmpmxEjVlPyFc5Zzqt3kd1DdCdOuoj79nDmpnosUJ5FD6P
         T3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=fT/uiX9DJiKWLSrGSaUNQbEmdVHwY+0Iq88fa/vtsiw=;
        b=rS/lU/YMxUMU7i3kx2/nBvOHztrlqFNjXOhv2+8qQKwmMtQJBRi5lOUAQjxkPURZyV
         lJHO16975Jxf9457PDgI2lg3vXZIo7udqh6iPPBUvoWGmvm2s4dtcfLWqOh/mH7Ilnjz
         qa1Chmj7jxi5N9AIvx45ax7jxJ6GOEf1JlEgH2mbPJDKHejWUMHYaRvYzx0V0B89D0qF
         eWXf0J8OV8kCy/uEJl9kNv9uqyuL4VZSCyuRMA5wj+422+5Hbfn8HkUdupwrhykpyUsF
         7j9CvHm5bqmJwpD4wQcMF1nK4EP1g/ESnIP3oRAwBiZvtmPgcVRL4iX1DfnS6WB3GfMa
         OMEA==
X-Gm-Message-State: AOAM533IJapS6wtWkul0zJ9wc7CdShmtdnP18yFNB5SYiOVIJJSkwEUx
        a+yioMuovzmvWIUzk3mRKs+jpxyTiJk+
X-Google-Smtp-Source: ABdhPJyTdeHC1yoxT0gpFRpMe2/9Nq4odvgwxIxMLPY5smJiapxFejusCW/e4+cxbKVi8bGMObu4dZAKKpSL
X-Received: from jiancai.svl.corp.google.com ([2620:15c:2ce:200:3664:f78f:3b89:adc6])
 (user=jiancai job=sendgmr) by 2002:a0c:f351:: with SMTP id
 e17mr605774qvm.21.1629930318275; Wed, 25 Aug 2021 15:25:18 -0700 (PDT)
Date:   Wed, 25 Aug 2021 15:25:14 -0700
Message-Id: <20210825222514.2107728-1-jiancai@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH] coresight: syscfg: fix compiler warnings
From:   Jian Cai <jiancai@google.com>
Cc:     mike.leach@linaro.org, dianders@chromium.org, mka@chromium.org,
        linux@roeck-us.net, manojgupta@google.com, llozano@google.com,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        clang-built-linux@googlegroups.com, Jian Cai <jiancai@google.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes warnings with -Wimplicit-function-declaration, e.g.

^[[1m/mnt/host/source/src/third_party/kernel/v5.4/drivers/hwtracing/coresight/coresight-syscfg.c:455:15: ^[[0m^[[0;1;31merror: ^[[0m^[[1mimplicit declaration of function 'kzalloc' [-Werror,-Wimplicit-function-declaration]^[[0m
        csdev_item = kzalloc(sizeof(struct cscfg_registered_csdev), GFP_KERNEL);
^[[0;1;32m                     ^

Signed-off-by: Jian Cai <jiancai@google.com>
---
 drivers/hwtracing/coresight/coresight-syscfg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
index fc0760f55c53..43054568430f 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 
 #include "coresight-config.h"
 #include "coresight-etm-perf.h"
-- 
2.33.0.259.gc128427fd7-goog

