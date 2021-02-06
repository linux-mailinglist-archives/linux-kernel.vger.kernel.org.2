Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03666311E57
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 16:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhBFPML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 10:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhBFPKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 10:10:45 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B37C06121D
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 07:09:07 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id u15so5102871plf.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 07:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zR9OsHslqhDG8eEUn6PBh2UQCbLLHkueVjbLue/1gyw=;
        b=AV089iQbfYZ3TEy26MlPZup2jvRdzw8UeMiOT5DYlDKCUfo45ZRXr1Te83bx7xjrpW
         zYreHLal6AkzgRP6eAX8eFKgtRktEExoHJRp6QzX06KU6+qmcivjCzF6LmMA520b/w3w
         zR8C9JGpC/XKXKZWpy4O0SuV7a9YXsWAK4B42+B2OzYM/qmxDHWxGbnz3FCylG1qIajT
         T+XaYAVsIPQWzXGMlRL3eluLC16/EslSDKwyM+VYmWElB+9rxoKLpa26008X0O2SltHi
         6/S6D2pyeyZHyXrvly/Jj2fkGInXY5lDx/rk+d3rXz8N/jWzA3OrjCoZer26flpUhIEJ
         mLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zR9OsHslqhDG8eEUn6PBh2UQCbLLHkueVjbLue/1gyw=;
        b=StGYc6Ba4oYKWbKON1NcT9UY1118xKUCuM4pJxB+ddHM6s2ZRINLgoGCT8I47HPF1X
         z8H/KAlhn5LrcvTUz3mzCMZz+kwgRsePQO3R05Lt3Vl4hrvLQgJ2TiIbVfptHPnBBpR0
         OFbSl4nWQuChq1a+yjQwHaWxj16wlWgDAcTNDs0mVRUw0km0oJTx93TsBhMxp12mPnXZ
         NKqTA6Yi0od6Pv7TzR4iaODkCT+TL1GdIDO6uAnRi9LgL+es2oZOM0R97m/tAHG/qjo7
         fTkQV3KThjcVcjmFVLnzQMTj5LFcK37RuUjTg4Jk5L4ZEu8ThZHmydjBNTg0fdaQp/jb
         sDrw==
X-Gm-Message-State: AOAM531SSKW28uT19Er6beSb/vYuJEPyF2GjLNL9+bl6ku0w4XrOPRBm
        iv9Ueay+TQJTY0t9CGyIJLebpA==
X-Google-Smtp-Source: ABdhPJzHhRA/YCVn3C/SiFaht017M5NJCA/gir1VRykF39YQux9zfgwsSmliQIrr6ITzG42+/VQvFQ==
X-Received: by 2002:a17:90b:4d06:: with SMTP id mw6mr8656415pjb.24.1612624147404;
        Sat, 06 Feb 2021 07:09:07 -0800 (PST)
Received: from localhost ([45.137.216.202])
        by smtp.gmail.com with ESMTPSA id v4sm11797312pjt.4.2021.02.06.07.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 07:09:06 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Al Grant <al.grant@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 8/8] Documentation: coresight: Add PID tracing description
Date:   Sat,  6 Feb 2021 23:08:33 +0800
Message-Id: <20210206150833.42120-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210206150833.42120-1-leo.yan@linaro.org>
References: <20210206150833.42120-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After support the PID tracing for the kernel in EL1 or EL2, the usage
gets more complicated.

This patch gives description for the PMU formats of contextID configs,
this can help users to understand how to control the knobs for PID
tracing when the kernel is in different ELs.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
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

