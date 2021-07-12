Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B843C6727
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 01:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbhGLXwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 19:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbhGLXwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 19:52:41 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1979CC0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 16:49:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so977896pjo.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 16:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LM54NTJ+dmglFjBn+os+BCojGr+CGTdcA45qtxyhsu4=;
        b=Qao5FhkkWRGDJvWel28oL1YN6AxwH7xqgkG+GPWNxMSsvo4NfCx9HDyi3kRuOXIYUT
         0e68BLw70J2pZYRAb89gMG0I3Pgoivj+XryeohSXq7rNTbfjfIwzwmj9DpLGSes0oTrD
         KJxxpRlO4I1eRGOPwIySG2v5qERN7+AmMPEvyKF2zzPRa6hP3A6i6xeR6BGZ8yYODZY/
         jR6tNpa7zBli7mfXmV1exGzPjuHDZOInWct3ZWXj1rYVdkFDkIuet4R62kZps46WLyir
         p0c7ara6j67egYl5PFf/LQjZeZ0k1uyJXkNuxJ1Cf/+MJQ8Xkb1lKVLtHZoz1Xq/GYN/
         B89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=LM54NTJ+dmglFjBn+os+BCojGr+CGTdcA45qtxyhsu4=;
        b=PUpf5VYiF5QRMd2m2cPpKVaHcx3CPSIH6J9hnUm3SqIRG+oamxUGbQGwmpiAysYcZt
         xEwg8NWnh29r1bXaij1JMoTuMTRDPSvKhL1nKP/95ziJUp/zk+ylML5snNfvOQHY9Hnp
         RdJjBqtmApyetBUMhE4t5wor1D4p91bNVmriiCkfac0PNOE/hMMTW1HTJdXfS/wZ3Bb1
         Al+ojz8aASPpkxdAp/lrdeoik49JAsDjyQT64aXSfaLAn11P5jS27h7NkWk1rRrMrkFH
         WFT/tmRg4zTPy7LO3zr+YHLITEq07GsmNybfn++c7Cy/z7Hm+GramvqtPsdzFB/0UyFj
         8z6w==
X-Gm-Message-State: AOAM532wRBTFm4zFB9oUCcuwBmDVz9d1ZTBleUugYDefYqL+9z2cnITv
        T0dYA//TCR+oBQ/Ct+JJoE4=
X-Google-Smtp-Source: ABdhPJyEAuCugLaxMAof7+/pjbZDVXmGbWRtkeyasXAt2TC1znFceVnl6hWPlzRDXUC7JUf/3euW4Q==
X-Received: by 2002:a17:90a:28f:: with SMTP id w15mr1397905pja.70.1626133791541;
        Mon, 12 Jul 2021 16:49:51 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:d0f2:96e7:d715:6393])
        by smtp.gmail.com with ESMTPSA id d191sm19450444pga.27.2021.07.12.16.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 16:49:51 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH] perf tools: Fix build with libpfm
Date:   Mon, 12 Jul 2021 16:49:49 -0700
Message-Id: <20210712234949.917788-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It missed to update the parse_libpfm_events_option() to use a new
helper function to set the event group leader.

  $ make LIBPFM4=1
  ...
    CC      util/pfm.o
  util/pfm.c: In function ‘parse_libpfm_events_option’:
  util/pfm.c:103:9: error: ‘struct evsel’ has no member named ‘leader’
    103 |    evsel->leader = grp_leader;
        |         ^~
  make[4]: *** [tools/build/Makefile.build:96: util/pfm.o] Error 1

Fixes: fba7c86601e2 ("libperf: Move 'leader' from tools/perf to perf_evsel::leader")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/pfm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
index dd9ed56e0504..756295dedccc 100644
--- a/tools/perf/util/pfm.c
+++ b/tools/perf/util/pfm.c
@@ -99,7 +99,7 @@ int parse_libpfm_events_option(const struct option *opt, const char *str,
 			grp_leader = evsel;
 
 		if (grp_evt > -1) {
-			evsel->leader = grp_leader;
+			evsel__set_leader(evsel, grp_leader);
 			grp_leader->core.nr_members++;
 			grp_evt++;
 		}
-- 
2.32.0.93.g670b81a890-goog

