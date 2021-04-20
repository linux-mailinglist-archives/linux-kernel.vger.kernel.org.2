Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5ED3650B7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 05:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbhDTDQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 23:16:06 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:40779 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbhDTDPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 23:15:52 -0400
Received: by mail-oi1-f169.google.com with SMTP id u16so20313610oiu.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 20:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KftKmS/o27Sgcc1bT74gmV9DoDXvkolzpYg8pd6W3VI=;
        b=jg7HmEm5KHqgEzY66JadAKnvMF/CcSeHZAX69kT/07CUgNHq7mXnxO71U9HtKgflKL
         T25QzJCY2QDVfU5xTtMhg+BqSNyG6Dq034zDzoyojHEtlC9h7cs5gN9fSpINsLizlACI
         HtZ/AwkHz5Z1y18B03RLhmJjLiH6QJ4IM51JqIZ1NIRRZMo5AP5qCF2X/GLF3Sk45MGl
         IAVbRmxe2OQTBH/rsaqL2aU/mpT31N/rzVHBWVmdug89Pu93JmkEPfgmX6nNwJZsNyJD
         E04awkH/criRsDSBzMCb8D/sYRnw6QmsBWk6uCa0l9Z0yoR8+JSIpTe0PDrIkAPMhCks
         nxtQ==
X-Gm-Message-State: AOAM533Azz6SIsfPBqwc1DNckn4glMCj6y4bfVLEl+42LRuhfYUmlkA3
        gEVpLVE7XH2djHJL6xnMeg==
X-Google-Smtp-Source: ABdhPJxsK2DzpEeJyXr3X69a2tHZ7oR+L1gWKVPUP1pZFIAbKl2SXiMmqMWi1Bxotx5uMWMS+0uPZQ==
X-Received: by 2002:aca:408b:: with SMTP id n133mr1596036oia.13.1618888520829;
        Mon, 19 Apr 2021 20:15:20 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id g16sm2347896oof.43.2021.04.19.20.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 20:15:20 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/9] drivers/perf: arm_pmu: Export the per_cpu cpu_armpmu
Date:   Mon, 19 Apr 2021 22:15:06 -0500
Message-Id: <20210420031511.2348977-5-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210420031511.2348977-1-robh@kernel.org>
References: <20210420031511.2348977-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm64 PMU driver needs to retrieve the struct arm_pmu pointer for
the current CPU. As the common code already maintains this with the
percpu cpu_armpmu, let's make it global.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/perf/arm_pmu.c       | 2 +-
 include/linux/perf/arm_pmu.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 2d10d84fb79c..6ac56280b9c7 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -99,7 +99,7 @@ static const struct pmu_irq_ops percpu_pmunmi_ops = {
 	.free_pmuirq = armpmu_free_percpu_pmunmi
 };
 
-static DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
+DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
 static DEFINE_PER_CPU(int, cpu_irq);
 static DEFINE_PER_CPU(const struct pmu_irq_ops *, cpu_irq_ops);
 
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 63af052e3909..1daad3b2cce5 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -127,6 +127,8 @@ struct arm_pmu {
 
 #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
 
+DECLARE_PER_CPU(struct arm_pmu *, cpu_armpmu);
+
 u64 armpmu_event_update(struct perf_event *event);
 
 int armpmu_event_set_period(struct perf_event *event);
-- 
2.27.0

