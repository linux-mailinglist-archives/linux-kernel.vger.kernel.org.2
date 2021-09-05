Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731CE400FDA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 15:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbhIENNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 09:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhIENNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 09:13:52 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A8DC061575
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 06:12:49 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id e7so2319665plh.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 06:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=trmoX4/mXFyoA+IsgLAnbNXqKcGcV7esjUPwUmwIlCM=;
        b=POQW7UUmTkZuStnwNW3j3xo/g25QBfG4hcVO93HcBst9fCejcmLzrWLTnC4HFYIV52
         qz4EsGvJVFHefALASHumAUwb2aIegmKd0Zktr90qKj4O7WVsdEymH9aytExW2ZXjmGZs
         kkfE1j22NHcK0Xkp4tiXFV72VlCQGwJWiQpcZPeMeQUZghXLdZ3s6OU7dDrIIGIDS/jC
         JNBo8vNmiMN1L4bPJNMHOGwpNzxeaDY5AnEPRX7QCBtNXkmQzGeKbZ5LbW92BbOUslAn
         s+UiK8bTih8TaqRUWUQzkInLbvFC1y4qAUDcSpZ+Q8TAIITptd7rSq8fPn9030ylVJ7T
         /SHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=trmoX4/mXFyoA+IsgLAnbNXqKcGcV7esjUPwUmwIlCM=;
        b=cuxwUSgvs+NM5eRdL4D3f3D9QDHTe1uxd0vhOOKzPF9Gt9ug/AprttFFkQ+rU/UkKH
         JeoIV19/22v3w89/zGeL/XStfmTcFFmlgGRRYER/tZco/Jvfa3bFMI+dYNB73HAJrwfW
         bIekpXVqJmUsd+gtjlB+qBNiEEkjY5uRGBZUhvAO17zCzE55aWH4bDKIaOffxftFALVg
         eiM0gUkZjUifahyt3npX9/a9Bwhczp2yNd1k6UmTSVoPXbLnC1++Zz4cfwMUEQNeB+Qa
         Aiu+RJT23qnW40ATWY/uswEA6lQQ4Pu983PgrA85/igdCKlyXLLsYSAHN75j6aSoMrsZ
         DB8A==
X-Gm-Message-State: AOAM530xVHmsyzJdLCgXhpQuPca7ndaBUWYyTDfLflWgxEpGbgfKb/Yn
        A4XP7LLelOqdPI9MJL84ji+DfA==
X-Google-Smtp-Source: ABdhPJze7PB5Ueo5yCToFRwMUSFfDWmilvGSYOYqVyEiBQPErLNwmFOJ/4JjfvUBOB1NHtuJSPKbjg==
X-Received: by 2002:a17:90b:3742:: with SMTP id ne2mr8981618pjb.218.1630847569045;
        Sun, 05 Sep 2021 06:12:49 -0700 (PDT)
Received: from localhost ([204.124.181.224])
        by smtp.gmail.com with ESMTPSA id gk12sm2734308pjb.39.2021.09.05.06.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 06:12:48 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 0/2] coresight: Fix for snapshot mode
Date:   Sun,  5 Sep 2021 21:12:35 +0800
Message-Id: <20210905131237.1035322-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the previous patch set for fixing CoreSight snapshot mode [1], the
patch for perf tool has been merged into the mainline kernel [2]; other
two patches for CoreSight driver have been left out.

This patch series resends these two missed out patches, alongside
patches 01 and 02 are updated with minor improvement commits.

This patch series has been tested on Arm64 Juno board.

Changes from v2:
- Minor improvement the commits for patches 01 and 02.

[1] https://lore.kernel.org/lkml/20210701093537.90759-1-leo.yan@linaro.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2f01c200d4405c4562e45e8bb4de44a5ce37b217


Leo Yan (2):
  coresight: tmc-etr: Use perf_output_handle::head for AUX ring buffer
  coresight: Update comments for removing cs_etm_find_snapshot()

 drivers/hwtracing/coresight/coresight-etb10.c   |  2 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c |  2 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 12 ++++--------
 3 files changed, 6 insertions(+), 10 deletions(-)

-- 
2.25.1

