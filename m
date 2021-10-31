Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B505440EE3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 15:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhJaOpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 10:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhJaOpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 10:45:18 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00D3C061570
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 07:42:46 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f5so14802059pgc.12
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 07:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dPTMEqL3NYtc2Q3PnJ9nazYoyjO4/ce4FmSNrOKpptk=;
        b=fvlc7+A6nqrzxoPKKUIvAefVAfll9mNtvEKZ6O3SGUNMcKV63hHgX0xMJlTH8cJK6+
         mvffOvszw/VC3IR49oLmoCEA1r2zARnOcQaJiofKWb8x5qkcu5Bb/vBizCjq8cFIxZ/g
         wO3+mPkOOJPtrS5HfLSP/26nEaBL+d94OvX+L5ixHb/QDgFfd9CKWi5lmMkyMdkvKttj
         Rb+k04JYYqbhmooL9EmZYDdBXyFXeNam1MkaZGjYLMDCnKu6pb1pDUXP8eeSplYaT8fY
         ZBIUIpHqWg1yqOgEMG4z0fZhFxx9FcGmVGpinXaUNE9PPRN6fmJBbW3NiW7Fz9+4zu8w
         sv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dPTMEqL3NYtc2Q3PnJ9nazYoyjO4/ce4FmSNrOKpptk=;
        b=dAjcAzmD1aBXlcg91oG0EacEQ0VI5aGnefy1UPIknnQVtUep78POuJSMRbohNmh3md
         8OyoCU4yDlaTA3WOEPa029bq9HTYEdt70ln0EknLtW44cRGb0Qba33Sy/ud9/Z+YyNWO
         m+3rrgOg2J2doduEkik/ktZJvui+65znrdW3oOHRMpFb1Lgh6XChg0OU7CjO5vTuavj/
         YQ7kPdjV0NTUZsfVFTzT0OMR/cmQCUiJzwqvcA8exrlx/FNI3Ndjk1qoFVB7rG8ia3ej
         YuR6y1K1VrY3b3pHXT+/2pVuhKRnTNUyTxuqgcqTKpiJSpK5FJGyVq2aZB3JBnJZhP2s
         B5VQ==
X-Gm-Message-State: AOAM533L7Mw5OkyeBdotUY5wpM2WlqdvR1dWJs7Hq8h/KKkA8B/UShyr
        V8uDsIHD4zDB2AxmuCzotUbpnw==
X-Google-Smtp-Source: ABdhPJwXduf3AOks9pU8yn43VO7xAPmYmLRcctvjxyNmzFodti8wWEVQIEw7JUcym45Ic3DlaybJBQ==
X-Received: by 2002:a05:6a00:1309:b0:44d:4d1e:c930 with SMTP id j9-20020a056a00130900b0044d4d1ec930mr22820405pfu.65.1635691366224;
        Sun, 31 Oct 2021 07:42:46 -0700 (PDT)
Received: from localhost ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id w13sm4088839pgm.3.2021.10.31.07.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 07:42:45 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 4/4] coresight: etm3x: Don't trace contextID for non-root namespace in perf mode
Date:   Sun, 31 Oct 2021 22:42:14 +0800
Message-Id: <20211031144214.237879-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211031144214.237879-1-leo.yan@linaro.org>
References: <20211031144214.237879-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ETMv3 driver doesn't handle the case when programs run in non-root PID
namespace, so it allows the contextID tracing by directly using perf
config.

This patch changes to only enable contextID tracing for root PID
namespace.  Note, the hardware supports VMID tracing from ETMv3.5, but
the driver never enables VMID trace, so this patch doesn't handle VMID
trace (bit 30 in ETMCR register) particularly.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index cf64ce73a741..0621ab0c71d9 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -340,6 +340,10 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
 
 	config->ctrl = attr->config;
 
+	/* Don't trace contextID when runs in non-root PID namespace */
+	if (task_active_pid_ns(current) != &init_pid_ns)
+		config->ctrl &= ~ETMCR_CTXID_SIZE;
+
 	/*
 	 * Possible to have cores with PTM (supports ret stack) and ETM
 	 * (never has ret stack) on the same SoC. So if we have a request
-- 
2.25.1

