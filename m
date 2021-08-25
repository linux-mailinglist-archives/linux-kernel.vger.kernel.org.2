Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503D23F7E4E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 00:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhHYWVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 18:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbhHYWVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 18:21:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C8BC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:20:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j9-20020a2581490000b02905897d81c63fso1012239ybm.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=BXmW2RjvQEh9Bli/X6dqHjbl1+e3RPnk9A5yhhpZXUk=;
        b=VWNy4eOvlQFRZ8qoPA8z1o2whMkIDETXh0On6H5qn9bqrDUxbp3yqRbzaHI8VB+6Cp
         mcNSoEm2cJEIP5tU16FVLKnVKT3NEegWiGqFcB1hfiG+QhHqTHP/K9vzTKqVDDQ+QHuB
         fl6i2hYMPFefpjNwiKdFZys6rvaOK1TE0JMP4mUVtw+WEC6xoPI18CYF+6EmbfHQVpwJ
         mRdne2iRaOeNlGuFoC46ugE5WyD9MiOsD0m+IzwzVL++FWgYD1sWmDsMJABgX4MCrfAE
         wvLxIr1FVRohOGaRkod7V5nz+EegDGuT5TYNZ4y12Eb7OblDTOsp92pNDEzFSCeukgA9
         bo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=BXmW2RjvQEh9Bli/X6dqHjbl1+e3RPnk9A5yhhpZXUk=;
        b=mPzcWYMGBd4s1YdwQitURw1g5HqjcdGOLkVdKMswn+D1B2es8T0CEbfC5Hy0nwbpq/
         9S8QSbVcj5qGYRix4/u/MzVh3i7tR3bGT37VQ9TdEd+Qd8nYtrVa4VvADuqe8rjIWrdS
         c3dwgHy8SXHyA72v3BeMz0FkH0SRSavj4ou195leDLDOR1ojOWSxdythMxt5mo/uRO9N
         0R8LrKhqj2KCzyf768pEpjXXRYJnliTG90oWat0xx1pKCJtch9sYfWQQcKH9SyFbluVl
         TvsuL5rv6PHSUprcu79hCzQyU4jhY51OWZgGP3kiztDAieq7PKLZvXVx3AYwRQDLFNoH
         qptg==
X-Gm-Message-State: AOAM532CZnZgHLmKEv1JayhV0Ntq18GhxS9YEWTx6M3rYaTCCwSQOONF
        naaLNLqU3d/nzC7eS2ReThZ+f2ttuYNl
X-Google-Smtp-Source: ABdhPJxwufwuJAmpO0WZBSg2a2VQJCB9UUVcMfvAIVyk4vya9nq4VlYMEahAVdg/VZFnIegN55UZpAtwka2u
X-Received: from jiancai.svl.corp.google.com ([2620:15c:2ce:200:3664:f78f:3b89:adc6])
 (user=jiancai job=sendgmr) by 2002:a25:ea52:: with SMTP id
 o18mr1346886ybe.150.1629930057109; Wed, 25 Aug 2021 15:20:57 -0700 (PDT)
Date:   Wed, 25 Aug 2021 15:20:51 -0700
Message-Id: <20210825222051.2106481-1-jiancai@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH] coresight: syscfg: Add initial configfs support
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

This fixes build failures with -Wimplicit-function-declaration, e.g.

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

