Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3BC3B8FD4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 11:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbhGAJiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 05:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbhGAJiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 05:38:17 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B09C0617A8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 02:35:47 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id a14so3114636pls.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 02:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RO+W36IfmCoOF5xjf8ZackNVFoRy6NygyQXZ/WJRofM=;
        b=amvEoN9eeC+VEBTD1Zaf1gJDs8BfXOLUFzr2bPmh3NDlpAr7wa6izhXSlUg6ufPnPw
         xpVRznI1jPWm2KBvbsXd7Q7OCmjgO2kQMEDYydzfgeaqkgAtuj7wrZX6yYvE1C2+9Rmh
         9RuBcA30NcqbRWxeMrLMNgbsyj0U0du6rXT/GeMiiaSKmQpIk/c2/67CV5a227JD6bvp
         GNYEUUVNDqWr0b+d2E+FkjIjugfw9nDMeSay++s5zJw1Jr//gl/LBJxWfxQqyhaN0Aff
         GE/aMQfkKNuP1jEmO7fjQBdU2nmgjp2yOMxRwvsfClV6zH1EwrHpsdLbZTeC4m/xXMT1
         RQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RO+W36IfmCoOF5xjf8ZackNVFoRy6NygyQXZ/WJRofM=;
        b=kDGtTrvlJUkQusODyFXmfAm+7sIweXxBBSu5RvtUSjqGwnp4yc8BDVQLUDZW+Gyw8/
         St4mbr/iLMlmjcxWgKkEM73Ch5MYUQHLKkh++s7z9714pSxqs612XHlWO1XnEF4TBiXG
         GWPr8wnmiC9bDgCtscwRCCy791O5C5gJFLKJo6L1B0yKC5P/5LzICrp4STpZMFsyTSpf
         XD9tKnB7NQ4vW19UiqbwPdl9Lfj7JnL1ctErYtqLMmh8RE4B6jiadT1L+SlgwXpwa+NS
         A3JzxeQ5MjtYuiVw7keJphMohY8NnPQDIAs2lJKeaUsVv0nsI2GJKq9uxGgInGXJltY0
         dOUw==
X-Gm-Message-State: AOAM531I6gET1hrxAgTMUxEMmiD2kh/ngTkoM/cfcNPYhra4P9lL3giq
        I3EINLx4iPoWJ9YP57CFZxFpXA==
X-Google-Smtp-Source: ABdhPJyE/KA0+duFfM8NqupreWeG8QVd2YC27MOUmBwTeRg6FRzcSGd2EMTkjhDusy27JhzUdVXQpw==
X-Received: by 2002:a17:902:7446:b029:128:ec77:b41e with SMTP id e6-20020a1709027446b0290128ec77b41emr14929267plt.80.1625132146445;
        Thu, 01 Jul 2021 02:35:46 -0700 (PDT)
Received: from localhost ([202.131.71.237])
        by smtp.gmail.com with ESMTPSA id q21sm9005717pjg.43.2021.07.01.02.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 02:35:45 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <James.Clark@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Daniel Kiss <daniel.kiss@arm.com>,
        Denis Nikitin <denik@google.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/3] coresight: Fix for snapshot mode
Date:   Thu,  1 Jul 2021 17:35:34 +0800
Message-Id: <20210701093537.90759-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is to correct the pointer usages for the snapshot
mode.

Patch 01 is to polish code, it removes the redundant header maintained
in tmc-etr driver and directly uses pointer perf_output_handle::head.

Patch 02 removes the callback cs_etm_find_snapshot() which wrongly
calculates the buffer headers; we can simply use the perf's common
function __auxtrace_mmap__read() for headers calculation.  Patch 03 is
to update comments in CoreSight drivers to reflect the changes
introduced by patch 02.

This patch can be cleanly applied on the mainline kernel with:

  commit dbe69e433722 ("Merge tag 'net-next-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next")

And it has been tested on Arm64 Juno board.

Changes from v1:
- Dropped the patch "coresight: etm-perf: Correct buffer syncing for
  snapshot", after a long discussion, the patch doesn't really resolve
  any issues for snapshot mode.  And another reason for unlike this
  patch is now the CoreSight and Intel-PT have the consistent behaviour
  (Suzuki/James/Mathieu);
- Added the patch 03 to updates drivers' comments (James);
- Added Suzuki's review tag for patch 01;
- Added James' review and testing tags for patch 02.


Leo Yan (3):
  coresight: tmc-etr: Use perf_output_handle::head for AUX ring buffer
  perf cs-etm: Remove callback cs_etm_find_snapshot()
  coresight: Update comments for removing cs_etm_find_snapshot()

 drivers/hwtracing/coresight/coresight-etb10.c |   2 +-
 .../hwtracing/coresight/coresight-tmc-etf.c   |   2 +-
 .../hwtracing/coresight/coresight-tmc-etr.c   |  12 +-
 tools/perf/arch/arm/util/cs-etm.c             | 133 ------------------
 4 files changed, 6 insertions(+), 143 deletions(-)

-- 
2.25.1

