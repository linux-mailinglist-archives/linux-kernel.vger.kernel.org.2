Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F260737304E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhEDTIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:08:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:38652 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231604AbhEDTIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:08:18 -0400
IronPort-SDR: uTJhcXAtNOmgdfvJHJa8f+UsRg2IuuNkGFPauCoZMdpMZADCSLGJKC9bHSJTq8eSy7ItpekILD
 en+sg0jKS08g==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="178269886"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="178269886"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 12:07:16 -0700
IronPort-SDR: VnEEtfP1kQ2EZthY9pdNHw4wZo6XrztQjFJatnkkViV9Ux8La1ZoZdsfpPI2C2v7iVDXq47oIq
 FJmEUWxtibMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="618591716"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga006.fm.intel.com with ESMTP; 04 May 2021 12:07:16 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Andi Kleen <andi.kleen@intel.com>
Subject: [RFC PATCH v5 01/16] x86/hpet: Expose hpet_writel() in header
Date:   Tue,  4 May 2021 12:05:11 -0700
Message-Id: <20210504190526.22347-2-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210504190526.22347-1-ricardo.neri-calderon@linux.intel.com>
References: <20210504190526.22347-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to allow hpet_writel() to be used by other components (e.g.,
the HPET-based hardlockup detector), expose it in the HPET header file.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v4:
 * Dropped exposing hpet_readq() as it is not needed.

Changes since v3:
 * None

Changes since v2:
 * None

Changes since v1:
 * None
---
 arch/x86/include/asm/hpet.h | 1 +
 arch/x86/kernel/hpet.c      | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index ab9f3dd87c80..be9848f0883f 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -72,6 +72,7 @@ extern int is_hpet_enabled(void);
 extern int hpet_enable(void);
 extern void hpet_disable(void);
 extern unsigned int hpet_readl(unsigned int a);
+extern void hpet_writel(unsigned int d, unsigned int a);
 extern void force_hpet_resume(void);
 
 #ifdef CONFIG_HPET_EMULATE_RTC
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 08651a4e6aa0..326af9a55129 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -78,7 +78,7 @@ inline unsigned int hpet_readl(unsigned int a)
 	return readl(hpet_virt_address + a);
 }
 
-static inline void hpet_writel(unsigned int d, unsigned int a)
+inline void hpet_writel(unsigned int d, unsigned int a)
 {
 	writel(d, hpet_virt_address + a);
 }
-- 
2.17.1

