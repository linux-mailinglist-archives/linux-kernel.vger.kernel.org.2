Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059EE36D6E3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 14:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhD1L7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 07:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbhD1L7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 07:59:01 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8B8C06138A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 04:58:16 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id f11-20020a17090a638bb02901524d3a3d48so8896432pjj.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 04:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kGpAm2p7nVFSJJsJKeJMpjJThBwUlAbTNq+bU/9Fn3Q=;
        b=FL7BAZQmkr4jiQ4maVnPoFh1fLwvYAfaVbHWWEyw0ZePg/D2kOwEtTwL/W/kHKNTF4
         BA2l/O3IyWRGV54A3zBJyabNUKaxv6tvnvFwVnWRIbWIyp1pTT5MLQPg+az0Vm5U31sY
         onMW25R5fPBY3wZyKEDoquRYMmN/Nq8f2GPPJqwzd2OcmCiEkFQwXkVnbdeZsTAe1qN5
         ZV7kyNl9aWqDYtZVkjdrOmYEdxsj7A0j28nGjmsom9B2deyOlGhpxiRFWVhJT1sLr8N+
         k9PCDCr0ggT/mWMssYPGL+6LXXyrKiR5eFFvQ1IGYwYKS4vl/XrcruHLtaW+gWY8fLur
         QilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kGpAm2p7nVFSJJsJKeJMpjJThBwUlAbTNq+bU/9Fn3Q=;
        b=KvJQ9K/aKoz240j3j+11xtcOeqDTerW6B/hWswtgN2LQouiRjYNTaon4HzG6MqBtc7
         ZM6c/cxIi+EaXyXLlJeamXtWWAA8F2KD8n6AfuCa9nHoHvo3BZ7DFf60Fg/Wt1lCaGwd
         nAEJCPrE0mMYETuNAQTQVgF6b3HaJoYEzi1PabDd0tYbM6BppbpJtO2i9V6YqEAreAV8
         fbyeu/3zTv5owwH1U9EvJa6IPZJQILxr6IWGdNNxRDHkQ4ttar3fKCVkRA+mtHIqN+su
         Z/5KtKEFbSkW9cOSdpQy5w+o9W2QNSjWk1B/INgfK1n2TXxcLWCVX2h9MjZElS9AVAYk
         U5TA==
X-Gm-Message-State: AOAM531+h4yQEULevNSRDGbX49rXLPlPTvD1PDXKNzc593sZxGENUWNm
        JcnCwNAIKjfdvUsdPhmIp7WjKA==
X-Google-Smtp-Source: ABdhPJygA3+wJlqq/7i4ARv3CsflKFlPPEWz+QnFqwuzRmBpzcCDeEkLvXXazoHvBOFkCy4fOso2uA==
X-Received: by 2002:a17:90a:5911:: with SMTP id k17mr32248046pji.73.1619611095619;
        Wed, 28 Apr 2021 04:58:15 -0700 (PDT)
Received: from localhost (ec2-18-166-74-158.ap-east-1.compute.amazonaws.com. [18.166.74.158])
        by smtp.gmail.com with ESMTPSA id j11sm4770222pfj.182.2021.04.28.04.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 04:58:15 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 1/4] perf tool: Change fields type in cap_user_time_short
Date:   Wed, 28 Apr 2021 19:57:46 +0800
Message-Id: <20210428115749.5229-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210428115749.5229-1-leo.yan@linaro.org>
References: <20210428115749.5229-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

C standard claims "An object declared as type _Bool is large enough to
store the values 0 and 1", bool type size can be 1 byte or larger than
1 byte.  Thus it's uncertian for bool type size with different
compilers.

This patch changes the bool type in structure cap_user_time_short to
__u8 type, and pads extra bytes for 8-byte alignment; this can give
reliable structure size.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: d110162cafc8 ("perf tsc: Support cap_user_time_short for event TIME_CONV")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/lib/perf/include/perf/event.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index d82054225fcc..48583e441d9b 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -346,8 +346,9 @@ struct perf_record_time_conv {
 	__u64			 time_zero;
 	__u64			 time_cycles;
 	__u64			 time_mask;
-	bool			 cap_user_time_zero;
-	bool			 cap_user_time_short;
+	__u8			 cap_user_time_zero;
+	__u8			 cap_user_time_short;
+	__u8			 reserved[6];	/* For alignment */
 };
 
 struct perf_record_header_feature {
-- 
2.25.1

