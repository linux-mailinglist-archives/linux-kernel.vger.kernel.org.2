Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCFD3AFC14
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 06:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhFVEku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 00:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhFVEkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 00:40:43 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1479CC061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 21:38:27 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id a2-20020ad441c20000b0290251bb08ce61so15265630qvq.19
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 21:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nyVTW/NfJ2wkCeZoen2ILlMbYSDECf1cn5qBJJZCWd0=;
        b=StjSZaMiKwuHNW8eRDB3FLTFwf8cjEhtxJu6FkU92v+Z3/7nJFcKNz5XjgNJGC5F9m
         WPizMhjjmX598C8vs5Nuj2zz7H4cK+KVQqxx1SoOMdqE+DH4makOO32AROQnmIb7WntS
         E1Bn+sH17u9n70ZIpxXFVeBG8MPlWl6PL0SPyd/CDK9gO0uqOhMLXQxYmGILkzZs6y2A
         miU8D7FdzWkr+8/E3G43img0A6ubEPbHJL9Qn6fWibplgP653T23dP81deqAIa5gkXLA
         MVPZ3FQpPifveFlwchkeXCOvOgxgXiRBeNN8NTYrPbKuF57XJAJdfpeq6LBxECyPdgAI
         D8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nyVTW/NfJ2wkCeZoen2ILlMbYSDECf1cn5qBJJZCWd0=;
        b=Yfwh0V7NdK1qokqTMIK4jZUQ4lxT/J3PEqFGckCN0Ux5UgBh5+HdCQddvskf5HLwXU
         3DTaj1cT+Rq6IPlnbjUJ/yUKTv7EZ32V0VPa8b5ow8nKH7sd8IbE1HpKbz9VtG3WobaW
         A3KB8wqKWua3N7lQo2RLahiJhIFGNs2UWpEuzaKYBCbbt8/Q9kPG3UVyBnTGrXbjoWVW
         bQGgSec7Gjv0ASYsF+Z6odpxYBoEBV68FWbyL3PgP6NUi5uGUeZBbE5i/upK4xyQUiAI
         Jjn25y637Lo9UdP66QiOen7RFMUzqYzfwSWGKwu6Y3ZQDuO9VAYwz70OpR3toagvc+JF
         HlSg==
X-Gm-Message-State: AOAM531PMVoJsdId62JDLewthcxOkD5U1YiJf4FAqGNu2ZW3l8jTMzel
        ++cGgRUR1prKBTYMEsEkM1iOJRZM1Zr0
X-Google-Smtp-Source: ABdhPJyHs4a5JhBga/7EW6l/pbrlQ9A5LjpNk6gVqEAvuhNxI6xpHsW2C3GuiUPfAZksMXwqwd/WKy4G+TQk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ffd6:b7f5:87ee:7be2])
 (user=irogers job=sendgmr) by 2002:a0c:e8cc:: with SMTP id
 m12mr6473299qvo.27.1624336706133; Mon, 21 Jun 2021 21:38:26 -0700 (PDT)
Date:   Mon, 21 Jun 2021 21:38:09 -0700
In-Reply-To: <20210622043811.3108564-1-irogers@google.com>
Message-Id: <20210622043811.3108564-2-irogers@google.com>
Mime-Version: 1.0
References: <20210622043811.3108564-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 2/4] perf: Add define for libtraceevent version
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-users@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Claire Jensen <cjense@google.com>
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
index 3a8a54b71654..6f318c16e8f1 100644
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
2.32.0.288.g62a8d224e6-goog

