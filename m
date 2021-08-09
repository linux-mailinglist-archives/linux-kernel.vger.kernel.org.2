Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB613E4477
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbhHILPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbhHILPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:15:40 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E1CC061796
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 04:15:20 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c16so15967842plh.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 04:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mUfdU9WBYmi8/NBmndyLWLFFhQ6mqBUwjCh/GuP5qb8=;
        b=qpdVxW5apeotrdM2TF06hZw08s65z4QwLumvU9xv/1WhAR9sgk2/cegXSUJAq5nd4z
         td9kmETmFcktCDgTZxPCkDSJN6YY1kAaofoZC+aMUG+r6j5hl2gFFJrrXA2dvq78eizO
         0uDjrQalWkQzu2N0/KVrfSHpa1MUGr04hBRaTN50+g/22xftdVxSfiQRLcbQfeLYmJ1o
         nvGA41UTpDKNXPh4t743VyFNgURK2k0H70kDUz8cKfqoarcH7wHGvtRPqMGzlZxL/fQ/
         YurX1u9V3i1s202T4XOfeWwVXlnXd72hrMnJ4AQ5Ob6sBo9wD4xXUrJf/RJci26N+MDy
         Qohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mUfdU9WBYmi8/NBmndyLWLFFhQ6mqBUwjCh/GuP5qb8=;
        b=FfF8KL/BeSzmfLiysGtkwoXMVx8UqNKiW4KSOFJl6z80exx2WAhxBA4wCJmDUT4ADf
         lgmwVlenJ3mgUq5KQi9BfplSF7QwmFGGoX9QLaco/lLsxjM5fij3WgcHu6xQZ4hq1s74
         q/GcVs/TVr37JujTqpulc/YhBe99OtwXrk05NEd21frFrglP1d/BTounREqI5TdYyp9G
         HKzZD8nt7bT/k2Z8p7vddzFqWpbzgzt0D3o7uMj9UGYO1Mr6WIbaML4tzK11xM7ZRo+s
         1vt932Wzp7dUy+/VMOwHY6BpYPfmfpmhpGob1lm1Tb591s5Ne2g13/FwVqkTnhY14Npb
         FneQ==
X-Gm-Message-State: AOAM530Ot39UFeNYU9peZpL5BUGJnW3v7amQN+3yzDK5w5DcXqtZa2rx
        L7lYNPabpHKGc+RdAEP0qAZeuA==
X-Google-Smtp-Source: ABdhPJxbQmUGGecefTVu1P63BV4lnVu3QGLeQsDHNtt0egqlT6WsDEjcKt0medrp0IYgHlC9XawHvA==
X-Received: by 2002:a17:903:22c7:b029:12c:4621:a2fd with SMTP id y7-20020a17090322c7b029012c4621a2fdmr9050245plg.61.1628507719959;
        Mon, 09 Aug 2021 04:15:19 -0700 (PDT)
Received: from localhost ([210.0.159.74])
        by smtp.gmail.com with ESMTPSA id v15sm17844635pja.53.2021.08.09.04.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 04:15:19 -0700 (PDT)
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
Subject: [PATCH v5 1/9] perf/ring_buffer: Add comment for barriers on AUX ring buffer
Date:   Mon,  9 Aug 2021 19:13:59 +0800
Message-Id: <20210809111407.596077-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809111407.596077-1-leo.yan@linaro.org>
References: <20210809111407.596077-1-leo.yan@linaro.org>
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

