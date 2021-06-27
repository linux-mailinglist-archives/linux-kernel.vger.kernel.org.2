Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9D73B532E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 13:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhF0Lwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 07:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhF0Lwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 07:52:46 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FADC061766
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 04:50:21 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id y13so7255621plc.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 04:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oi1ZJHf6HzEztg5bMRc8K5f9pFEUjpZ9qI75GxG+Cd4=;
        b=phlbRMlPWuyyZjgGN/uXM4A5fiK8rmg/7kqB/YHbhFhlnqikFUeGJ/iCvcbtECYaAk
         S95CV4RtpdMG1pbKIeLAtthPLDD77UnZYcFchRXlz28a3hYfZIbGXuaDWMJ47tBQA5o5
         rF5g5xGID+yjEUimfcrGyCEiykTukUfsYdaHdMydl3CvexuczzkEpr8eiup00JLa7gB2
         2XAySQWSycec4hS17FgvZqxp0mfiRVe2Ptx17Om4zThmvlw4lNChxFV2cNvxeFuU4Kb3
         mIxB1gP9e/IzAkX1HqdOGMuqU+xiInd8U+STED0ucJ7lF5n8gIO6bsV0XEV0qNs+Xj+s
         B2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oi1ZJHf6HzEztg5bMRc8K5f9pFEUjpZ9qI75GxG+Cd4=;
        b=mzABJOaXA0lJDJmFlQrT9oxQChzwe/wQPA6h007OHDPsZ3+IFgu6xlvf/SQqcoYsZ6
         lBYnOYEU3o+ewRB/h13xZscZKI6qwwnP065kVm6GLyZ5aWxj7AdFRw0xr+1v8dRf5/wC
         gxrCiyNbKimCOaYOLn1MYmot3CKnjIY1jAz84PJrHreqmHLz1YlddkrYhj3yOzlQRjcD
         kW2krVGNpGrE3aBYYWbwwOwJZjHyiBazISErytaBw26sWmHcvygjSrTGIeQys6Y4LbUj
         LAfalkev88v5k4WZgQ47KSr+UYNJfaOAPH9bZUDT8yZFHpayeAFBsELn0sr29385OZvw
         Tgow==
X-Gm-Message-State: AOAM53317Xl0tkzLDClwqnlqVwDi/nI8jh80zoymV8e9QhFD3zP1HFFf
        RaBLV1EnTD91Eb7k8AbgwH3VDQ==
X-Google-Smtp-Source: ABdhPJw6nZ6dHQdYSmOhqb4KAmSQNXOYZv8xcBmy1K69dmF3mzMEVw8z20o26pUj9Hzvp/mWHm5Hww==
X-Received: by 2002:a17:902:ea10:b029:128:c36f:2dd5 with SMTP id s16-20020a170902ea10b0290128c36f2dd5mr4810874plg.4.1624794620788;
        Sun, 27 Jun 2021 04:50:20 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id s13sm11311109pgi.36.2021.06.27.04.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 04:50:19 -0700 (PDT)
Date:   Sun, 27 Jun 2021 19:50:13 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] perf cs-etm: Split Coresight decode by aux records
Message-ID: <20210627115013.GA13045@leoy-ThinkPad-X240s>
References: <20210624164303.28632-1-james.clark@arm.com>
 <20210624164303.28632-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624164303.28632-2-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 05:43:02PM +0100, James Clark wrote:
> Populate the auxtrace queues using AUX records rather than whole
> auxtrace buffers so that the decoder is reset between each aux record.

[...]

> Signed-off-by: James Clark <james.clark@arm.com>

I tested this patch with kprobe/uprobe events; and confirmed this
patch works as expected.  So:

Tested-by: Leo Yan <leo.yan@linaro.org>


Below shares my testing steps.

- The rationale for the testing is to use "perf probe" to add trace
  points for PERF_RECORD_AUX/PERF_RECORD_AUXTRACE, and add another
  uprobe event for parsing AUX fragment.  So we can compare the
  recorded PERF_RECORD_AUX events, and check if AUX fragment can
  reorganize the perf AUX trace data correctly or not.

- The testing script test_cs_etm_snapshot.sh:
  http://paste.debian.net/1202563/

- Add kprobe event for perf_event_aux_event() so that it can trace
  the perf event PERF_RECORD_AUX:

  # perf probe --add "perf_event_aux_event head=head:x64 size=size:x64"

- Add uprobe event for __auxtrace_mmap__read() so that it can trace
  the perf event PERF_RECORD_AUXTRACE:

  # perf probe -x /mnt/linux-kernel/linux-cs-dev/tools/perf/perf \
     --add "__auxtrace_mmap__read:58 idx=mm->idx head=head:x64 offset=offset:x64 size=size:x64"

