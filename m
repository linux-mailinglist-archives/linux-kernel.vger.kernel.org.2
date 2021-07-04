Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065823BABC1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 09:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhGDHTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 03:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhGDHTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 03:19:51 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A171FC061762
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 00:17:15 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 62so6831531pgf.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 00:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MxgwZHP/NxGkiYvHiVeQZZDAd7piMTreovHUTu3tJE4=;
        b=F1Cm5HUe/W4qcO/YZMWcovyfhoTTd7gdBbhgFkxstFf0BT+ShATGv4q4OrsnJaIrpy
         G4hBHinkVsHh9Cfi4t7lXKwp5Oxp9ulth8gE3AIWRBetNA5chQJnCJiQvuemKUVHuRbe
         n0wOB5of97stC16+0L9Omkrn0PANT9WTrxCCu0YAkC2y8zgYlpDzcjMJCdW8dgPW9exy
         jJFzAoQSAkB35DvhbQtr8+GytWS5knvOXGvmCHZMucdYoV2PvCimYoGHVZxDSmDOZndZ
         LSQX4DwreOLmKwZYR3Nnikg/vk+UqtTmzHo34jmqqdyoIqKfxd2J+rzWJEchXwCUteoI
         NSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MxgwZHP/NxGkiYvHiVeQZZDAd7piMTreovHUTu3tJE4=;
        b=dNPW15x+6Z+LIRhNT0MXEAwQLlnAkgPGYw4LenCfFHXWvtXSp2Z+qp5VdL1fvdcndq
         JyiUunkzHXNOd/SnQW4Kat0BGaxPsLZGJJdr01J9BNhrx70qw8nJtUYLQgWQqSXZ9rmV
         udIHRffa2EiOYT3U3xb6y+FRUhSMb1as3j06NbWNp1r1lFwRQ2Tl9ekXvjJEJBXz+bP5
         sjeqvA+T8Xo0Mbmgl7bez6mkAgOo73OAYss7EkYYn3bx0h3NB6df0m2o9MU52earuab3
         eAbtURgdIutZ0p4RNgZncZZYZMkLPgdkcrYIF9I27a7jyS5OdI+5GP9t/K6rXp9pnjzs
         34iw==
X-Gm-Message-State: AOAM530iN0mg6z6WOPfprKw04PFx3bbtywdx7e3/aNn9KzFDqUP+xaAu
        3k5OT4KY6kHSDGelED17eZckhQ==
X-Google-Smtp-Source: ABdhPJxEg+L08YtRvHwbnJK9hTdwmsSSxA7M6/KGLxIa5RV8pIXUL0HVBWpIwu5ahxkZusKImzIv+Q==
X-Received: by 2002:a65:62d8:: with SMTP id m24mr9309521pgv.150.1625383035208;
        Sun, 04 Jul 2021 00:17:15 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id la17sm6983974pjb.34.2021.07.04.00.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 00:17:14 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 03/10] coresight: tmc-etf: Add comment for store ordering
Date:   Sun,  4 Jul 2021 15:16:37 +0800
Message-Id: <20210704071644.107397-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210704071644.107397-1-leo.yan@linaro.org>
References: <20210704071644.107397-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AUX ring buffer is required to separate the data store and aux_head
store, since the function CS_LOCK() has contained memory barrier mb(),
mb() is a more conservative barrier than smp_wmb() on Arm32/Arm64, thus
it's needless to add any explicit barrier anymore.

Add comment to make clear for the barrier usage for ETF.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 45b85edfc690..9a42ee689921 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -553,6 +553,12 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 	if (buf->snapshot)
 		handle->head += to_read;
 
+	/*
+	 * AUX ring buffer requires to use memory barrier to separate the trace
+	 * data store and aux_head store, because CS_LOCK() contains mb() which
+	 * gives more heavy barrier than smp_wmb(), it's not necessary to
+	 * explicitly invoke any barrier.
+	 */
 	CS_LOCK(drvdata->base);
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-- 
2.25.1

