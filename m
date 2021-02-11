Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6386F3191AA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhBKR4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhBKRV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:21:26 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8C8C061793
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:20:45 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id o7so4369395pgl.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DHjPOaB9z0WBR9paX+T9/UPiJiQWfM7w1AksmlIdo9Y=;
        b=eU3h2tZK0OSYBWpE09hoTjPELSrDOdjcBMd6DniKC5dg6tlKU6bmqYxw4N+L2HKUxm
         ftKV1XzIOGB/7DQDxwqUJ8pfQjMcq4tk6wV8xRXs8tq2lonxOXzS5T5zlhk8vXb/d+g5
         i5BjpqXOF6LiI8xciW9DzdLDEpmO48iAv5Q4smChXy4rllcFGP1RE7S38c8l7p8x9JW7
         +jRRMCN3aCzLzjyhE0hebjPFrb2RYzb3cYhhSWSNEvAtZC5FDiZ6wJ3bms9oI6q+gQ8o
         14AVgjLjyUUEafFlblhU/V1Viz+sblVG8XLQDcu2x5A+XpQLU8w+ijb3iPibLgc3nmMW
         hZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DHjPOaB9z0WBR9paX+T9/UPiJiQWfM7w1AksmlIdo9Y=;
        b=DaMQgw6xM7WGjwT3RzsQMrBNjKdi49mF3gTrFPhoHbXEgBj7XRYIonUHC7VgThW30n
         Ugv1rQfTyiR79SM4dsenrKdy3nSdcgeAJLSfTcaTRtl572XoQ+HNU7gNF8rqTtlPATN+
         KLz2RevdMScQWQkKAog4zs8zvS2CuKfyuP90y/OzSvH5F4D5IlQI0kUa8R07x7oMRoyS
         ZRyI6RJ42c1VWZp0Gs0VEw7G2Pva3bqv0EZ76zLuiO9iBmA9cObm5fp9UrnxpvCwpBy/
         Lcy7y/L3FuyH/sPF+bGJ+rZjiOZywbEkHXF6rrXXSgL+4yTsG+jP4fo0iOM5ZupUFcdA
         gmrw==
X-Gm-Message-State: AOAM5326uf0TY9PE+qsju0ARcr1rJeNYBzB01oTylQGhV5T9XFJMIypa
        pSqx++EHmhEvCYH3QQRkKyrvYg==
X-Google-Smtp-Source: ABdhPJwZFooGSB+rwaEj5HhhqBSvi+KPGQzcc/j7CBHP+c/2PB6d2KoVNBTY4UNv6zVn6Jod74WnvQ==
X-Received: by 2002:a63:c148:: with SMTP id p8mr8951625pgi.188.1613064045480;
        Thu, 11 Feb 2021 09:20:45 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e15sm7415384pgr.81.2021.02.11.09.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 09:20:44 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] Documentation: coresight: Add PID tracing description
Date:   Thu, 11 Feb 2021 10:20:38 -0700
Message-Id: <20210211172038.2483517-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211172038.2483517-1-mathieu.poirier@linaro.org>
References: <20210211172038.2483517-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

After support the PID tracing for the kernel in EL1 or EL2, the usage
gets more complicated.

This patch gives description for the PMU formats of contextID configs,
this can help users to understand how to control the knobs for PID
tracing when the kernel is in different ELs.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Message-Id: <20210206150833.42120-9-leo.yan@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/trace/coresight/coresight.rst | 32 +++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
index 0b73acb44efa..169749efd8d1 100644
--- a/Documentation/trace/coresight/coresight.rst
+++ b/Documentation/trace/coresight/coresight.rst
@@ -512,6 +512,38 @@ The --itrace option controls the type and frequency of synthesized events
 Note that only 64-bit programs are currently supported - further work is
 required to support instruction decode of 32-bit Arm programs.
 
+2.2) Tracing PID
+
+The kernel can be built to write the PID value into the PE ContextID registers.
+For a kernel running at EL1, the PID is stored in CONTEXTIDR_EL1.  A PE may
+implement Arm Virtualization Host Extensions (VHE), which the kernel can
+run at EL2 as a virtualisation host; in this case, the PID value is stored in
+CONTEXTIDR_EL2.
+
+perf provides PMU formats that program the ETM to insert these values into the
+trace data; the PMU formats are defined as below:
+
+  "contextid1": Available on both EL1 kernel and EL2 kernel.  When the
+                kernel is running at EL1, "contextid1" enables the PID
+                tracing; when the kernel is running at EL2, this enables
+                tracing the PID of guest applications.
+
+  "contextid2": Only usable when the kernel is running at EL2.  When
+                selected, enables PID tracing on EL2 kernel.
+
+  "contextid":  Will be an alias for the option that enables PID
+                tracing.  I.e,
+                contextid == contextid1, on EL1 kernel.
+                contextid == contextid2, on EL2 kernel.
+
+perf will always enable PID tracing at the relevant EL, this is accomplished by
+automatically enable the "contextid" config - but for EL2 it is possible to make
+specific adjustments using configs "contextid1" and "contextid2", E.g. if a user
+wants to trace PIDs for both host and guest, the two configs "contextid1" and
+"contextid2" can be set at the same time:
+
+  perf record -e cs_etm/contextid1,contextid2/u -- vm
+
 
 Generating coverage files for Feedback Directed Optimization: AutoFDO
 ---------------------------------------------------------------------
-- 
2.25.1

