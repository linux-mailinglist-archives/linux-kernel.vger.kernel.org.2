Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1BAC3EEEA2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 16:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237975AbhHQOjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 10:39:20 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:54895 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237475AbhHQOjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 10:39:19 -0400
Received: from localhost.localdomain (ip5f5aeb65.dynamic.kabel-deutschland.de [95.90.235.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5268B61E5FE00;
        Tue, 17 Aug 2021 16:38:44 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86: intel_epb: Mention firmware in ENERGY_PERF_BIAS warning
Date:   Tue, 17 Aug 2021 16:38:29 +0200
Message-Id: <20210817143830.34552-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The warning

    ENERGY_PERF_BIAS: Set to 'normal', was 'performance'

is shown on all my Intel systems, and for a normal user it’s unclear
what to do about it. Change it to

    ENERGY_PERF_BIAS: Set to 'normal', was 'performance' (unchanged by firmware)

so it’s clear, that it might be possible to change the setting in the
system firmware.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 arch/x86/kernel/cpu/intel_epb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
index f4dd73396f28..3f8c0b59d08a 100644
--- a/arch/x86/kernel/cpu/intel_epb.c
+++ b/arch/x86/kernel/cpu/intel_epb.c
@@ -91,7 +91,7 @@ static void intel_epb_restore(void)
 		val = epb & EPB_MASK;
 		if (val == ENERGY_PERF_BIAS_PERFORMANCE) {
 			val = ENERGY_PERF_BIAS_NORMAL;
-			pr_warn_once("ENERGY_PERF_BIAS: Set to 'normal', was 'performance'\n");
+			pr_warn_once("ENERGY_PERF_BIAS: Set to 'normal', was 'performance' (unchanged by firmware)\n");
 		}
 	}
 	wrmsrl(MSR_IA32_ENERGY_PERF_BIAS, (epb & ~EPB_MASK) | val);
-- 
2.33.0

