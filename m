Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4A33B0947
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhFVPlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:41:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35700 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232161AbhFVPlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624376367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wBXqrNbLCscMDmkC5p44AOxXH/3pHNeK/8OtrSyuu1A=;
        b=Evzx7TMz/a0zcLfrm9GIO2XQvrz/hMpHRof7FCxHG7sSdKUfZPDSktn5FxTznxIeUFX37q
        DQ8vdIgwdF9hSIOueqg9WLNyZsE1eTdExBT4lFHmI5R0aIvsWl9kbwmsSefOOs3FTtq79j
        3NVcXP3hMsUysAXnnzVlx/utj1KoaZA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-q3CZhBk7P0CDcSfZcAaHGQ-1; Tue, 22 Jun 2021 11:39:25 -0400
X-MC-Unique: q3CZhBk7P0CDcSfZcAaHGQ-1
Received: by mail-wr1-f69.google.com with SMTP id h17-20020adff4d10000b029011a7b7961dbso7693593wrp.15
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wBXqrNbLCscMDmkC5p44AOxXH/3pHNeK/8OtrSyuu1A=;
        b=UKrR16pRo7EDUflbit1RdiWorKLrRCIi+YDeD/OCGTjaitRNwxkmWUyLBhyghPVkiQ
         3D9UFAiSbYpOcVNEXccLLXK/hx7r0ZrkGJBZddrH3R+O9UEng3OUx9M4/4wPbZUVOgRE
         mNSJO4rRyKUfo7DNHhYafRH6sGuZkbp3IJZ+M97Hk5FGuP5AGCLfJIrz3y7QyRxkxPkw
         TxqWp6HV1PK5bwdhvBtMjmutUMlWRwBbw6SOWEcrIAsVMqP/10gb8PXdvFYpIsnNkzU7
         0iMcXv7ABRLp7sqT7IkK5dZJtGYO2Z6X4i1q5X2Jy8Q885nxrBrFOYCm9+nPUBRNZNos
         ryoQ==
X-Gm-Message-State: AOAM530Ukd0sR5NJghnVnarxwf+zJmZYiLw6O1NPXBIbtI6cqLQzxtuU
        PsAnElJEpYodpWwlcDv9KeO6ux6iAJWTPgyNagT45ZEXfJSaYJpnBxwtQnrCXqfzmRIfWnsmMYc
        4RjHBxeg9i1yXA9OrtkLW8sWS
X-Received: by 2002:adf:f20c:: with SMTP id p12mr5557371wro.257.1624376364652;
        Tue, 22 Jun 2021 08:39:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxz9E0y8K/lcu7FnurXWTEFT5XueN78ExpyLQa0eLIDBHJwhN7qtQHj6JryejSUOatclDVfSw==
X-Received: by 2002:adf:f20c:: with SMTP id p12mr5557355wro.257.1624376364533;
        Tue, 22 Jun 2021 08:39:24 -0700 (PDT)
Received: from krava.redhat.com ([5.171.243.0])
        by smtp.gmail.com with ESMTPSA id e3sm11647962wro.26.2021.06.22.08.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 08:39:24 -0700 (PDT)
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
Subject: [PATCH 01/10] perf: Track build id faults for mmap2 event
Date:   Tue, 22 Jun 2021 17:39:09 +0200
Message-Id: <20210622153918.688500-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622153918.688500-1-jolsa@kernel.org>
References: <20210622153918.688500-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep track of build id parsing faults per event,
so we can report it in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f5a6a2f069ed..5110a998f59b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -669,6 +669,7 @@ struct perf_event {
 	unsigned int			attach_state;
 	local64_t			count;
 	atomic64_t			child_count;
+	local64_t			build_id_faults;
 
 	/*
 	 * These are the total time in nanoseconds that the event
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6fee4a7e88d7..d83ccb58a3c1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8183,6 +8183,7 @@ struct perf_mmap_event {
 	u32			prot, flags;
 	u8			build_id[BUILD_ID_SIZE_MAX];
 	u32			build_id_size;
+	bool			build_id_fault;
 
 	struct {
 		struct perf_event_header	header;
@@ -8244,6 +8245,9 @@ static void perf_event_mmap_output(struct perf_event *event,
 	if (event->attr.mmap2 && use_build_id)
 		mmap_event->event_id.header.misc |= PERF_RECORD_MISC_MMAP_BUILD_ID;
 
+	if (mmap_event->build_id_fault)
+		local64_inc(&event->build_id_faults);
+
 	perf_output_put(&handle, mmap_event->event_id);
 
 	if (event->attr.mmap2) {
@@ -8386,8 +8390,11 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 
 	mmap_event->event_id.header.size = sizeof(mmap_event->event_id) + size;
 
-	if (atomic_read(&nr_build_id_events))
-		build_id_parse(vma, mmap_event->build_id, &mmap_event->build_id_size);
+	if (atomic_read(&nr_build_id_events)) {
+		int err = build_id_parse(vma, mmap_event->build_id,
+					 &mmap_event->build_id_size);
+		mmap_event->build_id_fault = err == -EFAULT;
+	}
 
 	perf_iterate_sb(perf_event_mmap_output,
 		       mmap_event,
-- 
2.31.1

