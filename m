Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725C83371DA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 12:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhCKLyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 06:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbhCKLyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 06:54:24 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4C6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 03:54:24 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id n17so6531459plc.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 03:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qG66Gjpd1fm/qHRbDBjOH04JKg/qjUv+OFKyWody6j4=;
        b=n7AMLheiqCLlVL6EHrLcTMsItl4oSAXLxHXTfn5KngoxK1eGnrtJ0Jx8qVB+wNPlV7
         lzQ+rbbXQ1UVOPeKjDzT4J6JYUyFIV8YIlG8NhnffzyWzf7U/9pRwuX4aoVrnWxqtWlg
         hL1B2xj720IM8BDYgtb4FXRHzzgeI0/kJtODZZ94jabvvjGYMuCkV4qPpqXvBAS/Ho6J
         GG7Rnkp5nOgrTLODsPx96nVEzO3e22tF+LmBm9swDQT19eVU28s5KTrLAarmWXys2uLo
         I6/XhiG2o0luF5+AB3qPiR+d6b/bz1nkMBvuHWNI0spChHTRM5di7ES+DXQc0vCVL4IV
         wngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=qG66Gjpd1fm/qHRbDBjOH04JKg/qjUv+OFKyWody6j4=;
        b=G/1e5tL7LA5pZb2Q/3e6Rn5lPOR+8tN1jtCHA3NWKvgqqw+0gZqIK6gPJxbUAeoA1c
         SvxhUV4WHbuXnODxLyOj2PdFH5KJ3+OV6ENf9VOBhX6iA53wIum4xEoJ6rUFOHqWajRu
         rHKUUsLx0lW/sJPMy2JLB6GP3dbbQM1zYpD7lVBqI4WqDYp6IK5S547HTyJTgTwNC41f
         0zCeST4K221yP2EHdTxJOyShIu3Mi5sS2kVkBFa2ziTqUs4Q41wsrIhclcw+M73oWAEI
         uLOv9TcTfvFgqd8bRv/w2X/EXBQVyZGmIR/gFYg9NEP9yTRl6eNfZ52StF3w7ctA1rA7
         bT4w==
X-Gm-Message-State: AOAM53398u2Y+JH2hETEhZOeJu6h8qTX1ZnMdcSXnYfSKlj/nQm6uPQv
        pjDToMmys1D4MptVJyj/qsk=
X-Google-Smtp-Source: ABdhPJwA5cFpPYSFzSW17W8Rm762rCgdnv9uIVWfxtI6Fg+pPjxBZp7SJg/wm/qCnU3zsNwO6NL21Q==
X-Received: by 2002:a17:90a:e556:: with SMTP id ei22mr8522426pjb.214.1615463663778;
        Thu, 11 Mar 2021 03:54:23 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id i14sm2233742pjh.17.2021.03.11.03.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 03:54:23 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        David Rientjes <rientjes@google.com>
Subject: [PATCH 2/2] perf core: Allocate perf_event in the target node memory
Date:   Thu, 11 Mar 2021 20:54:13 +0900
Message-Id: <20210311115413.444407-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210311115413.444407-1-namhyung@kernel.org>
References: <20210311115413.444407-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For cpu events, it'd better allocating them in the corresponding node
memory as they would be mostly accessed by the target cpu.  Although
perf tools sets the cpu affinity before calling perf_event_open, there
are places it doesn't (notably perf record) and we should consider
other external users too.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 10f2548211d0..519faf0b7b54 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11246,13 +11246,16 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	struct perf_event *event;
 	struct hw_perf_event *hwc;
 	long err = -EINVAL;
+	int node;
 
 	if ((unsigned)cpu >= nr_cpu_ids) {
 		if (!task || cpu != -1)
 			return ERR_PTR(-EINVAL);
 	}
 
-	event = kmem_cache_zalloc(perf_event_cache, GFP_KERNEL);
+	node = (cpu >= 0) ? cpu_to_node(cpu) : -1;
+	event = kmem_cache_alloc_node(perf_event_cache, GFP_KERNEL | __GFP_ZERO,
+				      node);
 	if (!event)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.31.0.rc2.261.g7f71774620-goog

