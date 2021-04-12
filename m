Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA3035C257
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 11:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243856AbhDLJnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240777AbhDLJK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:10:57 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81BCC061343
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:10:30 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id m18so3810307plc.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gYOeFD1p7L+L0MJlHbq/lmT2A46xpZFTUd3KclxAwSU=;
        b=qR8i1GCUyYtbhmw3kyuqnfzbl88sTpas0wSZxXEg0kFEgcQmXBCXUZJb87eQK8Q9Uq
         bx3LneBCPu6sIVi/ckk1aM2+V03YRZ4k7smhD6LTnCCKucEWWVmHokOsSJI93d3i8+7w
         PhyxFjI1h4rtd8V50HPkNskw622kAU6vuTG2yR8z6OhDyKPgTfu8CC3lHmLSpCvL3oOc
         BQOgaLMEoD1rEmU7zEEibK9SqcGv1EbJWmucOPTRyF5olU8KbjLHQb3VpCfUiLGKDs2B
         sWkNAlR5LR7Mt+OGuC0FvQIbxIrxEXdcwxG3J7RMMkCqHgNDwmJIwQabxTW1U35o0OyC
         zdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gYOeFD1p7L+L0MJlHbq/lmT2A46xpZFTUd3KclxAwSU=;
        b=J4GQWhJjTKuw2ivrtBUkMR8dhiEzJ9hMM5IJklEfMOryxkVxgZy0TtAVTb1brqqcHW
         /l9DHyhopS2qtTLdxwRAwnHZzAkM538Aa7LkiJbGkEBc4kbc9Rvgs4fjy/L2MPlW5BV9
         xHzs7f+BU7uA7qo1XXRSbLPR/SsV4qVMjS68tcpfRe9WrEyClg/aWuZ4Da+LiS+p1cgF
         swht68Igm+iOeAxTngc2NcpEgp+ZVcj5Axvy2vX26YC5iEjI3D6Mz4f3NInoaeUs/Y1w
         eq57aWwAZdcnvFzVD7grOdCjSPlQvOQdm/RYwSY4I1cDJAfbWXJ5taBprRzu9VsDCVAA
         WqJQ==
X-Gm-Message-State: AOAM531WP3hOk8OH3SvUo2jSZFbbSXyf8EQY6WjS/+6cErx93L6rLevd
        6HbvKJJfwkGxA4jqJt88GXa6Eg==
X-Google-Smtp-Source: ABdhPJwz7cZAUIaKvOa04vKxxxi6vvPMwCU49LxmI5d+JetOZgeEsMFrNKvkEvPjZfbAvIsBMVJRHg==
X-Received: by 2002:a17:902:47:b029:e9:2b01:1a66 with SMTP id 65-20020a1709020047b02900e92b011a66mr25892552pla.7.1618218630439;
        Mon, 12 Apr 2021 02:10:30 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id p22sm10291669pjg.39.2021.04.12.02.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 02:10:30 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Al Grant <Al.Grant@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        James Clark <James.Clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 3/6] perf arm-spe: Convert event kernel time to counter value
Date:   Mon, 12 Apr 2021 17:10:03 +0800
Message-Id: <20210412091006.468557-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210412091006.468557-1-leo.yan@linaro.org>
References: <20210412091006.468557-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When handle a perf event, Arm SPE decoder needs to decide if this perf
event is earlier or later than the samples from Arm SPE trace data; to
do comparision, it needs to use the same unit for the time.

This patch converts the event kernel time to arch timer's counter value,
thus it can be used to compare with counter value contained in Arm SPE
Timestamp packet.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 7620dcc45940..23714cf0380e 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -669,7 +669,7 @@ static int arm_spe_process_event(struct perf_session *session,
 	}
 
 	if (sample->time && (sample->time != (u64) -1))
-		timestamp = sample->time;
+		timestamp = perf_time_to_tsc(sample->time, &spe->tc);
 	else
 		timestamp = 0;
 
-- 
2.25.1

