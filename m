Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E153C95A3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 03:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbhGOBhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 21:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbhGOBhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 21:37:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F9EC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 18:34:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k32-20020a25b2a00000b0290557cf3415f8so5500024ybj.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 18:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1wHURlKzmxHcDsgqqsL7boqc8awDzR5MT7ZrdY0GfAc=;
        b=FhIUcbYKQWuBLjEcw6rTeD0kQZ0N62gcAnyt1AKJz2x9Dz1jbevUS5LNAVpsU7A6Si
         TrCpgnD/zGbmGc0F3owUEDbIG/IdEwNiqKYy0MymsXIVwbSrglxV6cUgVIaFzR8avAOY
         NIIid6gPuG/Cgd95Eyz7GAXtwdLtQLj9U1RGFA4RKcD5Rj4sIa6eqC/AJKbmNy4WCOiq
         x0HRQSMjl9+i+256MIGg2LLIxkGQ5MzUACPoLufGda/088yFbgWeP1enqsIwFax/hExl
         0OR8emoyXes6iW5MjspwCnWiaJMubsXfbIrEPqCdCqv3vOspxxrtte3B2MkQ8R22Hn8R
         O1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1wHURlKzmxHcDsgqqsL7boqc8awDzR5MT7ZrdY0GfAc=;
        b=VsSsVbUSU9kFzbaSFKq4+RcJRX7LgXc9vj6cAWCKJCRNQzkqwlRlhys0y+/xgRHdJZ
         syz+fEiTexIRDMH43rVunGT+6LeedUTg69d6ZdWBqx00Yb9EF14PGpnHGE8+EEMUYatH
         s2aEXJ6dwZPqoyjNkBalnpYquXGcklWO/uhYbbz7wIALGy3B8CtB7vPYWZIO7UBHEVvf
         xWjFtDupdfB1yYCGLMo4WlRpWKp65jYjCgDOegVjQeqhjvduAGzuLC+dITFW9Umm9hJt
         KS0SNHxw8Z0nJgYYNIhAM1KESMNxuntJfJZiavEmfxFUxoME1q19A8mcEaf7SrY7r0Xa
         kh/Q==
X-Gm-Message-State: AOAM533ThkS1tuq8Y0N33rG6D7zojPBtTTwZFdjWEpTH+SZo4VUb+pmP
        juqtio0X5ngAsoIyuXP7PvdiEc11/7kd
X-Google-Smtp-Source: ABdhPJxbVDXRTy6sbjAARKBzB/mvgBEYIQUu73ZC19a6yWwKDW9uGGj/kjofLj71Lf31YTAM4v1rPCstk1XF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:c0a3:e3b0:6b14:de32])
 (user=irogers job=sendgmr) by 2002:a25:8146:: with SMTP id
 j6mr1349646ybm.28.1626312850299; Wed, 14 Jul 2021 18:34:10 -0700 (PDT)
Date:   Wed, 14 Jul 2021 18:33:43 -0700
In-Reply-To: <20210715013343.2286699-1-irogers@google.com>
Message-Id: <20210715013343.2286699-8-irogers@google.com>
Mime-Version: 1.0
References: <20210715013343.2286699-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 7/7] perf doc: Reorganize ARTICLES variables.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Place early, as they are in the git Makefile. Remove references to a
'technical` directory that doesn't exist in perf.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/Makefile | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index 9d991b14ac4b..6e7b88917ca0 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -2,6 +2,10 @@
 include ../../scripts/Makefile.include
 include ../../scripts/utilities.mak
 
+ARTICLES =
+# with their own formatting rules.
+SP_ARTICLES =
+
 MAN1_TXT= \
 	$(filter-out $(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
 		$(wildcard perf-*.txt)) \
@@ -16,13 +20,6 @@ _MAN_HTML=$(patsubst %.txt,%.html,$(MAN_TXT))
 MAN_XML=$(addprefix $(OUTPUT),$(_MAN_XML))
 MAN_HTML=$(addprefix $(OUTPUT),$(_MAN_HTML))
 
-ARTICLES =
-# with their own formatting rules.
-SP_ARTICLES =
-API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technical/api-index.txt, $(wildcard technical/api-*.txt)))
-SP_ARTICLES += $(API_DOCS)
-SP_ARTICLES += technical/api-index
-
 _DOC_HTML = $(_MAN_HTML)
 _DOC_HTML+=$(patsubst %,%.html,$(ARTICLES) $(SP_ARTICLES))
 DOC_HTML=$(addprefix $(OUTPUT),$(_DOC_HTML))
-- 
2.32.0.402.g57bb445576-goog

