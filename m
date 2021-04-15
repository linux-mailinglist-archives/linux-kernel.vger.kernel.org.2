Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9745361369
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 22:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbhDOUYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 16:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbhDOUYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 16:24:32 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC374C061756
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 13:24:07 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id z16so17677119pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 13:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WAfI5gmtCJFa1TuhXQgYH1iMmMqE67AZfwLRWLHkhdg=;
        b=SfuU7weNeHlXrJzX/vyKr9IQdOgWWIPnlj2MFyTJEfnnYfEwPhHR3N759aYT6JghbO
         p9o8NNekkePdGsRrdvgrA6swzgQIrYjwiKIg1WzOWIqArUgGNEJDe1auTCG8f/0q+pq4
         LTZ7ymDfuy1cYnxRdkIggzG+yKw8O8D6NKZ1weJULh0F4stt5oWBSDHcoWM3fjD7c4sH
         FUsGIvSGcb6HPizlskaxJE1PiWWZUM6hwIwuBDT51gaohppviENCajg3KvkfvwP4nqZ0
         Bi7UTnDU0YOojsNj93dtnF8bbCN+OlGrCP0MExLTPXYEx3DSCXnaI28unrNyTNS6+qH8
         2LZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WAfI5gmtCJFa1TuhXQgYH1iMmMqE67AZfwLRWLHkhdg=;
        b=hazXNIq3zdytzaU48TCGpN5krhDaH3XGYu0DY7hCebnyMi75CmA3knaHJhem8wPUic
         NsGsJ2qqhARuzrpzSzN6uJvU+ZQGTgoTlRZ5q27pGz7ynKJhCVsAsG6TED5TuTeT1F//
         NEpEG/MHjEqxbVUQhZff8gRBkXR1oRHJzKYk1BPS/rdEJHNuxZyv1N0XKmfrRUNDPoue
         onBlFLnochwfaJwv2jHdjfgtwvW9dIaux5GuIBVVH7fY7FJwHmHqNVNtCvyBCWjkpX0+
         gIPzUU4vg6rTgkEAUfU+IBYcK917vjoDmzNxewuHEb+GYDd8hJXzyqUhfYrc3Y+kwjFP
         MWkQ==
X-Gm-Message-State: AOAM533LBg5ZVFKYxwNu8iKnUjxZ0BvEkeW+C6U9eQ7NDDu+2Qd1qEkR
        OXlkN8H8wcJNhKivA83xtXd7kGEW7l4kcw==
X-Google-Smtp-Source: ABdhPJx1ODeNmclj2OVM31Oq3MuqlC1GsIRH+OAzqYgBCbFwAB55189RQ9pMY/doig9PvfmEHHoioQ==
X-Received: by 2002:a63:f4e:: with SMTP id 14mr4270192pgp.236.1618518247557;
        Thu, 15 Apr 2021 13:24:07 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id kk6sm3275829pjb.51.2021.04.15.13.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 13:24:06 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     mike.leach@linaro.org, leo.yan@linaro.org, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] coresight: etm-perf: Fix define build issue when built as module
Date:   Thu, 15 Apr 2021 14:24:04 -0600
Message-Id: <20210415202404.945368-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415202404.945368-1-mathieu.poirier@linaro.org>
References: <20210415202404.945368-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Leach <mike.leach@linaro.org>

CONFIG_CORESIGHT_SOURCE_ETM4X is undefined when built as module,
CONFIG_CORESIGHT_SOURCE_ETM4X_MODULE is defined instead.

Therefore code in format_attr_contextid_show() not correctly complied
when coresight built as module.

Use IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X) to correct this.

Fixes: 88f11864cf1d ("coresight: etm-perf: Support PID tracing for kernel at EL2")
Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Link: https://lore.kernel.org/r/20210414194808.22872-1-mike.leach@linaro.org
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 0f603b4094f2..a706ba11b93e 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -52,7 +52,7 @@ static ssize_t format_attr_contextid_show(struct device *dev,
 {
 	int pid_fmt = ETM_OPT_CTXTID;
 
-#if defined(CONFIG_CORESIGHT_SOURCE_ETM4X)
+#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
 	pid_fmt = is_kernel_in_hyp_mode() ? ETM_OPT_CTXTID2 : ETM_OPT_CTXTID;
 #endif
 	return sprintf(page, "config:%d\n", pid_fmt);
-- 
2.25.1

