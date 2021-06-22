Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9387A3B094D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbhFVPmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:42:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32292 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232180AbhFVPlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624376376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lL9Zz+zbm8nhrT7havLRTayuM+rBoIpE6BIIVD/pt0g=;
        b=dQ+KlAMVTgqLSws5wfjdXOIjSryXKl4zCMsYUyL5b3FUBWgVd9VWsUfT3GWDlegyloGLAD
        jNz1eZGUMsgAx9oSVA5Q2sSpBkk0VB6J/K83jwfiUEq6IO2giZYttt/g/QH2e1UHoSO0ey
        4DrjwOdL05sssm8kEbkB8tVXeGJsZbc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-Womkdva9MaeqhguZkWhJaw-1; Tue, 22 Jun 2021 11:39:35 -0400
X-MC-Unique: Womkdva9MaeqhguZkWhJaw-1
Received: by mail-wm1-f71.google.com with SMTP id g14-20020a05600c4eceb02901b609849650so855670wmq.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lL9Zz+zbm8nhrT7havLRTayuM+rBoIpE6BIIVD/pt0g=;
        b=P6hsV6/3xVKQx4evU9hh0hkITNJMGrownSk+NMT+p/UBqU+Q5B0dtV1l6HPOGE66Z4
         IkmCkFYbooUgBPpm3Rnf8TambPhmwM4GgG/sGQ3JN2pKvxk5SuOR0ahZdJQPY7osKJXL
         Gm6hMZWpKxa1jxrf5AG5Z9rHIT/nmFf5J96lxFB8DJ9lbdUi29g+aAgym7JRKEILCFTG
         zqXXCcMArePDbPaT+NyoDsNvH0XT1zl2bzYDbcxIUddJPuLNYKkLOp9clfaCGcrj7BnZ
         zAap2K5aWiFz/SUQKrXJuLCGJpwBP3BWu5IuAVkeeVt94LXf9t3Mvl72DRW11pHVBAmJ
         n1Ng==
X-Gm-Message-State: AOAM531pVZCXe10CTmX0t2jIeyO8fHXB4oU2YTsM7U1wG0dWw7lo3v57
        m3KVxWYJbydSJ2bpeIAs1vVebsrFq6GB+OZPbApfG4nvz4ZvvDxbJNADkoWjCldrcaZzbTBN4ZN
        v6J1N0d8vAsiUARVUihWUpkso
X-Received: by 2002:adf:a284:: with SMTP id s4mr5592723wra.397.1624376374114;
        Tue, 22 Jun 2021 08:39:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTAUbO7IowBjvUCaOVTEnuIiX9PUWmwc9UrtZ0l8ibt/CqFVACe99xk120R04pQNUBwmqSNw==
X-Received: by 2002:adf:a284:: with SMTP id s4mr5592702wra.397.1624376373890;
        Tue, 22 Jun 2021 08:39:33 -0700 (PDT)
Received: from krava.redhat.com ([5.171.243.0])
        by smtp.gmail.com with ESMTPSA id e3sm11647962wro.26.2021.06.22.08.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 08:39:33 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 06/10] libperf: Do not allow PERF_FORMAT_GROUP in perf_evsel__read
Date:   Tue, 22 Jun 2021 17:39:14 +0200
Message-Id: <20210622153918.688500-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622153918.688500-1-jolsa@kernel.org>
References: <20210622153918.688500-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct perf_counts_values can hold only first three
read_format bits. We can't allow PERF_FORMAT_GROUP,
otherwise we get segfault.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/evsel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index bd8c2f19ef74..04e8386b3ed4 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -260,8 +260,12 @@ int perf_evsel__read_size(struct perf_evsel *evsel)
 int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 		     struct perf_counts_values *count)
 {
+	u64 read_format = evsel->attr.read_format;
 	size_t size = perf_evsel__read_size(evsel);
 
+	if (read_format & PERF_FORMAT_GROUP)
+		return -EINVAL;
+
 	memset(count, 0, sizeof(*count));
 
 	if (FD(evsel, cpu, thread) < 0)
-- 
2.31.1

