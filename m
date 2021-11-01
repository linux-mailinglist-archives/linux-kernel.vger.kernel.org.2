Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8143B4411C5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 02:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhKABSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 21:18:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39144 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhKABSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 21:18:37 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635729363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=QRQbhvPCapyUCdJPIMm3C2OiZudnzqO9rcDul1mvlJA=;
        b=gvroccR3MC4Vcgd5fGEe2ME6hxgoMPuOOpuTtm6WS0dYppb4fR3gJYF+9e3ezkIicpRMje
        9ptgHGWMJpqXFtOwO+/CUfpdpKlBXHtC2eu+cLP5mVo9YKJMY6uGVJjm0y/yp75vOMkvqO
        7U6PFsmM1DaQJhlvIWxkr4N/rr50fnxCG718aD8o3t7YhlgqoUquwKC9Gmfjjv3UBPvFhd
        fy++6fnvAhPSjHXk6nI+PeVx2YLO46em1N+hXIBS4ZhabGbG8Wlr4MO78ELAOQ+lc5mkVA
        T6AWoek5fOTgWvT3g2Acdf3XfHgSYsRyXaCVwcMSAVCYHqaFvv+Fsj1sQA0eXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635729363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=QRQbhvPCapyUCdJPIMm3C2OiZudnzqO9rcDul1mvlJA=;
        b=b5qPkqwkqA+e3ixhmtG6U/4LQLO7i/mqeyTfwJCcDTE2b8372auYcEtd7Va5cVLViA6H+G
        RymhzUtdBi3nVYDQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf/core for v5.16-rc1
References: <163572864256.3357115.931779940195622047.tglx@xen13>
Message-ID: <163572864709.3357115.1660789494337170811.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon,  1 Nov 2021 02:16:03 +0100 (CET)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2021-1=
0-31

up to:  2de71ee153ef: perf/x86/intel: Fix ICL/SPR INST_RETIRED.PREC_DIST enco=
dings


perf updates:

 core:
=20
  - Allow ftrace to instrument parts of the perf core code

  - Add a new mem_hops field to perf_mem_data_src which allows to represent
    intra-node/package or inter-node/off-package details to prepare for
    next generation systems which have more hieararchy within the
    node/pacakge level.

 tools:

  - Update for the new mem_hops field in perf_mem_data_src

 arch:

  - A set of constraints fixes for the Intel uncore PMU

  - The usual set of small fixes and improvements for x86 and PPC

Thanks,

	tglx

------------------>
Adrian Hunter (1):
      perf/x86: Add new event for AUX output counter index

Kajol Jain (4):
      perf: Add comment about current state of PERF_MEM_LVL_* namespace and r=
emove an extra line
      perf: Add mem_hops field in perf_mem_data_src structure
      tools/perf: Add mem_hops field in perf_mem_data_src structure
      powerpc/perf: Fix data source encodings for L2.1 and L3.1 accesses

Kan Liang (7):
      perf/x86/intel/uncore: Support extra IMC channel on Ice Lake server
      perf/x86/intel/uncore: Fix invalid unit check
      perf/x86/intel/uncore: Fix Intel ICX IIO event constraints
      perf/x86/intel/uncore: Fix Intel SPR CHA event constraints
      perf/x86/intel/uncore: Fix Intel SPR IIO event constraints
      perf/x86/intel/uncore: Fix Intel SPR M2PCIE event constraints
      perf/x86/intel/uncore: Fix Intel SPR M3UPI event constraints

Leo Yan (1):
      perf/x86: Add compiler barrier after updating BTS

Song Liu (1):
      perf/core: Allow ftrace for functions in kernel/event/core.c

