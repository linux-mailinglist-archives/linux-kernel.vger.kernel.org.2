Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E9D380AE2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 15:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhENOAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:00:47 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:29972 "EHLO
        esa4.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbhENOAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1621000773;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=gycOdl/jthuUyUiNugMfHecYSNvmxfvy3ZT9tM+u8Xw=;
  b=WxBwSuJ9aGK0iSLqjK4FERsFBzsASS3JYVood+lZH3iZxOc0XpDJiH3Q
   qjT/WfZDy6SRO9jD2rnXopbZfCZTcxebhlVKYilXqOeRk3ZLeyb9mBOAg
   l5AmrwnbKom/tBrOBxglleBfISFnpUa5oouv5UqRDdUY7sVJ+M6wUJ74C
   M=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: eY2JiRoUwa9lzXY5YBjKrStOxzobDQJVuzWKqTErueQELJyWFBLlKcnjp56j8sCUPYse/cIuc9
 n1G0N0ltY6ToAIb8p/zqrN7z6AVuWJ4RsIL66k1xL82o2jpLs/uLfm2ing4RH1Y0HqL2tj7W4k
 oVi2JHjw0r4wCdkPrDrF+Boq/fK0WUCFy7+bjnIbzNqUh4vmO0Mq6zYzEbjzvom4FDrW7rtJSA
 DiLXCwANwqNSP3Aw3/f7GAwu/MEVG2fGjqAj7w2jl5qbRQNJrgyZqWxResx8Wy0r7oXfhhnIl2
 y3s=
X-SBRS: 5.1
X-MesageID: 45354932
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
IronPort-HdrOrdr: A9a23:0ziehqvBIfqgVXFojOCDNYg67skCU4Eji2hC6mlwRA09TyXGra
 2TdaUgvyMc1gx7ZJh5o6HmBEDyewK7yXcV2/hZAV7MZniChILFFu9fBOjZsnXd8k/Fh4pgPM
 5bGsATZ+EYZmIbsS+O2njbLz9W+qjlzEnHv4bj5kYoaTsvR7Br7g9/BAreOFZxXhN+HpY8FI
 CR/I5uuyegUW5/VLX/OlA1G8z44/HbnpPvZhALQzQ97hOVtCil7L7hHwLd9gsCUhdCy7Yr9m
 jel2XCl+GemsD+7iWZ+37Y7pxQltek4MBEHta0kcQQKi/hkEKBeJlhYbufpzo4ydvfr2oCoZ
 3pmVMNLs5z43TeciWeuh32wTD63DIv8XP5jXSzqxLY0JfEbQN/L/AEqZNScxPf5UZllsp7yr
 hzxG6ct4BaF1f7tgGV3amQazha0m6P5VYym+8aiHJSFaEEbqVKlJcS+ENOHI1FITnz75o/Fv
 JyMdrV6/lXe26LdnyxhBgo/PWcGlAIWjuWSEkLvcKYlxJMmmpi9lAVwMwEkm1F/JUhS4Nc7+
 CBKK5hk7tJSdIbfL8VPpZcfeKHTkj2BT7cOmObJlrqUIsdPWjWkoX65LUu6PvvfJAT1pM9lI
 7GTEhTuQcJChrTIPzL+KcO3gHGQW27Uzio4NpZ/YJBobH5RKDmK2mEU1Ahk8yppv8bAsHdRv
 arMJ9aGPP4NwLVaNx09jy7f6MXBWgVUcUTtNp+cUmJuNjzMYHvtvbWarLLP7zmHSw/Vm66CW
 tGXz7uP8JJ60CtVBbD8UfsckKoXna60YN7EaDc8eRW4pMKLJd0qQQQiU60/IWXMjVEqLUxZ1
 ZiO7vpnaOwuHmu8Q/znjhUEysYKnwQzKTrUntMqwNPGVjza6w/t9KWfn0X9GebJzdkJvmmWj
 J3lhBSw+aaPpaQzSctB5aMKWSBlUYeo3qMUtM1hrCD38H4YZk1Z6xWFZCZVD+7WyCdqzwa5l
 urWzV0B3M30QmeyZlNuaZkS903seMMwztDb/Qk6043/n/s3P3HDkFrJwJG+/Tn3zrGAQAkzW
 GZupVv+4aoiHKhL3Ayj/8/N0AJYGOLAKheBADAf4lMnKv3ETsAOVtiqAbq+S3bQFCagnn6R1
 aRUxF8csu7dWa1ekoooZoC1WkEAFl1U3gAFkySgLcNZVgu4EwDrNNjTpDDrFe5ex8FmL5ANi
 3ZCAFiUz+G6erHriKopA==
X-IronPort-AV: E=Sophos;i="5.82,300,1613451600"; 
   d="scan'208";a="45354932"
