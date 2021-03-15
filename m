Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361E233AA9C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 05:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhCOE5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 00:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhCOE4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 00:56:47 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E60C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 21:56:47 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id e26so5808905pfd.9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 21:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T6iP5qmdrF3GmpohmzLfiNNlDHtgl7Bh9pCRbOUlUrc=;
        b=dlRl4wgtvQjtv2J/ICFFzJHGgJJK4d66h43RegVXhDIwwvwnIv4QK97jxjOiKXqFWQ
         1HTf4+wotRgSvBlFfw306ELkcB+T4oL1h5Vb2b7fUVcFqv82NQSkkMixWQ7dWa6j2M3d
         Ao4WK2qaHhZE+If5x6Bg8iKl8uMwHH67c0fYGS6MpLfZLRIkz32AkG3m0WslfxzJjxK1
         qLTO9GF7/XqgYnqwfGIrciG8ditcvPogLuqAqIaHvXL4EU9mj5KY5UfyyV5uRAXeo3iF
         PnRDaTLh0kFYNfLdkFyIBD9lC+8rnQSN0LZRImEiwacCAKjpJJ3WO0qNK0YWDOSdV0XU
         rrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=T6iP5qmdrF3GmpohmzLfiNNlDHtgl7Bh9pCRbOUlUrc=;
        b=ZWiu1YeamGhYGEG0Qs2c1Zt/S4ctejrP4Jajxx9reHpTCVzb6C1xDjg65t2X50zW9I
         ipJG3enBGikMX8eimqAymXc9HXor2z/criQZLM1YkW+xRHMN8ApD1OLllDrTJ3FPOYvc
         sXAzGQLdN/w3rNINZRNFVIFIFatBhe3YiQisE2uD1TbC10Cwx1NhchKd2ztZiIHzQx9Q
         aQhrsXrNIYWv5xFkyLAKWBG+D0xfjWCzrWCIyPZQ4PXtBHydVGWoTy3A3SYL+ZDLGFCB
         oZ1Z9Hp881aG2naYZeKdsvVa1ncMRHFvF5Haz/NFfyxA29ZrKQerUmmnZJI/fYuOwzV0
         GzpA==
X-Gm-Message-State: AOAM530YoYbRT097wJpfH7Med0gyudo8EM8oKTKERp49gfESTVVJ6dhD
        nJFfB4TzrQsncvGT+y2clYw=
X-Google-Smtp-Source: ABdhPJyZaPXFaESpVPHYN8wn6raEZMl4n1TxazAiYfk06Scpp23nMbPPmHua1svk7mcZa4xYK0R/vA==
X-Received: by 2002:a62:3646:0:b029:205:2117:f339 with SMTP id d67-20020a6236460000b02902052117f339mr6708784pfa.32.1615784206720;
        Sun, 14 Mar 2021 21:56:46 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id d24sm12259704pfr.139.2021.03.14.21.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 21:56:46 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH] perf record: Fix memory leak in vDSO
Date:   Mon, 15 Mar 2021 13:56:41 +0900
Message-Id: <20210315045641.700430-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got several memory leak reports from Asan with a simple command.  It
was because VDSO is not released due to the refcount.  Like in
__dsos_addnew_id(), it should put the refcount after adding to the list.

  $ perf record true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.030 MB perf.data (10 samples) ]

  =================================================================
  ==692599==ERROR: LeakSanitizer: detected memory leaks

  Direct leak of 439 byte(s) in 1 object(s) allocated from:
    #0 0x7fea52341037 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x559bce4aa8ee in dso__new_id util/dso.c:1256
    #2 0x559bce59245a in __machine__addnew_vdso util/vdso.c:132
    #3 0x559bce59245a in machine__findnew_vdso util/vdso.c:347
    #4 0x559bce50826c in map__new util/map.c:175
    #5 0x559bce503c92 in machine__process_mmap2_event util/machine.c:1787
    #6 0x559bce512f6b in machines__deliver_event util/session.c:1481
    #7 0x559bce515107 in perf_session__deliver_event util/session.c:1551
    #8 0x559bce51d4d2 in do_flush util/ordered-events.c:244
    #9 0x559bce51d4d2 in __ordered_events__flush util/ordered-events.c:323
    #10 0x559bce519bea in __perf_session__process_events util/session.c:2268
    #11 0x559bce519bea in perf_session__process_events util/session.c:2297
    #12 0x559bce2e7a52 in process_buildids /home/namhyung/project/linux/tools/perf/builtin-record.c:1017
    #13 0x559bce2e7a52 in record__finish_output /home/namhyung/project/linux/tools/perf/builtin-record.c:1234
    #14 0x559bce2ed4f6 in __cmd_record /home/namhyung/project/linux/tools/perf/builtin-record.c:2026
    #15 0x559bce2ed4f6 in cmd_record /home/namhyung/project/linux/tools/perf/builtin-record.c:2858
    #16 0x559bce422db4 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:313
    #17 0x559bce2acac8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:365
    #18 0x559bce2acac8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:409
    #19 0x559bce2acac8 in main /home/namhyung/project/linux/tools/perf/perf.c:539
    #20 0x7fea51e76d09 in __libc_start_main ../csu/libc-start.c:308

  Indirect leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x7fea52341037 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x559bce520907 in nsinfo__copy util/namespaces.c:169
    #2 0x559bce50821b in map__new util/map.c:168
    #3 0x559bce503c92 in machine__process_mmap2_event util/machine.c:1787
    #4 0x559bce512f6b in machines__deliver_event util/session.c:1481
    #5 0x559bce515107 in perf_session__deliver_event util/session.c:1551
    #6 0x559bce51d4d2 in do_flush util/ordered-events.c:244
    #7 0x559bce51d4d2 in __ordered_events__flush util/ordered-events.c:323
    #8 0x559bce519bea in __perf_session__process_events util/session.c:2268
    #9 0x559bce519bea in perf_session__process_events util/session.c:2297
    #10 0x559bce2e7a52 in process_buildids /home/namhyung/project/linux/tools/perf/builtin-record.c:1017
    #11 0x559bce2e7a52 in record__finish_output /home/namhyung/project/linux/tools/perf/builtin-record.c:1234
    #12 0x559bce2ed4f6 in __cmd_record /home/namhyung/project/linux/tools/perf/builtin-record.c:2026
    #13 0x559bce2ed4f6 in cmd_record /home/namhyung/project/linux/tools/perf/builtin-record.c:2858
    #14 0x559bce422db4 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:313
    #15 0x559bce2acac8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:365
    #16 0x559bce2acac8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:409
    #17 0x559bce2acac8 in main /home/namhyung/project/linux/tools/perf/perf.c:539
    #18 0x7fea51e76d09 in __libc_start_main ../csu/libc-start.c:308

  SUMMARY: AddressSanitizer: 471 byte(s) leaked in 2 allocation(s).

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/vdso.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index 3cc91ad048ea..43beb169631d 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -133,6 +133,8 @@ static struct dso *__machine__addnew_vdso(struct machine *machine, const char *s
 	if (dso != NULL) {
 		__dsos__add(&machine->dsos, dso);
 		dso__set_long_name(dso, long_name, false);
+		/* Put dso here because __dsos_add already got it */
+		dso__put(dso);
 	}
 
 	return dso;
-- 
2.31.0.rc2.261.g7f71774620-goog

