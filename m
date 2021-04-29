Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228EA36ECE4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 17:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbhD2PB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 11:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbhD2PB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 11:01:56 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E63C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:01:09 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m6-20020a17090a8586b02901507e1acf0fso11103851pjn.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/1TsN7V8vdFFa1jTdLAYOQAqYvkzTRY5XtBlHiV+cWU=;
        b=OrUOtDRiPFLfD20p+bsQFI4BkYU4RCJ0c1Hbr7SmtJenqHtLp7g8tJbqorziZy0xeb
         8+uyZtpdqKRJsXiD0yMwgD10J1SbvsvfG2rHmyIiLxn/sIc/XDOZWraLxtgyzRp5MAtr
         AYtv+rN4o/CyYi8oW3tRklBfT4Ko25jC0a6+2c3fCewXSBqtxgLUjgPpyJ8zFLwyHkkE
         aJGSGJp3CjOdACeERUpXzrIWIXqeKbzkASQagVA0pIO3SnsuRJUUrZDR+dScQOuCH5nG
         SB9h1cQ4ALp+dEggZ9y8GL7aJcmM8LI0Q0Z15MGdxA6W80a1DVuKMiUX/tzmGeVhWNp0
         nEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/1TsN7V8vdFFa1jTdLAYOQAqYvkzTRY5XtBlHiV+cWU=;
        b=jjqQNCQvv5CS8KvlO5hdLSZD77Cr7+a2N/HZtZbjfa76vPJBuB/2in6OG4ggxzB0VR
         UrCBqELtFlVIQVNwo8qvMYfIE876Ef8jRAyBPhg/jHdZCNurD+XfIRlHmUaz0cPbZJz6
         tXB/9+2gDQWoqaHH0sKm4QwKeWmuq1KkMFAQ90Wi+NIwhYcjiX+GyzxY7Xa69X8xap8W
         dw+JAtSdKgKPiax1PvcPqhRARU49b6AP7K+9OSeCZavszocYEfWCAzgAQe3+GUSD/hr0
         cXMKehmkW5YAG5uwveSGli4bluw8vutq+n50kHR+Ql9mnn+0/eWCVL3TZ725AK+5CUA6
         Qr7w==
X-Gm-Message-State: AOAM5311/HRnwevVzqEJiFSjsRfEREmHK/sx3ubBxg7J0QjpChLZ1g6f
        NrdCyHeTopOtNz4qyXY3ILlcmg==
X-Google-Smtp-Source: ABdhPJxSiXD7UkDhOrm0EG11H5sFBhdp1XFkfb6BqLhe+JOtDRSW96tjLpSQcIIjS143Faad/4Ap/Q==
X-Received: by 2002:a17:90a:430e:: with SMTP id q14mr10132243pjg.189.1619708468109;
        Thu, 29 Apr 2021 08:01:08 -0700 (PDT)
Received: from localhost ([204.124.180.30])
        by smtp.gmail.com with ESMTPSA id z12sm2580223pfn.195.2021.04.29.08.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 08:01:07 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <James.Clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Grant <Al.Grant@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/3] perf arm-spe: Correct recording configurations
Date:   Thu, 29 Apr 2021 23:00:57 +0800
Message-Id: <20210429150100.282180-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is to correct Arm SPE recording configurations.

As found by James Clark, it's not reasonable for the current code for
sample flags CPU/TIME/TID which are hard coded.  For TIME sample flag,
since it's always enabled, then Arm SPE has no chance for timeless
tracing; for CPU sample flag, it's not needed for per-thread mode;
for TID sample flag, it's redundant for AUX and dummy events.

This series corrects the sample flags setting, and it enables
timestamp for per-cpu mode tracing by default.

This patch set has been tested on Arm64 Hisilicon D06 platform.


Leo Yan (3):
  perf arm-spe: Correct sample flags for SPE event
  perf arm-spe: Correct sample flags for dummy event
  perf arm-spe: Enable timestamp for per-cpu mode

 tools/perf/arch/arm64/util/arm-spe.c | 66 +++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 16 deletions(-)

-- 
2.25.1

