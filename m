Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B083AFC15
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 06:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhFVEkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 00:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFVEkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 00:40:45 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D01C061766
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 21:38:29 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id t131-20020a37aa890000b02903a9f6c1e8bfso16570870qke.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 21:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=f6S0WBq/K51AHVi882cH7yHUVw3RgS/c1EddbRfRkGY=;
        b=XJjB3vfBTB14D/uOjWqlVbSdqEOMEKvPIBDNxqz245aG6s4iP3Wt97k13nN3heVdJ6
         yXw2rg1ihfW005qDP9buBaE/4XCpAr6GhYC5TM1rGAWqXqEnGIbUT9NzTC2IO3wV0X6y
         l2cdyBKSDaIn1cK13477PFiSXrMIx2fHhT7jw6dtr8TV2eURw2ahAjI9WxgX/tdOP7pe
         dWwJnArXjAmVRrsmOrux8UnQ9D0HS34lORpdLT37kpx9c4dUxm8lIR39IT0+FJNiEVOn
         h80EAvdKxtL+saT21doNHKY4cidpkUkGP+WtTrFAa+Bg1/wTXKkJ6H03TaTjMZs7gaCG
         3f6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=f6S0WBq/K51AHVi882cH7yHUVw3RgS/c1EddbRfRkGY=;
        b=eWID4pPdHvdk8+OVQ2/RDy91iSFvytw4fXb/RXl/Vpyx0ksDXdaRqOXN8bJ4N35u1c
         ImCraWs3/tEGnTV1M/5N4dlfxazPXmkBSrxFr9eH96pQC95T+UVHJlSmSKEtNPcu7+7y
         xHwOlRahe7afrcGTQkaryy3luq82bjBC7m+ccHLWVP7coh3CdYN32fUKNYJmu6oSSews
         AUrG1cO/afJtT66gOkX6FdwsFcNha7+T3jJcIotYiiDg8jjmb4B51xD8LKqyfDzRL5mM
         QFtpts7UCtXZwsihS4ZECNzAqcf3tzsP8IW/195oGIBz9YfMDAzt/1NB3VqzkfD37Qoi
         /vDQ==
X-Gm-Message-State: AOAM532o4X7zloZ+/ccLi5N0vYRhZjupnNO2g1vVBkb73hlmcexokK1d
        xxo05rVWiAh7FEfdys6B9a61oC0EfQRy
X-Google-Smtp-Source: ABdhPJxEEY/xt/NvaDOiUGhk4FeaGmtuHEugG55zaUrYTpgmZHnDr8YgjhvtfkrruUch1MG0uXP4KH/hY/1A
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ffd6:b7f5:87ee:7be2])
 (user=irogers job=sendgmr) by 2002:ad4:4e13:: with SMTP id
 dl19mr23694833qvb.9.1624336708448; Mon, 21 Jun 2021 21:38:28 -0700 (PDT)
Date:   Mon, 21 Jun 2021 21:38:10 -0700
In-Reply-To: <20210622043811.3108564-1-irogers@google.com>
Message-Id: <20210622043811.3108564-3-irogers@google.com>
Mime-Version: 1.0
References: <20210622043811.3108564-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 3/4] perf: Add define for libtracefs version
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

This will allow version specific support of libtracefs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 6f318c16e8f1..9389ef68e2fb 100644
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
2.32.0.288.g62a8d224e6-goog

