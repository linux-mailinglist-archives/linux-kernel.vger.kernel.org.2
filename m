Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796C836C740
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238274AbhD0Ntj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:49:39 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:33374 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238228AbhD0Nti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:49:38 -0400
Received: by mail-oi1-f181.google.com with SMTP id u80so26165777oia.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 06:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rascPb9+iTk18v3l72lt8dJj1SNq+fKe6BYOPqMWaBA=;
        b=aROHdpmDL7cwNJny7I4TUj9FhI/B4Q1SaVGOFtA/VA3XjPBO5lVOZKwqL0Tnqd5MjI
         iE3oI+WskCoIjdDE3XvUtJAO7oU/ZPoZ3jG9vENC8DwUpYmZjxF6xJnjk3XHtm9cUeLW
         vqeeWTcdqZlsuo14aINTWK4gM2xGm2RFTAq+EwMT7G23zLaVhorjKfxLkK+lXNDOzo3M
         RUumwxwVEKKfzrZG7TjPwSyIfqxxJfsizxpwJkO5ZSAkrZ/aL+K2ESfSlwOKSUACZVrx
         BdqFMkd3ln+BFQYnQgLzUAdhrK478GrubMs8cJNwdRr0iNabkwCNTRLDYF1s9o3Pr9XA
         W3EQ==
X-Gm-Message-State: AOAM532BE7FU0CbUvi0UTHi6xBkGQVK0ysssQebPMghclI8VILrovnha
        UEylYRd0wlHiJT3nJos8fA==
X-Google-Smtp-Source: ABdhPJwITZZ2Rb/bFBACjX8TM0OViMLryidYFlnVJGIv6SEgqSK5z0Wrue+zXy2UHLPG0lxG0N6w5A==
X-Received: by 2002:a54:4f91:: with SMTP id g17mr16737612oiy.15.1619531333895;
        Tue, 27 Apr 2021 06:48:53 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id e22sm496194oii.58.2021.04.27.06.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 06:48:53 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] arm64: perf: Ensure EL0 access is disabled at reset
Date:   Tue, 27 Apr 2021 08:48:52 -0500
Message-Id: <20210427134852.1411642-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ER, SW, and EN bits in the PMUSERENR_EL0 register are UNKNOWN at
reset and the register is never initialized, so EL0 access could be
enabled by default on some implementations. Let's initialize
PMUSERENR_EL0 to a known state with EL0 access disabled.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/kernel/perf_event.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 4658fcf88c2b..c32778ae5117 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -450,6 +450,11 @@ static inline void armv8pmu_pmcr_write(u32 val)
 	write_sysreg(val, pmcr_el0);
 }
 
+static void armv8pmu_clear_pmuserenr(void)
+{
+	write_sysreg(0, pmuserenr_el0);
+}
+
 static inline int armv8pmu_has_overflowed(u32 pmovsr)
 {
 	return pmovsr & ARMV8_PMU_OVERFLOWED_MASK;
@@ -933,6 +938,9 @@ static void armv8pmu_reset(void *info)
 	armv8pmu_disable_counter(U32_MAX);
 	armv8pmu_disable_intens(U32_MAX);
 
+	/* User access is unknown at reset. */
+	armv8pmu_clear_pmuserenr();
+
 	/* Clear the counters we flip at guest entry/exit */
 	kvm_clr_pmu_events(U32_MAX);
 
-- 
2.27.0

