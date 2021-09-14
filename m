Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B5240B973
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 22:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbhINUtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 16:49:24 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:45612 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbhINUtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 16:49:21 -0400
Received: by mail-ot1-f52.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso354103otv.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 13:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E4do6ZA0TOFP4Hz327TP/A6q+bKxaXa1iSI4FOzJa60=;
        b=PwKeoP739Mb0dvZDbghosXFI4+/81tHeb9b1V1SMtYgyZwhiVQ2JheNlCJWwiv+8To
         YmytsUICxTRddGMyuISsCg5khvX8cgfkJ+hqqqJVjcanxrlbhArA29GWOeFNM4arg6Y+
         VSCqDEqv8WR2K51+2oaAh0EStl1vdYPHIpMAlCThaMfIAqMcVo2PT3U1mGs2EoVDfTIF
         ZlQveloWondgcJ5TF03KFhEpoSf8sOLczNtKeiuaQk0Jaf1sRn2YsRyMr79RNj4kRw/j
         GsyyAOqDVzKGyF+LRHtSmG4WClo4L4HlxjxULL5mPNEowWBSNp9XPmbFdtN7G+bAPn9B
         mSzg==
X-Gm-Message-State: AOAM5304P9684iPHofvbtQvp/gbtm4yqPdFq6s+JddqvvOi3EsEJ9wNt
        +ZnnRs4yOtkSv35sAq7INg==
X-Google-Smtp-Source: ABdhPJyEXtSPTKolZuuw+LNsDBA3Aao0tZ3BSBbYdafbVuFccEagg74RqQYQT16YdRlPbxBLKKGPBg==
X-Received: by 2002:a9d:6d02:: with SMTP id o2mr16293329otp.302.1631652483786;
        Tue, 14 Sep 2021 13:48:03 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id y14sm2883236oti.69.2021.09.14.13.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 13:48:03 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 2/5] perf: Add a counter for number of user access events in context
Date:   Tue, 14 Sep 2021 15:47:57 -0500
Message-Id: <20210914204800.3945732-3-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914204800.3945732-1-robh@kernel.org>
References: <20210914204800.3945732-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For controlling user space counter access, we need to know if any event
in a context (currently scheduled or not) is using user space counters.
Walking the context's list of events would be slow, so add a counter
to track this.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v10:
 - Re-added.
 - Maintain the count in the perf core
v9:
 - Dropped
v8:
 - new patch
---
 include/linux/perf_event.h | 1 +
 kernel/events/core.c       | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 12debf008d39..4f82a4d47139 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -821,6 +821,7 @@ struct perf_event_context {
 
 	int				nr_events;
 	int				nr_active;
+	int				nr_user;
 	int				is_active;
 	int				nr_stat;
 	int				nr_freq;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 744e8726c5b2..01290d150da3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1808,6 +1808,8 @@ list_add_event(struct perf_event *event, struct perf_event_context *ctx)
 
 	list_add_rcu(&event->event_entry, &ctx->event_list);
 	ctx->nr_events++;
+	if (event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT)
+		ctx->nr_user++;
 	if (event->attr.inherit_stat)
 		ctx->nr_stat++;
 
@@ -1999,6 +2001,8 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 	event->attach_state &= ~PERF_ATTACH_CONTEXT;
 
 	ctx->nr_events--;
+	if (event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT)
+		ctx->nr_user--;
 	if (event->attr.inherit_stat)
 		ctx->nr_stat--;
 
-- 
2.30.2

