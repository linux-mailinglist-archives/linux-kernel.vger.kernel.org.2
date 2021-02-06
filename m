Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103CA311E47
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 16:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBFPJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 10:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBFPJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 10:09:19 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F970C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 07:08:40 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id z9so5465736pjl.5
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 07:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZspU6L37XgcENXFVgUeRV2DHijrkLVw1Znnl1QRz8qQ=;
        b=Pi7VUqJE9S7HbzCe6zVqL1qdjye7sNokP1s+h3GR8Nk4Xx5zudG/G7cdogBLeojNwj
         Uo0obEO2XhTuIY8qKmCOwQs80ZbVerqMWD+GXIfvQAtVJvuoPmyazypubYeNO5fphLUD
         mZChTM6WXoCfeyL/quAOU7bB3gcHPwebhhhM1A4FRnqb7UAcvbpkDvJY9J67/kIvfNKY
         cWwrqajDDJ7hABa8MUPp4W5B73NmN02Q9frVhEHEXRUgCZM0MRdVPbxRsn4JIDHb1Xfh
         uuJW9Z4DeQCK2Vypu1nfM8v4FDNey2UEvy0OGAN9H4ywEWX6W5QnNdqyKbeT+ZFIUsp1
         4f3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZspU6L37XgcENXFVgUeRV2DHijrkLVw1Znnl1QRz8qQ=;
        b=BxjEky9qTmC1EK3ulDKkj5tZP2acafM3hfku8jj8RSOIILcr9P6giApID40K97FYmi
         owyC+42m09VnmZT+NdvMWPreLl3DhG5QzPaNQEJCka2nrWiSEA1v6cPRoyzrJBWBTJm+
         jReaBbWSUMeJOSTdlq/DgUMaBXU3jqtbCI7ptsSBygAExIaUzOeCs18/U85bvoR5TIKr
         6CA+YWw9p2fL7VbjkSbxDdBsRS5UXm5w15dyb9KV/vQ8qIaWwUhyp4mweLr9yn6vKF/v
         +AWBli07oxYz15QyoAJ22DklHpkfAoM48RMDdS2QXRdHCeyl1xyb87uWHILChH5BMGS8
         i4bw==
X-Gm-Message-State: AOAM531Jlpk17Z6Kjy5V2Gb0XV6209sHCnAGE0TwvnNjGWFySSaQQ3N1
        8fDvEou4jMqiUIetEdsc64K0jA==
X-Google-Smtp-Source: ABdhPJwu5jxF7iqb3RH136Hsl5o2diii5bu45/NlStNlwhGDLf0//lIT22219V8yVqUES/fqav9fag==
X-Received: by 2002:a17:90a:5788:: with SMTP id g8mr2809110pji.219.1612624119668;
        Sat, 06 Feb 2021 07:08:39 -0800 (PST)
Received: from localhost ([45.137.216.202])
        by smtp.gmail.com with ESMTPSA id a24sm14483595pff.18.2021.02.06.07.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 07:08:38 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Al Grant <al.grant@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 0/8] coresight: etm-perf: Fix pid tracing with VHE
Date:   Sat,  6 Feb 2021 23:08:25 +0800
Message-Id: <20210206150833.42120-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is to support PID tracing with Virtualization Host
Extensions (VHE).

To be backward compatibility, and can both support PID tracing for the
kernel is running at either EL1 or EL2, the two new PMU formats
"contextid1" and "contextid2" are introduced, which works as switches
to trace PID for EL1 kernel and EL2 kernel respectively.

The existed PMU format "contextid" needs to be backward compatible for
users, it's changed as an alias for "contextid1" on EL1 kernel and for
"contextid2" on EL2 kernel.  Therefore, even without setting "contextid"
config, the perf tool can dynamically pick up the config for PID
tracing, the user doesn't have to set the "contexid" config manually.

This patch series can be cleanly applied on perf/core branch:

  commit cd07e536b020 ("Merge remote-tracking branch 'torvalds/master' into perf/core")

... and applied on the mainline kernel:

  commit 1e0d27fce010 ("Merge branch 'akpm' (patches from Andrew)")

The patch series has been tested on Arm Juno-r2 board.  Verified the
kernel with EL1 and didn't find issue; after some hacking in kernel
driver and tool to emulate the code paths for kernel on EL2, can see
the code path is hit without failure.


Changes from v2:
* Split into two patches for clarification comment on perf options, one
  patch is for kernel change and the another one is for tools' change
  (Suzuki);
* Simplified cs_etm__get_pid_fmt() to return ETM_OPT_CTXTID2 OR
  ETM_OPT_CTXTID, but not both (Suzuki);
* Cached "pid_fmt" in cs_etm_decoder__set_tid() (Suzuki);
* Refined documentation for more clear description for PMU format usages
  (Mike);
* Added Suzuki's and Mike's Reviewed tags.

Changes from v1:
* Refactored PMU formats, added formats "contextid1"/"contextid2", and
  reworked format "contextid" (Suzuki/Mathieu);
* Refined the comments for perf configs (Leo/Mike);
* Added patch 07/07 for description PID tracing in docs;
* Found the issue for bitmap for option, extracted patch 03/07 for the
  fixing.

Changes from RFC:
* Added comments to clarify cases requested (Leo);
* Explain the change to generic flags for cs_etm_set_option() in the
  commit description;
* Stored PID format in metadata and passed it to decoder (Leo);
* Enhanced cs-etm for backward compatibility (Denis Nikitin).


Leo Yan (4):
  coresight: etm-perf: Clarify comment on perf options
  tools headers UAPI: Update tools' copy of linux/coresight-pmu.h
  perf cs-etm: Add helper cs_etm__get_pid_fmt()
  Documentation: coresight: Add PID tracing description

Suzuki K Poulose (4):
  coresight: etm-perf: Support PID tracing for kernel at EL2
  perf cs-etm: Fix bitmap for option
  perf cs-etm: Support PID tracing in config
  perf cs-etm: Detect pid in VMID for kernel running at EL2

 Documentation/trace/coresight/coresight.rst   | 32 ++++++++
 .../hwtracing/coresight/coresight-etm-perf.c  | 32 +++++++-
 .../coresight/coresight-etm4x-core.c          | 13 ++++
 include/linux/coresight-pmu.h                 | 20 +++--
 tools/include/linux/coresight-pmu.h           | 20 +++--
 tools/perf/arch/arm/util/cs-etm.c             | 73 +++++++++++++++----
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 38 +++++++++-
 tools/perf/util/cs-etm.c                      | 42 +++++++++++
 tools/perf/util/cs-etm.h                      |  1 +
 9 files changed, 239 insertions(+), 32 deletions(-)

-- 
2.25.1