Stephane Eranian (1):
      perf/x86/intel: Fix ICL/SPR INST_RETIRED.PREC_DIST encodings


 arch/powerpc/perf/isa207-common.c        | 26 +++++++++++++++++++-----
 arch/powerpc/perf/isa207-common.h        |  2 ++
 arch/x86/events/core.c                   |  6 ++++++
 arch/x86/events/intel/bts.c              |  6 ++++++
 arch/x86/events/intel/core.c             | 21 ++++++++++++++++++--
 arch/x86/events/intel/ds.c               |  5 +++--
 arch/x86/events/intel/uncore_discovery.h |  2 +-
 arch/x86/events/intel/uncore_snbep.c     | 16 +++++++++++++--
 arch/x86/events/perf_event.h             |  1 +
 include/linux/perf_event.h               |  1 +
 include/uapi/linux/perf_event.h          | 34 +++++++++++++++++++++++++++++-=
--
 kernel/events/Makefile                   |  5 -----
 kernel/events/core.c                     | 30 ++++++++++++++++++++++++++++
 tools/include/uapi/linux/perf_event.h    | 19 +++++++++++++++---
 tools/perf/util/mem-events.c             | 20 +++++++++++++++++--
 15 files changed, 169 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-com=
mon.c
index f92bf5f6b74f..7ea873ab2e6f 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -238,11 +238,27 @@ static inline u64 isa207_find_source(u64 idx, u32 sub_i=
dx)
 		ret |=3D P(SNOOP, HIT);
 		break;
 	case 5:
-		ret =3D PH(LVL, REM_CCE1);
-		if ((sub_idx =3D=3D 0) || (sub_idx =3D=3D 2) || (sub_idx =3D=3D 4))
-			ret |=3D P(SNOOP, HIT);
-		else if ((sub_idx =3D=3D 1) || (sub_idx =3D=3D 3) || (sub_idx =3D=3D 5))
-			ret |=3D P(SNOOP, HITM);
+		if (cpu_has_feature(CPU_FTR_ARCH_31)) {
+			ret =3D REM | P(HOPS, 0);
+
+			if (sub_idx =3D=3D 0 || sub_idx =3D=3D 4)
+				ret |=3D PH(LVL, L2) | LEVEL(L2) | P(SNOOP, HIT);
+			else if (sub_idx =3D=3D 1 || sub_idx =3D=3D 5)
+				ret |=3D PH(LVL, L2) | LEVEL(L2) | P(SNOOP, HITM);
+			else if (sub_idx =3D=3D 2 || sub_idx =3D=3D 6)
+				ret |=3D PH(LVL, L3) | LEVEL(L3) | P(SNOOP, HIT);
+			else if (sub_idx =3D=3D 3 || sub_idx =3D=3D 7)
+				ret |=3D PH(LVL, L3) | LEVEL(L3) | P(SNOOP, HITM);
+		} else {
+			if (sub_idx =3D=3D 0)
+				ret =3D PH(LVL, L2) | LEVEL(L2) | REM | P(SNOOP, HIT) | P(HOPS, 0);
+			else if (sub_idx =3D=3D 1)
+				ret =3D PH(LVL, L2) | LEVEL(L2) | REM | P(SNOOP, HITM) | P(HOPS, 0);
+			else if (sub_idx =3D=3D 2 || sub_idx =3D=3D 4)
+				ret =3D PH(LVL, L3) | LEVEL(L3) | REM | P(SNOOP, HIT) | P(HOPS, 0);
+			else if (sub_idx =3D=3D 3 || sub_idx =3D=3D 5)
+				ret =3D PH(LVL, L3) | LEVEL(L3) | REM | P(SNOOP, HITM) | P(HOPS, 0);
+		}
 		break;
 	case 6:
 		ret =3D PH(LVL, REM_CCE2);
diff --git a/arch/powerpc/perf/isa207-common.h b/arch/powerpc/perf/isa207-com=
mon.h
index 4a2cbc3dc047..ff122603989b 100644
--- a/arch/powerpc/perf/isa207-common.h
+++ b/arch/powerpc/perf/isa207-common.h
@@ -273,6 +273,8 @@
 #define P(a, b)				PERF_MEM_S(a, b)
 #define PH(a, b)			(P(LVL, HIT) | P(a, b))
 #define PM(a, b)			(P(LVL, MISS) | P(a, b))
