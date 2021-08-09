Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6C83E447B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbhHILQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbhHILPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:15:51 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAD5C061799
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 04:15:31 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so24999827pjn.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 04:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u/h6y01vhaIboCmoU5QTv0ntWs0BLu7zaNEJjRy0DS4=;
        b=hkyAS0RhMsAa7LD1MUeZEUEA6CJRhXoRGGkq6d3F/54q7BhmZASfdVQkwasll/kw/F
         SOlyMLOFqZnh8DJsZGVsmPrQNJoy7r5Pn6+5mB7m8wBMq8/T5iw4lpJIXPriz+L/s3Ta
         CUMoKKCINcM90LBQz+WzRu0ZljJj6Kc68I9BhgoVQEJLyNaPTaYetVpHcANKcsXqPpOp
         aT0ZBXoKMZ9+ieE6wuiUHu7x9QLwSQ2MDDFyzhE+3nsBXnD2/KwhT06slkS/XlqVYk6m
         Rsb1U5aIIiDhb/3A58reek7T5dSubzZKW8upKdfCAJmV3FVf7LmaQvzRKlDW9cPjKM+b
         OHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u/h6y01vhaIboCmoU5QTv0ntWs0BLu7zaNEJjRy0DS4=;
        b=KwqcbNBUs+SOXtYbU0dVbT0GaT2QL8GtQi6yWLBCK2fLGKzHKkm7G7jhC0AOf/ZnzD
         mvJVWL/pVqBm6gv+vtYUXtb/3azdHcyExFntzzI+Zzg1Yv/EbKgQzWE24PC6mGlUUFUP
         XFsdsTgucC6u4KMbCr3QZwx27rAOFPD8FPtNIzU9YyoAY0B4Pg31ImjFVxBftsNT9aNd
         IHbRdsKb5qtm/crn/xp/D0LVJH7LEzdz2tIScALufJDKzHdPKb/jP1pULZYWVGcrhuoa
         Z7d/lOWicpR5V2NU5CBSaa3QEFV5dzvceXICzcjBzfEgS2etcerkXAw6hwa/gxmvl8EU
         59pg==
X-Gm-Message-State: AOAM530KGhyii8iQM984wTPwvWKjMYUGVYttUsMhzKES+d8BGxUWeQCw
        vo5QIUu7b+Gb12dvoaZMQym78w==
X-Google-Smtp-Source: ABdhPJzqhcGgIWjxWcNcl2NY9IEGS+ZexPGs38I6dKh/kL4UUSiskPXmu4C2WEkQ/2bALqJpxIqNBQ==
X-Received: by 2002:a63:fd51:: with SMTP id m17mr56716pgj.395.1628507731152;
        Mon, 09 Aug 2021 04:15:31 -0700 (PDT)
Received: from localhost ([210.0.159.74])
        by smtp.gmail.com with ESMTPSA id 81sm20460136pfv.185.2021.08.09.04.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 04:15:30 -0700 (PDT)
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
Subject: [PATCH v5 5/9] perf auxtrace: Use WRITE_ONCE() for updating aux_tail
Date:   Mon,  9 Aug 2021 19:14:03 +0800
Message-Id: <20210809111407.596077-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809111407.596077-1-leo.yan@linaro.org>
References: <20210809111407.596077-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use WRITE_ONCE() for updating aux_tail, so can avoid unexpected memory
behaviour.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/perf/util/auxtrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index cc1c1b9cec9c..79227b8864cd 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -480,7 +480,7 @@ static inline void auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
 	/* Ensure all reads are done before we write the tail out */
 	smp_mb();
 #if BITS_PER_LONG == 64 || !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
-	pc->aux_tail = tail;
+	WRITE_ONCE(pc->aux_tail, tail);
 #else
 	do {
 		old_tail = __sync_val_compare_and_swap(&pc->aux_tail, 0, 0);
-- 
2.25.1

