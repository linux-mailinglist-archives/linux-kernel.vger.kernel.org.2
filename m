Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1E8308553
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 06:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhA2Fts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 00:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhA2Ftr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 00:49:47 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08360C061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 21:49:07 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id b21so5921029pgk.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 21:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tVJjTenNLTzHrF2aTm18o4ON4OCXDq74QxlW6fJ6i20=;
        b=u+YFGHCWcybaeGxmjuH8ppCeMC/mwFMCm71N1fx3ra6xmTfLyowDhegmz3BSsTuw83
         sb+ZlisAcyY7Bjd3VSFUkLP/zd9vwB3jcQE8LPtA9mozdw4MaJ7aA48hij2iXfZOeyE+
         wHS1qiX4Ana43rX8ljrkQULaIG0NuGPxF8dZ5hO7h5ka9RphEEIE47tcNSsHNeRJJ/WE
         nVs2k610mZhko6Ub451XzBbLD1rB9cyDrIgFqlLyzXH0To3YWmNIqbKOT3DoWXI8siP5
         ScBZyRX8VwpFwZNBRy6qYXhpcCY1629uZwCIYqZeFVNieNSqsnrNYj5EdLqeUeSJvBw3
         Oh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=tVJjTenNLTzHrF2aTm18o4ON4OCXDq74QxlW6fJ6i20=;
        b=Xf6ZY62YYyPem26HhfkB42vuf74IvKcPO+CdfuOiFewFK7sId/ezaUMSlj0moMHVM/
         fJ5N3FGEesOraISoEtRsw0vEbJmBiUbslMkJS89IZ1cqKc+ZxMi2i9LHVNF0TLWbt/kP
         /2NIg0MbjwjBQUw1L2HYZ/SQpNzU6PBbXCd9xZ5TggzUxFFNS+Q/mxpcLlM8hSZy78et
         n1xVYLInf9oRdbF2Z6gQHxSCDIWn1czmy/vZxswjh+UMFTGx1FVj5MMTCiqPmZRbnQCF
         0bu229yLLbPiQYmu5F2bk1pfn8+SFx31qm5ofYRya8PIqOnfAg8m/rkgFm7mjTNugxQV
         221w==
X-Gm-Message-State: AOAM530CG8QMi8m0doZT8cec9Vw11MluPrZOUmCcKx76VGTFeI5hKvTW
        jn6cp69Ge1dmf7QAIHrs7V8=
X-Google-Smtp-Source: ABdhPJxRRTu5p8MuSjnDFQ4ApX2EkFrSZ8R3tcYx7OovA259yQTynVXtmBsQsxQCOdCMRxYj+9J87w==
X-Received: by 2002:a63:5b43:: with SMTP id l3mr3022235pgm.369.1611899346559;
        Thu, 28 Jan 2021 21:49:06 -0800 (PST)
Received: from balhae.roam.corp.google.com ([114.129.115.223])
        by smtp.gmail.com with ESMTPSA id j13sm7408098pfr.214.2021.01.28.21.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 21:49:05 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH v2 0/3] perf tools: Minor improvements in event synthesis
Date:   Fri, 29 Jan 2021 14:48:58 +0900
Message-Id: <20210129054901.1705483-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is to optimize the event synthesis during perf record.

The first patch is to reduce memory usage when many threads are used.
The second is to avoid unncessary syscalls for kernel threads.  And
the last one is to reduce the number of threads to iterate when new
threads are being created at the same time.

Unfortunately there's no dramatic improvement here but I can see ~5%
gain in the 'perf bench internals synthesize' on a big machine.
(The numbers are not stable though)


Before:
  # perf bench internals synthesize --mt -M1 -I 100
  # Running 'internals/synthesize' benchmark:
  Computing performance of multi threaded perf event synthesis by
  synthesizing events on CPU 0:
    Number of synthesis threads: 1
      Average synthesis took: 68831.480 usec (+- 101.450 usec)
      Average num. events: 9982.000 (+- 0.000)
      Average time per event 6.896 usec


After:
  # perf bench internals synthesize --mt -M1 -I 100
  # Running 'internals/synthesize' benchmark:
  Computing performance of multi threaded perf event synthesis by
  synthesizing events on CPU 0:
    Number of synthesis threads: 1
      Average synthesis took: 65036.370 usec (+- 158.121 usec)
      Average num. events: 9982.000 (+- 0.000)
      Average time per event 6.515 usec


Thanks,
Namhyung


Namhyung Kim (3):
  perf tools: Use /proc/<PID>/task/<TID>/status for synthesis
  perf tools: Skip MMAP record synthesis for kernel threads
  perf tools: Use scandir() to iterate threads

 tools/perf/util/synthetic-events.c | 88 ++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 30 deletions(-)

-- 
2.30.0.365.g02bc693789-goog

