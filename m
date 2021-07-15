Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53413C95A1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 03:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbhGOBhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 21:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235822AbhGOBg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 21:36:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541D8C061760
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 18:34:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q10-20020a056902150ab02905592911c932so5432526ybu.15
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 18:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3PaY7rl6y+KJgPw0jiCw1HGIj2gM6HP9UOg1XKxaldk=;
        b=ffcOjDVLHTbqOAadQhmPlFOAiWQ0dM2uiBLaj051kDdwHfwN3hRD9zbWN51R35Gf73
         DgRgNRgrbP9KbTeMgmv0jI//LDhLbuNsbFDGsZUXDCeLwMqUWZYa8ZyOV/7+sSzVHGIE
         wLjsZum77mfNBQZMzMM1+ga0AiTAoyMTeWSl4Y1c4we5lIXc9KhGMbhJvhNKhEDF7Jxl
         AdByKlli+4q3a1N04rMGe7r+j6yV+cLpCIjPaw6zmnJ3KWhlMuTfyRevud5BfmIazXVr
         ge6/Hw0wFeDdZmxpO7ypOECZ9CFCfNvQGU6qbc3lBjNF3I0ruxuC4NRNn6srWzhTcrFd
         Qgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3PaY7rl6y+KJgPw0jiCw1HGIj2gM6HP9UOg1XKxaldk=;
        b=s9fFMGSuIzjCopmeRRGTk3j6XhskJkCz4XlJ82tp7LdZac+VxuQJxXqpzkDL9HmkE8
         Y5cVuoTsFm+PZghuxei5Rwo+PevgwnRL4OZHqAEW9UVh5vKw9+BtkX7W6fAnrzJ38bMN
         dI/SPgG2f2dLxgHLgGIYKJf5gzyQDlozvJHTO7M41WeyvgZ/oG8mLmVCZzyWdc3LdXV1
         1V8CUrBtmtNqA/4jWiCNI+7uhwSV/Qn1XQhB1CKh6fBYoWReqfrV2ca7DCIEb4L93Ywh
         RBUeVENLhGjgduCy9+N6vVLBGq4+2bRP4Ii9iOFrNwfd2YAAlzB+P4R/H0Hq/mDuuqd/
         T5QQ==
X-Gm-Message-State: AOAM533EHgiIvQzmbdsYQbOWHJLvbsysGw4RYXGuqDYSG0pqFIDZidUH
        5/wVZR+NTrFkalG0lWDsC/wGgfpcZpDZ
X-Google-Smtp-Source: ABdhPJy1DJnNi4my+6zT/pPptafb5GzaggYhOmNWRansd4h+JmmiekfDMxTwr6MEWAUFoIuUFRFNy268ReuC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:c0a3:e3b0:6b14:de32])
 (user=irogers job=sendgmr) by 2002:a05:6902:1202:: with SMTP id
 s2mr1276085ybu.475.1626312845577; Wed, 14 Jul 2021 18:34:05 -0700 (PDT)
Date:   Wed, 14 Jul 2021 18:33:41 -0700
In-Reply-To: <20210715013343.2286699-1-irogers@google.com>
Message-Id: <20210715013343.2286699-6-irogers@google.com>
Mime-Version: 1.0
References: <20210715013343.2286699-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 5/7] perf doc: Remove cmd-list.perl references
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

cmd-list.perl exists in git but not in perf. As such these targets fail
with missing dependencies. Remove them.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/Makefile | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index 85a796c112a2..c5ec17ee5bb0 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -237,24 +237,6 @@ $(OUTPUT)doc.dep : $(wildcard *.txt) build-docdep.perl
 
 -include $(OUTPUT)doc.dep
 
-_cmds_txt = cmds-ancillaryinterrogators.txt \
-	cmds-ancillarymanipulators.txt \
-	cmds-mainporcelain.txt \
-	cmds-plumbinginterrogators.txt \
-	cmds-plumbingmanipulators.txt \
-	cmds-synchingrepositories.txt \
-	cmds-synchelpers.txt \
-	cmds-purehelpers.txt \
-	cmds-foreignscminterface.txt
-cmds_txt=$(addprefix $(OUTPUT),$(_cmds_txt))
-
-$(cmds_txt): $(OUTPUT)cmd-list.made
-
-$(OUTPUT)cmd-list.made: cmd-list.perl ../command-list.txt $(MAN1_TXT)
-	$(QUIET_GEN)$(RM) $@ && \
-	$(PERL_PATH) ./cmd-list.perl ../command-list.txt $(QUIET_STDERR) && \
-	date >$@
-
 CLEAN_FILES =									\
 	$(MAN_XML) $(addsuffix +,$(MAN_XML))					\
 	$(MAN_HTML) $(addsuffix +,$(MAN_HTML))					\
@@ -262,8 +244,7 @@ CLEAN_FILES =									\
 	$(OUTPUT)*.texi $(OUTPUT)*.texi+ $(OUTPUT)*.texi++			\
 	$(OUTPUT)perf.info $(OUTPUT)perfman.info				\
 	$(OUTPUT)howto-index.txt $(OUTPUT)howto/*.html $(OUTPUT)doc.dep		\
-	$(OUTPUT)technical/api-*.html $(OUTPUT)technical/api-index.txt		\
-	$(cmds_txt) $(OUTPUT)*.made
+	$(OUTPUT)technical/api-*.html $(OUTPUT)technical/api-index.txt
 clean:
 	$(call QUIET_CLEAN, Documentation) $(RM) $(CLEAN_FILES)
 
-- 
2.32.0.402.g57bb445576-goog