+#define LEVEL(x)			P(LVLNUM, x)
+#define REM				P(REMOTE, REMOTE)
=20
 int isa207_get_constraint(u64 event, unsigned long *maskp, unsigned long *va=
lp, u64 event_config1);
 int isa207_compute_mmcr(u64 event[], int n_ev,
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 2a57dbed4894..be33423e9762 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -66,6 +66,8 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_enable_all,  *x86_pmu.enabl=
e_all);
 DEFINE_STATIC_CALL_NULL(x86_pmu_enable,	     *x86_pmu.enable);
 DEFINE_STATIC_CALL_NULL(x86_pmu_disable,     *x86_pmu.disable);
=20
+DEFINE_STATIC_CALL_NULL(x86_pmu_assign, *x86_pmu.assign);
+
 DEFINE_STATIC_CALL_NULL(x86_pmu_add,  *x86_pmu.add);
 DEFINE_STATIC_CALL_NULL(x86_pmu_del,  *x86_pmu.del);
 DEFINE_STATIC_CALL_NULL(x86_pmu_read, *x86_pmu.read);
@@ -1215,6 +1217,8 @@ static inline void x86_assign_hw_event(struct perf_even=
t *event,
 	hwc->last_cpu =3D smp_processor_id();
 	hwc->last_tag =3D ++cpuc->tags[i];
=20
+	static_call_cond(x86_pmu_assign)(event, idx);
+
 	switch (hwc->idx) {
 	case INTEL_PMC_IDX_FIXED_BTS:
 	case INTEL_PMC_IDX_FIXED_VLBR:
@@ -2005,6 +2009,8 @@ static void x86_pmu_static_call_update(void)
 	static_call_update(x86_pmu_enable, x86_pmu.enable);
 	static_call_update(x86_pmu_disable, x86_pmu.disable);
=20
+	static_call_update(x86_pmu_assign, x86_pmu.assign);
+
 	static_call_update(x86_pmu_add, x86_pmu.add);
 	static_call_update(x86_pmu_del, x86_pmu.del);
 	static_call_update(x86_pmu_read, x86_pmu.read);
diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 6320d2cfd9d3..974e917e65b2 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -209,6 +209,12 @@ static void bts_update(struct bts_ctx *bts)
 	} else {
 		local_set(&buf->data_size, head);
 	}
+
+	/*
+	 * Since BTS is coherent, just add compiler barrier to ensure
+	 * BTS updating is ordered against bts::handle::event.
+	 */
+	barrier();
 }