From:   Andrew Cooper <andrew.cooper3@citrix.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Pu Wen <puwen@hygon.cn>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        "Joerg Roedel" <jroedel@suse.de>
Subject: [PATCH] perf/x86/rapl: Use CPUID bit on AMD and Hygon parts
Date:   Fri, 14 May 2021 14:59:20 +0100
Message-ID: <20210514135920.16093-1-andrew.cooper3@citrix.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD and Hygon CPUs have a CPUID bit for RAPL.  Drop the fam17h suffix as
it is stale already.

Make use of this instead of a model check to work more nicely in virtual
environments where RAPL typically isn't available.

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
---
CC: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: Jiri Olsa <jolsa@redhat.com>
CC: Namhyung Kim <namhyung@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Borislav Petkov <bp@alien8.de>
CC: x86@kernel.org
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Pu Wen <puwen@hygon.cn>
CC: Tom Lendacky <thomas.lendacky@amd.com>
CC: Yazen Ghannam <Yazen.Ghannam@amd.com>
CC: Joerg Roedel <jroedel@suse.de>
CC: linux-kernel@vger.kernel.org
---
 arch/x86/events/rapl.c             | 6 ++----
 arch/x86/include/asm/cpufeatures.h | 2 +-
 arch/x86/kernel/cpu/amd.c          | 4 ++++
 arch/x86/kernel/cpu/hygon.c        | 4 ++++
 arch/x86/kernel/cpu/powerflags.c   | 2 ++
 5 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index f42a70496a24..f337006c2c08 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -764,13 +764,14 @@ static struct rapl_model model_spr = {
 	.rapl_msrs      = intel_rapl_spr_msrs,
 };
 
-static struct rapl_model model_amd_fam17h = {
+static struct rapl_model model_amd_hygon = {
 	.events		= BIT(PERF_RAPL_PKG),
 	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
 	.rapl_msrs      = amd_rapl_msrs,
 };
 
 static const struct x86_cpu_id rapl_model_match[] __initconst = {
+	X86_MATCH_FEATURE(X86_FEATURE_RAPL,		&model_amd_hygon),
 	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,		&model_snb),
 	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,	&model_snbep),
 	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE,		&model_snb),
@@ -801,9 +802,6 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&model_spr),
-	X86_MATCH_VENDOR_FAM(AMD,	0x17,		&model_amd_fam17h),
-	X86_MATCH_VENDOR_FAM(HYGON,	0x18,		&model_amd_fam17h),
-	X86_MATCH_VENDOR_FAM(AMD,	0x19,		&model_amd_fam17h),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index a0431935850f..d80dcb6a66d5 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -108,7 +108,7 @@
 #define X86_FEATURE_EXTD_APICID		( 3*32+26) /* Extended APICID (8 bits) */
 #define X86_FEATURE_AMD_DCM		( 3*32+27) /* AMD multi-node processor */
 #define X86_FEATURE_APERFMPERF		( 3*32+28) /* P-State hardware coordination feedback capability (APERF/MPERF MSRs) */
-/* free					( 3*32+29) */
+#define X86_FEATURE_RAPL		( 3*32+29) /* AMD/Hygon RAPL interface */
 #define X86_FEATURE_NONSTOP_TSC_S3	( 3*32+30) /* TSC doesn't stop in S3 state */
 #define X86_FEATURE_TSC_KNOWN_FREQ	( 3*32+31) /* TSC has known frequency */
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 2d11384dc9ab..da57b96fafbe 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -646,6 +646,10 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 	if (c->x86_power & BIT(12))
 		set_cpu_cap(c, X86_FEATURE_ACC_POWER);
 
+	/* Bit 14 indicates the Runtime Average Power Limit interface. */
+	if (c->x86_power & BIT(14))
+		set_cpu_cap(c, X86_FEATURE_RAPL);
+
 #ifdef CONFIG_X86_64
 	set_cpu_cap(c, X86_FEATURE_SYSCALL32);
 #else
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index 0bd6c74e3ba1..6d50136f7ab9 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -260,6 +260,10 @@ static void early_init_hygon(struct cpuinfo_x86 *c)
 	if (c->x86_power & BIT(12))
 		set_cpu_cap(c, X86_FEATURE_ACC_POWER);
 
+	/* Bit 14 indicates the Runtime Average Power Limit interface. */
+	if (c->x86_power & BIT(14))
+		set_cpu_cap(c, X86_FEATURE_RAPL);
+
 #ifdef CONFIG_X86_64
 	set_cpu_cap(c, X86_FEATURE_SYSCALL32);
 #endif
diff --git a/arch/x86/kernel/cpu/powerflags.c b/arch/x86/kernel/cpu/powerflags.c
index fd6ec2aa0303..e2055f51342e 100644
--- a/arch/x86/kernel/cpu/powerflags.c
+++ b/arch/x86/kernel/cpu/powerflags.c
@@ -21,4 +21,6 @@ const char *const x86_power_flags[32] = {
 	"eff_freq_ro", /* Readonly aperf/mperf */
 	"proc_feedback", /* processor feedback interface */
 	"acc_power", /* accumulated power mechanism */
+	"conn_standby", /* Connected Standby */
+	"rapl", /* Runtime Average Power Limit */
 };
-- 
2.11.0

