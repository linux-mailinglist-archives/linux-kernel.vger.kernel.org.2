Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD4C36D705
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 14:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhD1MKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 08:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbhD1MKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 08:10:13 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F98FC06138A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 05:09:29 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id j7so35147310pgi.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 05:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pTmK7aCuO+JgVajONYR1FKskSgQ8youTi+N6g89HWRY=;
        b=Hw/INPO6X8ySiT7BfvVMv6SLuxkEF1nRql6QfSSKXUhYZMVdoa2Agd//5oh05ilfUF
         H6VMbWHpashDSpziEHIUrIZ524bT80KMae4CVMXETzktHdn7TQJsMd6iJrl+i0u+AnPY
         rksx6DI8J5Qiwj1tM02joW44Yw9yivEMrjTigUXqCqhm5IGehjdvjl3hVnz25zE9/cyy
         HnpMbl4AN+9EG7THf/ymaLF211+u7VmtzwRaaJdjyNm+uZ3Yz47WYJvlKOzFM1TJLbmD
         GoU3p7qVDKX/zE/vOTEXUssu01FVYj7sRYdkftGiY4zQDoSmWHQEjh/B5K8iX/ZMsHt4
         /Abg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pTmK7aCuO+JgVajONYR1FKskSgQ8youTi+N6g89HWRY=;
        b=QumCf4AQR3/jdKNemEIvCfA4zP+bSeD+PO9MULMgj63iqMKSdC0xDeY9h3FRa8SnCp
         mLyioRrZiHh5on2etv2afS9n3JB5vaT00TS352WNSu77MdUDwoX1jLpUMH6wUiw8+XAk
         ceAgkIhjAoAoeKQnEM6vqnMfUlNRgfq/p5xwIIo06vXvwutpWapLqE6j5kdl9R0KF1So
         krIJN1cqF+RIGwoyxmkltESKdpFR7OpCHXDqSpkm0nUwd6MsoMGMfhMHSe+2oQDVTTmk
         /mLTOEZOCngA9z1X7eDBv8knDzGP3f3hRWyMazl2thwFxLcdh7cc2V9YVHx3Wr0Kl0qi
         nRtA==
X-Gm-Message-State: AOAM531rbkmXVXB9714Ru1Kd2AGzGYKLcVmlHTy4qpPYfIiDnl2Bt8ae
        Wttp/5vgfaHlJkhvT5ge09zgsQ==
X-Google-Smtp-Source: ABdhPJzJhZboTxLbprhBPe052w4HiJpISSLnuIL64nxUZ/5b4az7RjVJoG6V3wh6kA2Ar3uyGplw1Q==
X-Received: by 2002:a05:6a00:1588:b029:272:f5b1:c96c with SMTP id u8-20020a056a001588b0290272f5b1c96cmr20025201pfk.47.1619611768639;
        Wed, 28 Apr 2021 05:09:28 -0700 (PDT)
Received: from localhost (ec2-18-166-74-158.ap-east-1.compute.amazonaws.com. [18.166.74.158])
        by smtp.gmail.com with ESMTPSA id g14sm4933388pjh.28.2021.04.28.05.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 05:09:28 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 1/4] perf tool: Change fields type in perf_record_time_conv
Date:   Wed, 28 Apr 2021 20:09:12 +0800
Message-Id: <20210428120915.7123-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210428120915.7123-1-leo.yan@linaro.org>
References: <20210428120915.7123-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

C standard claims "An object declared as type _Bool is large enough to
store the values 0 and 1", bool type size can be 1 byte or larger than
1 byte.  Thus it's uncertian for bool type size with different
compilers.

This patch changes the bool type in structure perf_record_time_conv to
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