=20
 static int
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7011e87be6d0..c67d95ee685c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -243,7 +243,8 @@ static struct extra_reg intel_skl_extra_regs[] __read_mos=
tly =3D {
=20
 static struct event_constraint intel_icl_event_constraints[] =3D {
 	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
-	FIXED_EVENT_CONSTRAINT(0x01c0, 0),	/* INST_RETIRED.PREC_DIST */
+	FIXED_EVENT_CONSTRAINT(0x01c0, 0),	/* old INST_RETIRED.PREC_DIST */
+	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* INST_RETIRED.PREC_DIST */
 	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
 	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* CPU_CLK_UNHALTED.REF */
 	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
@@ -287,7 +288,7 @@ static struct extra_reg intel_spr_extra_regs[] __read_mos=
tly =3D {
=20
 static struct event_constraint intel_spr_event_constraints[] =3D {
 	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
-	FIXED_EVENT_CONSTRAINT(0x01c0, 0),	/* INST_RETIRED.PREC_DIST */
+	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* INST_RETIRED.PREC_DIST */
 	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
 	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* CPU_CLK_UNHALTED.REF */
 	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
@@ -2402,6 +2403,12 @@ static void intel_pmu_disable_event(struct perf_event =
*event)
 		intel_pmu_pebs_disable(event);
 }
=20
+static void intel_pmu_assign_event(struct perf_event *event, int idx)
+{
+	if (is_pebs_pt(event))
+		perf_report_aux_output_id(event, idx);
+}
+
 static void intel_pmu_del_event(struct perf_event *event)
 {
 	if (needs_branch_stack(event))
@@ -4494,8 +4501,16 @@ static int intel_pmu_check_period(struct perf_event *e=
vent, u64 value)
 	return intel_pmu_has_bts_period(event, value) ? -EINVAL : 0;
 }
=20
+static void intel_aux_output_init(void)
+{
+	/* Refer also intel_pmu_aux_output_match() */
+	if (x86_pmu.intel_cap.pebs_output_pt_available)
+		x86_pmu.assign =3D intel_pmu_assign_event;
+}
+
 static int intel_pmu_aux_output_match(struct perf_event *event)
 {
+	/* intel_pmu_assign_event() is needed, refer intel_aux_output_init() */
 	if (!x86_pmu.intel_cap.pebs_output_pt_available)
 		return 0;
=20
@@ -6301,6 +6316,8 @@ __init int intel_pmu_init(void)
 	if (is_hybrid())
 		intel_pmu_check_hybrid_pmus((u64)fixed_mask);
=20
+	intel_aux_output_init();
+
 	return 0;
 }
=20
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 8647713276a7..4dbb55a43dad 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -923,7 +923,8 @@ struct event_constraint intel_skl_pebs_event_constraints[=
] =3D {
 };
=20
 struct event_constraint intel_icl_pebs_event_constraints[] =3D {
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x1c0, 0x100000000ULL),	/* INST_RETIRED.PREC_=
DIST */
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x01c0, 0x100000000ULL),	/* old INST_RETIRED.=
PREC_DIST */
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0100, 0x100000000ULL),	/* INST_RETIRED.PREC=
_DIST */
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),	/* SLOTS */
=20
 	INTEL_PLD_CONSTRAINT(0x1cd, 0xff),			/* MEM_TRANS_RETIRED.LOAD_LATENCY */
@@ -943,7 +944,7 @@ struct event_constraint intel_icl_pebs_event_constraints[=
] =3D {
 };
=20
 struct event_constraint intel_spr_pebs_event_constraints[] =3D {
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x1c0, 0x100000000ULL),
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_=
DIST */
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
=20
 	INTEL_FLAGS_EVENT_CONSTRAINT(0xc0, 0xfe),
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel=
/uncore_discovery.h
index 7280c8a3c831..6d735611c281 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -30,7 +30,7 @@
=20
=20
 #define uncore_discovery_invalid_unit(unit)			\
