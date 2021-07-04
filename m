Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3BE3BABC4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 09:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbhGDHUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 03:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhGDHUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 03:20:00 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EF2C061762
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 00:17:25 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id pf4-20020a17090b1d84b029016f6699c3f2so12455286pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 00:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cqZ3/8qRJ0T11IxZy6/iUe0ZOS4dBLD3FIlV5usicsM=;
        b=E3UX6x54x8lZhJxaCXtRbUP78eBR4I+u4kodpswYImEgDSGt5OsPpK6aig1cAPUsXW
         kGOyxg1euP+NI63PmPk3bax3UXoPbvCL4fY+7Yrxtec2/mcYxFDBcvjEkew+Z0LgD2Ke
         1JC8cnvg+TxOs/q06D+FZnf1x7Z0HSb+QFoHhPP1utkSIEuwI+Fttfbkc5fJ3KjWWpFT
         erb3my3THxDLnWwFHi/xusawcMjuE4iGWIRpqNkM2lAZ8uBd2vN1BUXxLjndkH1Cbiw6
         8wvnZ5X4WiApZ9Zm99zqorutI1O6Yirntyp/q6zjhnGbgKqWsYQMKvdJKEMXLY7n91Am
         uBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cqZ3/8qRJ0T11IxZy6/iUe0ZOS4dBLD3FIlV5usicsM=;
        b=ZBrB7EOshoP1LOMkwHvj2J4SWqXyxwmUu1PXQJXjArP9Y5blBx0dX/THNQjQhVfgIi
         4nmimFkylnr6UUxX9I+EIjSRX13i6njXGThoUwhh5YEqRznJBgeWNRn5Lf+IG8QB+NF6
         AaJt5rljEOColW0d2hEKI1IgIi5ouBreH/evCzCnbBiwkN/vPwdCjXtFFmPCUhypXQfP
         WgnoFUTfZbBBQ7/yiOVJH1XgfjlLauWYy08IhVDBZIIJ6jdx3e/txz96CjxNk5Of6vk/
         2zDObIpyQ51jcIrTXhphLwWZwTCQxOu7TfQw6c/wCF9l+hiryVqePEqs7eegVNiEN2F8
         /nVg==
X-Gm-Message-State: AOAM530/R/w6wx1yL3V9hGpuBSHWXSIOzl/KCiPZiv95KgDd/CzmyIEV
        ElD/NVUrCPjL78w20gNGcG3MTA==
X-Google-Smtp-Source: ABdhPJxxP1J0v8GY7Te1DQbveJ8mV/KCKQeQTcGZB4JU9I32dUshft2tWw6YxwA1immL4jEh56ilbg==
X-Received: by 2002:a17:90a:e415:: with SMTP id hv21mr8509138pjb.178.1625383045501;
        Sun, 04 Jul 2021 00:17:25 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id s20sm18870464pjn.23.2021.07.04.00.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 00:17:24 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
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
Subject: [PATCH v3 06/10] perf auxtrace: Remove auxtrace_mmap__read_snapshot_head()
Date:   Sun,  4 Jul 2021 15:16:40 +0800
Message-Id: <20210704071644.107397-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210704071644.107397-1-leo.yan@linaro.org>
References: <20210704071644.107397-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the function auxtrace_mmap__read_snapshot_head() is exactly same
with auxtrace_mmap__read_head(), whether the session is in snapshot mode
or not, it's unified to use function auxtrace_mmap__read_head() for
reading AUX buffer head.

And the function auxtrace_mmap__read_snapshot_head() is unused so this
patch removes it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/auxtrace.c |  5 ++---
 tools/perf/util/auxtrace.h | 10 ----------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 9350eeb3a3fc..44bd04dbb6d6 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1686,13 +1686,12 @@ static int __auxtrace_mmap__read(struct mmap *map,
 	union perf_event ev;
 	void *data1, *data2;
 
+	head = auxtrace_mmap__read_head(mm);
+
 	if (snapshot) {
-		head = auxtrace_mmap__read_snapshot_head(mm);
 		if (auxtrace_record__find_snapshot(itr, mm->idx, mm, data,
 						   &head, &old))
 			return -1;
-	} else {
-		head = auxtrace_mmap__read_head(mm);
 	}
 
 	if (old == head)
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index f489ca159997..1a2f42980e3f 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -440,16 +440,6 @@ struct auxtrace_cache;
 
 #ifdef HAVE_AUXTRACE_SUPPORT
 
-static inline u64 auxtrace_mmap__read_snapshot_head(struct auxtrace_mmap *mm)
-{
-	struct perf_event_mmap_page *pc = mm->userpg;
-	u64 head = READ_ONCE(pc->aux_head);
-
-	/* Ensure all reads are done after we read the head */
-	smp_rmb();
-	return head;
-}
-
 static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
 {
 	struct perf_event_mmap_page *pc = mm->userpg;
-- 
2.25.1

