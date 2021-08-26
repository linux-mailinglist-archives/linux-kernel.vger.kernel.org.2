Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096EF3F8E20
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 20:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243330AbhHZSta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 14:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbhHZSt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 14:49:26 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497CAC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:48:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g192-20020a25dbc9000000b0059bd2958c8aso1085367ybf.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=574wPISS8tCg0FtWFoBAsPvMx8DTHUTnbYJhfrVYJio=;
        b=KTatZ9VMDNXbGBEpdiDXhavnjCd4AhNRcSs5HyN6PvQQ4DrikRFKaX6+2yrn1BRt7K
         qFf3k+Ea1AEkYlKKDbONBAAUqg+/eXD38NhUz648LYgDhku0c3FwoA8y0pp4mVb7YqQJ
         1TIzoSggKQfPGMjxNy4EKSOaBzYzmHoorS6XdYCP5s1q+dLEptKG9AiP2xEJFMobnK2X
         psc8Jjw3P/d0Mp6R3E7556QjfRAWGzeopeBHV/zO2e/OF6s7kz8V5nYzGAOAr9gT0jP/
         4VIScRdXD15Jj0bTpzqCwwFSN+9EeJpOOn65F5L6iRYCZAid7xIgwEf6bir8K6/FYHSX
         HJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=574wPISS8tCg0FtWFoBAsPvMx8DTHUTnbYJhfrVYJio=;
        b=eMtHOVBKjOZZIRA+qW6IMfjXSxSzZpq+fNh6cUBJe8ZOXwJg1MPDgNeX+eOXVk8vpQ
         KCLGMcX87isEkFYCunBkEOkeASHZ4pyZlwjV7tOUaGFVSgXBteJoajsouTdpC/pL88R1
         ayN77C4kzpJJ4CLZwCSUWbdF70rWNB+eahwZctNOF5LHMBu396hfkaYgkQeZqCyCoxmE
         YOMeabdlY40vzgn67jMS5rS9KBcKZAqfYIosuKu1+6ITbtx6MSCVewpIjIzCQmP3lCqW
         rOnEGmrufAV+wiekPxv6PS7MO1CIhCEGaZ3C7B8e6KQZUcE5thENQrmgfun/O0ZNkTQS
         Tlig==
X-Gm-Message-State: AOAM532BP+2Xg/owtr+XBO8wgre1ZlRwxxZcw7oZO9BALgkwdSR+zGvs
        RSbieDVU79QFmdG4TaT0v6nL75qK7xAN
X-Google-Smtp-Source: ABdhPJwDbx4iAlZZn6vbjuBMAQdnEevvuznBezeyMZOT9Ba4O/Ekdt0Dvlban2zkpEHcTLpcw1vePG3Y3M5m
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:c034:ab65:973a:f67b])
 (user=irogers job=sendgmr) by 2002:a25:d446:: with SMTP id
 m67mr197590ybf.187.1630003718499; Thu, 26 Aug 2021 11:48:38 -0700 (PDT)
Date:   Thu, 26 Aug 2021 11:48:33 -0700
Message-Id: <20210826184833.408563-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH v2] perf bpf: Fix memory leaks relating to BTF.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BTF needs to be freed with btf__free.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate.c  | 2 +-
 tools/perf/util/bpf-event.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index d43f6b5e5169..0bae061b2d6d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1833,7 +1833,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 	ret = 0;
 out:
 	free(prog_linfo);
-	free(btf);
+	btf__free(btf);
 	fclose(s);
 	bfd_close(bfdf);
 	return ret;
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index cdecda1ddd36..17a9844e4fbf 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -296,7 +296,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 
 out:
 	free(info_linear);
-	free(btf);
+	btf__free(btf);
 	return err ? -1 : 0;
 }
 
@@ -486,7 +486,7 @@ static void perf_env__add_bpf_info(struct perf_env *env, u32 id)
 	perf_env__fetch_btf(env, btf_id, btf);
 
 out:
-	free(btf);
+	btf__free(btf);
 	close(fd);
 }
 
-- 
2.33.0.259.gc128427fd7-goog

