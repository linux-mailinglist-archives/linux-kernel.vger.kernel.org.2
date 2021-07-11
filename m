Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221BD3C3B97
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 12:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhGKKoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 06:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbhGKKoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 06:44:12 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DE1C0613E5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 03:41:25 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id me13-20020a17090b17cdb0290173bac8b9c9so378185pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 03:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MxgwZHP/NxGkiYvHiVeQZZDAd7piMTreovHUTu3tJE4=;
        b=JnuDDQXdPNRWlCR6EUfqkyGZnRvs0mSk1aPj/Uw0zb9ip1uVoMooO0nZVAE95eQfnv
         kfCjTMTDJ/fMr+7C5yf8Okx2Jjki94LXLE+IyjUJpC3C8ekWoOjmhx2ZET2xjTshaek8
         SE+r8bWo5Ny0o+tjd21vcqXk6NLBsdwYVnC+XePA7mrnPJ+wc29/fqwkhDczXnHsjWiz
         DzKbhXhthyWAdTC7z+XEpYoprPi+T5VTVvRX4KOGes1D9ZtC1iuAOxJ1Odpy27OSUcLk
         k1egAO/BrwnfRXozDkX5tpWtT+FL1XQ86ru3oeKW8+VurrYCqZzm2B5Xiw0IFu6PyEyV
         cVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MxgwZHP/NxGkiYvHiVeQZZDAd7piMTreovHUTu3tJE4=;
        b=SkYMVj2TcfAZvN/K5UrkbOn4lqKekaBd2t4N62FA6rfD96jgsnSmZGoIIoxrBi2asC
         2OWt2hGQA9yH2dSp3HxbNGH0EjINwTXU+DE9J7d//eip56P5mBSNcS+INyWeo76Qu7J9
         40zgOTNBCvaZU8NYZsCNT6bvLG0p93UmLeI4G+f/6rw3O6Goi7lm9SVztOXqw3TRsB/j
         kvja5Ke02aAZxEqzn2EG5pTSyiYw1Rl/epv0LCWH3Z3osUXoCka4scIg7h6TupZFqx3s
         1qresZeSO5R+xFYue8nuz9duDSqqNHjyRCGFqYH66cPxXRS8DP4t8dRkruXKSuZd22Y8
         Lj/w==
X-Gm-Message-State: AOAM532LNV1nu52My5MYwGROLe0R+47RG4WwXi3c7EzTBIrJYiPbVBt/
        J4IlX+pOYHH4x869tanbBahdeQ==
X-Google-Smtp-Source: ABdhPJzNZQip/BwALlXE7Z7NBJGyg6SKSf+M0vJ6RYGbUSs5QT+KzgE2IUOJho/3zqy/j8F/SKOUnA==
X-Received: by 2002:a17:90b:3844:: with SMTP id nl4mr8431143pjb.78.1626000085273;
        Sun, 11 Jul 2021 03:41:25 -0700 (PDT)
Received: from localhost ([103.127.241.250])
        by smtp.gmail.com with ESMTPSA id j6sm10570265pji.23.2021.07.11.03.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 03:41:24 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: [PATCH v4 03/11] coresight: tmc-etf: Add comment for store ordering
Date:   Sun, 11 Jul 2021 18:40:57 +0800
Message-Id: <20210711104105.505728-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210711104105.505728-1-leo.yan@linaro.org>
References: <20210711104105.505728-1-leo.yan@linaro.org>
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

