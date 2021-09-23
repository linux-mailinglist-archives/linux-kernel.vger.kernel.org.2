Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4562641546D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 02:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbhIWAMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 20:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238582AbhIWAMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 20:12:05 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3992EC061757
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 17:10:35 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id p12-20020ad4496c000000b0037a535cb8b2so15430362qvy.15
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 17:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1rELxei1Th/UNLZ4fkAjYBbAjk1Yskkc5Wgg+H/lMdA=;
        b=aj4ITEB5JceytWBHfNcVZcASLLTMUoHYYe1f328a7S6X2W14GhzWC+8Mra/X1zSFRa
         MG1KY3dnyQaUOROahD5evtsUwd93Q9oyYa7LxIgVCI0v3BcL2Ha1n9w9ITYAkgxRLBb6
         uR5I5IBH1aWELGFZJuqZDwHXEzm4ELAmcdTca5mj2vTOFa/U1KEVAL7YgHckmJECMW1t
         7joH10yxt5VFm9/If55eNRR9OLShFbUYZsHeWFrO6VD/8MRYNrmS/Ris1LvTRZplZMpj
         mJHdLZWBGrx9PysOlu0H3JJzEW1VXEZbtQW+7ZydG/QwFX6TBRL2GLW4T0hInJYjb6h3
         tgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1rELxei1Th/UNLZ4fkAjYBbAjk1Yskkc5Wgg+H/lMdA=;
        b=fQmoeaWWqqvvTJU1e73SiFa7vVQKgD1CZ/2qwu9XWxLFQHTzTXXvS1rfmV2rpJlMwV
         cyexn2dT6Tjwoxca6grbTWQkMwhVoOlE84n4bLszLgDx6zqANa0E7hMZjR3yYYSgpINs
         AoCY4bzvyrBhc/QsTcVSILzRCPpVy18Qyeu+G33RWq5LtGgWM2Dm57lu+VjkYMTzkqWP
         7Sq66iw6KUZGAUA2dOxaQdw0QL9fVaE1XCOg+DvOP52Z3AJnyBsKJXq3sc4caFwtgEzD
         V6ehvd3E6Py1iSbH2kkunbkL5JZX9ztPQdSmDaAJskSStzp/yl0qVEnSUyXBsb0z4JGl
         GydA==
X-Gm-Message-State: AOAM532TGtfN8AZUSNDOnmNtJTIh+a2MgeJUmligxf/1vHX6qCYy3Mmj
        mIQCrIUiSSDEh977DOI+SxBTqIe3bYUY
X-Google-Smtp-Source: ABdhPJzjm/4Mi5fc7Pf8x7huJqqqC5yilO3pfA3yu3xyN3RxlPlH2FRCHiesTjDAl2F3JrJhR3PfOJ7Jw7/l
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:a25:ae97:: with SMTP id
 b23mr2412310ybj.50.1632355834372; Wed, 22 Sep 2021 17:10:34 -0700 (PDT)
Date:   Wed, 22 Sep 2021 17:10:22 -0700
In-Reply-To: <20210923001024.550263-1-irogers@google.com>
Message-Id: <20210923001024.550263-2-irogers@google.com>
Mime-Version: 1.0
References: <20210923001024.550263-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v3 2/4] perf: Add define for libtraceevent version
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The definition is derived from pkg-config as discussed in:
https://lore.kernel.org/lkml/20210610155915.20a252d3@oasis.local.home/
The definition is computed using expr rather than passed to be computed
in C code, this avoids complications with quote  in the variable
expansions. For example see the target python/perf.so in Makefile.perf.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 00ec900ddbca..2001c315f0db 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1093,6 +1093,12 @@ ifdef LIBTRACEEVENT_DYNAMIC
   $(call feature_check,libtraceevent)
   ifeq ($(feature-libtraceevent), 1)
     EXTLIBS += -ltraceevent
+    LIBTRACEEVENT_VERSION := $(shell $(PKG_CONFIG) --modversion libtraceevent)
+    LIBTRACEEVENT_VERSION_1 := $(word 1, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
+    LIBTRACEEVENT_VERSION_2 := $(word 2, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
+    LIBTRACEEVENT_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
+    LIBTRACEEVENT_VERSION_CPP := $(shell expr $(LIBTRACEEVENT_VERSION_1) \* 255 \* 255 + $(LIBTRACEEVENT_VERSION_2) \* 255 + $(LIBTRACEEVENT_VERSION_3))
+    CFLAGS += -DLIBTRACEEVENT_VERSION=$(LIBTRACEEVENT_VERSION_CPP)
   else
     dummy := $(error Error: No libtraceevent devel library found, please install libtraceevent-devel);
   endif
-- 
2.33.0.464.g1972c5931b-goog

