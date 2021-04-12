Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A8135C20E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 11:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239396AbhDLJid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240727AbhDLJKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:10:54 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9454AC06138F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:10:24 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c17so8798996pfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gk/+cUxEFhkA5Sr23xDJi6lyVwLgABo9cNglBLLd61g=;
        b=qsjsJo50hMoR+naug+xFzA1xHA7FjV62lRTjqRKpyOeNHq484SHORyD50a47lqNiQL
         2S93nlQ504n8QC2srq0dF+8NMIR2V+VSBVXXLsG2sREV7nuHoC0qk+8/1Y3MvUFClXrC
         ozjfha2lhiMge6Isa4h1FlkCmwYv8YvbOhXgeAz3eZYi2Fliy3SMq97uN7WPjRzQgYZs
         BvlE3MiZniIvZhUK7cmrp2+ieJDjEKH8ODDmt8co0BMYBQ7/kV+ZJN1CfdMhO8xow3i/
         j9ub/jzZ3UmIURCMsVgC5lomgOgrAAZTX/FEDGCYBQ8bOXe7489IhF0Ag/ZtfdikQHl6
         /l8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gk/+cUxEFhkA5Sr23xDJi6lyVwLgABo9cNglBLLd61g=;
        b=lzfZGT6h60Epv31oMAVv1NDotwpFzx3yHJ/tsOX6298cP8wmvT/9KJS1mmF04pMQ9X
         QyWar7dv5fZNhCvIn2ol9eQNJ20SyZCybL06JOIElA5kcc6hAn9+i8iWcRYO9nOxGXEV
         v4SNGQbYo3hzyTLv4PUODCLA0WTmoRyKKLEmjncNymieqfCXr/VnXa3csx0BVSQ3oxFh
         DeJ9Bx4WwQVpddD3K6EBIyCvpYeKDIXV4ZvTL6eF2oHzA2qcKhdrp+i4e+jhsD9shAPk
         WW3+OPF8QvAqTCWLYUq4ngKD2xqcfU0tEK1kvfScQpN7rhdKP1XVxS1tgmqJhg08g1Va
         gwuQ==
X-Gm-Message-State: AOAM532LPQVV/JkCUaBVY4IxwfS48x8xU/MGku/Ew7r0CyHbfsF+SYt8
        mpXKv3BzR8xKGua2VQnAS5NWVg==
X-Google-Smtp-Source: ABdhPJzx4UCGci4yBj68Z38bKn4CVgVVUcd1FUN7aq/GXQ6aG1ontDmelZc0UdEirWIw3d5B9x3RaQ==
X-Received: by 2002:a62:2943:0:b029:24b:f35d:2565 with SMTP id p64-20020a6229430000b029024bf35d2565mr5605768pfp.52.1618218624176;
        Mon, 12 Apr 2021 02:10:24 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id x12sm9537709pjk.53.2021.04.12.02.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 02:10:23 -0700 (PDT)
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
Subject: [PATCH v4 1/6] perf arm-spe: Remove unused enum value ARM_SPE_PER_CPU_MMAPS
Date:   Mon, 12 Apr 2021 17:10:01 +0800
Message-Id: <20210412091006.468557-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210412091006.468557-1-leo.yan@linaro.org>
References: <20210412091006.468557-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enum value 'ARM_SPE_PER_CPU_MMAPS' is never used so remove it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.h b/tools/perf/util/arm-spe.h
index 98d3235781c3..105ce0ea0a01 100644
--- a/tools/perf/util/arm-spe.h
+++ b/tools/perf/util/arm-spe.h
@@ -11,7 +11,6 @@
 
 enum {
 	ARM_SPE_PMU_TYPE,
-	ARM_SPE_PER_CPU_MMAPS,
 	ARM_SPE_AUXTRACE_PRIV_MAX,
 };
 
-- 
2.25.1

