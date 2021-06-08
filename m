Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323B239F9A0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbhFHOzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:55:39 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:42983 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbhFHOzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:55:38 -0400
Received: by mail-pg1-f180.google.com with SMTP id i34so10277649pgl.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 07:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GjjYvlo6o9qYmuvrmoD8jiP53R/+0wba+qif8TcHjrA=;
        b=u5mAwC3u3L5IH46vd4ciAayfeQ3nM5sy5exzt+TJQM2OAWL93U9IvLDtrUkohttu9F
         KvDPwUjzRKCry+ExqTn8qeDxr6nrRdvYoygi01TupNLKCuP7cnjpZzRZK8qiRMi2NRrc
         5P4+FnoivbBeUQj8kXjARRI+/Ya6Ezudu/TnVq8xRHXPCLNIFXkNvgK+6WhVQl3qWsbO
         3zu+SAOEyiE3b1NUiFn1sOBDKkdYJEcAwRpP0LuMevVh4GeakYKK6TjbGlNDRYoqKbNO
         GhEoGVdYM3WzA5k8o2hjzKy7CzQ/bVkpWw2hJ53GNm7J9RAywW6VFWshcRWYZ3q+n6ko
         yQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GjjYvlo6o9qYmuvrmoD8jiP53R/+0wba+qif8TcHjrA=;
        b=OewFk0ve/T4feYx3MUpDZlOniuGMn/3Jtwbzr9tylP1/zn6dK5IPLeIV6j/IfoeYUw
         eAI5o7mMOQHkBNhi6TGm8NE+26kU1DgqRMHcpYmAheYozZT79gyaEAGte2y48j73XcLt
         tgxh9swGUY7QJcnUkF83GTw2xCVTXakQOO2QhYg++ilRuzywyrj+gn9l+T73rjFZ1Z6X
         yTZ1WRfWBfb/Mv+TonrLyeGx/H//sa9O+n5Opiexto+0+HmZqAeCzFTFiU4JvpADIf5Q
         kIU8RuGYLfnU6rTb+CWuWYpeefHWMxflnHaL4dU2uywqqniBZUw1jR8glLUCoXJej1Na
         6ezg==
X-Gm-Message-State: AOAM531hxhAnjhvj/GCGHcWyXp8RNzsRFz2ckFJWzTgz+OdqBNnHT5Zy
        VQepWDkRTU3vAv/SR72NzKNtzg==
X-Google-Smtp-Source: ABdhPJys2rCAqYVEXhJeccvB2e2xd98ttYnH2gIKxpWEHJqhce3k27GEFOHEg/jAY1/ItRpj2TDPoA==
X-Received: by 2002:a63:b30a:: with SMTP id i10mr22916323pgf.306.1623163965453;
        Tue, 08 Jun 2021 07:52:45 -0700 (PDT)
Received: from localhost (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id r5sm2793644pjd.2.2021.06.08.07.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 07:52:45 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 2/2] arm64: perf: Report error if PMU fails to support current CPU
Date:   Tue,  8 Jun 2021 22:52:28 +0800
Message-Id: <20210608145228.36595-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608145228.36595-1-leo.yan@linaro.org>
References: <20210608145228.36595-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When run perf command on the Arm big.LITTLE system (Juno-r2 board):

  perf record -e cycles --per-thread program

The command executes normally without any errors; but when report the
result with "perf report", it fails to parse the symbols.  This is
because the perf data file doesn't contain MMAP2 events, thus it cannot
find the correct object file for parsing symbols.

On the big.LITTLE system, if the initialized PMU doesn't match with the
CPU the profiled task is scheduled on; for example, the initialized PMU
is on CPU0 in the LITTLE cluster, when invoke the function
perf_event_mmap_event() on CPU2 in the big cluster, the event is always
filtered out due to the CPU2 is not supported by the initialized PMU.
Finally, there have no any MMAP2 samples are generated for the
profiling.

This patch doesn't fix for this issue, alternatively, it simply reports
an error when detect the current CPU is not supported by PMU, so can
remind the user for the abnormal situation.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/perf/arm_pmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index aedea060ca8b..99ddc8bf6466 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -565,6 +565,9 @@ static int armpmu_filter_match(struct perf_event *event)
 	int ret;
 
 	ret = cpumask_test_cpu(cpu, &armpmu->supported_cpus);
+	if (!ret)
+		pr_err("PMU doesn't support current CPU %d\n", cpu);
+
 	if (ret && armpmu->filter_match)
 		return armpmu->filter_match(event);
 
-- 
2.25.1

