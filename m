Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1C83650B9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 05:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhDTDQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 23:16:13 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:36677 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbhDTDPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 23:15:55 -0400
Received: by mail-oi1-f172.google.com with SMTP id v6so9814883oiv.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 20:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fe06l4mMv/umMH3B2MqQPjc0UcqJVWjftNupHuwIv3M=;
        b=PWHOX2ZmkCMcLwFrLJ6tMRqK0oP6bACHeXS+ksbb47wLVaMehAw1fkDSSr28bKqlol
         kdEA45OaAGT6zg4t1GRe4EtonaXYNzWRDEfklB0OB+fXJjEbUJHVLFx638j0yNmwW65k
         5efW/EDoNYLO3v7/HcMOh3YNaRr5b4S6h52UZXI6U7mSGGeh66g4rdDTokB55bwIhkkA
         voLdMySFaSqhAkT2kt20TEjzTcVa76eGK65a1ZlBebhYf5V/fBGjWhuRis+rmYvZmGBi
         2BSiEwBj1kDT4kWVt6dn8I8ofhq93uxYOVbIoG/P+yTRcUOFTNQ4djLYraPTVEeBtYrK
         HeWw==
X-Gm-Message-State: AOAM531iIVpK0jAYzLt1e8gBgYDThLwkO9dccp1wc1qf5ezhpsVHb0YP
        R5aCUaaOW5DZ5ibf0zigeQ==
X-Google-Smtp-Source: ABdhPJwFnnE12a945ApPg7D1QPBH7crLjsZAs4f3E13EDN8Kbcjr0x4ok7Ya+2cNi/5hbw+8ooiSJA==
X-Received: by 2002:aca:33d5:: with SMTP id z204mr1633768oiz.32.1618888522872;
        Mon, 19 Apr 2021 20:15:22 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id g16sm2347896oof.43.2021.04.19.20.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 20:15:21 -0700 (PDT)
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
Subject: [PATCH v7 5/9] arm64: perf: Add userspace counter access disable switch
Date:   Mon, 19 Apr 2021 22:15:07 -0500
Message-Id: <20210420031511.2348977-6-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210420031511.2348977-1-robh@kernel.org>
References: <20210420031511.2348977-1-robh@kernel.org>
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
 arch/arm64/kernel/perf_event.c | 61 ++++++++++++++++++++++++++++++++--
 include/linux/perf/arm_pmu.h   |  4 ++-
 2 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index bfbb7f449aca..1ab6308ca89c 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -336,6 +336,54 @@ static const struct attribute_group armv8_pmuv3_caps_attr_group = {
 	.attrs = armv8_pmuv3_caps_attrs,
 };
 
+static void armv8pmu_disable_user_access(void *mm);
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
+	if (val != cpu_pmu->attr_rdpmc) {
+		cpu_pmu->attr_rdpmc = !!val;
+		if (!val)
+			on_each_cpu_mask(&cpu_pmu->supported_cpus, armv8pmu_disable_user_access, NULL, 1);
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
@@ -950,7 +998,8 @@ static void armv8pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
 	 * If a new task has user access enabled, clear the dirty counters
 	 * to prevent the potential leak.
 	 */
-	if (ctx && current->mm && atomic_read(&current->mm->context.pmu_direct_access)) {
+	if (ctx && to_arm_pmu(ctx->pmu)->attr_rdpmc &&
+	    current->mm && atomic_read(&current->mm->context.pmu_direct_access)) {
 		armv8pmu_enable_user_access();
 		armv8pmu_clear_dirty_counters(to_arm_pmu(ctx->pmu));
 	} else {
@@ -1093,7 +1142,8 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 				       &armv8_pmuv3_perf_cache_map,
 				       ARMV8_PMU_EVTYPE_EVENT);
 
-	if (armv8pmu_event_want_user_access(event) || !armv8pmu_event_is_64bit(event))
+	if (armpmu->attr_rdpmc &&
+	    (armv8pmu_event_want_user_access(event) || !armv8pmu_event_is_64bit(event)))
 		event->hw.flags |= ARMPMU_EL0_RD_CNTR;
 
 	/*
@@ -1218,7 +1268,9 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
 
 static int armv8pmu_undef_handler(struct pt_regs *regs, u32 insn)
 {
-	if (atomic_read(&current->mm->context.pmu_direct_access)) {
+	struct arm_pmu *armpmu = *this_cpu_ptr(&cpu_armpmu);
+
+	if (armpmu->attr_rdpmc && atomic_read(&current->mm->context.pmu_direct_access)) {
 		armv8pmu_enable_user_access();
 		return 0;
 	}
@@ -1277,6 +1329,9 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_CAPS] = caps ?
 			caps : &armv8_pmuv3_caps_attr_group;
 
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_RDPMC] = &armv8_pmuv3_rdpmc_attr_group;
+	cpu_pmu->attr_rdpmc = true;
+
 	return 0;
 }
 
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 1daad3b2cce5..9303cd07ac57 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -82,6 +82,7 @@ enum armpmu_attr_groups {
 	ARMPMU_ATTR_GROUP_EVENTS,
 	ARMPMU_ATTR_GROUP_FORMATS,
 	ARMPMU_ATTR_GROUP_CAPS,
+	ARMPMU_ATTR_GROUP_RDPMC,
 	ARMPMU_NR_ATTR_GROUPS
 };
 
@@ -107,7 +108,8 @@ struct arm_pmu {
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

