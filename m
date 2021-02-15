Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D37031B894
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhBOMBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhBOMAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:00:37 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAEEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 03:59:56 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id cv23so3594099pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 03:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9T76R5wUoQ6QbcA59Hub5qgGpiG4101vCYkJ2djiRCo=;
        b=Xdeab72MYt/4MBdce4oi3yie43HUKV/20z4HX3pz5bLUk7tI+f6HnUtQVa3a40qvTb
         ecFqEvZVVT8xC9cp1FzWnqQedrjTwCGrP2h5WUU6A33kQM79To40EoebTJq4j/HfyaUH
         m1YjnCLa5qoj2q1ymT9CWz1blI6dTAdT2fMUa2toZBYfXbbk7Z3XiSreqGgCYYozXeDd
         MqrD77H6pQkpoUTzt+dp1ZsVw96gfWHK/MysakzTG/MXfNJa2kSlBOL4W8ULfkpbMrHp
         4hqsRvXcMeXCTuMWFwP8R6wdAhAbXbfHB3jlMB0WYlukH5/spC945iKZbhtjA2QcGaW7
         +zMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9T76R5wUoQ6QbcA59Hub5qgGpiG4101vCYkJ2djiRCo=;
        b=iiRuq3uphPcn9YdTqUyelmryHFo0Qw2cV2Y59astq/XCQeNVaCJOf5MqXDxU53i4dp
         85dCfynVt69qsf2QJCSwU8n5XLk1/eN7vQUe/k3dZ6h2UdNSPS8GjBJCwET9upS5ep7F
         rO2tmdtGsr3TB7a5BPwpPC1u0AT82GkgBzr08NJcRReiBfnxVivMp7jX16yjPfCfv+RR
         3/eyLWFIQTuu0IwdoAlYgS2S8WXwQ0JptOfCJ6SEBvuL9WkraOzDlIs+w0nBdmWaFeik
         PftabHTRxv30TWaItYNp1bEGzj/fCQ9x8FR3QZHfo42OL3GqC3mAFkOfIJ9edITEwu0c
         XpWA==
X-Gm-Message-State: AOAM533DiozFrXhZAOghGm2deTj7yr8eZpTouRIOp4BKSQZPw3m6m8Aw
        BLubs/c45oCN8sqb/Z2vgo401Q==
X-Google-Smtp-Source: ABdhPJxyeIoqXJ0bZR6pCINU3u7j0Gjqz6qIZ2C+WQ0CNnZLsez3QVPmXwQ6rbtvNA4AuviLCKIBwQ==
X-Received: by 2002:a17:90a:7345:: with SMTP id j5mr16120474pjs.176.1613390396064;
        Mon, 15 Feb 2021 03:59:56 -0800 (PST)
Received: from localhost ([45.137.216.90])
        by smtp.gmail.com with ESMTPSA id s135sm19089116pfs.206.2021.02.15.03.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 03:59:55 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/2] perf test: Output sub testing result in cs-etm
Date:   Mon, 15 Feb 2021 19:59:42 +0800
Message-Id: <20210215115944.535986-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "perf test" can be integrated into testing framework, e.g. Linux
kernel functional testing (LKFT) [1].  We are not satisfied with only
outputting the summarized result for Arm CoreSight testing but lacking
more detailed result for sub testing.

This patch set is to output sub testing result in cs-etm.  Thus the
testing framework can extract the detailed info and generates reports
for which sub cases causes failure.

This patch set is cleanly applied on perf/core branch with:

  commit 6db59d357e8e ("perf arm64/s390: Fix printf conversion specifier for IP addresses")

