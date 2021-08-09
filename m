Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA643E44D5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbhHIL2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbhHIL2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:28:03 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF24C06179B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 04:27:43 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso6123753pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 04:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ffo+BFghYOyiUfwtRs9Z93LC8RfNRNR6YWnTHcFyWA4=;
        b=HtzCFgTbZujxHFgCpuT6lhx9Xq35xX0vxduY4GYyyL9tuctz+TnYquFIa5mifGnUhY
         O/C7H5CU9Ssl03Vnh+XmSPGod2KGKgfz0ebYwXQjxCmIepFStIJCpbqSwb8yT51N9p41
         YKFgufs0olY+BFMHDGm5M1Pk4am40Tbno9y4rmChxhaJ+rQF2oVhuub44BYfOmW2IriB
         aP0nkhsT4wsFR8iJDMDaN1ekfcze9ZA/EGYSNH7XOWpx5KdULmWAkhvx0TSGC0900zxH
         VcmeASB8ipPDqqo+pIKXPF6e++vP/7dDDE6wgtb3+yQOga67qNDi7uyV2TJzGV16PupE
         EL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ffo+BFghYOyiUfwtRs9Z93LC8RfNRNR6YWnTHcFyWA4=;
        b=BT/rAYuhPxPyvm4A8Irhm+AnObFZjCxpH99m/lTjxg3paOiFadUB9wQ6rQLxC+udwO
         cUpnkQNSL/6x1SLKlPgTvfoEKRtCH3ftjqfGFzQmbSIibOg8h2Ii6wFs6/briQgdibPu
         DZaxkIZ6MH2lo3kv5WvDmZ/VpTaVowHoboDMnzVG8pLmixow+TWwV/iISvwP/vj4Wsim
         R+e6/f5ap7vVfhfqDCmuU9MWoIkI65VBqZmNon+SMKq4jpYfokblSTclFntBYtGsD/Sk
         k1zeO09zNl9KAg2OKoWQkv9xdNdfmGRqo9mxzQyXIuatt+DykKjUbNtioTk1Cv4ioB43
         K6+A==
X-Gm-Message-State: AOAM532+MN7wxnWeud6qVO/kqNccELp4+ZIig1Zxc+sdDOiPOHgzo+Z3
        jt4ioNKfMmComclXhJngYV0A/g==
X-Google-Smtp-Source: ABdhPJyZKOEWkzuWrpbCfIaSlK/cFovYTDHtSnY0Zu2owhEQ5lf+WOHFqQxw8aoKiDD1Y3HLoJueBw==
X-Received: by 2002:a17:90a:f696:: with SMTP id cl22mr8519679pjb.124.1628508463334;
        Mon, 09 Aug 2021 04:27:43 -0700 (PDT)
Received: from localhost ([210.0.159.74])
        by smtp.gmail.com with ESMTPSA id 8sm9000578pfo.153.2021.08.09.04.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 04:27:42 -0700 (PDT)
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
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 3/3] perf auxtrace arm: Support compat_auxtrace_mmap__{read_head|write_tail}
Date:   Mon,  9 Aug 2021 19:27:27 +0800
Message-Id: <20210809112727.596876-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809112727.596876-1-leo.yan@linaro.org>
References: <20210809112727.596876-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the tool runs with compat mode on Arm platform, the kernel is in
64-bit mode and user space is in 32-bit mode; the user space can use
instructions "ldrd" and "strd" for 64-bit value atomicity.

This patch adds compat_auxtrace_mmap__{read_head|write_tail} for arm
building, it uses "ldrd" and "strd" instructions to ensure accessing
atomicity for aux head and tail.  The file arch/arm/util/auxtrace.c is
built for arm and arm64 building, these two functions are not needed for
arm64, so check the compiler macro "__arm__" to only include them for
arm building.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm/util/auxtrace.c | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index b187bddbd01a..c7c7ec0812d5 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -107,3 +107,35 @@ struct auxtrace_record
 	*err = 0;
 	return NULL;
 }
+
+#if defined(__arm__)
+u64 compat_auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
+{
+	struct perf_event_mmap_page *pc = mm->userpg;
+	u64 result;
+
+	__asm__ __volatile__(
+"	ldrd    %0, %H0, [%1]"
+	: "=&r" (result)
+	: "r" (&pc->aux_head), "Qo" (pc->aux_head)
+	);
+
+	return result;
+}
+
+int compat_auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
+{
+	struct perf_event_mmap_page *pc = mm->userpg;
+
+	/* Ensure all reads are done before we write the tail out */
+	smp_mb();
+
+	__asm__ __volatile__(
+"	strd    %2, %H2, [%1]"
+	: "=Qo" (pc->aux_tail)
+	: "r" (&pc->aux_tail), "r" (tail)
+	);
+
+	return 0;
+}
+#endif
-- 
2.25.1

