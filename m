Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F0F36762A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 02:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343879AbhDVATY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 20:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343871AbhDVATX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 20:19:23 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EC2C06138B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 17:18:48 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id m130-20020a628c880000b029021007090c43so12104292pfd.22
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 17:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=InGXRJoehZzqf88O4Bt+zuFetATrFUWqYs8yN3vRqLA=;
        b=l9+yX1Z7vIwgD/vS0LRjEANK7LrzEFSQS1x8Gr8oiIZIShujccwJ1QurNQu5vqZP4F
         FVD5t+FBBqjuSgYtxgoZDyRv4izWBSe1Lp8yT82WEqrpEaDFYRP18UwuIttJLqVZCApB
         zFV5FJKrQYb+pX2en4+9oshJ6eYUpk7SqLq4AkNuPh232UpzRZXVvAgwnOIZ7SdHYWWp
         yVH2PanXvEqlPGr8mCffE628ISqz2EqfmM71Ok4NBvSOaR+FDF/2f+mmUqsJvqiXbE5W
         cCCrLlpx4FmwQ28gUyZ+CnjSIGJL0r/RtFv3PVXfkSc6r2fWiJERy5XRCW82osbrqHYc
         Y8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=InGXRJoehZzqf88O4Bt+zuFetATrFUWqYs8yN3vRqLA=;
        b=SWUdfBVrYTahLw9USsFwtNj+reZ3GkiuhldxWPIXrXlCZQHkHT9idL1BpJWfhVMlOf
         6EuB+pTFbDt8CCYJQijNKJ976n32W0oBS/sbvmDr/+3W93qUUbMIe0XMMAMiRv72cpjH
         H/SInTukwK4Ia5T4i77WBH40KvfbJVq9DBO8ap2CaANvynm8Ar0/Q3GcmKIiy4tgm7YU
         EfmfbaaBt0h098SdTdeQXM8qqqMDpzqtk0/SYh8c7A1BL1YV7bxFd0b+/sBPFLv4ipqZ
         msTeml1eSA7DyMbmfA+IZTtgnyczCZlTFxRWfvmVgm2FDDyJ6ujKlsO0Bed5xUVjIaE5
         Cr4Q==
X-Gm-Message-State: AOAM5315EWQ5rsqhqgryomhd7lcqnHTabrZb/BJ7CmxGcYyoCLiQqs4M
        BAdPs/TEUJHANXUNSKN9LNL/ToVDncBo0w==
X-Google-Smtp-Source: ABdhPJzJwJ1k4tRTd5q22O87C7x61PVXv2hGBgVu77fDStDkGXMd3CX3lSCY8kDOvDhwshFVHXo98qs6MyMlrQ==
X-Received: from tortoise.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1a0d])
 (user=jmattson job=sendgmr) by 2002:a62:920d:0:b029:25d:102a:f0a4 with SMTP
 id o13-20020a62920d0000b029025d102af0a4mr679659pfd.37.1619050727976; Wed, 21
 Apr 2021 17:18:47 -0700 (PDT)
Date:   Wed, 21 Apr 2021 17:18:34 -0700
Message-Id: <20210422001834.1748319-1-jmattson@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH] perf/x86/kvm: Fix Broadwell Xeon stepping in isolation_ucodes[]
From:   Jim Mattson <jmattson@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        kvm-list@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>, Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only stepping of Broadwell Xeon parts is stepping 1. Fix the
relevant isolation_ucodes[] entry, which previously enumerated
stepping 2.

Although the original commit was characterized as an optimization, it
is also a workaround for a correctness issue.

If a PMI arrives between kvm's call to perf_guest_get_msrs() and the
subsequent VM-entry, a stale value for the IA32_PEBS_ENABLE MSR may be
restored at the next VM-exit. This is because, unbeknownst to kvm, PMI
throttling may clear bits in the IA32_PEBS_ENABLE MSR. CPUs with "PEBS
isolation" don't suffer from this issue, because perf_guest_get_msrs()
doesn't report the IA32_PEBS_ENABLE value.

Fixes: 9b545c04abd4f ("perf/x86/kvm: Avoid unnecessary work in guest filtering")
Cc: Andi Kleen <ak@linux.intel.com>
Reported-by: Peter Shier <pshier@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Peter Shier <pshier@google.com>
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 37ce38403cb8..c57ec8e27907 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4516,7 +4516,7 @@ static const struct x86_cpu_desc isolation_ucodes[] = {
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_D,		 3, 0x07000009),
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_D,		 4, 0x0f000009),
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_D,		 5, 0x0e000002),
-	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_X,		 2, 0x0b000014),
+	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_X,		 1, 0x0b000014),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 3, 0x00000021),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 4, 0x00000000),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 5, 0x00000000),
-- 
2.31.1.368.gbe11c130af-goog

