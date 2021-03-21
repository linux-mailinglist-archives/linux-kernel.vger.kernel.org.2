Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7960034320E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 11:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhCUK5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 06:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhCUK4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 06:56:40 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7323C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 03:56:39 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id t18so16580346ejc.13
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 03:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7xewp/fJ6NIVBrvph1Qz3m2XTYWuxqMxQ/FQOlUGsXo=;
        b=A9+kjX11a90YgvzqORqYtn0urgMxm1FEOf1if/3sw6nmPbeqhAAobwXk/LEhSwE2Uv
         Lt8WTjZsVJDx2yo7krJMU5/4qbqUI0mLg1S2TY1WiatbV7Cw1v8xy6yIZJrQ/Rd6J19I
         kj4YonEoE8E+tThusyVuaMhGjm7z4nxHxMY8LTmpfJzf8JbHITXk/3w9COMpZ4PlPx+c
         7LL4wfH2/tByrvI7H0DLLO3u/0Es9CMtkbyrBjZWR4FHFp47YMyHXiuxgtZ3+2t+gfI8
         s+ybKaPoln96lJMBltZEV13fOczurbQ7iyKm0Sy+MTsyHKv/PjVxI/tiVrktBiS0P/k8
         evmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=7xewp/fJ6NIVBrvph1Qz3m2XTYWuxqMxQ/FQOlUGsXo=;
        b=g4jcD7tjoqlG34YrTf1WSN2PMy1xYq1L/DmAnTZg9Tr1JVzClDDnrXGe0ES6oS4aNu
         ayCvEYC0LsC+M7LABii9bbn3XIeFsekS/+FB9PqYT1RCK0CMHyACID0A6rvC3dHFiTCT
         3K7l5yljeX2A/t9oIyMvWRDamQJBUvKtSANSuqsbgRmLbXiNv2rRAS00Kt34k7nzhPBV
         uJR5eWQEZgnCA/7u03RdRBgZzlOuJnV9FPhARyTBSq8lDw1x2RisJJvXfhUWC78wp5fk
         4QOEqXq+2i1ZwzD8isCWw7J/AvMxA/dvBHOAaoP380uetw5USJpe8Jl/7UgJ79HpgLrT
         N0qw==
X-Gm-Message-State: AOAM5313BJ6kVATPoEArmlrd/gYjUKyTXOge7a/fVzT4bV14scGDKEgo
        B9qPH8LHFoP0Sq1p1wQrXAE=
X-Google-Smtp-Source: ABdhPJxq6iIMbvgCEykp1akysyWujx4l8Bm0gkc+l3HPIXbR7qJoudb5Sh6HN1tEl/drLD/D/iz8jA==
X-Received: by 2002:a17:906:ecfb:: with SMTP id qt27mr13715952ejb.245.1616324198510;
        Sun, 21 Mar 2021 03:56:38 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id gb4sm6719381ejc.122.2021.03.21.03.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 03:56:37 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 21 Mar 2021 11:56:36 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <20210321105636.GA201014@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2021-03-21

   # HEAD: 2dc0572f2cef87425147658698dce2600b799bd3 perf/x86/intel: Fix unchecked MSR access error caused by VLBR_EVENT

Boundary condition fixes for bugs unearthed by the perf fuzzer.

 Thanks,

	Ingo

------------------>
Kan Liang (2):
      perf/x86/intel: Fix a crash caused by zero PEBS status
      perf/x86/intel: Fix unchecked MSR access error caused by VLBR_EVENT


 arch/x86/events/intel/core.c | 3 +++
 arch/x86/events/intel/ds.c   | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7bbb5bb98d8c..37ce38403cb8 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3659,6 +3659,9 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		return ret;
 
 	if (event->attr.precise_ip) {
+		if ((event->attr.config & INTEL_ARCH_EVENT_MASK) == INTEL_FIXED_VLBR_EVENT)
+			return -EINVAL;
+
 		if (!(event->attr.freq || (event->attr.wakeup_events && !event->attr.watermark))) {
 			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
 			if (!(event->attr.sample_type &
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7ebae1826403..d32b302719fe 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2010,7 +2010,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 		 */
 		if (!pebs_status && cpuc->pebs_enabled &&
 			!(cpuc->pebs_enabled & (cpuc->pebs_enabled-1)))
-			pebs_status = cpuc->pebs_enabled;
+			pebs_status = p->status = cpuc->pebs_enabled;
 
 		bit = find_first_bit((unsigned long *)&pebs_status,
 					x86_pmu.max_pebs_events);