- Add uprobe event for cs_etm__queue_aux_fragment():

  # perf probe -x /mnt/linux-kernel/linux-cs-dev/tools/perf/perf \
     --add "cs_etm__queue_aux_fragment:63 aux_offset=aux_offset:x64 aux_size=aux_event->aux_size:x64"

- Enable trace events:

  # cd /sys/kernel/debug/tracing
  # echo 1 > events/probe/enable
  # echo 1 > events/probe_perf/enable

- Executed the testing script and perf report command:

  # sh test_cs_etm_snapshot.sh
  [ perf record: Woken up 7 times to write data ]
  [ perf record: Captured and wrote 19.534 MB /tmp/__perf_test.perf.data.miRDs ]
  # perf report -i /tmp/__perf_test.perf.data.miRDs

- At the end, I can get the tracing result:

  # cd /sys/kernel/debug/tracing
  # cat trace

  # entries-in-buffer/entries-written: 21/21   #P:6
  #
  #                                _-----=> irqs-off
  #                               / _----=> need-resched
  #                              | / _---=> hardirq/softirq
  #                              || / _--=> preempt-depth
  #                              ||| /     delay
  #           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
  #              | |         |   ||||      |         |
                dd-2206    [001] d.h3  1395.922396: perf_event_aux_event: (perf_event_aux_event+0x0/0x108) head=0x400000 size=0x400000
              perf-2204    [002] ....  1395.922565: __auxtrace_mmap__read_L58: (0xaaaaab154394) idx=1 head=0x400000 offset=0x0 size=0x400000
                dd-2206    [001] d.h3  1395.942658: perf_event_aux_event: (perf_event_aux_event+0x0/0x108) head=0x50b3f0 size=0x10b3f0
              perf-2204    [002] ....  1395.942739: __auxtrace_mmap__read_L58: (0xaaaaab154394) idx=1 head=0x50b3f0 offset=0x400000 size=0x10b3f0
                dd-2206    [001] d.h3  1396.000040: perf_event_aux_event: (perf_event_aux_event+0x0/0x108) head=0x90b3f0 size=0x400000
              perf-2204    [002] ....  1396.000150: __auxtrace_mmap__read_L58: (0xaaaaab154394) idx=1 head=0x90b3f0 offset=0x50b3f0 size=0x400000
                dd-2206    [001] d.h3  1396.023098: perf_event_aux_event: (perf_event_aux_event+0x0/0x108) head=0xb87ae0 size=0x27c6f0
              perf-2204    [002] ....  1396.023197: __auxtrace_mmap__read_L58: (0xaaaaab154394) idx=1 head=0xb87ae0 offset=0x90b3f0 size=0x27c6f0
                dd-2206    [001] d.h3  1396.087722: perf_event_aux_event: (perf_event_aux_event+0x0/0x108) head=0xf87ae0 size=0x400000
              perf-2204    [002] ....  1396.087838: __auxtrace_mmap__read_L58: (0xaaaaab154394) idx=1 head=0xf87ae0 offset=0xb87ae0 size=0x400000
                dd-2206    [001] d.h3  1396.131696: perf_event_aux_event: (perf_event_aux_event+0x0/0x108) head=0x1387ae0 size=0x400000
              perf-2204    [002] ....  1396.131808: __auxtrace_mmap__read_L58: (0xaaaaab154394) idx=1 head=0x1387ae0 offset=0xf87ae0 size=0x400000
              perf-2217    [003] ....  1439.581363: cs_etm__queue_aux_fragment_L63: (0xaaaac9582ba8) aux_offset=0x0 aux_size=0x400000
              perf-2217    [003] ....  1439.581467: cs_etm__queue_aux_fragment_L63: (0xaaaac9582ba8) aux_offset=0x400000 aux_size=0x10b3f0
              perf-2217    [003] ....  1439.581510: cs_etm__queue_aux_fragment_L63: (0xaaaac9582ba8) aux_offset=0x50b3f0 aux_size=0x400000
              perf-2217    [003] ....  1439.581553: cs_etm__queue_aux_fragment_L63: (0xaaaac9582ba8) aux_offset=0x90b3f0 aux_size=0x27c6f0
              perf-2217    [003] ....  1439.581595: cs_etm__queue_aux_fragment_L63: (0xaaaac9582ba8) aux_offset=0xb87ae0 aux_size=0x400000
              perf-2217    [003] ....  1439.581638: cs_etm__queue_aux_fragment_L63: (0xaaaac9582ba8) aux_offset=0xf87ae0 aux_size=0x400000

  We can see the recording AUX trace data in perf_event_aux_event()
  can be decoded properly in events cs_etm__queue_aux_fragment_L63().

Thanks,
Leo
