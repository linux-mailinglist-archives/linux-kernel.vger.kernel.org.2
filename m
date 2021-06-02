Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59B2398685
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhFBKcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbhFBKcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:32:03 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C818DC061756
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:30:19 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id k5so1430400pjj.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E6SPovOHBtUbXkJg7El86KoYgfeSSGvNOlrRgDOrmu4=;
        b=uIYsbANVkfRPocwkidwIxFsUj4EELWKStycxreDCqHyqcYzc/3Z/om6cNf2/yKEgIh
         K2NUGZyriiSZlXC5UjCpsTpkMoH3lxhSA7dE6vybOMJhLGwKTmNGh4WJOX7oUBdX6Iss
         wkMxNAUQrNkzWre9PDi4XWqKX/aNc1MAKwh9YSBCdIKkVSTky9doZWo3946iLDSows2A
         t65O+KTLicVJsh/jS676OAyHzsDB3CBKg1v0Wls3gzqnGClhBfrvDauo7Qve2N6b0+kF
         JZZpg/B/dRWFyII48ydPFLjPK59g3+S8dpyO07o3rOYo8xR6MyGVnMsQTt4tPQcuoyhs
         19PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E6SPovOHBtUbXkJg7El86KoYgfeSSGvNOlrRgDOrmu4=;
        b=VRFUQtoYsiTtAjKJRDBxThI0FuUUOLN09e6xaU6ciNP9IA83qEBO/UHCFjPy8m23EW
         meCSVAkCcMXkl3CyzGv+rt2VA/nPmzQxuCPbGNu4KFitEEso1dLRqPA1ZwfS24l7A1O1
         KZrlxWDkwJFpYY9MWvSeIML50GkxeZ54AZDoxIiX4tUuomLZ7hBfOfseZMyfxzXvdA9a
         UJbf20r7aDg2h0Za7Le3mIg4IiC1t07xrTxjL8wdmjm/Y1sENR2wRyjICZuWP/speYUr
         RIIJm0BSRKSfho1t9q2wXbXhX83/tXgXfeWazfN1OHOM8rKYHaEhBgAAvPac2qVBIThY
         4Zxw==
X-Gm-Message-State: AOAM533IJWqN7rV0WUNVoyNtppquWIDLABaD/R/3/7d7D5papuYw0wc/
        HbswaVkAXm6lux5EVzeAYEBi9w==
X-Google-Smtp-Source: ABdhPJypMAbuBZG8MpOxNAfRGmm0a0kTxcE/hJEHUnjt0C6+DenxeNnqX5nLl8TpcnU94jpwrTSMfQ==
X-Received: by 2002:a17:902:b713:b029:ef:b031:2a9c with SMTP id d19-20020a170902b713b02900efb0312a9cmr30196100pls.22.1622629819320;
        Wed, 02 Jun 2021 03:30:19 -0700 (PDT)
Received: from localhost (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id o24sm16696451pgl.55.2021.06.02.03.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:30:18 -0700 (PDT)
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
Subject: [PATCH v2 1/8] perf/ring_buffer: Add comment for barriers on AUX ring buffer
Date:   Wed,  2 Jun 2021 18:30:00 +0800
Message-Id: <20210602103007.184993-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602103007.184993-1-leo.yan@linaro.org>
References: <20210602103007.184993-1-leo.yan@linaro.org>
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

