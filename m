Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43003C3B9E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 12:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbhGKKob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 06:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbhGKKo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 06:44:26 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C422C0613E8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 03:41:40 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id a14so7491632pls.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 03:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tg4kPboEv8a50CVYTi4+9WCNhiUYVPJPPco+6cKmUZQ=;
        b=HBfB6xTheoC7W0jGr+IND8Dc+xf45Pl4OcIdBANA/8KAHA40loCVDsuKThFnuNVIC7
         pA/NI+MDKq0puehth94k8+z1drCCyeoV1PmoRIyjWyWvj9nvm6GXUcW6fDpJighzoIlT
         8DNU7dA3WPIM53WaZJ1WKak++KVGOOxwkUAXcmi7TFuFQF3/mbU5iUrYg25rx2h4R4Vr
         flb/MSUKIaa0ViTcqMILHNZG6Kt3yd3xu7Y7PtF3RfIDN4X4wp9r7TJSmtTz+SS7v5j5
         U+FdXE3TVXoaJ7t+b9WQebJgHR1J8YvydRO071Ht0duDxCxp2Kp57hz4UUuvTQcEAA9A
         Wm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tg4kPboEv8a50CVYTi4+9WCNhiUYVPJPPco+6cKmUZQ=;
        b=fv4NmPaEVoFv0oAE0mwGJh+d2ci55UHseTg6vmI1s/FT+nGjzRUD8cZRq76u2tJ57d
         6q4Oj8cVaHBXT7P1x7T0lM5vktKipBmabjRbKciSqjwDQlf2HXMc5XC8K9a5daWCZYwi
         86ERXJMsst7l/1NSrx8Smb8Y187MgCDfmS9SJVF1NGg9RiprGkRU7eJHrs2IV24KNVFR
         3hX3DcjzxCh7iSsB43MdSMypB9XwRiXB7Wykb+NIdVh47qychz2dcdEFfjv6U8hlh8al
         YH3JKygiqPRoYC6C9q+gcRAXrIsm09chKR2rcDmUT1tyIREO4M2rQCWl9XfZxRFfHe/k
         DUnw==
X-Gm-Message-State: AOAM531zac91z42moB4p0B7rVKW6ENXroHkpZ7jDA4JmoymvdvYxU8wd
        CgVqcsrkpWoSij9WtxHKTk8TjQ==
X-Google-Smtp-Source: ABdhPJyFP2IA4WrbAagQhrSQ1fhtt8nGm2nPWr+r4ifwYH2PuGscAo8Lee8kFXCZKI3R9atYNv+UiA==
X-Received: by 2002:a17:902:8d98:b029:129:18e5:8c31 with SMTP id v24-20020a1709028d98b029012918e58c31mr38737450plo.3.1626000100000;
        Sun, 11 Jul 2021 03:41:40 -0700 (PDT)
Received: from localhost ([103.127.241.250])
        by smtp.gmail.com with ESMTPSA id c136sm12182066pfc.201.2021.07.11.03.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 03:41:39 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 08/11] perf: Cleanup for HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT
Date:   Sun, 11 Jul 2021 18:41:02 +0800
Message-Id: <20210711104105.505728-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210711104105.505728-1-leo.yan@linaro.org>
References: <20210711104105.505728-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the __sync functions have been dropped, This patch removes unused
build and checking for HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT in perf tool.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/Makefile.config | 4 ----
 tools/perf/util/auxtrace.c | 5 -----
 2 files changed, 9 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index eb8e487ef90b..4a0d9a6defc7 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -349,10 +349,6 @@ CXXFLAGS += $(INC_FLAGS)
 
 LIBPERF_CFLAGS := $(CORE_CFLAGS) $(EXTRA_CFLAGS)
 
-ifeq ($(feature-sync-compare-and-swap), 1)
-  CFLAGS += -DHAVE_SYNC_COMPARE_AND_SWAP_SUPPORT
-endif
-
 ifeq ($(feature-pthread-attr-setaffinity-np), 1)
   CFLAGS += -DHAVE_PTHREAD_ATTR_SETAFFINITY_NP
 endif
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 7958e17229ea..6a63be8b2430 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -130,11 +130,6 @@ int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
 		return 0;
 	}
 
-#if BITS_PER_LONG != 64 && !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
-	pr_err("Cannot use AUX area tracing mmaps\n");
-	return -1;
-#endif
-
 	pc->aux_offset = mp->offset;
 	pc->aux_size = mp->len;
 
-- 
2.25.1

