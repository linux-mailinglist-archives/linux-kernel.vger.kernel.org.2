Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACBA383DDE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 21:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbhEQTzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 15:55:44 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:38822 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236743AbhEQTzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 15:55:33 -0400
Received: by mail-oi1-f170.google.com with SMTP id z3so7568405oib.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4cNBCoea0mf78a2MH4F0spkjulstbsJuX6u2flP4NwM=;
        b=HxbAnZZzIRGJqwwyezl7eVaohZEk53YQVd41Y19SiudY2/V8knopMz+m39o7RyJFPd
         yIUFyODXP3RbUg5bEHllvh87BP+oaMfemMY3pkLNTcRygjc7GgoerfOe3E+57NJUD+Py
         RdvI69hrEkP/GIst8UP34oW9gwxaVogGbH5UtPj+5VFAL54FK61GrrK+f8RUmLnQ0cFN
         m7p427bkaBJQIid9GmhAdUTii5rbHL8XE6PZmlAiOGe6YdObPqWcm2UeHrqGqtIe2aW9
         bi1UMqTOmEbyEPPRheUIZCDp4dMFoaRD76jXK8lHX/qF9rYE9N+nd3UVGJIvZrZCwm/w
         CQrw==
X-Gm-Message-State: AOAM532w8b0/bVqsKj+2VhrWZVO9xxhbao2+IZf65yKzQjo5QBMkIGJn
        8caZIAYlxG2bbrIZdvLNvQ==
X-Google-Smtp-Source: ABdhPJwsT9q/WJRnG8Ec/1MXZWl7bJ6fKA4esaU21p/pJRaBjygtmPU1lk3pGfOayWL+IWpPgQCGHg==
X-Received: by 2002:a05:6808:13d5:: with SMTP id d21mr1087201oiw.31.1621281255773;
        Mon, 17 May 2021 12:54:15 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id m81sm2920758oig.43.2021.05.17.12.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 12:54:14 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 4/5] arm64: perf: Add userspace counter access disable switch
Date:   Mon, 17 May 2021 14:54:04 -0500
Message-Id: <20210517195405.3079458-5-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210517195405.3079458-1-robh@kernel.org>
References: <20210517195405.3079458-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like x86, some users may want to disable userspace PMU counter
altogether. Add a sysfs 'rdpmc' file to control userspace counter
access. The default is '1' which is enabled. Writing '0' disables
access.

In the case of multiple PMUs (i.e. big.LITTLE), the control is per PMU
and userspace must disable access on each PMU.

Note that x86 also supports writing '2' to globally enable user access.
As there's not existing userspace support to worry about, this shouldn't
be necessary for Arm. It could be added later if the need arises.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v8:
 - Adjust due to patch 3 changes
v7:
 - New patch
---
 arch/arm64/kernel/perf_event.c | 64 ++++++++++++++++++++++++++++++++--
 include/linux/perf/arm_pmu.h   |  4 ++-
 2 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index dc79cf7b58ee..4e7b93c23db9 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -334,6 +334,60 @@ static const struct attribute_group armv8_pmuv3_caps_attr_group = {
 	.attrs = armv8_pmuv3_caps_attrs,
 };

+static void armv8pmu_disable_user_access(void);
+
+static void armv8pmu_disable_user_access_ipi(void *unused)
+{
+	armv8pmu_disable_user_access();
+}
+
+static ssize_t get_attr_rdpmc(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct arm_pmu *cpu_pmu = container_of(pmu, struct arm_pmu, pmu);
+
+	return snprintf(buf, 40, "%d\n", cpu_pmu->attr_rdpmc);
+}
+
+static ssize_t set_attr_rdpmc(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct arm_pmu *cpu_pmu = container_of(pmu, struct arm_pmu, pmu);
+	unsigned long val;
+	ssize_t ret;
+
+	ret = kstrtoul(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	if (val > 1)
+		return -EINVAL;
+
+	if (!!val != cpu_pmu->attr_rdpmc) {
+		cpu_pmu->attr_rdpmc = !!val;
+		if (!val)
+			on_each_cpu_mask(&cpu_pmu->supported_cpus,
+				armv8pmu_disable_user_access_ipi, NULL, 1);
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR(rdpmc, S_IRUSR | S_IWUSR, get_attr_rdpmc, set_attr_rdpmc);
+
+static struct attribute *armv8_pmuv3_rdpmc_attrs[] = {
+	&dev_attr_rdpmc.attr,
+	NULL,
+};
+
+static const struct attribute_group armv8_pmuv3_rdpmc_attr_group = {
+	.attrs = armv8_pmuv3_rdpmc_attrs,
+};
+
 /*
  * Perf Events' indices
  */
@@ -711,6 +765,9 @@ static void armv8pmu_enable_user_access(struct arm_pmu *cpu_pmu)
 {
 	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);

+	if (!cpu_pmu->attr_rdpmc)
+		return;
+
 	if (!bitmap_empty(cpuc->dirty_mask, ARMPMU_MAX_HWEVENTS)) {
 		int i;
 		/* Don't need to clear assigned counters. */
@@ -918,7 +975,7 @@ static void armv8pmu_clear_event_idx(struct pmu_hw_events *cpuc,

 static int armv8pmu_access_event_idx(struct perf_event *event)
 {
-	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
+	if (!to_arm_pmu(event->pmu)->attr_rdpmc || !(event->hw.flags & ARMPMU_EL0_RD_CNTR))
 		return 0;

 	/*
@@ -1071,7 +1128,7 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 		event->hw.flags |= ARMPMU_EVT_64BIT;

 	/* Userspace counter access only enabled if requested and a per task event */
-	if (armv8pmu_event_want_user_access(event) && event->hw.target)
+	if (to_arm_pmu(event->pmu)->attr_rdpmc && armv8pmu_event_want_user_access(event) && event->hw.target)
 		event->hw.flags |= ARMPMU_EL0_RD_CNTR;

 	/* Only expose micro/arch events supported by this PMU */
@@ -1219,6 +1276,9 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_CAPS] = caps ?
 			caps : &armv8_pmuv3_caps_attr_group;

+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_RDPMC] = &armv8_pmuv3_rdpmc_attr_group;
+	cpu_pmu->attr_rdpmc = true;
+
 	return 0;
 }

diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 02ab0010c6d0..2ecd41df29dd 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -81,6 +81,7 @@ enum armpmu_attr_groups {
 	ARMPMU_ATTR_GROUP_EVENTS,
 	ARMPMU_ATTR_GROUP_FORMATS,
 	ARMPMU_ATTR_GROUP_CAPS,
+	ARMPMU_ATTR_GROUP_RDPMC,
 	ARMPMU_NR_ATTR_GROUPS
 };

@@ -106,7 +107,8 @@ struct arm_pmu {
 	int		(*map_event)(struct perf_event *event);
 	int		(*filter_match)(struct perf_event *event);
 	int		num_events;
-	bool		secure_access; /* 32-bit ARM only */
+	bool		secure_access:1; /* 32-bit ARM only */
+	bool		attr_rdpmc:1;
 #define ARMV8_PMUV3_MAX_COMMON_EVENTS		0x40
 	DECLARE_BITMAP(pmceid_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
 #define ARMV8_PMUV3_EXT_COMMON_EVENT_BASE	0x4000
--
2.27.0
