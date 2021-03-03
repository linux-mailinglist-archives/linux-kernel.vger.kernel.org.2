Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B8132C156
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838530AbhCCTAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 14:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1580463AbhCCSeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 13:34:10 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08626C061760
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 10:33:29 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ci14so25133229ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 10:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G5PS+Mqh6yRiEh5sqcZaMRrHIODcCKN4OdPVN4vj0uo=;
        b=WaXJNF1l2cnQ42vAHQn7cbYyezN/8kHOwZlwnHX7pLYOBecJblguul2b0lFdViFCBz
         qZyHCcB568CBZ2fZXWMknT+iNyb8TZ5Rmqd4uPMybwj/cb992oPxj+4d1DBFVdwc1b+0
         U/s62GrM3Az5wQCwEFPa2ykiuKOEyxq/yUU46mAD4PLiE6ZHw9F84zbU7+C1arwEOOTb
         0DAuidJgIMkWXAo63OToKv9BSAn2D/4ZQdwZWJlThs7m76Gp+huxFPlmFHYsvy/A8Y7w
         WfEaFMkEtj6GJ0R3g61QBEg4vpDCiMR1F6wjodamHATzp7QmBkADGiE3bzaUmizAZdgb
         vfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G5PS+Mqh6yRiEh5sqcZaMRrHIODcCKN4OdPVN4vj0uo=;
        b=UT8JNm2WJADKLVXgXuCs8BlQPMbMbWRQ3N/1IG/zERT4YwPHdEv8BArbecomxZCXnl
         2JCNDsydvq8x2VFKnzzNf1DyckyIMtHJOvEBhFCtWckkw856DInKjDrI3a42HjUhk+QF
         DUeMZDl1JD4Pfc4Ff9OS7ON7MHaSouwhcIoOdr1ewk+RB+HaUnT4/+7DlMbvkskOyGgf
         a6NKdwTDpQAUmRvTsvOfgvEozNnjvYKHZX8BdepuCGCrZAi9vqX9XQ/814CiIdQN3io3
         LXc4zCG/7vMUNnzSJbq3DX68q2gctb6yPa4wsrQ7O9Sd4hLrabpK3x4ozhB8rzk0IxdC
         HO0Q==
X-Gm-Message-State: AOAM530r0TyvB2YV9A9PESCtjwmi3Q346HxTEoyAeUcBDLdlwPlR24/h
        5eypc715xgqp4LOkvdeM2mI=
X-Google-Smtp-Source: ABdhPJyvSS67uE5t2X66rAVig3dxiuLn6amiqIjP8gK06H6QAFFb0kyGxYXICrNcX5ZeffRkYEQj5g==
X-Received: by 2002:a17:906:3c50:: with SMTP id i16mr162873ejg.175.1614796407666;
        Wed, 03 Mar 2021 10:33:27 -0800 (PST)
Received: from localhost.localdomain (dynamic-046-114-034-198.46.114.pool.telefonica.de. [46.114.34.198])
        by smtp.googlemail.com with ESMTPSA id q12sm14951405ejd.51.2021.03.03.10.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 10:33:27 -0800 (PST)
From:   Gon Solo <gonsolo@gmail.com>
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Gon Solo <gonsolo@gmail.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Perf: Clean generated directory, other archs.
Date:   Wed,  3 Mar 2021 19:32:46 +0100
Message-Id: <20210303183247.217385-1-gonsolo@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 tools/perf/arch/arm64/Makefile   | 5 +++--
 tools/perf/arch/powerpc/Makefile | 5 +++--
 tools/perf/arch/s390/Makefile    | 5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
index fab3095fb5d0..426aecdd0b71 100644
--- a/tools/perf/arch/arm64/Makefile
+++ b/tools/perf/arch/arm64/Makefile
@@ -10,7 +10,8 @@ HAVE_KVM_STAT_SUPPORT := 1
 # Syscall table generation for perf
 #
 
-out    := $(OUTPUT)arch/arm64/include/generated/asm
+generated := $(OUTPUT)arch/arm64/include/generated
+out    := $(generated)/asm
 header := $(out)/syscalls.c
 incpath := $(srctree)/tools
 sysdef := $(srctree)/tools/arch/arm64/include/uapi/asm/unistd.h
@@ -24,6 +25,6 @@ $(header): $(sysdef) $(systbl)
 	$(Q)$(SHELL) '$(systbl)' '$(CC)' '$(HOSTCC)' $(incpath) $(sysdef) > $@
 
 clean::
-	$(call QUIET_CLEAN, arm64) $(RM) $(header)
+	$(call QUIET_CLEAN, arm64) $(RM) -r $(header) $(generated)
 
 archheaders: $(header)
diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
index 840ea0e59287..979c2bebc167 100644
--- a/tools/perf/arch/powerpc/Makefile
+++ b/tools/perf/arch/powerpc/Makefile
@@ -11,7 +11,8 @@ PERF_HAVE_JITDUMP := 1
 # Syscall table generation for perf
 #
 
-out    := $(OUTPUT)arch/powerpc/include/generated/asm
+generated := $(OUTPUT)arch/powerpc/include/generated
+out    := $(generated)/asm
 header32 := $(out)/syscalls_32.c
 header64 := $(out)/syscalls_64.c
 sysprf := $(srctree)/tools/perf/arch/powerpc/entry/syscalls
@@ -28,6 +29,6 @@ $(header32): $(sysdef) $(systbl)
 	$(Q)$(SHELL) '$(systbl)' '32' $(sysdef) > $@
 
 clean::
-	$(call QUIET_CLEAN, powerpc) $(RM) $(header32) $(header64)
+	$(call QUIET_CLEAN, powerpc) $(RM) -r $(header32) $(header64) $(generated)
 
 archheaders: $(header32) $(header64)
diff --git a/tools/perf/arch/s390/Makefile b/tools/perf/arch/s390/Makefile
index 74bffbea03e2..27cf67f1cc78 100644
--- a/tools/perf/arch/s390/Makefile
+++ b/tools/perf/arch/s390/Makefile
@@ -10,7 +10,8 @@ PERF_HAVE_JITDUMP := 1
 # Syscall table generation for perf
 #
 
-out    := $(OUTPUT)arch/s390/include/generated/asm
+generated := $(OUTPUT)arch/s390/include/generated
+out    := $(generated)/asm
 header := $(out)/syscalls_64.c
 sysprf := $(srctree)/tools/perf/arch/s390/entry/syscalls
 sysdef := $(sysprf)/syscall.tbl
@@ -23,6 +24,6 @@ $(header): $(sysdef) $(systbl)
 	$(Q)$(SHELL) '$(systbl)' $(sysdef) > $@
 
 clean::
-	$(call QUIET_CLEAN, s390) $(RM) $(header)
+	$(call QUIET_CLEAN, s390) $(RM) -r $(header) $(generted)
 
 archheaders: $(header)
-- 
2.27.0

