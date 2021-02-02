Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C5330C633
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbhBBQlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236731AbhBBQjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:39:47 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8C0C0613ED
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 08:39:07 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id nm1so2602564pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 08:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b38PbWWvjwCc9O3KDe7MyXUwafx01VvqV6s7ApqBfZE=;
        b=lLjL48NNB64cbd5J1UH6ZeGorOS5hhpQTI1NLBW0+P3g76xMFsc1j05rkEKOBoS8Hq
         lrR4bPXZg7i2smlnXKn8HEWUktTsiEBeaseEs3NCY51WVkRmehj81oFN8dmZzjRdMgYz
         n9rM42fgJZ1KNq6wMk48SpPDe/M+hgeri7Y3xwAqBpyxStwh5EWnZKp+MHSTRqA5Ez45
         In3CpsIOeCEJktQNKQkmlKo0drScwqMeu2UZ1cXRROWHMHmDOmUzRKcKo7zAP6CEWDHX
         wU3q6EBru+nIyhLmMIkVevIxNeXn15U2oZRupo6BTRmdR6l8WOvMRMsV2igRbvDoYVL3
         XY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b38PbWWvjwCc9O3KDe7MyXUwafx01VvqV6s7ApqBfZE=;
        b=ECfX12kBPAr5WWjq4FimwJCIaAYviB2B1QJ0LT/+A1LsxAoJFeBuO2AZ/CTVB53ahH
         3yH0sv2dxULwf3ws3ib0HmUEjC67SPHxIhFs4o6aatMQfLSbpxiWdTht5ulCqMJnaLmi
         7Jh5pptQm1VEI3ZZ2+kRVzqv3AfU7D/re88F0QjRlvM/YDdNv+3Kv+8TQRAm8JkkwXFP
         DEwdU4OhkjYyI0cK5b1U3suv1j2nyUgEIg0+XHeePJ/iwuxdSh53tkILl130rlmIBDaW
         1/HN25vMQX3ChKAtPN2oPweh1AmABtzmHFeTZgzi+SuCvrFLuQ4E0hb0bfYFeDkeAt0z
         Lzxg==
X-Gm-Message-State: AOAM530ZKiKg5Qgv/Hk15mA8rHNzxfopqTLsof7j2wE9fK1zzi9fuG/4
        VfqZnb/KeEYQgWt6AvFdPcMR7Q==
X-Google-Smtp-Source: ABdhPJyApfVZVPwqNrXCIgoJkQE38h+AcTZF+1Djd9izwDK38OVIuW5iXk+ElSIbckm88jMTNKBczg==
X-Received: by 2002:a17:90b:949:: with SMTP id dw9mr5538261pjb.20.1612283946762;
        Tue, 02 Feb 2021 08:39:06 -0800 (PST)
Received: from localhost ([45.137.216.202])
        by smtp.gmail.com with ESMTPSA id ds10sm3326998pjb.1.2021.02.02.08.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:39:06 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/7] coresight: etm-perf: Fix pid tracing with VHE
Date:   Wed,  3 Feb 2021 00:38:35 +0800
Message-Id: <20210202163842.134734-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is to support PID tracing with Virtualization Host
Extensions (VHE).

Since the patch series v1 was sent out for reviewing, we had some
discussion and finalized the solution which is implemented in this
version.  Simply to say, to be backward compatibility, and can both
support PID tracing for the kernel is running at either EL1 or EL2,
the two new PMU formats "contextid1" and "contextid2" are introduced,
which works as a switch to trace PID for EL1 kernel and EL2 kernel
respectively.

The existed PMU format "contextid" needs to be backward compatible for
users, it's changed to an alias for "contextid1" on EL1 kernel and for
"contextid2" on EL2 kernel.  Therefore, even without setting "contextid"
config, the perf tool can dynamically pick up the config for PID
tracing, so the user doesn't have to set the "contexid" config manually.

As results, we now have three PMU formats, for easier understanding the
implementation, just copy and paste the descriptions for these three PMU
formats from the patch 07/07:

  "contextid1": Available on both EL1 kernel and EL2 kernel.  When the
                kernel is running at EL1, "contextid1" enables the PID
                tracing; when the kernel is running at EL2, this enables
                tracing the PID of guest applications.

  "contextid2": Only usable when the kernel is running at EL2.  When
                selected, enables PID tracing on EL2 kernel.

  "contextid":  Will be an alias for the option that enables PID
                tracing.  I.e,
                contextid == contextid1, on EL1 kernel.
                contextid == contextid2, on EL2 kernel.

This patch series can be cleanly applied on perf/core branch:

  commit cd07e536b020 ("Merge remote-tracking branch 'torvalds/master' into perf/core")

... and applied on the mainline kernel:

  commit 88bb507a74ea ("Merge tag 'media/v5.11-3' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media")

The patch series has been tested on Arm Juno-r2 board.  Verified the
kernel with EL1 and didn't find issue; though absenting the platform for
kernel with EL2, after some hacking in kernel driver and tool to emulate
the code paths for kernel on EL2, can see the code path is hit without
failure.


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


Leo Yan (3):
  coresight: etm-perf: Clarify comment on perf options
  perf cs-etm: Add helper cs_etm__get_pid_fmt()
  Documentation: coresight: Add PID tracing description

Suzuki K Poulose (4):
  coresight: etm-perf: Support PID tracing for kernel at EL2
  perf cs-etm: Fix bitmap for option
  perf cs-etm: Support PID tracing in config
  perf cs-etm: Detect pid in VMID for kernel running at EL2

 Documentation/trace/coresight/coresight.rst   | 37 ++++++++++
 .../hwtracing/coresight/coresight-etm-perf.c  | 32 +++++++-
 .../coresight/coresight-etm4x-core.c          | 13 ++++
 include/linux/coresight-pmu.h                 | 20 +++--
 tools/include/linux/coresight-pmu.h           | 20 +++--
 tools/perf/arch/arm/util/cs-etm.c             | 73 +++++++++++++++----
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 32 +++++++-
 tools/perf/util/cs-etm.c                      | 43 +++++++++++
 tools/perf/util/cs-etm.h                      |  1 +
 9 files changed, 239 insertions(+), 32 deletions(-)

-- 
2.25.1

