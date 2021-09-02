Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B63C3FEA80
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 10:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243987AbhIBITT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 04:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbhIBITS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 04:19:18 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C087C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 01:18:20 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id s29so1040531pfw.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 01:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wI2EeO/lKrV6ZOTCZm6ZqifjFiAszk20GuR/ni0HaV8=;
        b=BYvawW1FNkTQ4OSXiV70BTle3CN+Z19E5m0SNV4TdEFkQUwUhukUs2Ya/sYgujZxyM
         IHU3OAJ+zWP8HXc4jTpw9jo4x7k+yLF/AAih9wp2ULMpJCIDRKtKA3/XxZdP9uNiDMWe
         BsImcIA8A/2Sgot8xkbgzCFo+rwNSp+8alJtsmrkGP4fH8OWdfmlSKZ4jPSyemFYenwj
         Tdd1z/5Vlrefr/hQG3zQJhMVJli5oS7axfUTZRq+mAGyOh7Lt7d9HJgBAtw6QHu+4/UQ
         1lfmLtmiesQpgjpM9Mwevjdd33w3JxfWNz3rY/fBcApDsRGDH0FT6nPr3EPUpAibQVT8
         f80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wI2EeO/lKrV6ZOTCZm6ZqifjFiAszk20GuR/ni0HaV8=;
        b=Lr7LhCR8e2HDGDl/AEoImvKa/uuofQbbb0HdrDl3RFJOEWwcCGood7hr4Y9r/9xq5p
         qTw16f8jP0d10VyvhM52iLVZi6rKz5a/4T3eQ2UxnE9f3agmtrU+fQAofa5St2Zm1cXh
         M+Z65IvopqZV/8J1CHQ0tOSLyOU5DZa0GhAxsM1l0rbdtz22Vl8ynh873VzgcnvFR2UM
         p8kiuRizwwV4s0kkRTIwVG4FAyJ3IWZTfS3KJg0Y6COQhF5z/l62EZ36bLBgXwMPnrYJ
         KaoPJV1TavnCkm/7ce2j4Ni17ZAyX7kKvjRzLQN3uL9ye/PfhrvogHFfvXnhpv0MvIx8
         vvKw==
X-Gm-Message-State: AOAM530ieonmSqUFhr9cvy29r8dC75vBxze38/ccZ/Psqg+RLmh665HZ
        ropO/SjTQkOTifn5F66iqyrLmi+phBlGqVIhDK0=
X-Google-Smtp-Source: ABdhPJy9/N+eC1lvVXexIoXNMMzcJWV4EbnbFybPCyhnGO+OC1B5ul/gyqfhodAMgaTbjZY/5G6KSA==
X-Received: by 2002:a63:4384:: with SMTP id q126mr2045158pga.1.1630570699951;
        Thu, 02 Sep 2021 01:18:19 -0700 (PDT)
Received: from localhost ([204.124.181.224])
        by smtp.gmail.com with ESMTPSA id gk8sm1377002pjb.49.2021.09.02.01.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 01:18:19 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
        mike.leach@linaro.org, suzuki.poulose@arm.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2] perf build: Report failure for testing feature libopencsd
Date:   Thu,  2 Sep 2021 16:18:00 +0800
Message-Id: <20210902081800.550016-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When build perf tool with passing option 'CORESIGHT=1' explicitly, if
the feature test fails for library libopencsd, the build doesn't
complain the feature failure and continue to build the tool with
disabling the CoreSight feature insteadly.

This patch changes the building behaviour, when build perf tool with the
option 'CORESIGHT=1' and detect the failure for testing feature
libopencsd, the build process will be aborted and it shows the complaint
info.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---

Changes from v1:
Fixed a typo in the error message.

 tools/perf/Makefile.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 4a0d9a6defc7..5df79538486b 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -489,6 +489,8 @@ ifdef CORESIGHT
         CFLAGS += -DCS_RAW_PACKED
       endif
     endif
+  else
+    dummy := $(error Error: No libopencsd library found or the version is not up-to-date. Please install recent libopencsd to build with CORESIGHT=1)
   endif
 endif
 
-- 
2.25.1

