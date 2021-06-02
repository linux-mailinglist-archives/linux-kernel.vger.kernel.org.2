Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59AE439955D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 23:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhFBVZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 17:25:31 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:39440 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhFBVZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 17:25:30 -0400
Received: by mail-pl1-f180.google.com with SMTP id q16so1778218pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 14:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DfdDU6e0YWhm8GiUYoVOU7IBIs5ShVcV9zH63gd4jZ4=;
        b=Kcf8fIi2m7QQeqwOGqxUXvq/8ArpV2yVIYX2G1i8mIh5gudU+6xEYqa+1SPGY0+iMQ
         Jkq0tSxPygDE6bZE5SMOS9B8YWILXzOgQ/w6Us+rr0cN0YFMWzdLz4ZcnTWolLTxcBcT
         CrhEz31FUVk1qO+iPxohJZIiJay0Tr/F8byLP1S7Xnz23s9haOpquscRvi3nkNbCEOyn
         EUP//GzFm6cHYod3ZrgXW2fb4HHimQZRgVm6MWf8neSaDECstQ+sT03YySSXYGAAtrNr
         42GdmDp1NP2vWUiz3UEYTcteCaYl0tvBIrn+3uOj9rLUh7hTucGGabqRowTC0w7VPD7K
         3Wnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DfdDU6e0YWhm8GiUYoVOU7IBIs5ShVcV9zH63gd4jZ4=;
        b=Ag9S1HE76lFXk0HNfkuh+k7B1bmRwgeyIjbispRtllwBSoNAuArjRo9/+/ibG3VEc6
         We+PEC9UL4v/X+sxLiR+tiDo4Hbp5oWIgbgAcwwnt1R3WBFszitoJl+c7oJ/p7sTGe5R
         ax3SoaMG1bkHtV93ji4IsOglgio9mlbnUvmj3Hg0b/DBMbvgR7+mLaaCIuYM016pb4Y6
         5sQCyBwttt3KqhLCP2g/8jgWA8XDefY8llUPMDciSic6bjjjIJHGcZTwsM713HR2fBXH
         RpHl2iIEWVmnb94BKI1IxypIWlUeMjrg7N8MZfy0nVYfBhyK+fpqjIGs8N9uRYteCkov
         pAGw==
X-Gm-Message-State: AOAM532pzKne+/ZIl3Ci9RenDwANsk++4i5zu6230UeyNR0bqPDHB23S
        X48eJIkY0pCbYc4KY13pfyc=
X-Google-Smtp-Source: ABdhPJwS7aUccz9RxesR7aabyMA4HV1mDe/stEG3I5dkgQT2sP9qn/zgivFinuhglXlQE8mntmg9ng==
X-Received: by 2002:a17:90b:247:: with SMTP id fz7mr7461964pjb.137.1622668966827;
        Wed, 02 Jun 2021 14:22:46 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:ea44:6c81:cb03:abf2])
        by smtp.gmail.com with ESMTPSA id z9sm435860pfc.101.2021.06.02.14.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 14:22:46 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH 3/3] perf stat: Honor event config name on --no-merge
Date:   Wed,  2 Jun 2021 14:22:41 -0700
Message-Id: <20210602212241.2175005-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
In-Reply-To: <20210602212241.2175005-1-namhyung@kernel.org>
References: <20210602212241.2175005-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If user gave an event name explicitly, it should be displayed in the
output as is.  But with --no-merge option it adds a pmu name at the
end so might confuse users.

Actually this is true for hybrid pmus, I think we should do the same
for others.

Cc: Jin Yao <yao.jin@linux.intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 04afd41b6067..f7cb9bba673b 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -541,7 +541,7 @@ static void uniquify_event_name(struct evsel *counter)
 	char *config;
 	int ret = 0;
 
-	if (counter->uniquified_name ||
+	if (counter->uniquified_name || counter->use_config_name ||
 	    !counter->pmu_name || !strncmp(counter->name, counter->pmu_name,
 					   strlen(counter->pmu_name)))
 		return;
@@ -555,10 +555,8 @@ static void uniquify_event_name(struct evsel *counter)
 		}
 	} else {
 		if (perf_pmu__has_hybrid()) {
-			if (!counter->use_config_name) {
-				ret = asprintf(&new_name, "%s/%s/",
-					       counter->pmu_name, counter->name);
-			}
+			ret = asprintf(&new_name, "%s/%s/",
+				       counter->pmu_name, counter->name);
 		} else {
 			ret = asprintf(&new_name, "%s [%s]",
 				       counter->name, counter->pmu_name);
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

