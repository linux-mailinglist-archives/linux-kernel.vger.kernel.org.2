Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3E645AF62
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 23:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239946AbhKWWvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 17:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239677AbhKWWvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 17:51:38 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CACC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 14:48:30 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id u11-20020a17090a4bcb00b001a6e77f7312so362419pjl.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 14:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FMQLoym76yTY3cbbWiDyiD1lX2+hK6fXMJaMyVRGwOw=;
        b=Qbe0vA6gXGRBxEWwQZqgRTy/OZEtHuCAGqQ7pNGzYR6IB+q8JCqZOQL/bOjUuAOQsi
         9G7LepeCCyAkTA/zt/8HYjze+pZcQ035u7Peuxtbc7fa9xNOEt8Mz0tiCelgkpR6kqJV
         UVJ5SvOg8gA0GldDP3anDljKbbPj3wtXcjQnsWvML3456LfOGdw2JVcRAHN7AuGYXHYP
         /+JEX7HJ/nlGIjRF53S7R732iyTEYq1m2dkLi/FGdpGlKXSqjGNOz8F77+8jdOupQgUr
         fjLqnIA+2kfVRyYIMePCc73YfrudYzHFvOJnopfnhHX5cCIKkr8BPtUIye/sxTFQSXyc
         D8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FMQLoym76yTY3cbbWiDyiD1lX2+hK6fXMJaMyVRGwOw=;
        b=HRCxFw+RUVvKEdIRhhkaGNj993WKIvBgg4XUJmSZrJFibrO0Cen/esCLP2MDlKutpV
         ed2vNqo452fNbWtUseOro5RbKsdUUSyeNDKmlKwQnyntPg+ZSUSGC87qY9p0Yrt2Keam
         xcouHP/nLh0rlJKnHumWL5p/uJvrZy74bef3i3kn5IwDK3TeJfcFRWMZTzHwrV54hCSl
         6xSqX/RJUC0+Aqg0kOD2+dFTzD7Zb75p8hAeKo3wrz4ckDVyZ1FxmpHZrVjCw4Me/vk5
         jZz3Z18SAGGoMe3b0D9wSS/z4MPvKNzX9cN9hhVg1xKHyMFwpIB06ePcQBTomeKSUN1v
         MKJw==
X-Gm-Message-State: AOAM5309KsShJqlUPc7dxEZYKxIlau2x7Yrv4WRiHZTysChyNRhGrR77
        4Cc6jOgCHxOG/ciUVwWNJi3Y8o+G/rkC
X-Google-Smtp-Source: ABdhPJys4YEAse8Egj+M2QQAIbNTekARl8nB+PnwPM6IUT1E1yXSQ67yY1azYo+Kxe+hR4KQUT2B58VkJjiw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:dbab:a6fe:1e3a:91fa])
 (user=irogers job=sendgmr) by 2002:a17:903:11cd:b0:143:d220:fdd8 with SMTP id
 q13-20020a17090311cd00b00143d220fdd8mr11605843plh.79.1637707709588; Tue, 23
 Nov 2021 14:48:29 -0800 (PST)
Date:   Tue, 23 Nov 2021 14:48:21 -0800
In-Reply-To: <20211123224821.3258649-1-irogers@google.com>
Message-Id: <20211123224821.3258649-3-irogers@google.com>
Mime-Version: 1.0
References: <20211123224821.3258649-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH 3/3] perf tools: Probe non-deprecated sysfs path 1st
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following Documentation/ABI/stable/sysfs-devices-system-cpu the
/sys/devices/system/cpu/cpuX/topology/core_cpus is deprecated in favor
of thread_siblings, so probe thread_siblings before falling back on
core_cpus.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/smt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
index 2636be65305a..2b0a36ebf27a 100644
--- a/tools/perf/util/smt.c
+++ b/tools/perf/util/smt.c
@@ -79,11 +79,10 @@ int smt_on(void)
 		char fn[256];
 
 		snprintf(fn, sizeof fn,
-			"devices/system/cpu/cpu%d/topology/core_cpus", cpu);
+			"devices/system/cpu/cpu%d/topology/thread_siblings", cpu);
 		if (sysfs__read_str(fn, &str, &strlen) < 0) {
 			snprintf(fn, sizeof fn,
-				"devices/system/cpu/cpu%d/topology/thread_siblings",
-				cpu);
+				"devices/system/cpu/cpu%d/topology/core_cpus", cpu);
 			if (sysfs__read_str(fn, &str, &strlen) < 0)
 				continue;
 		}
-- 
2.34.0.rc2.393.gf8c9666880-goog

