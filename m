Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9223E44D2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbhHIL2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbhHIL16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:27:58 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9068C061796
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 04:27:38 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j1so27362632pjv.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 04:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/3VLoyUUFLgGGIpwzBZniAYs6R20cyWHMNHgFMGrgsI=;
        b=yoqwI5vsX5wlcGT223si8LwTa1uAsMG6307HtfcLZz/1TcnoZzdwJ8EY1D+3EaRYk4
         nO2FvLrZR9I0nbdck2yzBThuGqegbgtgk6fQ6ieEjS4vc43NKuOu8TVIvHO3SvAtR/0N
         zOmRHMOWNkQBhAMmakeM7ALPJ8STlw+uEv2nyXY2b6kJIN73wyX1xSBbArZ6zGSnDEXN
         nTkqjJ+W1LveX4MhMGTZHDULFJTTI1mbOOKv0BmhYf6js1K840zLLIVdS+J5DkIM0FZ0
         799pBxr0xz1D2G8CqHaCvqu71CYo/8v1gFx0OdjUsUQxj53IcwPiIpDdaEV5fIjx0Cjq
         BQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/3VLoyUUFLgGGIpwzBZniAYs6R20cyWHMNHgFMGrgsI=;
        b=gj4eX4IJGUIsQjsdlzei/vhgssVC+UbiONs5bNJ9RZ9FkgE4PfK/e3xyPq4CCsqzoR
         2xXzqQkDVrZeDimTvjp1kfsHXD77nQIr8U4zDaz8kcv+z92EeskQV/M8l6VFfCTH3Iwp
         LMgOGy4Rz/56ufeq14PcmDYz+zjBz6cTNIni8sfXbgsj5bfqfYRbc5L/K1IQYQkrBqED
         kSN3LIMpYCdDGAMgEww4NovQwGyWYNBhMeEc3XfGu618sJ9Ydg5mVm+zrKWZNrFR9BAP
         42XHsYNgLPOqQJdJ43WEeYSm64k/IuUm/1j404pZvZ1yEmVElXBJwU1jgjjQREeAwNp5
         KbEg==
X-Gm-Message-State: AOAM532gcNZMTIR0r8gU6PnSPQr3uRIkE4kmM0wKAFH0AU0+D2B8UTN2
        JPNKaE/xKfHBkz6ctW4RBva8Dw==
X-Google-Smtp-Source: ABdhPJz72xJUcKouE4PzDu7moJ6A3YlxKWnVOiFrEhLX2UI/6z0N+uCgXJev6X4O86udz1RAbqtlaw==
X-Received: by 2002:aa7:8752:0:b029:3bd:82f0:3bf9 with SMTP id g18-20020aa787520000b02903bd82f03bf9mr23655808pfo.75.1628508458189;
        Mon, 09 Aug 2021 04:27:38 -0700 (PDT)
Received: from localhost ([210.0.159.74])
        by smtp.gmail.com with ESMTPSA id k11sm23841483pgc.30.2021.08.09.04.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 04:27:37 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Li Huafei <lihuafei1@huawei.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v1 1/3] perf env: Track kernel 64-bit mode in environment
Date:   Mon,  9 Aug 2021 19:27:25 +0800
Message-Id: <20210809112727.596876-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809112727.596876-1-leo.yan@linaro.org>
References: <20210809112727.596876-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's useful to know that the kernel is running in 32-bit or 64-bit
mode.  E.g. We can decide if perf tool is running in compat mode
based on the info.

This patch adds an item "kernel_is_64_bit" into session's environment
structure perf_env, its value is initialized based on the architecture
string.

Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/env.c | 24 +++++++++++++++++++++++-
 tools/perf/util/env.h |  3 +++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index ab341050be46..8f7ff0035c41 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -219,13 +219,35 @@ void perf_env__exit(struct perf_env *env)
 	zfree(&env->hybrid_cpc_nodes);
 }
 
-void perf_env__init(struct perf_env *env __maybe_unused)
+void perf_env__init(struct perf_env *env)
 {
 #ifdef HAVE_LIBBPF_SUPPORT
 	env->bpf_progs.infos = RB_ROOT;
 	env->bpf_progs.btfs = RB_ROOT;
 	init_rwsem(&env->bpf_progs.lock);
 #endif
+	env->kernel_is_64_bit = -1;
+}
+
+static void perf_env__init_kernel_mode(struct perf_env *env)
+{
+	const char *arch = perf_env__raw_arch(env);
+
+	if (!strncmp(arch, "x86_64", 6) || !strncmp(arch, "aarch64", 7) ||
+	    !strncmp(arch, "arm64", 5) || !strncmp(arch, "mips64", 6) ||
+	    !strncmp(arch, "parisc64", 8) || !strncmp(arch, "riscv64", 7) ||
+	    !strncmp(arch, "s390x", 5) || !strncmp(arch, "sparc64", 7))
+		env->kernel_is_64_bit = 1;
+	else
+		env->kernel_is_64_bit = 0;
+}
+
+int perf_env__kernel_is_64_bit(struct perf_env *env)
+{
+	if (env->kernel_is_64_bit == -1)
+		perf_env__init_kernel_mode(env);
+
+	return env->kernel_is_64_bit;
 }
 
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[])
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 6824a7423a2d..1f5175820a05 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -61,6 +61,7 @@ struct perf_env {
 	unsigned long long	total_mem;
 	unsigned int		msr_pmu_type;
 	unsigned int		max_branches;
+	int			kernel_is_64_bit;
 
 	int			nr_cmdline;
 	int			nr_sibling_cores;
@@ -143,6 +144,8 @@ extern struct perf_env perf_env;
 
 void perf_env__exit(struct perf_env *env);
 
+int perf_env__kernel_is_64_bit(struct perf_env *env);
+
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[]);
 
 int perf_env__read_cpuid(struct perf_env *env);
-- 
2.25.1