-	(!unit.table1 || !unit.ctl || !unit.table3 ||	\
+	(!unit.table1 || !unit.ctl || \
 	 unit.table1 =3D=3D -1ULL || unit.ctl =3D=3D -1ULL ||	\
 	 unit.table3 =3D=3D -1ULL)
=20
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/unc=
ore_snbep.c
index 5ddc0f30db6f..eb2c6cea9d0d 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -452,7 +452,7 @@
 #define ICX_M3UPI_PCI_PMON_BOX_CTL		0xa0
=20
 /* ICX IMC */
-#define ICX_NUMBER_IMC_CHN			2
+#define ICX_NUMBER_IMC_CHN			3
 #define ICX_IMC_MEM_STRIDE			0x4
=20
 /* SPR */
@@ -5076,8 +5076,10 @@ static struct event_constraint icx_uncore_iio_constrai=
nts[] =3D {
 	UNCORE_EVENT_CONSTRAINT(0x02, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x03, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x83, 0x3),
+	UNCORE_EVENT_CONSTRAINT(0x88, 0xc),
 	UNCORE_EVENT_CONSTRAINT(0xc0, 0xc),
 	UNCORE_EVENT_CONSTRAINT(0xc5, 0xc),
+	UNCORE_EVENT_CONSTRAINT(0xd5, 0xc),
 	EVENT_CONSTRAINT_END
 };
=20
@@ -5463,7 +5465,7 @@ static struct intel_uncore_ops icx_uncore_mmio_ops =3D {
 static struct intel_uncore_type icx_uncore_imc =3D {
 	.name		=3D "imc",
 	.num_counters   =3D 4,
-	.num_boxes	=3D 8,
+	.num_boxes	=3D 12,
 	.perf_ctr_bits	=3D 48,
 	.fixed_ctr_bits	=3D 48,
 	.fixed_ctr	=3D SNR_IMC_MMIO_PMON_FIXED_CTR,
@@ -5647,6 +5649,7 @@ static struct intel_uncore_type spr_uncore_chabox =3D {
 	.event_mask		=3D SPR_CHA_PMON_EVENT_MASK,
 	.event_mask_ext		=3D SPR_RAW_EVENT_MASK_EXT,
 	.num_shared_regs	=3D 1,
+	.constraints		=3D skx_uncore_chabox_constraints,
 	.ops			=3D &spr_uncore_chabox_ops,
 	.format_group		=3D &spr_uncore_chabox_format_group,
 	.attr_update		=3D uncore_alias_groups,
@@ -5658,6 +5661,7 @@ static struct intel_uncore_type spr_uncore_iio =3D {
 	.event_mask_ext		=3D SNR_IIO_PMON_RAW_EVENT_MASK_EXT,
 	.format_group		=3D &snr_uncore_iio_format_group,
 	.attr_update		=3D uncore_alias_groups,
+	.constraints		=3D icx_uncore_iio_constraints,
 };
=20
 static struct attribute *spr_uncore_raw_formats_attr[] =3D {
@@ -5686,9 +5690,16 @@ static struct intel_uncore_type spr_uncore_irp =3D {
=20
 };
=20
+static struct event_constraint spr_uncore_m2pcie_constraints[] =3D {
+	UNCORE_EVENT_CONSTRAINT(0x14, 0x3),
+	UNCORE_EVENT_CONSTRAINT(0x2d, 0x3),
+	EVENT_CONSTRAINT_END
+};
+
 static struct intel_uncore_type spr_uncore_m2pcie =3D {
 	SPR_UNCORE_COMMON_FORMAT(),
 	.name			=3D "m2pcie",
+	.constraints		=3D spr_uncore_m2pcie_constraints,
 };
=20
 static struct intel_uncore_type spr_uncore_pcu =3D {
@@ -5765,6 +5776,7 @@ static struct intel_uncore_type spr_uncore_upi =3D {
 static struct intel_uncore_type spr_uncore_m3upi =3D {
 	SPR_UNCORE_PCI_COMMON_FORMAT(),
 	.name			=3D "m3upi",
+	.constraints		=3D icx_uncore_m3upi_constraints,
 };
=20
 static struct intel_uncore_type spr_uncore_mdf =3D {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e3ac05c97b5e..76436a55d9ba 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -726,6 +726,7 @@ struct x86_pmu {
 	void		(*enable_all)(int added);
 	void		(*enable)(struct perf_event *);
 	void		(*disable)(struct perf_event *);
+	void		(*assign)(struct perf_event *event, int idx);
 	void		(*add)(struct perf_event *);
 	void		(*del)(struct perf_event *);
 	void		(*read)(struct perf_event *event);
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2d510ad750ed..126b3a314f3a 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1397,6 +1397,7 @@ perf_event_addr_filters(struct perf_event *event)
 }
=20
 extern void perf_event_addr_filters_sync(struct perf_event *event);
+extern void perf_report_aux_output_id(struct perf_event *event, u64 hw_id);
=20
 extern int perf_output_begin(struct perf_output_handle *handle,
 			     struct perf_sample_data *data,
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index f92880a15645..bd8860eeb291 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1141,6 +1141,21 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_TEXT_POKE			=3D 20,
=20
+	/*
+	 * Data written to the AUX area by hardware due to aux_output, may need
+	 * to be matched to the event by an architecture-specific hardware ID.
+	 * This records the hardware ID, but requires sample_id to provide the
+	 * event ID. e.g. Intel PT uses this record to disambiguate PEBS-via-PT
+	 * records from multiple events.
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				hw_id;
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_AUX_OUTPUT_HW_ID		=3D 21,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
=20
@@ -1210,14 +1225,16 @@ union perf_mem_data_src {
 			mem_remote:1,   /* remote */
 			mem_snoopx:2,	/* snoop mode, ext */
 			mem_blk:3,	/* access blocked */
-			mem_rsvd:21;
+			mem_hops:3,	/* hop level */
+			mem_rsvd:18;
 	};
 };
 #elif defined(__BIG_ENDIAN_BITFIELD)
 union perf_mem_data_src {
 	__u64 val;
 	struct {
-		__u64	mem_rsvd:21,
+		__u64	mem_rsvd:18,
+			mem_hops:3,	/* hop level */
 			mem_blk:3,	/* access blocked */
 			mem_snoopx:2,	/* snoop mode, ext */
 			mem_remote:1,   /* remote */
@@ -1241,7 +1258,13 @@ union perf_mem_data_src {
 #define PERF_MEM_OP_EXEC	0x10 /* code (execution) */
 #define PERF_MEM_OP_SHIFT	0
=20
-/* memory hierarchy (memory level, hit or miss) */
+/*
+ * PERF_MEM_LVL_* namespace being depricated to some extent in the
+ * favour of newer composite PERF_MEM_{LVLNUM_,REMOTE_,SNOOPX_} fields.
+ * Supporting this namespace inorder to not break defined ABIs.
+ *
+ * memory hierarchy (memory level, hit or miss)
+ */
 #define PERF_MEM_LVL_NA		0x01  /* not available */
 #define PERF_MEM_LVL_HIT	0x02  /* hit level */
 #define PERF_MEM_LVL_MISS	0x04  /* miss level  */
@@ -1307,6 +1330,11 @@ union perf_mem_data_src {
 #define PERF_MEM_BLK_ADDR	0x04 /* address conflict */
 #define PERF_MEM_BLK_SHIFT	40
=20
+/* hop level */
+#define PERF_MEM_HOPS_0		0x01 /* remote core, same node */
+/* 2-7 available */
+#define PERF_MEM_HOPS_SHIFT	43
+
 #define PERF_MEM_S(a, s) \
 	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
=20
diff --git a/kernel/events/Makefile b/kernel/events/Makefile
index 3c022e33c109..8591c180b52b 100644
--- a/kernel/events/Makefile
+++ b/kernel/events/Makefile
@@ -1,10 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ifdef CONFIG_FUNCTION_TRACER
-CFLAGS_REMOVE_core.o =3D $(CC_FLAGS_FTRACE)
-endif
-
 obj-y :=3D core.o ring_buffer.o callchain.o
=20
 obj-$(CONFIG_HAVE_HW_BREAKPOINT) +=3D hw_breakpoint.o
 obj-$(CONFIG_UPROBES) +=3D uprobes.o
-
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1cb1f9b8392e..0e90a5084f18 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9062,6 +9062,36 @@ static void perf_log_itrace_start(struct perf_event *e=
vent)
 	perf_output_end(&handle);
 }
=20
+void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
+{
+	struct perf_output_handle handle;
+	struct perf_sample_data sample;
+	struct perf_aux_event {
+		struct perf_event_header        header;
+		u64				hw_id;
+	} rec;
+	int ret;
+
+	if (event->parent)
+		event =3D event->parent;
+
+	rec.header.type	=3D PERF_RECORD_AUX_OUTPUT_HW_ID;
+	rec.header.misc	=3D 0;
+	rec.header.size	=3D sizeof(rec);
+	rec.hw_id	=3D hw_id;
+
+	perf_event_header__init_id(&rec.header, &sample, event);
+	ret =3D perf_output_begin(&handle, &sample, event, rec.header.size);
+
+	if (ret)
+		return;
+
+	perf_output_put(&handle, rec);
+	perf_event__output_id_sample(event, &handle, &sample);
+
+	perf_output_end(&handle);
+}
+
 static int
 __perf_event_account_interrupt(struct perf_event *event, int throttle)
 {
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux=
/perf_event.h
index f92880a15645..2fc09579e24a 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1210,14 +1210,16 @@ union perf_mem_data_src {
 			mem_remote:1,   /* remote */
 			mem_snoopx:2,	/* snoop mode, ext */
 			mem_blk:3,	/* access blocked */
-			mem_rsvd:21;
+			mem_hops:3,	/* hop level */
+			mem_rsvd:18;
 	};
 };
 #elif defined(__BIG_ENDIAN_BITFIELD)
 union perf_mem_data_src {
 	__u64 val;
 	struct {
-		__u64	mem_rsvd:21,
+		__u64	mem_rsvd:18,
+			mem_hops:3,	/* hop level */
 			mem_blk:3,	/* access blocked */
 			mem_snoopx:2,	/* snoop mode, ext */
 			mem_remote:1,   /* remote */
@@ -1241,7 +1243,13 @@ union perf_mem_data_src {
 #define PERF_MEM_OP_EXEC	0x10 /* code (execution) */
 #define PERF_MEM_OP_SHIFT	0
=20
-/* memory hierarchy (memory level, hit or miss) */
+/*
+ * PERF_MEM_LVL_* namespace being depricated to some extent in the
+ * favour of newer composite PERF_MEM_{LVLNUM_,REMOTE_,SNOOPX_} fields.
+ * Supporting this namespace inorder to not break defined ABIs.
+ *
+ * memory hierarchy (memory level, hit or miss)
+ */
 #define PERF_MEM_LVL_NA		0x01  /* not available */
 #define PERF_MEM_LVL_HIT	0x02  /* hit level */
 #define PERF_MEM_LVL_MISS	0x04  /* miss level  */
@@ -1307,6 +1315,11 @@ union perf_mem_data_src {
 #define PERF_MEM_BLK_ADDR	0x04 /* address conflict */
 #define PERF_MEM_BLK_SHIFT	40
=20
+/* hop level */
+#define PERF_MEM_HOPS_0		0x01 /* remote core, same node */
+/* 2-7 available */
+#define PERF_MEM_HOPS_SHIFT	43
+
 #define PERF_MEM_S(a, s) \
 	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
=20
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index f0e75df72b80..3167b4628b6d 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -301,6 +301,16 @@ static const char * const mem_lvlnum[] =3D {
 	[PERF_MEM_LVLNUM_NA] =3D "N/A",
 };
=20
+static const char * const mem_hops[] =3D {
+	"N/A",
+	/*
+	 * While printing, 'Remote' will be added to represent
+	 * 'Remote core, same node' accesses as remote field need
+	 * to be set with mem_hops field.
+	 */
+	"core, same node",
+};
+
 int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 {
 	size_t i, l =3D 0;
@@ -320,12 +330,14 @@ int perf_mem__lvl_scnprintf(char *out, size_t sz, struc=
t mem_info *mem_info)
 	/* already taken care of */
 	m &=3D ~(PERF_MEM_LVL_HIT|PERF_MEM_LVL_MISS);
=20
-
 	if (mem_info && mem_info->data_src.mem_remote) {
 		strcat(out, "Remote ");
 		l +=3D 7;
 	}
=20
+	if (mem_info && mem_info->data_src.mem_hops)
+		l +=3D scnprintf(out + l, sz - l, "%s ", mem_hops[mem_info->data_src.mem_h=
ops]);
+
 	printed =3D 0;
 	for (i =3D 0; m && i < ARRAY_SIZE(mem_lvl); i++, m >>=3D 1) {
 		if (!(m & 0x1))
@@ -472,8 +484,12 @@ int c2c_decode_stats(struct c2c_stats *stats, struct mem=
_info *mi)
 	/*
 	 * Skylake might report unknown remote level via this
 	 * bit, consider it when evaluating remote HITMs.
+	 *
+	 * Incase of power, remote field can also be used to denote cache
+	 * accesses from the another core of same node. Hence, setting
+	 * mrem only when HOPS is zero along with set remote field.
 	 */
-	bool mrem  =3D data_src->mem_remote;
+	bool mrem  =3D (data_src->mem_remote && !data_src->mem_hops);
 	int err =3D 0;
=20
 #define HITM_INC(__f)		\

