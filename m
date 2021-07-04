Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6494E3BABBF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 09:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhGDHTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 03:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhGDHTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 03:19:44 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EFCC061764
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 00:17:10 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id w22so9906755pff.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 00:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mUfdU9WBYmi8/NBmndyLWLFFhQ6mqBUwjCh/GuP5qb8=;
        b=HF78Ns2KJ94lBFHkqHHYvCYHD4XrlhN8LrnvJOs4SzJEbXQLwLgpWDt0zU6kv9thCu
         gdLazU3mmrvpTorsHnLibdESJswhC7Ied5jYBfhzPiW58xbfw5eAPfe1mVMpniRzfofV
         +J+ihmTl+sjPqr720iwqV6ZqP6s0SpNdLr3sGr1iz5fVo1rh3ib+OWocNyxehHC6ZL8t
         oquO+TcF2/bdRIX+rLF/ytpAptqJ7/eBCGJxFrTa0XwsX4tLt95P1Xd2bg1/jOn2osH2
         tSVXGkxAjKtOsk2uUj3BWHJt5y4nI42fVH36oP0b7Pnyt8+b+M5gqyaWIBA3vLVmE+30
         aHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mUfdU9WBYmi8/NBmndyLWLFFhQ6mqBUwjCh/GuP5qb8=;
        b=ZllQpZYt4/MyB+bYzErAdqrjOpo4/nhHioJR+y06/3xxzFwGlDFivvOfF+h52zwzjE
         R8+pPd3GBkmB2k4tGZ6GEMRaolYd45VIErBhH3dS4jzF7haoHTZhv4U/2Ivw/zz650cT
         yxRG4win+IoJZORQkHSpohMw1ChGD5Hm+abx6RBIkBEMNMdCBD49yutFQzDjFA9r5F3x
         CbIq+NFsCEmeCD69nU1p29SKifBve12LJ7TrV5lYCIHuN+YHVRPR9EDIzMKv2bHcDm9q
         v6kTmn7Ke9OlvhkA85D6BQ4Ock3XWuzo7R3fMGMDl10yN7fkEMv3Nj2C5sb+N0+BpK4/
         KNfg==
X-Gm-Message-State: AOAM532cELKJ/+IOBkpFmYGD/zlGiOGLM+8UcSF/8vg5UAP4O3rKJOfY
        WKPdWPTRANvGHfIdbjPCVrthZQ==
X-Google-Smtp-Source: ABdhPJxikogZ+NeiWmhynh68p62mZPKUnJOdPzdcYP2HqwkcqPAR8k719kBsv+JqyjlFHGxFOLDWGA==
X-Received: by 2002:a63:f515:: with SMTP id w21mr9167878pgh.343.1625383029524;
        Sun, 04 Jul 2021 00:17:09 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id d2sm9657731pgh.59.2021.07.04.00.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 00:17:09 -0700 (PDT)
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
Subject: [PATCH v3 01/10] perf/ring_buffer: Add comment for barriers on AUX ring buffer
Date:   Sun,  4 Jul 2021 15:16:35 +0800
Message-Id: <20210704071644.107397-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210704071644.107397-1-leo.yan@linaro.org>
References: <20210704071644.107397-1-leo.yan@linaro.org>
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

