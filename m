Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811943C3B95
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 12:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhGKKoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 06:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbhGKKoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 06:44:06 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2308C0613E5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 03:41:19 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id a14so7491411pls.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 03:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mUfdU9WBYmi8/NBmndyLWLFFhQ6mqBUwjCh/GuP5qb8=;
        b=RtX0qI4MGvgBvDGGTerEq7GxtH+wniuNEW7utX4Sj0O4q4Q26d6jcMwwestxzCiHzf
         QNREUyk2x12NqOorPsbS3FoidmVIpuT/X9x1hAaaDwk5vvIg5bJeUN/xIvP+5jXZxRNx
         u/oWY3EUWzmjc8kBz9+LguNLGpCx88gDP2zAl34xnTCTXim7dSVTNN4jzMPHY5CZfNP3
         rQ+MsT5YTP5b2k71mOiwnmQObvk5ATNEF1tVHNUWlJA56zt5qd8az7VglCncXoOBA7Zf
         bgX5cPJFk47D0smGeeKZxFnYCvrVO30Dz7ypy3OlOpHsT0reQULiqgBvOOWyCoycLp+D
         xZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mUfdU9WBYmi8/NBmndyLWLFFhQ6mqBUwjCh/GuP5qb8=;
        b=VyWnvEmGYq17iltXzcwWvaJkmcK4wkI2jLQFo6p7SlgRqMR3Y6JEg/LDrq3ISFKYNi
         xu8iO3yxX0sI5ZXRdfGbTi3O/ktdfTTlO6N1R/yok0sIR/FBgrMXSy6T3x0kCy4fMoSo
         lx2NeoXmeOE5fsN5wU3kdF8vYhEqHFIJqaU6IYC9mcZEkgY2BwHjaPOoWyYVM/SQxMUR
         ButfpRJvA0sb0SciClKUDN+knPSeJkJu0KBwN9weYVMgD15EnwDktq4S0VilROCAvvHN
         Zears/qrfjyxGjBerCZjA5MIWzYfoG0H2iNfwr08O02pbNzszOeYmvqlyMQ0+U+Kaf0M
         CvOg==
X-Gm-Message-State: AOAM5333sr5fNwjewP+DCrMxgbU7oVxy2ej/JkWpHGbZZeslpkxsy18x
        D5xeV/WdANrWvdw91eV97R18vg==
X-Google-Smtp-Source: ABdhPJyQ8XxCLn1vu+B0STHNwIFTAWH9uvWnYEj6A61rhx5yfvxHRMAmDfZWPGYHsUsY0F9uNVDSvg==
X-Received: by 2002:a17:90a:9511:: with SMTP id t17mr48277859pjo.108.1626000079190;
        Sun, 11 Jul 2021 03:41:19 -0700 (PDT)
Received: from localhost ([103.127.241.250])
        by smtp.gmail.com with ESMTPSA id t2sm16735752pjq.0.2021.07.11.03.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 03:41:18 -0700 (PDT)
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
Subject: [PATCH v4 01/11] perf/ring_buffer: Add comment for barriers on AUX ring buffer
Date:   Sun, 11 Jul 2021 18:40:55 +0800
Message-Id: <20210711104105.505728-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210711104105.505728-1-leo.yan@linaro.org>
References: <20210711104105.505728-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AUX ring buffer applies almost the same barriers as perf ring buffer,
but there has an exception for ordering between writing the AUX trace
data and updating user_page::aux_head.

This patch adds comment for how to use the barriers on AUX ring buffer,
and gives comment to ask the drivers to flush the trace data into AUX
ring buffer prior to updating user_page::aux_head.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/ring_buffer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 52868716ec35..5cf6579be05e 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -509,6 +509,15 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
 		perf_event_aux_event(handle->event, aux_head, size,
 				     handle->aux_flags);
 
+	/*
+	 * See perf_output_put_handle(), AUX ring buffer applies the same
+	 * barrier pairing as the perf ring buffer; except for B, since
+	 * AUX ring buffer is written by hardware trace, we cannot simply
+	 * use the generic memory barrier (like smp_wmb()) prior to update
+	 * user_page::aux_head, the hardware trace driver takes the
+	 * responsibility to ensure the trace data has been flushed into
+	 * the AUX buffer before calling perf_aux_output_end().
+	 */
 	WRITE_ONCE(rb->user_page->aux_head, rb->aux_head);
 	if (rb_need_aux_wakeup(rb))
 		wakeup = true;
-- 
2.25.1

