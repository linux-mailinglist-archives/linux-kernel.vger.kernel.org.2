Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C83365BF3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbhDTPQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbhDTPQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:16:37 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5C0C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 08:16:06 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so20619662pjv.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 08:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p+G9I0twdQ25gtNDzTS0vvubZNpcCb4yzAAC9B7XO08=;
        b=aVtd2WJozOwrhWmRHVYpvwf0WF70utvUycTTCVf9m+QkZi+huf3sziTEqkz2LQtEfx
         GJUqOcTvvEqdLcATaoF3wu5t5FfKyqQO7UHuKKQ6cw2OSCYQOLZtf+pXBkhe+Hi2lAxQ
         34llZVzxhqidPIQfrkl+OWFPW00X8jX2g8pWFNKOhZEN7Cl7x/wvC/DLPrD7ZAwRhzIj
         mRNWbxmppJtovmNSR8wSfNtH0Pg698x6Fq/fMC+xtMXBNdkzPh3dOPNUBPuQDENom3LW
         9SnActI/E1zHJbMEKWuVlb0czaYUJMlMH21WB22elXUUhb4SJWe/lC7JF/sdus+VC0rE
         jXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p+G9I0twdQ25gtNDzTS0vvubZNpcCb4yzAAC9B7XO08=;
        b=RUjujZPuXvdT+zyzrg4x+hOMAwgc5MtEG8AWY6A6WyYaMzrEaKjzN+9oq9WInS1PfR
         ziUeTuHlMRmrGgv5CYVFBJf5AXP/kpwdQZPS/QakVPLPvZyErW0TnVObcwjgf3CcsDvC
         BYX4p6u9wIaW4uW351Lgx7J5EkbinzdMSlNMzla5FcWGQAqjQDJTdksmSli1hp14Ks9z
         G4WYLDWRYTsb2K57AlfK+zNDdqkZ5PCUv4ZWsecmoqj74RN8ac5txm7qyoW83NkNXMNZ
         ylIdKIGSYGCG+VyocBMC+FOBkPSEBtEfKO+N0Pkp3vU3KV1L1UA7yOvI/VG7Qhq6aC+8
         /nQA==
X-Gm-Message-State: AOAM532zYy4GyjbSG71R+aLdsVQ3s84ouKxjdo5z14JpjUhGEQwiWmds
        hJPvXcbQUvvEjNZPl7Ir+xFbdw==
X-Google-Smtp-Source: ABdhPJyCODabRkMDM3er0M3Lq37OMWExHbMXfffEvpiTk6nQH/WJYqKv8iVWbtAWHl9TTGQhJxefAA==
X-Received: by 2002:a17:90a:670a:: with SMTP id n10mr5536990pjj.176.1618931765726;
        Tue, 20 Apr 2021 08:16:05 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id a129sm2913849pfa.36.2021.04.20.08.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 08:16:04 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf auxtrace: Fix potential null pointer dereference
Date:   Tue, 20 Apr 2021 23:15:53 +0800
Message-Id: <20210420151554.2031768-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function auxtrace_parse_snapshot_options(), the callback pointer
"itr->parse_snapshot_options" can be NULL if it has not been set during
the AUX record initialization.  This can cause tool crashing if the
callback pointer "itr->parse_snapshot_options" is dereferenced without
performing NULL check.

Add a NULL check for the pointer "itr->parse_snapshot_options" before
invoke the callback.

Fixes: d20031bb63dd ("perf tools: Add AUX area tracing Snapshot Mode")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/auxtrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 953f4afacd3b..320b47f133d3 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -638,7 +638,7 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
 		break;
 	}
 
-	if (itr)
+	if (itr && itr->parse_snapshot_options)
 		return itr->parse_snapshot_options(itr, opts, str);
 
 	pr_err("No AUX area tracing to snapshot\n");
-- 
2.25.1

