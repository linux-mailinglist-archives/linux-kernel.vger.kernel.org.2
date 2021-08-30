Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0FD3FBAF4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbhH3R3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbhH3R3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:29:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF50BC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:28:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o76-20020a25414f000000b0059bb8130257so2417876yba.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=kodoJmi6WDuZJrPTFcRxRUB0Jbyp7ZG0JWBLCSvowuQ=;
        b=DKia4FFu9QYBM6YQMGDmGO4N/gnhRt/zkglFnEQ+xM4/6x0Al+7Hcxn4C8V6UUEn0a
         62/zA2l0mkTghgk7ZWmvHOx37VnFzLHWr1Gi52b6AaSky64RsYk54wzRjflBeLz6vKuS
         NfkpxyeWzKPZfUkjixMkBLEHLemy00RYk+aKg9cTXp44Y4jGAZA26bjzbWHte0EvbZ+v
         QqU+3SGuAY4zlVoKSMyT0rwr/raL3vig2z/oCHfuwmSHyuY+Rl/o1gQ7+Xo4lssrhYJJ
         M371f0B1Iw0WA0d9ltb1wJ7PTg5ayA22zn1UiD+3KcVD6f7DO9XOSFNbSYDQIiSHje+8
         z9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=kodoJmi6WDuZJrPTFcRxRUB0Jbyp7ZG0JWBLCSvowuQ=;
        b=fn5Y5EjiQNxk96AwHPhaMn26jgn8WiqAaJw6P4RI8t1s3xhQv0ARZqa5vbhKBXUL6y
         9XlOlKtfjNVlZSQXsbJ6mJii8JszY0aOHkGvFYkZHuPdLt3ZBzayZsC1BgNzwGHH4PQg
         MdV41P8ZeOZmQ4UvWXHkFEeHJMGCJoWSFCs2i18SXYe3sKWTHOSfipW8XvhOHj2X92g4
         6LVi0s7FCBmqDDFdYH0AGlnWjj5C5PU5KGRqKrnXd6ZB7aE02h+b4pFi79Z5y1ezVWe0
         iZTP7r8wQ0tI5H0lAZZqPk4Om2ngF6mOU9bcRPZ/zkRUB/z367kRTFIdoa0qHvdgZ0nG
         k0SA==
X-Gm-Message-State: AOAM530TKEckXyXriHNxvTNpf5dK6oJzIcjAvJqU/0+NyEbFmj5MqTuF
        2qdG/zjn9MlvYDIhkIgKn6SxadkCAt5O
X-Google-Smtp-Source: ABdhPJy41DNEJQGZEl2tN6mjusExB81ZTXcD+ytTnMQGALzhVaEVC/yusnG6KvHirOSE1NUPuUvOOU3nq9dT
X-Received: from jiancai.svl.corp.google.com ([2620:15c:2ce:200:dd51:f64e:22ea:f5ac])
 (user=jiancai job=sendgmr) by 2002:a25:9847:: with SMTP id
 k7mr24040661ybo.170.1630344504154; Mon, 30 Aug 2021 10:28:24 -0700 (PDT)
Date:   Mon, 30 Aug 2021 10:28:19 -0700
Message-Id: <20210830172820.2840433-1-jiancai@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH v2] coresight: syscfg: fix compiler warnings
From:   Jian Cai <jiancai@google.com>
Cc:     mike.leach@linaro.org, linux@roeck-us.net, dianders@chromium.org,
        mka@chromium.org, manojgupta@google.com, llozano@google.com,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        clang-built-linux@googlegroups.com, Jian Cai <jiancai@google.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes warnings with -Wimplicit-function-declaration, e.g.

drivers/hwtracing/coresight/coresight-syscfg.c:455:15: error:
implicit declaration of function 'kzalloc' [-Werror,
-Wimplicit-function-declaration]
        csdev_item = kzalloc(sizeof(struct cscfg_registered_csdev),
                             GFP_KERNEL);

Fixes: 85e2414c518a ("coresight: syscfg: Initial coresight system configuration")
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Jian Cai <jiancai@google.com>
---

Changes v1 -> v2:
  Format the commit message and add Fixes and Reviewed-by tag.

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