After applied the patches, which is tested on Arm Juno-r2 board with
option '-v', the output result is shown in below; the introduced sub
testing result has the format like:

  "CoreSight path testing (CPU0 -> tmc_etf0): PASS".


  # perf test 73 -v
  73: Check Arm CoreSight trace data recording and synthesized samples:
  --- start ---
  test child forked, pid 17423
  Recording trace (only user mode) with path: CPU0 => tmc_etf0
  Looking at perf.data file for dumping branch samples:       
  Looking at perf.data file for reporting branch samples:
  Looking at perf.data file for instruction samples:     
  CoreSight path testing (CPU0 -> tmc_etf0): PASS   
  Recording trace (only user mode) with path: CPU0 => tmc_etr0
  Looking at perf.data file for dumping branch samples:       
  Looking at perf.data file for reporting branch samples:
  Looking at perf.data file for instruction samples:     
  CoreSight path testing (CPU0 -> tmc_etr0): PASS   
  Recording trace (only user mode) with path: CPU1 => tmc_etf0
  Looking at perf.data file for dumping branch samples:       
  Looking at perf.data file for reporting branch samples:
  Looking at perf.data file for instruction samples:     
  CoreSight path testing (CPU1 -> tmc_etf0): PASS   
  Recording trace (only user mode) with path: CPU1 => tmc_etr0
  Looking at perf.data file for dumping branch samples:
  Looking at perf.data file for reporting branch samples:
  Looking at perf.data file for instruction samples:     
  CoreSight path testing (CPU1 -> tmc_etr0): PASS   
  Recording trace (only user mode) with path: CPU2 => tmc_etf0
  Looking at perf.data file for dumping branch samples:
  Looking at perf.data file for reporting branch samples:
  Looking at perf.data file for instruction samples:     
  CoreSight path testing (CPU2 -> tmc_etf0): PASS   
  Recording trace (only user mode) with path: CPU2 => tmc_etr0
  Looking at perf.data file for dumping branch samples:
  Looking at perf.data file for reporting branch samples:
  Looking at perf.data file for instruction samples:                  
  CoreSight path testing (CPU2 -> tmc_etr0): PASS        
  Recording trace (only user mode) with path: CPU3 => tmc_etf0
  Looking at perf.data file for dumping branch samples:
  Looking at perf.data file for reporting branch samples:
  Looking at perf.data file for instruction samples:
  CoreSight path testing (CPU3 -> tmc_etf0): PASS
  Recording trace (only user mode) with path: CPU3 => tmc_etr0
  Looking at perf.data file for dumping branch samples:
  Looking at perf.data file for reporting branch samples:
  Looking at perf.data file for instruction samples:
  CoreSight path testing (CPU3 -> tmc_etr0): PASS
  Recording trace (only user mode) with path: CPU4 => tmc_etf0
  Looking at perf.data file for dumping branch samples:
  Looking at perf.data file for reporting branch samples:
  Looking at perf.data file for instruction samples:
  CoreSight path testing (CPU4 -> tmc_etf0): PASS
  Recording trace (only user mode) with path: CPU4 => tmc_etr0
  Looking at perf.data file for dumping branch samples:
  Looking at perf.data file for reporting branch samples:
  Looking at perf.data file for instruction samples:
  CoreSight path testing (CPU4 -> tmc_etr0): PASS
  Recording trace (only user mode) with path: CPU5 => tmc_etf0
  Looking at perf.data file for dumping branch samples:
  Looking at perf.data file for reporting branch samples:
  Looking at perf.data file for instruction samples:
  CoreSight path testing (CPU5 -> tmc_etf0): PASS
  Recording trace (only user mode) with path: CPU5 => tmc_etr0
  Looking at perf.data file for dumping branch samples:
  Looking at perf.data file for reporting branch samples:
  Looking at perf.data file for instruction samples:
  CoreSight path testing (CPU5 -> tmc_etr0): PASS
  Recording trace with system wide mode
  Looking at perf.data file for dumping branch samples:
  Looking at perf.data file for reporting branch samples:
  Looking at perf.data file for instruction samples:
  CoreSight system wide testing: PASS
  Recording trace with snapshot mode
  Looking at perf.data file for dumping branch samples:
  Looking at perf.data file for reporting branch samples:
  Looking at perf.data file for instruction samples:
  CoreSight snapshot testing: PASS
  test child finished with 0
  ---- end ----
  Check Arm CoreSight trace data recording and synthesized samples: Ok

[1] https://lkft.linaro.org/


Leo Yan (2):
  perf test: Suppress logs in cs-etm testing
  perf test: Output the sub testing result in cs-etm

 tools/perf/tests/shell/test_arm_coresight.sh | 45 ++++++++++----------
 1 file changed, 23 insertions(+), 22 deletions(-)

-- 
2.25.1

