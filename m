Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A18398689
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhFBKcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbhFBKcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:32:15 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244DBC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:30:32 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t9so1880222pgn.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WZdXkeLXyTRCRBlV6ZkvwSxOi71Ng+ItJPqjFI54Mcg=;
        b=Z3sB+5zdNXr9kef5JA3bJvYP76xDiTOty/eJXFB532T92HsbDk7gItssLcLF5a+Okv
         DRLOrn43EY1kdU1/LchPW2gzDwUvBULq3wHLgA2d+huNDCSOW5BOnFEfY/+os56y11aX
         rXEdqD5bI1hPOr7cu5P7uCRP67zfCHm0xxmaIXH3md4KFb9EDuvM6upqbbtw2DWjc/+V
         ZpdMWlGpHm9FJDb0D7TutJxr8CzO8iwi4Hzq1A+u2+SJMti1ch5We3G2fjdnzNjV1A4+
         aa4jPTK5jbAq2gdWcArgQFFCyQFQJvzpSy60LSq47C48o1c5NQSFtQ9qrYHbHxgWwkk7
         t0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WZdXkeLXyTRCRBlV6ZkvwSxOi71Ng+ItJPqjFI54Mcg=;
        b=entqAl/AWdU8PSgPvXPPrfTQ/dcTcm12JnDOMoLdRROYfpkqX3egmZvWzpzMUeTej8
         p2TdFSXf6zDIZlqqh4HakqswxHnQxt/vaoWsqdcZOaZcU3V+pDaSt3Yjq8LIsfepyi+W
         LJYbYC583mPmX/oEAf5YEN2raLj2JP0Wbf6U47PbF5CwqRFRtiqUarVIL8EgjJ9lijut
         /xAgoiWbYBrdzHa+nERqQP8hkHNDXzTMsntZsk8JoCLmAAAu7lbR+LQO2tvLqubfeOlr
         c9J1k2ocIh988wldYEYv5Z8DV6tCfJzURiQGJIGp4J3FCl3fhfuQNe2yMbooweIzJquw
         wvTQ==
X-Gm-Message-State: AOAM532/qoVFbFLEKRtx2h3hZyFx/Z1ZKwmJDXWwgnwG+POhW1zrJg94
        HEHzNxC9B/2KoZy9vi+YpPuhPg==
X-Google-Smtp-Source: ABdhPJyzXB1PcQNWg3aQfHpUUQxqS7K4lMUmeNIvTRxqevGy++Vn5qNRvTHr+W+TDzT0S9K2D8xe3Q==
X-Received: by 2002:a63:471f:: with SMTP id u31mr33399072pga.85.1622629831701;
        Wed, 02 Jun 2021 03:30:31 -0700 (PDT)
Received: from localhost (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id o24sm16697046pgl.55.2021.06.02.03.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:30:31 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 5/8] perf auxtrace: Change to use SMP memory barriers
Date:   Wed,  2 Jun 2021 18:30:04 +0800
Message-Id: <20210602103007.184993-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602103007.184993-1-leo.yan@linaro.org>
References: <20210602103007.184993-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel and the userspace tool can access the AUX ring buffer head
and tail from different CPUs, thus SMP class of barriers are required
on SMP system.

This patch changes to use SMP barriers to replace mb() and rmb()
barriers.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/auxtrace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index a4fbb33b7245..42b7ef811bde 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -444,7 +444,7 @@ static inline u64 auxtrace_mmap__read_snapshot_head(struct auxtrace_mmap *mm)
 	u64 head = READ_ONCE(pc->aux_head);
 
 	/* Ensure all reads are done after we read the head */
-	rmb();
+	smp_rmb();
 	return head;
 }
 
@@ -458,7 +458,7 @@ static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
 #endif
 
 	/* Ensure all reads are done after we read the head */
-	rmb();
+	smp_rmb();
 	return head;
 }
 
@@ -470,7 +470,7 @@ static inline void auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
 #endif
 
 	/* Ensure all reads are done before we write the tail out */
-	mb();
+	smp_mb();
 #if BITS_PER_LONG == 64 || !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
 	pc->aux_tail = tail;
 #else
-- 
2.25.1

