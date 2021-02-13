Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679E131AB0C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 12:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhBMLdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 06:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhBMLdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 06:33:11 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAE3C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 03:32:30 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id u143so1218158pfc.7
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 03:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W2CQVz20vN5F7fQcfxaSQ2VjkuwMeYspcqmbmEfvZR8=;
        b=UTYXjdDqeb5mNjNNjhHuYOdIaSyLxw+j46OAeZs/Gv+zAQ8C/pUL5W8o9+1aajXZPW
         V994DZN4eBHGgJDbuiCpJ5mJg6HiP1L0vIY/a5pH/wTshf0XFMQm+NmXBYg2T/6iLuvU
         W4LCD+4csQbpVdx7VLVAxHW4KVCCLdS28B0quzHb3/TnWTE5JfXhyzNpNYzVsrwMWHAx
         CZwe5q0beK2KaRez69zKT4X9yJuVKIF83bP1Fe0xeDuNCvVduHUl2EJOKxC8Tly/vVvK
         cHU2nLO6Z+O8E0A2aa/d1LgR0EmeA2z67OFIVUAkjcdziz227mj0JdZuGkh9cUTiaix0
         xAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W2CQVz20vN5F7fQcfxaSQ2VjkuwMeYspcqmbmEfvZR8=;
        b=tVyvtcB5KqDFaiPg4XlcAU+wpoNrbwAGUJVpDDvovSFzGL45nwHQFtqtmEC6W7PuVk
         yc/EjlXVzk671jL8QyLz5YOBDrAH7aZ593PH+6MkiGb4OF89lgI7lAZS20sil/4FDGTQ
         cVKgo1AhNak91U2S3zhWt6X/v8kW1EHijgtER9eodMl2rrLfaUxJujmxzumS5Ea9uzKr
         bxok1YPWiXPbTqNYP5gTqFgN9EtYXVdKRDjU9cvt42pNjFeBGo7kL9mfyI0fDfhHqiHS
         RQ6APySIjA2oQZTJgaYDc/aWN6NQf52k3HocTxQAZAqPy/EkoQr1e+sDujOSdUwu89iZ
         IcHA==
X-Gm-Message-State: AOAM531ZKmtDUCX/7yfyH9a9YacasdBpM5PqWqBnN7cNfSBs8HepesTf
        gkY2mwzsx+iVEKUsAHiBFItn7Q==
X-Google-Smtp-Source: ABdhPJyfPFOnv/XqyxL0uGHTirdaJq5eQXmTOzFczogtqRBIVqM2soJfgql1fe28iR0Q26/5xZctnw==
X-Received: by 2002:aa7:9197:0:b029:1d5:bc1b:ee79 with SMTP id x23-20020aa791970000b02901d5bc1bee79mr7183060pfa.38.1613215949880;
        Sat, 13 Feb 2021 03:32:29 -0800 (PST)
Received: from localhost ([45.137.216.202])
        by smtp.gmail.com with ESMTPSA id d5sm11540003pgd.86.2021.02.13.03.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 03:32:29 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 0/5] perf cs-etm: Fix pid tracing with VHE
Date:   Sat, 13 Feb 2021 19:32:15 +0800
Message-Id: <20210213113220.292229-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to follow up the patch series "coresight: etm-perf:
Fix pid tracing with VHE" [1].

Since the kernel and documentation patches have been picked up by
Mathieu Poirier and will go through the char-misc-next branch [2] to the
mainline kernel; the rest patches are for the perf tool, so combine
these patches into this patch set.

The patch set can be cleanly applied on perf/core branch with:

  commit 6db59d357e8e ("perf arm64/s390: Fix printf conversion specifier for IP addresses")

And this patch set has been verified on Arm Juno-r2 board.

Changes from v3:
* Added Reviewed-by tags (Mathieu/Mike/Suzuki);
* Changed to use the existed macros for option bits in patch 02/05
  (Mathieu).


[1] https://lore.kernel.org/patchwork/cover/1376776/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/log/?h=char-misc-next


Leo Yan (2):
  tools headers UAPI: Update tools' copy of linux/coresight-pmu.h
  perf cs-etm: Add helper cs_etm__get_pid_fmt()

Suzuki K Poulose (3):
  perf cs-etm: Fix bitmap for option
  perf cs-etm: Support PID tracing in config
  perf cs-etm: Detect pid in VMID for kernel running at EL2

 tools/include/linux/coresight-pmu.h           | 20 ++++--
 tools/perf/arch/arm/util/cs-etm.c             | 69 ++++++++++++++-----
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 38 ++++++++--
 tools/perf/util/cs-etm.c                      | 42 +++++++++++
 tools/perf/util/cs-etm.h                      |  1 +
 5 files changed, 145 insertions(+), 25 deletions(-)

-- 
2.25.1

