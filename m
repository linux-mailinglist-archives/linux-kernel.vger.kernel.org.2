Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3336D3E4478
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbhHILPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbhHILPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:15:43 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBEBC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 04:15:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id a8so27289742pjk.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 04:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FNKiiIhfoxwyjjlrmMVPD0DKnFNw0oyY5Z/6cuWikiM=;
        b=q50IRsTzpC659Hj0lYLMLuS575e4kkbjR6P5w0qCT/vBGQXrlGA9mAYEtRCevdNVXO
         IW/7JO5iQ6ifmD/sqFUOzDnoRbGD+VdR8F9i9UVppdU6oz0LpeG0pOARX3Aiu+7ztsRv
         i0pimaiGSBM/WBcgk4+OcFqgtApCNqfCIJbE6y5PqahgUnf3DNMRxSgwPexiMsISE622
         O2K8sX9HYLU+Q4imWk7EBYkQyOXi9EGtA26f9B5G+28WkP36Htn+u/BdffzD8vT0RuKI
         Ibg7+7DUA/bGCv/buIEyfL8IXjAZ08XKDaFWzN8Jrg2e3RuHJO8zd2LGIicd8ceinsdz
         4SXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FNKiiIhfoxwyjjlrmMVPD0DKnFNw0oyY5Z/6cuWikiM=;
        b=pM+itMkdQBmGULicQ9u9XeRwcy/yfjdYPpHz/AXdx7nZs0Q5r+ANt3TsLEy3t4mCE/
         K6rWYosqUCwVAeZKA4KKCHeqRCAqE7y6W4vxg+/OSofDJSoTaGfRgmgzfAl4e8iC9RIA
         lBFaMQTToU0KKkQ+vfxAlpDB7Us5GdKRq5jjw5nQ8Auq4oru/keTH/YV8sEjUR3AKHhJ
         iuv8wvbDXqZ1VrUcCXKfSK8+JrlHEvTI7FYeYPSYQeXk+KxAvTfgoE/gJUv5mjqVIa4G
         yEsdZcDix2wMHee3Xne27NzhhsQ2g26LG1p/m1GOR9B2trYVqBu4VluRCpxNuHv75fHE
         6kYA==
X-Gm-Message-State: AOAM532RgJxvGhu3t11ks64/cxlv9c+YwHIK2cFZSy6g9AcF0yabQpuw
        8RnUc5YoTtfvF2MZnf6qxhWo5A==
X-Google-Smtp-Source: ABdhPJwEQt4wx3EDVsKEI4XgBS5gyLZRktaFVxothL5bIu5lfUl2KRqYEoPglvPGKDc0UiH6GxMDdQ==
X-Received: by 2002:a17:903:1243:b029:107:eca4:d5bf with SMTP id u3-20020a1709031243b0290107eca4d5bfmr1421457plh.15.1628507722603;
        Mon, 09 Aug 2021 04:15:22 -0700 (PDT)
Received: from localhost ([210.0.159.74])
        by smtp.gmail.com with ESMTPSA id w15sm17904203pjc.45.2021.08.09.04.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 04:15:22 -0700 (PDT)
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
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Song Liu <songliubraving@fb.com>, x86@kernel.org,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 2/9] coresight: tmc-etr: Add barrier after updating AUX ring buffer
Date:   Mon,  9 Aug 2021 19:14:00 +0800
Message-Id: <20210809111407.596077-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809111407.596077-1-leo.yan@linaro.org>
References: <20210809111407.596077-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a memory barrier is required between AUX trace data store and
aux_head store, and the AUX trace data is filled with memcpy(), it's
sufficient to use smp_wmb() so can ensure the trace data is visible
prior to updating aux_head.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index acdb59e0e661..13fd1fc730ed 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1563,6 +1563,14 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 	 */
 	if (etr_perf->snapshot)
 		handle->head += size;
+
+	/*
+	 * Ensure that the AUX trace data is visible before the aux_head
+	 * is updated via perf_aux_output_end(), as expected by the
+	 * perf ring buffer.
+	 */
+	smp_wmb();
+
 out:
 	/*
 	 * Don't set the TRUNCATED flag in snapshot mode because 1) the
-- 
2.25.1

