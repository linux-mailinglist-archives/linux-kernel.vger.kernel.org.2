Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA82731AB0D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 12:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhBMLdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 06:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhBMLdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 06:33:13 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB14C061756
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 03:32:33 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id e9so1120099pjj.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 03:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4svOvLw3+LGXfw76WgcnaPgI6C2/qj0owFvWH3CaT/w=;
        b=klgAYQ8urs+Z9pTTeF0cHKBNnpCuQbfKbCg3waHodKRyplqtTmwLy+ykFOmBsu/IY/
         rCgS5OxaN4tM8pT8N/ZNMcSBAin/tAxaQxpPlW/wHZUhcXHwGMGJhnhxFDwPbP1YCgWs
         IDK5bVAxB4x97GRnBUk6l0ndFzqveXKBB9C9ORTponUWHwS5JCLRZ26gieWoINm27LQl
         lVOG9jWWVzQb6xVI6/NbTyyZy19il8jr+dkT24cp5i/Fh/0O54UzGyrd0ZZAl7nr1cyy
         Z1XGCIglUgCGd2JEN9DZTGEbfO0pky7Lbmam0bWZSxLAPgZ4Up8S2BPlabrFnuciEOu4
         v47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4svOvLw3+LGXfw76WgcnaPgI6C2/qj0owFvWH3CaT/w=;
        b=D544UjecGj2QXmrPTlU4C4N07Ho3JXbQRMGIBbBDRHUre/H4NOKDWR8I3wrnJzrRyd
         MIY8pBLAZG/jef8MtzUUcs1AIj8hjfhFX7WceHB5ic+se3cMTCkt7/dhtY+QBvubeaF0
         dF0xrU3rVv2PQowd/iAxwfSrNX01PxjcULVOo45LJpu3A3j5MuuE/EHrWuX3MwhXsAWb
         7wL1IrrB3IuCj4s7gTGs1sycKLTGQMhWcJgKjR2Oct1d9TbbcuUZjr/YXewN7S9jfwpe
         fiif7623MM9ggvvNJP8RNKcE9Vcm2epUaaUbU5hfM6DK/7jxuk4T5eNCoGWAxHihJm81
         YEwQ==
X-Gm-Message-State: AOAM533CXoggIsXfDUBE8IzHsp+fX0k8IRfu30Fv1V5MQ2CWo61QQIRy
        kwrsqZ9bq08Ajdbb+3zo00WBxQ==
X-Google-Smtp-Source: ABdhPJzWGXNDxoCjpGl4zvQIDpdvppBpCUhLgBJ/C9h/NzBw8/h1jUPof5vYAR+bNsVY3xcwObxL0A==
X-Received: by 2002:a17:902:a40b:b029:e0:1096:7fb with SMTP id p11-20020a170902a40bb02900e0109607fbmr6507000plq.40.1613215953090;
        Sat, 13 Feb 2021 03:32:33 -0800 (PST)
Received: from localhost ([45.137.216.202])
        by smtp.gmail.com with ESMTPSA id i1sm12259852pfq.158.2021.02.13.03.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 03:32:32 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 1/5] tools headers UAPI: Update tools' copy of linux/coresight-pmu.h
Date:   Sat, 13 Feb 2021 19:32:16 +0800
Message-Id: <20210213113220.292229-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210213113220.292229-1-leo.yan@linaro.org>
References: <20210213113220.292229-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To get the changes in the commit:

  "coresight: etm-perf: Clarify comment on perf options".

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/include/linux/coresight-pmu.h | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
index b0e35eec6499..5dc47cfdcf07 100644
--- a/tools/include/linux/coresight-pmu.h
+++ b/tools/include/linux/coresight-pmu.h
@@ -10,11 +10,18 @@
 #define CORESIGHT_ETM_PMU_NAME "cs_etm"
 #define CORESIGHT_ETM_PMU_SEED  0x10
 
-/* ETMv3.5/PTM's ETMCR config bit */
-#define ETM_OPT_CYCACC  12
-#define ETM_OPT_CTXTID	14
-#define ETM_OPT_TS      28
-#define ETM_OPT_RETSTK	29
+/*
+ * Below are the definition of bit offsets for perf option, and works as
+ * arbitrary values for all ETM versions.
+ *
+ * Most of them are orignally from ETMv3.5/PTM's ETMCR config, therefore,
+ * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
+ * directly use below macros as config bits.
+ */
+#define ETM_OPT_CYCACC		12
+#define ETM_OPT_CTXTID		14
+#define ETM_OPT_TS		28
+#define ETM_OPT_RETSTK		29
 
 /* ETMv4 CONFIGR programming bits for the ETM OPTs */
 #define ETM4_CFG_BIT_CYCACC	4
-- 
2.25.1

