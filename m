Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57667375D45
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 00:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhEFW5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 18:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhEFW5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 18:57:44 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F1FC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 15:56:45 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id e13-20020ac8598d0000b02901cde66f0e26so4513927qte.16
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 15:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9qAE3ylGIgIN6z2XX1IF/s7yDr0HR2DijcyVu3luS2o=;
        b=LvBA82++LFbBBQHWRIMTP7rmFgicJqfMG3jSxbkB7T5QcBm7BJ0ko3KZrvnZcJdtnm
         Kcny3KUZawdrREvwexS0ova/q8laLz80mZrE5SungnHflsqQf14pO5ZRBw63MoJ3LD3T
         SwV6vIQDNfVqA2EpxLzV+Di6SWndWkDUTXgoKWozhL0gpXGW4h0KtizpTJ64Fy19m6GK
         o55wJfViNi7uF+xX6DVG5qCieptHr+mkJQEzQXPaGA3u+mgZcPeXhjuVkZKYc6sCYNs+
         ZM30VgUj78UB/5yGW+sq4RL5yrFLfERC959kBb/1zm1L8cXv6IwS+VxR/IigKjsUst5B
         Uciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9qAE3ylGIgIN6z2XX1IF/s7yDr0HR2DijcyVu3luS2o=;
        b=imYPdkCLtlp2ibejt+FK9wWgHw+PagZ3u8e4XZJAye7A70XJvUsrTHr+yeMRJ/2AyD
         VaBJTgrYcZ5X1o23683zqjQ7je+Eu8vou3iPy6bmgDvBougJ7ZNeGi3XfQ8Gl5mET6FV
         4Yju2dbjG5/agI5ElhrlFP49aivVNxNZjHfogJYJPfLhZJmE0aJ/vFX9YN0hz5CWB9co
         fplaBjdmhsv3Kupx2DFaX3Y6khsnVWTIxIhUvKFb1w6pyAGy1jm27zIIAgCkwY9AJu4T
         PDUo4XvLKRPBBpe9Ceo2rNJKmCzx8rlaNJwoWrI/7jm8kHeJU8ut22c3KDQVnB88X3BD
         A8rA==
X-Gm-Message-State: AOAM533M50Xlb6V5ygOQxy3akoMH38bClmWthgjupY5BAAtA7Ps/CcVc
        SpUD9/6XTYKpY25wIAVdtCqJGNb/aPKg
X-Google-Smtp-Source: ABdhPJxrLR+FGblybNHDE6jvh8Ihl3/eLAPTzEmh/u5wOptAg8BXKztPxYiW9C3O4KAEBdbKjuY1WBRM4tm9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:e9b2:d505:ffb2:fde1])
 (user=irogers job=sendgmr) by 2002:a0c:e486:: with SMTP id
 n6mr6918259qvl.21.1620341804683; Thu, 06 May 2021 15:56:44 -0700 (PDT)
Date:   Thu,  6 May 2021 15:56:40 -0700
Message-Id: <20210506225640.1461000-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH] perf jevents: Silence warning for ArchStd files
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Kim Phillips <kim.phillips@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

json files in the level 1 directory are used for ArchStd events (see
preprocess_arch_std_files), as such they shouldn't be warned about.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index ed4f0bd72e5a..7422b0ea8790 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -1123,8 +1123,10 @@ static int process_one_file(const char *fpath, const struct stat *sb,
 			mapfile = strdup(fpath);
 			return 0;
 		}
-
-		pr_info("%s: Ignoring file %s\n", prog, fpath);
+		if (is_json_file(bname))
+			pr_debug("%s: ArchStd json is preprocessed %s\n", prog, fpath);
+		else
+			pr_info("%s: Ignoring file %s\n", prog, fpath);
 		return 0;
 	}
 
-- 
2.31.1.607.g51e8a6a459-goog

