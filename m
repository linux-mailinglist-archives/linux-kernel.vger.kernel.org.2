Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9952141546E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 02:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbhIWAMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 20:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238650AbhIWAMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 20:12:08 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C02FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 17:10:37 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id ib9-20020a0562141c8900b003671c3a1243so14914724qvb.21
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 17:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0fQ8TCUq2nIKYsU5pQLtTTkuNxp/JAtlPHlUXR9S+Vg=;
        b=iI7qtmAmICkCCgLQogFaAY+iqk/g0Dx4kqDujqKKmXN0v1JFPQUul3NCyww0gCz+bh
         soWX/aTviRUIArTACFx4jx2YDtC/FS+VH3xG3lrhqQKz3eDY/Sf/na5CMpzHV3Jp6p+S
         vmwGIU1AFGE3XDfVSQi8SR+UxDkFdXWtVTTPHUsQziKUCV3Dxz7MnHRmmpsJ4yOsl5Nv
         e7G4Jco/RdvVPH/WvqiK+eu0wuw79xzZu6/fWm9FtXX38e3qGYteTYv37xU2cugbDrLf
         Fvl+PiIY7HA+F+tjRhBEA2R330mEZqzv0HZLdyulB7WvxnDh2bArBW9ZPsjbmHAaFuH8
         0Sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0fQ8TCUq2nIKYsU5pQLtTTkuNxp/JAtlPHlUXR9S+Vg=;
        b=dYWxgLpjIPuzgcG0+m3dXbRd10TeB2uDbCoECWjKIFH+1k2/igVvF79E51cB8eMj/R
         MzXieFEI17V+oio/zC+Re1pMqtBcCvLxw7I0veIEDTaFGhygR2rGCrdljdEcxupX5Y/N
         VJcJ6MoBs80/Myj1tcym8MpqdiDSgru9nEhDwsBmAa8spI61XRi8QdpaoF0ZVtkCxZUl
         l9gVAF6CXfPCn5t3Z2cAixIukYYsJy4kQmQI/gG5It+ItRG5XlxjepX/0aoR3UxZn3Mo
         OP0iJQIcG5ULqMh176bv6SidDsrRNMju7cJaqetGjXLVeAJn/DoMykVJ/OiLekOG1qmf
         79Ew==
X-Gm-Message-State: AOAM533A01NfpwfHUlgZRxJhAOAd1gqMPni5kKDZTisny6QoyPWaD2BL
        Hx4ixFU434BgogrFpBplhsirwFiw3qZG
X-Google-Smtp-Source: ABdhPJy3RyfRfsylWhaJSckwnbpuVOrAcbDqdc5Kw2u184AKjwVFqJK7ZhO8wo5+A2EsARnq9Dm++Cv3pPH7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:a05:6214:6a7:: with SMTP id
 s7mr1648022qvz.34.1632355836614; Wed, 22 Sep 2021 17:10:36 -0700 (PDT)
Date:   Wed, 22 Sep 2021 17:10:23 -0700
In-Reply-To: <20210923001024.550263-1-irogers@google.com>
Message-Id: <20210923001024.550263-3-irogers@google.com>
Mime-Version: 1.0
References: <20210923001024.550263-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v3 3/4] perf: Add define for libtracefs version
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

