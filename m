Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7143C3CD4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 15:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhGKN3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 09:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhGKN3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 09:29:40 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADCAC0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 06:26:53 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id c17so27669105ejk.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 06:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=vUoaRlEedhmlshDEkrSRWETaK9NB1fWxZKUcVGsRvoo=;
        b=fT9TC/HldbkxGMowLPVdopmmtz6O/J+DBGeXKZxvd5yTgWgp4fVuDbIm6lK0D9kzEO
         Y8azoz3F4tUxndzK7zlF+TZmDC31XLdoJQKNzr0MvuYpyBgt5fwIfnZEmIvkWUnOIrnx
         zeW/owQhkxplqo8SKEUSPPG8GvkQNjrsqu/Gm/Tru0/FGSmsEIs5cL6WPMMCLyJuPVy7
         mzLy3GfJlo5Hyq3b6xvLRtMF4axZ03SjJ9TVUk3nrg6X8X4zk8ugJ//NRR65Mijgkytf
         V7QmB5fqeHrlX31sGssZhg9eCHuPFqqk7bwFjKr8OPjQ8lkHpbSbfKV60t/q9xEy/UUE
         ZIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=vUoaRlEedhmlshDEkrSRWETaK9NB1fWxZKUcVGsRvoo=;
        b=QZIw6sH1KXMuypsPBHraQfFBqeti3GfoKQw0MXVM8HPsaJM9TwmRiGksBWFPd3w7cd
         MHMdqEsP6yJf48vODIZ7gr4VTZNXhrZN0nXTrg7sQvD/bqKXUe8YnZ7NSCKiRro0snLE
         jIxKkJf/jur9rUx1b3MuSwnimqmxml87iVd0Che4zTMFFSNTvR6RNMoBMT0BHRIvzKeC
         DjWAzoy7X2K/NWnKbTvOoyzl+S1FBQ1aY4Nkc2lRWg2Wj694gbZfeAg3R54TY4Pk3efv
         1Qo8rBd2wXtrVm6XqjyeW7Cmx3lrLcTMMt6wDQqezWZr7YRsRUh3KRkr0w9TGYgIEFki
         DnpA==
X-Gm-Message-State: AOAM532lCASRX3Wg5+ZiD1ucjJVXp2+da7ro6qXevKK2JEAjbjJ9uV4U
        wZgrf+dQ3TepaDs8reKsuT0=
X-Google-Smtp-Source: ABdhPJyk1/xj2BFakokRkj5tdGNSP/xlhUOm6tz8q0jmFLaUz5rpKHqrC8NWiDqTG7Cm/ao23MoHmg==
X-Received: by 2002:a17:906:f9c5:: with SMTP id lj5mr27136748ejb.482.1626010012055;
        Sun, 11 Jul 2021 06:26:52 -0700 (PDT)
Received: from gmail.com (77-234-64-154.pool.digikabel.hu. [77.234.64.154])
        by smtp.gmail.com with ESMTPSA id i10sm455501edf.12.2021.07.11.06.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 06:26:51 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 11 Jul 2021 15:26:50 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <YOrxmiI8jmELoABe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2021-07-11

   # HEAD: d4ba0b06306a70c99a43f9d452886a86e2d3bd26 perf/x86/intel/uncore: Clean up error handling path of iio mapping

A fix and a hardware-enablement addition:

 - Robustify uncore_snbep's skx_iio_set_mapping()'s error cleanup
 - Add cstate event support for Intel ICELAKE_X and ICELAKE_D

 Thanks,

	Ingo

------------------>
Kan Liang (1):
      perf/x86/intel/uncore: Clean up error handling path of iio mapping

Zhang Rui (1):
      perf/x86/cstate: Add ICELAKE_X and ICELAKE_D support


 arch/x86/events/intel/cstate.c       | 23 +++++++++++++++++------
 arch/x86/events/intel/uncore_snbep.c |  6 ++++--
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 433399069e27..c6262b154c3a 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -40,7 +40,7 @@
  * Model specific counters:
  *	MSR_CORE_C1_RES: CORE C1 Residency Counter
  *			 perf code: 0x00
- *			 Available model: SLM,AMT,GLM,CNL,TNT,ADL
+ *			 Available model: SLM,AMT,GLM,CNL,ICX,TNT,ADL
  *			 Scope: Core (each processor core has a MSR)
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
@@ -50,8 +50,8 @@
  *	MSR_CORE_C6_RESIDENCY: CORE C6 Residency Counter
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
- *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL,
- *						TNT,RKL,ADL
+ *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
+ *						TGL,TNT,RKL,ADL
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
@@ -61,7 +61,7 @@
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
- *						KBL,CML,ICL,TGL,TNT,RKL,ADL
+ *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
@@ -72,8 +72,8 @@
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
- *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL,
- *						TNT,RKL,ADL
+ *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
+ *						TGL,TNT,RKL,ADL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
@@ -566,6 +566,14 @@ static const struct cstate_model icl_cstates __initconst = {
 				  BIT(PERF_CSTATE_PKG_C10_RES),
 };
 
+static const struct cstate_model icx_cstates __initconst = {
+	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
+				  BIT(PERF_CSTATE_CORE_C6_RES),
+
+	.pkg_events		= BIT(PERF_CSTATE_PKG_C2_RES) |
+				  BIT(PERF_CSTATE_PKG_C6_RES),
+};
+
 static const struct cstate_model adl_cstates __initconst = {
 	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
 				  BIT(PERF_CSTATE_CORE_C6_RES) |
@@ -664,6 +672,9 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&icl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&icx_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&icx_cstates),
+
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&icl_cstates),
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 3a75a2c601c2..1f7bb4898a9d 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3789,11 +3789,11 @@ static int skx_iio_set_mapping(struct intel_uncore_type *type)
 	/* One more for NULL. */
 	attrs = kcalloc((uncore_max_dies() + 1), sizeof(*attrs), GFP_KERNEL);
 	if (!attrs)
-		goto err;
+		goto clear_topology;
 
 	eas = kcalloc(uncore_max_dies(), sizeof(*eas), GFP_KERNEL);
 	if (!eas)
-		goto err;
+		goto clear_attrs;
 
 	for (die = 0; die < uncore_max_dies(); die++) {
 		sprintf(buf, "die%ld", die);
@@ -3814,7 +3814,9 @@ static int skx_iio_set_mapping(struct intel_uncore_type *type)
 	for (; die >= 0; die--)
 		kfree(eas[die].attr.attr.name);
 	kfree(eas);
+clear_attrs:
 	kfree(attrs);
+clear_topology:
 	kfree(type->topology);
 clear_attr_update:
 	type->attr_update = NULL;
