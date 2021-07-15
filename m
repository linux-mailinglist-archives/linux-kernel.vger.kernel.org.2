Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E34A3C95A0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 03:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbhGOBg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 21:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbhGOBg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 21:36:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EACC061760
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 18:34:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l16-20020a25cc100000b0290558245b7eabso5426773ybf.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 18:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GIjWo0gzOMptvkl7/douQ77SF5UMK5TcXXj5psLQmwQ=;
        b=YfYatFr1PgmuDlSqCxGHNS7KP86q5AQ6O4VjwKg1ku2Vjnrx9PUEOSlRRlTDNnYjGT
         lkbu9PGbmIVZq1MgvMPNwcDSFCVd1HpW9yaO8T0clDTLLJCPJXAaIbmsukYaTnsS1GzM
         UjCe2BhfEZS0KXWUQbDl9ScElnh0XxjZVJ6ien4zR6T7v7c2kEBVIwtnMs/PDoITSF+o
         45UuJoywYuvd/vTFUSxanL8U3Cwu5xTP0IP26bw5cRRaEO95UpstaXs9gMjgrxET0Vu0
         1mLanC+CvRqHfLa0jZrN/LCz3hUqqg29hLXwVLmoWjjm/E/sQp1YgmIgLGzepfK/5oc/
         0g/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GIjWo0gzOMptvkl7/douQ77SF5UMK5TcXXj5psLQmwQ=;
        b=YNHH6ISl316a7zwYa6lncqR9F9gX6xTmadJpX8NiLmyWL8Mv+Qv/AEHGhGVVX/SzKp
         fhRMqbl9eTTRbWU5IzC7xr8fBxTSjqX2weESBZLmXqU+tisy6tcStN5FjcsW//XLmcRr
         fNn/Uy2cGPErLG2lKaPojNNCXDxlw5whaeKOMSIaWgxRzyIbdzGquEVkwLZggt1tkfhx
         8tLzhk7tgWjJpbj0YifPFt3cmY1e1ezO68zRY7nCCFzcKn/bJ36l4ghOEzhDVLbXgWLy
         hJFg4NK118S8hckUOX0ztWUcAOavmTcxS2nEuf5ln7MIBKbsM1ZbrZbyL9ZphH+bgnGU
         Bqzw==
X-Gm-Message-State: AOAM532JH0B8B+fLlZaY+PyAzOZ1oMsSCOmjj/SL7/GbulBidc+Du9uY
        NPLYZ3veRLi78vHJycvG3zxc0SXlUtH1
X-Google-Smtp-Source: ABdhPJwm9dD9egCtGYZHwFPyFZ1Trxro9AjycOBuUEmkfseiRuUNBjrVu3FodNRFeytyKV0I6AM/71SGvDDP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:c0a3:e3b0:6b14:de32])
 (user=irogers job=sendgmr) by 2002:a25:ed01:: with SMTP id
 k1mr1315360ybh.74.1626312843141; Wed, 14 Jul 2021 18:34:03 -0700 (PDT)
Date:   Wed, 14 Jul 2021 18:33:40 -0700
In-Reply-To: <20210715013343.2286699-1-irogers@google.com>
Message-Id: <20210715013343.2286699-5-irogers@google.com>
Mime-Version: 1.0
References: <20210715013343.2286699-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 4/7] perf doc: Add info pages to all target.
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

Enabled to ensure that info pages build.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index 03300c151858..85a796c112a2 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -173,7 +173,7 @@ ifneq ($(V),1)
 endif
 endif
 
-all: html man
+all: html man info
 
 html: $(DOC_HTML)
 
-- 
2.32.0.402.g57bb445576-goog

