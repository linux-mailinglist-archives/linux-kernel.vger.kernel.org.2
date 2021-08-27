Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4BF3FA1D5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 01:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhH0XdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 19:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbhH0XdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 19:33:04 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669B6C0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 16:32:15 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id w8so7216553pgf.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 16:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fCipVVzTtJpoy8nLWmkhfFoaX9arljPeiBEW051ggiM=;
        b=jj7qwY65kq8rl1/56FoSPk/YBdheQc5ViDCQFm5IggU/+B7LAYIXNE+DXPIBn2Hk52
         Qa+bcf3PwOfTc2uhrJqba1kD8YT9OZifpXL8n+ZmRxgBDfqPgt3mc1Xd5CiuQmXPYPsJ
         8ATrxL06s7/g8o050kYEWT1pE7RJMGJi7rIe6fcVb4noSEwXeeRg4l4BgTLP8sxhvLUd
         vwFO3l/UQbPyKCYVzHi+nqU15Tw5A+k22G560UvdT/6yAC5xTgdmWvjP1IFjTRcBvoh3
         vOmOdYApHrPpZuYGl5kO+OL+qTXqRJDdjfDpkCVSNW2uEzs6Fd0MP+tF3O2B3p2q0XCe
         HE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=fCipVVzTtJpoy8nLWmkhfFoaX9arljPeiBEW051ggiM=;
        b=VdiinCQwFG72IkSD1XeDnYnEHEKYKKuKyBHFmhyQFIEOVOwBIDMwkJwgVoRlNAy9Fs
         tmNMDHL+taY/CxlMEsUkWP6NXuIJyXtb04Syr2xKVCy+rrc7t3bLufDfCBnyI8w+PAch
         WZ/yOvP3fAH2PDQBoZ2SQNqODPtioEnF2Yl6Yy72CPC6RwlgCZ4jNhoTe2c+FWTJ6zu1
         epmihWro5VOAYm0tiu9QTwj+i8lAfwxIrRkV6Yd+e7zqnMrx/zQq8Lq73PfI1PhAM9B0
         Qwhdmx6iJKhepc3/kdyaVZ8Megy/Cn912JJGDMkqbGy9146UuQj72kcWo88I0315TerL
         r5vQ==
X-Gm-Message-State: AOAM5337NsfbUW+CofaONAx12ax+x2jM2xzw3Xy0UMvZEbxW81Kfw+pQ
        sNjnik8yOBpYaXwJFnEdh/4=
X-Google-Smtp-Source: ABdhPJx8siQ7j/sIeVAWsyhCR1H2VvzAvGiuzk24H8noTovVdYyGCxNxZqU8fodHUm9O5mUD4Cl4dg==
X-Received: by 2002:a05:6a00:238b:b0:3e1:9c51:b737 with SMTP id f11-20020a056a00238b00b003e19c51b737mr11228888pfc.29.1630107134874;
        Fri, 27 Aug 2021 16:32:14 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:e240:cd27:1a36:e9c0:fa73])
        by smtp.gmail.com with ESMTPSA id x129sm7396613pfx.198.2021.08.27.16.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 16:32:14 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH] perf record: Fix wrong comm in system-wide mode with delay
Date:   Fri, 27 Aug 2021 16:32:12 -0700
Message-Id: <20210827233212.3121037-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane found that the name of the forked process in a system-wide
mode is wrong when --delay option is used.  For example,

  # perf record -a --delay=1000  noploop 3

The noploop process will run a busy loop for 3 second.  And on an idle
machine it should show up at the top in the perf report.  It works
well without the --delay option.  But if I add the option, it showed
'perf' not 'noploop'.

  # perf report -s comm -q | head -3
      52.94%  perf
      16.65%  swapper
      12.04%  chrome

It turned out that the dummy event didn't work at all and it missed
COMM and MMAP events for the noploop process (and others too).  We
should enable the dummy event immediately in system-wide mode, as the
enable-on-exec would work only for task events.

With this change,

  # perf report -s comm -q | head -3
      52.75%  noploop
      17.03%  swapper
      12.83%  chrome

Cc: Adrian Hunter <adrian.hunter@intel.com>
Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-record.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 548c1dbde6c5..acfe66e31cf0 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -910,7 +910,8 @@ static int record__open(struct record *rec)
 		 * Enable the dummy event when the process is forked for
 		 * initial_delay, immediately for system wide.
 		 */
-		if (opts->initial_delay && !pos->immediate)
+		if (opts->initial_delay && !pos->immediate &&
+		    !target__has_cpu(&opts->target))
 			pos->core.attr.enable_on_exec = 1;
 		else
 			pos->immediate = 1;
-- 
2.33.0.259.gc128427fd7-goog

