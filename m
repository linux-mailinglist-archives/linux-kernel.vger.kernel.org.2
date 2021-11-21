Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DD645845A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 16:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238227AbhKUPMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 10:12:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54408 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237304AbhKUPMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 10:12:33 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637507367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cohdbTKlGGX0pZ6VypJAN45PTv7vQ8glM8IofVNTmbs=;
        b=BxhXUr+qCYswEPc802ryg1yeFWcW4WLB0lRzQ0mljgPG8H3AKC9mTSxvSxBrKyJeTGeKcN
        OAI6p//B4P+kHhpWODr7dIXMEKM5iyR7GrkWtPuV9kOOXcaINAgF8msk21Uoj6PkO6Nlmb
        rxkhvsagmykYyKm8gv7BbEhFJuJm1BP2kuwESZC9kk/WmszKj1StQ9Q4UCZOaM0dr5KmCk
        Pt63gLVN2D/ePBwS5SsH+AuHNOnblqA2mIYzREgGgqpW50QfVd2jTXBbNvAmClD91ecCXq
        lCGmBMsoWVZACeXaVDRQhZjJiYecFrurU7WrS6UdZdHAcyukWrLd7ZhbueFE2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637507367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cohdbTKlGGX0pZ6VypJAN45PTv7vQ8glM8IofVNTmbs=;
        b=x4/k6hpzcyeJiOl0LwvhnNS7kUhD76qh4mvpg31QFyK8DEHDXnXzWO9uoq57Cjo0bF/W0L
        X0MDNreLN8JfMfDA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf/urgent for v5.16-rc1
Message-ID: <163750734517.21962.4980600300710105647.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 21 Nov 2021 16:09:26 +0100 (CET)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2021=
-11-21

up to:  f3fd84a3b775: x86/perf: Fix snapshot_branch_stack warning in VM

A set of perf/X86 fixes:

 - Remove unneded PEBS disabling when taking LBR snapshots to prevent an
   unchecked MSR access error.

 - Fix IIO event constraints for Snowridge and Skylake server chips.

Thanks,

	tglx

------------------>
Alexander Antonov (3):
      perf/x86/intel/uncore: Fix filter_tid mask for CHA events on Skylake Se=
rver
      perf/x86/intel/uncore: Fix IIO event constraints for Skylake Server
      perf/x86/intel/uncore: Fix IIO event constraints for Snowridge

Song Liu (1):
      x86/perf: Fix snapshot_branch_stack warning in VM


 arch/x86/events/intel/core.c         |  2 --
 arch/x86/events/intel/uncore_snbep.c | 12 ++++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 42cf01ecdd13..ec6444f2c9dc 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2211,7 +2211,6 @@ intel_pmu_snapshot_branch_stack(struct perf_branch_entr=
y *entries, unsigned int
 	/* must not have branches... */
 	local_irq_save(flags);
 	__intel_pmu_disable_all(false); /* we don't care about BTS */
-	__intel_pmu_pebs_disable_all();
 	__intel_pmu_lbr_disable();
 	/*            ... until here */
 	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags);
@@ -2225,7 +2224,6 @@ intel_pmu_snapshot_arch_branch_stack(struct perf_branch=
_entry *entries, unsigned
 	/* must not have branches... */
 	local_irq_save(flags);
 	__intel_pmu_disable_all(false); /* we don't care about BTS */
-	__intel_pmu_pebs_disable_all();
 	__intel_pmu_arch_lbr_disable();
 	/*            ... until here */
 	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/unc=
ore_snbep.c
index eb2c6cea9d0d..3660f698fb2a 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3608,6 +3608,9 @@ static int skx_cha_hw_config(struct intel_uncore_box *b=
ox, struct perf_event *ev
 	struct hw_perf_event_extra *reg1 =3D &event->hw.extra_reg;
 	struct extra_reg *er;
 	int idx =3D 0;
+	/* Any of the CHA events may be filtered by Thread/Core-ID.*/
+	if (event->hw.config & SNBEP_CBO_PMON_CTL_TID_EN)
+		idx =3D SKX_CHA_MSR_PMON_BOX_FILTER_TID;
=20
 	for (er =3D skx_uncore_cha_extra_regs; er->msr; er++) {
 		if (er->event !=3D (event->hw.config & er->config_mask))
@@ -3675,6 +3678,7 @@ static struct event_constraint skx_uncore_iio_constrain=
ts[] =3D {
 	UNCORE_EVENT_CONSTRAINT(0xc0, 0xc),
 	UNCORE_EVENT_CONSTRAINT(0xc5, 0xc),
 	UNCORE_EVENT_CONSTRAINT(0xd4, 0xc),
+	UNCORE_EVENT_CONSTRAINT(0xd5, 0xc),
 	EVENT_CONSTRAINT_END
 };
=20
@@ -4525,6 +4529,13 @@ static void snr_iio_cleanup_mapping(struct intel_uncor=
e_type *type)
 	pmu_iio_cleanup_mapping(type, &snr_iio_mapping_group);
 }
=20
+static struct event_constraint snr_uncore_iio_constraints[] =3D {
+	UNCORE_EVENT_CONSTRAINT(0x83, 0x3),
+	UNCORE_EVENT_CONSTRAINT(0xc0, 0xc),
+	UNCORE_EVENT_CONSTRAINT(0xd5, 0xc),
+	EVENT_CONSTRAINT_END
+};
+
 static struct intel_uncore_type snr_uncore_iio =3D {
 	.name			=3D "iio",
 	.num_counters		=3D 4,
@@ -4536,6 +4547,7 @@ static struct intel_uncore_type snr_uncore_iio =3D {
 	.event_mask_ext		=3D SNR_IIO_PMON_RAW_EVENT_MASK_EXT,
 	.box_ctl		=3D SNR_IIO_MSR_PMON_BOX_CTL,
 	.msr_offset		=3D SNR_IIO_MSR_OFFSET,
+	.constraints		=3D snr_uncore_iio_constraints,
 	.ops			=3D &ivbep_uncore_msr_ops,
 	.format_group		=3D &snr_uncore_iio_format_group,
 	.attr_update		=3D snr_iio_attr_update,

