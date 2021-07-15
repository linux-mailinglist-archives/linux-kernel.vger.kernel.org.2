Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7E73C95A2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 03:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbhGOBhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 21:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbhGOBhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 21:37:02 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BB5C061764
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 18:34:08 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id e7-20020ac84e470000b029025ca4fbcc12so2778946qtw.18
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 18:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DTdO0iYUr3tsZd3QdGCYNG4c6LNiO3CfWVyTLuAjf0U=;
        b=DLC6ZUlopRThS5wwEXziEwgZUsiQFr/WMkkDWPQan+kgcacxeTFTudfycoLOwM1Fqu
         qvuddKq/ztcWHP1ZRVJLPML+VKYNz3kMw8dGc1xsVQWKMAdhCoEGI3gsFcEk6VjNAv1R
         VyOaQx+xdK8YedJOwuFZADfPF0JTZ+ekFCu7HAuM5VbV6cBvORcdTZ9kCHdwmOGZVnwY
         xmK6IPW3C2JpGGPA2fjwyYNh/KT85GCwwJC56LLN24V7Dj+rW9BdOqciLuBe24Lbi/yD
         7lD4XmTBO/FgC2G2sEKxGqlvNrfTQet6tE8nUq+P1YaBteG3TglLwy1feODSA8BxCgAd
         ugbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DTdO0iYUr3tsZd3QdGCYNG4c6LNiO3CfWVyTLuAjf0U=;
        b=EV7CIIxkvVrV6nJghylqPeoquMdfBmqYVqFwvvHtM194Y3z0rGRmeWh4midnwzbl6i
         ia87VhTOV4q01Xh3xrCBj96CiYbbr/WribJtQC+mz7epK6Q3q/1smvB+curI1OQGjevq
         HO3RZ09dDIdw/3DeIsZi5gm2CtjX5uVP58jHz3btUqJRhcjWqLl27KWTQP7zQhQHoM1B
         FHiCvzqqTv59fc6W3uUNWTB3kiQxoRyG1RnGE1J6aMXIh8KrgKo+SqSsn2ka/bQxYl5S
         AxlFQNzaQpiFX4rNtDMT0ABM2S6Ak9nYudINRgBmQd9vjo0jBXQT/MIvD4GHrrPQvbmK
         nVdA==
X-Gm-Message-State: AOAM530R5pIZ432qtd/CHvsROLiilbC1imK2j8ztQvGitFeSslKhGNHa
        HrskQAbrhhVlo3vpoKFppTxCyPAOB2qz
X-Google-Smtp-Source: ABdhPJzDBG+wIjPM20CutNVzhPSyKssLfx3uW1s6fh/ZEz7S4KilDePRV36i72b4ODtJgGCPbSQ1zNvzOOPm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:c0a3:e3b0:6b14:de32])
 (user=irogers job=sendgmr) by 2002:a05:6214:2623:: with SMTP id
 gv3mr1057146qvb.46.1626312847812; Wed, 14 Jul 2021 18:34:07 -0700 (PDT)
Date:   Wed, 14 Jul 2021 18:33:42 -0700
In-Reply-To: <20210715013343.2286699-1-irogers@google.com>
Message-Id: <20210715013343.2286699-7-irogers@google.com>
Mime-Version: 1.0
References: <20210715013343.2286699-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 6/7] perf doc: Remove howto-index.sh related references.
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

howto-index.sh exists in git but not in perf, as such targets that
depend upon it fail. Remove such failing targets.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/Makefile | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index c5ec17ee5bb0..9d991b14ac4b 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -242,8 +242,7 @@ CLEAN_FILES =									\
 	$(MAN_HTML) $(addsuffix +,$(MAN_HTML))					\
 	$(DOC_HTML) $(DOC_MAN1) $(DOC_MAN5) $(DOC_MAN7)				\
 	$(OUTPUT)*.texi $(OUTPUT)*.texi+ $(OUTPUT)*.texi++			\
-	$(OUTPUT)perf.info $(OUTPUT)perfman.info				\
-	$(OUTPUT)howto-index.txt $(OUTPUT)howto/*.html $(OUTPUT)doc.dep		\
+	$(OUTPUT)perf.info $(OUTPUT)perfman.info $(OUTPUT)doc.dep		\
 	$(OUTPUT)technical/api-*.html $(OUTPUT)technical/api-index.txt
 clean:
 	$(call QUIET_CLEAN, Documentation) $(RM) $(CLEAN_FILES)
@@ -294,21 +293,11 @@ $(patsubst %.txt,%.texi,$(MAN_TXT)): %.texi : %.xml
 	$(DOCBOOK2X_TEXI) --to-stdout $*.xml >$@+ && \
 	mv $@+ $@
 
-howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
-	$(QUIET_GEN)$(RM) $@+ $@ && \
-	'$(SHELL_PATH_SQ)' ./howto-index.sh $(wildcard howto/*.txt) >$@+ && \
-	mv $@+ $@
-
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
 	$(QUIET_ASCIIDOC)$(ASCIIDOC) -b $(ASCIIDOC_HTML) $*.txt
 
 WEBDOC_DEST = /pub/software/tools/perf/docs
 
-$(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
-	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	sed -e '1,/^$$/d' $< | $(ASCIIDOC) -b $(ASCIIDOC_HTML) - >$@+ && \
-	mv $@+ $@
-
 # UNIMPLEMENTED
 #install-webdoc : html
 #	'$(SHELL_PATH_SQ)' ./install-webdoc.sh $(WEBDOC_DEST)
-- 
2.32.0.402.g57bb445576-goog

