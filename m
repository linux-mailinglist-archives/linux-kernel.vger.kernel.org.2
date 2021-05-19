Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527463885E3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 06:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbhESERO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 00:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbhESERN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 00:17:13 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024E2C061760
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 21:15:54 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gm21so6645499pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 21:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8KlIx2h9yP5lu52R7H8yaLkI8C4WgX2JDrvEkj4ssOY=;
        b=mhFRGQhblIWhwIIBvChprBSmli3LGqtGXscKQA0LyUxX+S8NgxhImXrSM0Z0vIwvgn
         BCzS1fASl+A6G1Ax+0gxtUjGbswxQHQjHhO7UtvTUXKW00qY4B8LRarU4IFTzEhRXe9t
         juyOeb8ggNJZRuAWU6+LmJc8GdvKecg0tbTqWuFHWWNeTHxBrsQf4h/hA3gn++suCJ4Y
         RO2lslmVQHmcDVK76wO03RofWzbB9Dko1qIVoq2qV1q52xljuJCvWPkXnG6815EQoy7h
         hhZYlEYvk8/S39E49x4V7V7k0IhuuWxRi+DAgPzFh4pebYa574GDEuTR4kJQ9wLzDYm/
         Iw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8KlIx2h9yP5lu52R7H8yaLkI8C4WgX2JDrvEkj4ssOY=;
        b=BaniAkfOVHjT2YRvNF+La/NAKWlykGbCb7FsGkMfqrAHOE1TiR56WjYnK4E1ws+Y0k
         tyV2/gh5VP0CVq2oT/Y7mof0RanDJy1CtavdXb44YNyzAE6IBFZoGJ4JB+/KlNaP+pqf
         m4Z8lg6bDCcVZSIqrOvbQGxFAOMSLp/ZJf9AcFn2kNFuppvybhstqeVxerdjOFjbZSx8
         E7r3txMqy4mkgEuiD/anIg7ZAGP1PaUuZV8tpWUEPtIzGyJw/UkUPPVuzDY6yjVc5ROj
         F/+Xu+s21a4svWvqmBBODo0oGhBlxpcfSBG0/T4doYIPGHt6oX8mfNL7mKb0w/r9LVMb
         Cnww==
X-Gm-Message-State: AOAM531oS5OzDB7I69QMuvpZhlSTpp9djBVVn1v/dkQuRAN0Yt0PQP9R
        3zf4JhQCQWRT+jLm3szxb5M9UA==
X-Google-Smtp-Source: ABdhPJzUgy+j31LqGWq+8AtbM+zgRTuVzM7+bhTOYQ4DSsiEzvm1Tsp8QY3mb94aFCSqtcNDMFgM9Q==
X-Received: by 2002:a17:902:b7ca:b029:f0:b0ea:db44 with SMTP id v10-20020a170902b7cab02900f0b0eadb44mr8477803plz.59.1621397753403;
        Tue, 18 May 2021 21:15:53 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id j189sm13434033pfd.21.2021.05.18.21.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 21:15:52 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/4] perf arm-spe: Correct recording configurations
Date:   Wed, 19 May 2021 12:15:42 +0800
Message-Id: <20210519041546.1574961-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is to correct Arm SPE recording configurations.

As James Clark found, there have several issues of recording
configurations for Arm SPE.  One main issue is the sample flags setting
for Arm SPE event and dummy event, and there have two minor issues for
enabling timestamp and redundant checking for "full_auxtrace".

This series fixes these issues and has been tested on Arm64 Hisilicon
D06 platform.

Changes from v1:
* Added patch 04/04 to remove redundant checking for "full_auxtrace" 
  (James);
* Added James Clark's Tested-by and Reviewed-by tags for patches 01-03.

Leo Yan (4):
  perf arm-spe: Correct sample flags for SPE event
  perf arm-spe: Correct sample flags for dummy event
  perf arm-spe: Enable timestamp for per-cpu mode
  perf arm-spe: Remove redundant checking for "full_auxtrace"

 tools/perf/arch/arm64/util/arm-spe.c | 45 +++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 7 deletions(-)

-- 
2.25.1

