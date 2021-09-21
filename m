Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C4D413BBD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 22:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbhIUUu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 16:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbhIUUuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 16:50:25 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B098C061756
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 13:48:56 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id p23-20020a05620a22f700b003d5ac11ac5cso3116676qki.15
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 13:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0fQ8TCUq2nIKYsU5pQLtTTkuNxp/JAtlPHlUXR9S+Vg=;
        b=M8rUSoyqhCE2pVWw+XCFo9eKV4+oKAaS77hyjuGwvD6X6Hm2OwL6HvrL6ERj+CKLSs
         LSNAUJUgR27wTDCNyU5/vDnSeMfa0nqXs5RItXkwcGn+V8RRcFl30F1aGJXXQWE7PCR5
         4tIHLWzubEHJ5D1cmOTmebr+F9bvxls+Sim2gCdFGsOYqfKIi3zbLKvQ6hxEAkMU1K4r
         3Z22Nkdp2XloJZKFsPIjYZr7xCdFo/m1UVe6DcMZDrwJIsiqbsMGBXPi5IhfHn1BxGBO
         nbBzpjdz18jsU+HSSvYYHRFuEL+O6y/tqsL4dCHi9hhu6+YR6m6vu0l5vG5Y1ScQY/US
         6eRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0fQ8TCUq2nIKYsU5pQLtTTkuNxp/JAtlPHlUXR9S+Vg=;
        b=kJt+NQjc7OEp+gh1lL9p+Ile3K5P1xYbSFx/Pkv8hj+RbmEY+wVtci7s8eaX1+UI3G
         VDKTxr+hWWXZ0+g6UnJhHCOKSKbrMQpNm5Y9kYkZrVqyxgfCtAnKujqzyzNtOqaKTsFt
         dCQLQjg09BMtj/+mskYjXj/8XNOBnw8/OrC8x2wbnPaFHhnOQ3LSxAL1gnM2sn4k9ZQ5
         jB3xN4zUAzf+lwmlOYe+WNjEl+og6W41ffBZ0xliqq6A5WzcVNO+d37bCWAeTeefppZV
         ycfURicZl8ebsUHMgSXH2guH2mOKjBsXK1bOSMWUdaOaU5OIMqB/RnW5NoXarZh+iFWY
         eMGg==
X-Gm-Message-State: AOAM532hUYr+OmZ8Q1EzZz3KgigRgdZq0teNpBxXqwTVXJXLiSIS/Sad
        fWteGnGai+MFWflg5xwYuEHhy2oKOWRx
X-Google-Smtp-Source: ABdhPJz+hk6+WNO8Dibbg6BJwFS1NpCW9OBNqbDVONr+XMUqVUf0sWNtnDo8Z6fJaiV9wdVLa0MEDShjVnSh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:dffa:819a:f0e2:47e])
 (user=irogers job=sendgmr) by 2002:a05:6902:1107:: with SMTP id
 o7mr40185706ybu.454.1632257335328; Tue, 21 Sep 2021 13:48:55 -0700 (PDT)
Date:   Tue, 21 Sep 2021 13:48:38 -0700
In-Reply-To: <20210921204839.236840-1-irogers@google.com>
Message-Id: <20210921204839.236840-3-irogers@google.com>
Mime-Version: 1.0
References: <20210921204839.236840-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v2 3/4] perf: Add define for libtracefs version
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

This will allow version specific support of libtracefs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 2001c315f0db..0ae2e3d8b832 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1108,6 +1108,12 @@ ifdef LIBTRACEFS_DYNAMIC
   $(call feature_check,libtracefs)
   ifeq ($(feature-libtracefs), 1)
     EXTLIBS += -ltracefs
+    LIBTRACEFS_VERSION := $(shell $(PKG_CONFIG) --modversion libtracefs)
+    LIBTRACEFS_VERSION_1 := $(word 1, $(subst ., ,$(LIBTRACEFS_VERSION)))
+    LIBTRACEFS_VERSION_2 := $(word 2, $(subst ., ,$(LIBTRACEFS_VERSION)))
+    LIBTRACEFS_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEFS_VERSION)))
+    LIBTRACEFS_VERSION_CPP := $(shell expr $(LIBTRACEFS_VERSION_1) \* 255 \* 255 + $(LIBTRACEFS_VERSION_2) \* 255 + $(LIBTRACEFS_VERSION_3))
+    CFLAGS += -DLIBTRACEFS_VERSION=$(LIBTRACEFS_VERSION_CPP)
   else
     dummy := $(error Error: No libtracefs devel library found, please install libtracefs-dev);
   endif
-- 
2.33.0.464.g1972c5931b-goog

