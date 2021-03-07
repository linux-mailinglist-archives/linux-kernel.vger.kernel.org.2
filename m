Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B181330015
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 11:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhCGKVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 05:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbhCGKVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 05:21:01 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B554C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Mar 2021 02:21:01 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id bm21so13964304ejb.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 02:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eIhiT5SiYr2fv6+SX4g6nfLVV+wipnouIkttpcdr9P0=;
        b=Gh7Zd70cIDpC3SNK9SFratG7fQOMYWSfJ38u4MyKKbIdGPxlYWUz7fa4qs39IgIWWR
         N6nXEiPnYL9SK7B/Nw52+pHn5Verv/qFCtxi4eSjFYAm0lEVz5pxN0CcatLy3hAs018s
         0lmXPolU3JCiA644Jsa+avbH50zwGoOI7F9ZoVqG7GxDQ5uvmP6A2396zzP+BbgYdqj/
         OvcQMdumUgkqtfByBIK2pzHnNDu9AIIi2+WJh/127wSt+NqRF/wH2I15FJAJirsT1vl5
         Ase43zM6q5Az/xuKyq7uGNvT1oSckhMevF3kgZ0etJDAQ3t7l3W2BwVwoml6dq5cKdL3
         PXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eIhiT5SiYr2fv6+SX4g6nfLVV+wipnouIkttpcdr9P0=;
        b=uO37pQe1v8x5llDwptf5j4+2sWG9+KqTtYpBjLDcVb8TUKBFDwzhAGCz0dzMpt9xqz
         eUKOsZHVYUi7T8htT5Nn2jsA+kYpsm/0aylfJGZkTt+DnxesHd1FWFQ5Ao8HRA/v4PSR
         BkZQXzVIToM981j9bbZxiTEnX4imqa85Fvsp9cn2EliXxux0Xpgv0+rPaVV5FSnvpRHY
         xo3RTA7q/y9mqcLQ4kJeVb33WFVemXwSk/nh9KL3hxt3ubD9ULQoqL7Ycbd6Cwp0e5c1
         taPvOGhW+Aq2QO14UDRcc2qblTxTB2ypRAnzU0KMJKPZpSYX32c5HhC6skGOrqZ4hdZa
         lXEQ==
X-Gm-Message-State: AOAM533vVfnxJnqVvIwkuvdBz73ofQEd8j1112IKgKYlT69ZiLE6l1Wx
        LHpWOo4OlUOKrvVHZerdj6Q=
X-Google-Smtp-Source: ABdhPJzGnj+7YrqPF+xIIUc1a2J9+tOPeDXmTNp/mvyjt98aCTWioZehE8j8ldPzKGBYpykenxmWkg==
X-Received: by 2002:a17:906:380c:: with SMTP id v12mr10295622ejc.65.1615112460006;
        Sun, 07 Mar 2021 02:21:00 -0800 (PST)
Received: from Limone.hitronhub.home (ip5f5ac7f5.dynamic.kabel-deutschland.de. [95.90.199.245])
        by smtp.googlemail.com with ESMTPSA id g17sm5177994edw.56.2021.03.07.02.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 02:20:59 -0800 (PST)
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
Cc:     Gon Solo <gonsolo@gmail.com>,
        Andreas Wendleder <andreas.wendleder@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Perf: Clean generated directory, other archs.
Date:   Sun,  7 Mar 2021 11:19:42 +0100
Message-Id: <20210307101942.254366-1-gonsolo@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a make clean there are generated directories left in the arch
directories of perf. Clean them up.

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Andreas Wendleder <andreas.wendleder@gmail.com>
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

