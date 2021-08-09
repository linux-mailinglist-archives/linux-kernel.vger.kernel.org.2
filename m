Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6313E447A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbhHILP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbhHILPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:15:49 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E449CC061796
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 04:15:28 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso6074493pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 04:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Icy+Z5PUT8u8Dpc5dkfKGlMZmq16q7ysRKkB/tucaTI=;
        b=g/ZYxqNSVYfAFHS8Y3Q3LzN7lJVW0gpKxk0VOgH2xoHxQ2NKRV+6csjIvgyrBywe+R
         ltqX4DJvWgANRw6Nqe8rUwmSIG+EDpqswEY0E+CfJ/O//FkSNNgnONSqBD52NBgheHqf
         IL+wA/2mBW0nWKRFKTNOTKsUawDafYB7PEly8exN+kIZ5jNUcK1KLqO9Dv498JOnhgtn
         lOPBbeeSBqs5TUIxc7BkRpvOakIRWVcxw0bGa7bs44s7HueWVPIuULbCQwrnovXyAjN4
         iEqu1DIH3tJr1THGFTL8yGEUVs6AytYqfeczR72X6Dpe58kkFXlTkoE8PmF6NpOpUN4G
         elHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Icy+Z5PUT8u8Dpc5dkfKGlMZmq16q7ysRKkB/tucaTI=;
        b=HjWZsTlhxIXpqLRewOy3brPkoU5A6gpWKp8s5pwdQlXaDcrn/EUoEb+ytD7cWIPC5f
         05vcrOb5ZfMIVmAmS6nGmDQVVCv0IGXBMpOcjkIQmEkdu7YqqPjgMkGXMAlDOnfBTYdA
         npzcBKoN9IEiVuJm8EoP2sUKazfcvbJAi10CshnBZN8W6C29MZsV2Tl/lnBY7rv5rJMS
         DbJa3HL/nXMNZOCSj+9sG2ur1AYZtLi2N/qdJPWH7waFHOKJiQbqOAI/drteoBW85sPu
         ZYF4r0WFV1YCQDfmwnJM2HviekgXhU2C/F7JAsERXGtnt5kzcb1a1vu3PGyijqxij8ru
         IHCQ==
X-Gm-Message-State: AOAM533fSpMFejk6ftStw7D9hjj1TfUjHcHOzRRAs+rq+jqloVOD4Yek
        exdb97uwu6AR+2gIuZC/+3SiBQ==
X-Google-Smtp-Source: ABdhPJyNV8pgx/xOzD9VU7toSF2rH3xwT8aKSjCPECncWnnPs/WlkFT7R4RMV2uLO/EZwqlldYgXEg==
X-Received: by 2002:a17:902:ce8f:b029:12c:c4e7:682d with SMTP id f15-20020a170902ce8fb029012cc4e7682dmr19964157plg.58.1628507728380;
        Mon, 09 Aug 2021 04:15:28 -0700 (PDT)
Received: from localhost ([210.0.159.74])
        by smtp.gmail.com with ESMTPSA id 136sm23941683pge.77.2021.08.09.04.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 04:15:27 -0700 (PDT)
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
Subject: [PATCH v5 4/9] perf/x86: Add compiler barrier after updating BTS
Date:   Mon,  9 Aug 2021 19:14:02 +0800
Message-Id: <20210809111407.596077-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809111407.596077-1-leo.yan@linaro.org>
References: <20210809111407.596077-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since BTS is coherent, simply add a compiler barrier to separate the BTS
update and aux_head store.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/x86/events/intel/bts.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 6320d2cfd9d3..974e917e65b2 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -209,6 +209,12 @@ static void bts_update(struct bts_ctx *bts)
 	} else {
 		local_set(&buf->data_size, head);
 	}
+
+	/*
+	 * Since BTS is coherent, just add compiler barrier to ensure
+	 * BTS updating is ordered against bts::handle::event.
+	 */
+	barrier();
 }
 
 static int
-- 
2.25.1

