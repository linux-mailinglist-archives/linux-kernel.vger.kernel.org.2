Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07DF36D704
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 14:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbhD1MKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 08:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhD1MKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 08:10:12 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3109CC06138A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 05:09:26 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id b21so4197632plz.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 05:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5XNbQ4jS+oEXsc5GlcM2m6b8j3J1nAAGezzxy2+DoYs=;
        b=Q2XwIizloJd2toyJiA+osnbErOig8kN5L7KDEPFsod7H8NfuPrUh8yOaSBkFsuwS10
         GL5keAiLkcvD3utMjxyyGXQu785vT/hKz0m5t1+Y2L6Pe88hICry9+1ArV86UUh2O+C9
         5PsdceqVkCeR+XbdxHuCjXhu9ayNV+0cg8qKHFONq1MZv8S+lMncnYEF2S8AJ9RRxsF/
         PDESK8gr3hnJ89HfN7RWmimccOIw9b6REKlKYkjRITqaQ613RcpqMhVGYi1XP3lLDdTY
         ghgRIKbKX2WyvgzT1xzrw9jJYtnrfy7/v4AavZxM4gcbgNyXr4EalLR4vO7HxZGCoEaE
         nvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5XNbQ4jS+oEXsc5GlcM2m6b8j3J1nAAGezzxy2+DoYs=;
        b=GQqNQvQYbCx94JEpRm0xrVIwBR5GZ+X3cNpPbY6ir59A4je7ukmYKc86hyLBOvN94i
         WV3ckfHDf6Sj+601QYx/MaltlOUfGpV3TTRQc3gCVqEPnGRKz2Z/WQH26vacn6em0mG/
         FX46tb26js9GOSO8bSbA140OdsM06WK2e8taElceGxWzuZWW1HhuCBCIMWxu+iyTUWhI
         8N6qSS8UaYCkixYSyEZ1rLPaeZX0EBBN5qMzSHsSAHK34v87bWQusyH/XP/GKSujdvnP
         udocvhp3ejAsLdwVjS3HMljtmw9PLCugyG0XXLlaAtDW50XXaQOc3DZCCSbKfH0CzdxW
         +apw==
X-Gm-Message-State: AOAM531RJxHHhNqBHX/TLC6W+1SkoA8l78w8u5OD0NHWdvdXHLLnu1k3
        D6FsgA72SRHQwN0BN6JWtgrrew==
X-Google-Smtp-Source: ABdhPJwUvHIeeJ60S4HPiVj/59XXkm1I8zR0Nrtf8ZwEp3l2L7RS2JhMFK5wRKNFzUhhUy3IwJJtfw==
X-Received: by 2002:a17:90a:a404:: with SMTP id y4mr3623528pjp.228.1619611765700;
        Wed, 28 Apr 2021 05:09:25 -0700 (PDT)
Received: from localhost (ec2-18-166-74-158.ap-east-1.compute.amazonaws.com. [18.166.74.158])
        by smtp.gmail.com with ESMTPSA id g21sm5166040pjl.28.2021.04.28.05.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 05:09:25 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 0/4] perf: Allow TIME_CONV to be backwards-compatible and dump it
Date:   Wed, 28 Apr 2021 20:09:11 +0800
Message-Id: <20210428120915.7123-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The event PERF_RECORD_TIME_CONV was extended for clock parameters, but
the tool fails to be backwards-compatible for the old event format.

Based on checking the event size, this patch series can decide if the
extended clock parameters are contained in the perf event or not.  This
allows the event PERF_RECORD_TIME_CONV to be backwards-compatible.

The last patch also is introduced for dumping the event, for both the
old and latest event formats.

The patch set has been rebased on perf/core branch with:

  commit 4c391ea001cb ("perf beauty: Fix fsconfig generator")

And the patches have been tested on Arm64 HiSilicon D06 platform.

Changes from v2:
* Fixed subject and commit log in patch 01.

Changes from v1:
* Changed from bool to __u8 for perf_record_time_conv (Adrain);
* Added helper event_contains() and used it (Adrian).


Leo Yan (4):
  perf tool: Change fields type in perf_record_time_conv
  perf jit: Let convert_timestamp() to be backwards-compatible
  perf session: Add swap operation for event TIME_CONV
  perf session: Dump PERF_RECORD_TIME_CONV event

 tools/lib/perf/include/perf/event.h |  7 +++++--
 tools/perf/util/jitdump.c           | 30 +++++++++++++++++++----------
 tools/perf/util/session.c           | 28 +++++++++++++++++++++++++--
 tools/perf/util/tsc.c               | 30 +++++++++++++++++++++++++++++
 tools/perf/util/tsc.h               |  4 ++++
 5 files changed, 85 insertions(+), 14 deletions(-)

-- 
2.25.1

