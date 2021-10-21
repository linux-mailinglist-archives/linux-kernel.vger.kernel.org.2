Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A6143634D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 15:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhJUNsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 09:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbhJUNsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:48:11 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1223C061220
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 06:45:55 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so3179637pjl.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 06:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=scJONSeVpOmV2CJVVcM76etm+auyzPBKzEOe3qDiuJI=;
        b=yf6zl7BSnChL++bbuckoCVvgC4TomTcXaTcWHOM7j0198dxACJIobVYzGwkvRXnN3n
         mqJVzfJqusMXuLXyDtKvPr/XvUrl5Pfpg9BnM7nqw4IJd3PQXg05RRWqhKMKGuM/SZWt
         uivpxxT/SmJiYAstIA/v92JAjTbftIZsHNxXhexEW2mfTq1gxFh0/jfx1FlVRTV7Yzgq
         3qbI/IkLOddEEFfoLXae4vqmpQ4CiHi/ni8xvdz5WP9rTZ0ljZ2gqJpFBtRsUn/srKBO
         xJMDHK2QIY3I87+iQ+C/gaM4WiQhy0ewC1EyK9NlsLUuKF7Br00oJbFgiYtJaZVzTbCf
         638w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=scJONSeVpOmV2CJVVcM76etm+auyzPBKzEOe3qDiuJI=;
        b=VzWboLj6+OltRLHMzl6ODfcFkC+v/U7W89LXygiftV/WQZ2+U1YdHRAWgZelgJUZM0
         FniyLoTPqueTKVkFSbAK5+X6z23CSZQ9EIm6Yye7jVZuJrPmM54CRrKmXPxzWabQ7C+h
         xmppzeh0K98nLHT2xtOWVIRNSjxEoJiILZkQJETunAexkzojfuI6Qh7jHfJNCFRMl4o7
         tHCk2mo8pWmON5kCcRZyilKDoa4evkawvLkLL8vxnUqSah4EYE2JuKGnMO0tlo14vvSA
         WpATNOdG1CGz08viwfYtyXhCIMeqTpQgYfBQvi+5+oKL7J2BZEYtGxTr9ebMf0fkItqw
         dB0g==
X-Gm-Message-State: AOAM532oIBkZcv8DLpI5UETHNkw8cJD16Tpha76/1LxxA/eFQqWsKf03
        fCuKBc0QSmaKEXA3yody7RBsJA==
X-Google-Smtp-Source: ABdhPJzGxXaDeuxo28QlnFOxhVT5SttuPRnaGNdYo/lbZThTyRUA0LHbeq/ZIhYriJdjajjwI9uYhg==
X-Received: by 2002:a17:90b:4a8d:: with SMTP id lp13mr6861919pjb.240.1634823955404;
        Thu, 21 Oct 2021 06:45:55 -0700 (PDT)
Received: from localhost ([103.127.241.129])
        by smtp.gmail.com with ESMTPSA id n14sm5383076pgd.68.2021.10.21.06.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 06:45:54 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [RFCv1 4/4] perf: arm_spe: Dynamically switch PID tracing to contextidr
Date:   Thu, 21 Oct 2021 21:45:30 +0800
Message-Id: <20211021134530.206216-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211021134530.206216-1-leo.yan@linaro.org>
References: <20211021134530.206216-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now Arm64 provides API for enabling and disable PID tracing, Arm SPE
driver invokes these functions to dynamically enable it during
profiling when the program runs in root PID name space, and disable PID
tracing when the perf event is stopped.

Device drivers should not depend on CONFIG_PID_IN_CONTEXTIDR for PID
tracing, so this patch uses the consistent condition for setting bit
EL1_CX for PMSCR.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/perf/arm_spe_pmu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index d44bcc29d99c..935343cdcb39 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -23,6 +23,7 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/mmu_context.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -272,7 +273,7 @@ static u64 arm_spe_event_to_pmscr(struct perf_event *event)
 	if (!attr->exclude_kernel)
 		reg |= BIT(SYS_PMSCR_EL1_E1SPE_SHIFT);
 
-	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
+	if (perfmon_capable() && (task_active_pid_ns(current) == &init_pid_ns))
 		reg |= BIT(SYS_PMSCR_EL1_CX_SHIFT);
 
 	return reg;
@@ -731,6 +732,13 @@ static void arm_spe_pmu_start(struct perf_event *event, int flags)
 	if (hwc->state)
 		return;
 
+	/*
+	 * Enable tracing PID to contextidr if profiling program runs in
+	 * root PID namespace.
+	 */
+	if (perfmon_capable() && (task_active_pid_ns(current) == &init_pid_ns))
+		contextidr_enable();
+
 	reg = arm_spe_event_to_pmsfcr(event);
 	write_sysreg_s(reg, SYS_PMSFCR_EL1);
 
@@ -792,6 +800,9 @@ static void arm_spe_pmu_stop(struct perf_event *event, int flags)
 	}
 
 	hwc->state |= PERF_HES_STOPPED;
+
+	if (perfmon_capable() && (task_active_pid_ns(current) == &init_pid_ns))
+		contextidr_disable();
 }
 
 static int arm_spe_pmu_add(struct perf_event *event, int flags)
-- 
2.25.1

