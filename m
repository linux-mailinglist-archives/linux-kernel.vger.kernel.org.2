Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AFC39955A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 23:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhFBVY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 17:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhFBVY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 17:24:27 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412EAC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 14:22:44 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 27so3377774pgy.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 14:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BsbmirkQTrn5Y/d7vxsXgoXVmSWKzfg79YhqEox9cnI=;
        b=V8RMV2L26lg4HUyruFenGz+7Zt7ri1MvrSCM/6mwECE/TDuvP7nuOdtCViEv1okUO+
         8ZnULGMy7biqOairR7J5qvPq7I7f10qnwguHulr3b/t8q2npXcZixmB94QYu1zLhEy14
         7ccKoON9kEZ6VN4KH0/eek2/5z6o0AnezdNDPbvtw2F/vT58NI4r1Y9UFP5NwO1ZY7G4
         hcXc1tpsJdMRz0qQh4xDZXZ2k0JBN1dFARWEogjrENC8i0ejNhktcDUnDWQw8dGSuefq
         Ln3Z3LzCmlJGjhFkFy++nmcabCEq5MaTcT6jr6srGr/auS56E2kwuKWtZ+f2gzo6JwE8
         /75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=BsbmirkQTrn5Y/d7vxsXgoXVmSWKzfg79YhqEox9cnI=;
        b=stwr2TcLdmsEbnnU/im11ze4EQnfL7c1SKsUHEx+WSvGVEhpdT6oiH6euDt7LO7+Ok
         GEOaEHKz76AS/BNY+e2KNBlC3aDlDouqcV16zbCbD284gXoxQXBHgqyte1thaxaxb9/I
         JsXmKNz+FYkigp26U5sUZ8eylO3oteRoqvh/QnStoiJk3skR/IWNvku3YR6j/JLLxbYL
         09Pur2Xicb857dHspLSY1AtqLHotIK+1BRSQUlc3F+nwixjLsRwU8Xjvp8XRhPqP5xyY
         3dwt4nNxj1syO9xQXtB//wsg5p8havk1p+h7tyqFrNbk+I88NDpWCNJ2KZ7S+yOYUSzp
         +M7A==
X-Gm-Message-State: AOAM5332l9/vN6da1kZ14efOcMQqX3faau+lTgWigbBh598l2z2KfN1S
        8sGMfYYLnKP9e8Qv2id01/U=
X-Google-Smtp-Source: ABdhPJwwzbfhJPjbbQR1lld3DtsKic4FCHHvEvdOhrpXdZZQnbmbjvmlK+VpDoT2h8VuIXuJLVgl1w==
X-Received: by 2002:a63:125d:: with SMTP id 29mr19569288pgs.151.1622668963822;
        Wed, 02 Jun 2021 14:22:43 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:ea44:6c81:cb03:abf2])
        by smtp.gmail.com with ESMTPSA id z9sm435860pfc.101.2021.06.02.14.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 14:22:43 -0700 (PDT)
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
Subject: [PATCH 1/3] perf stat: Check return value of asprintf() properly
Date:   Wed,  2 Jun 2021 14:22:39 -0700
Message-Id: <20210602212241.2175005-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It returns -1 on error, so checking with 0 would not work.

Fixes: 12279429d862 ("perf stat: Uniquify hybrid event name")
Cc: Jin Yao <yao.jin@linux.intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index b759dfd633b4..04afd41b6067 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -564,7 +564,7 @@ static void uniquify_event_name(struct evsel *counter)
 				       counter->name, counter->pmu_name);
 		}
 
-		if (ret) {
+		if (ret > 0) {
 			free(counter->name);
 			counter->name = new_name;
 		}
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

