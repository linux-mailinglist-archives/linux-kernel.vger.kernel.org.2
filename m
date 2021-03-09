Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71E833320F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 00:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhCIXuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 18:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbhCIXtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 18:49:53 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E83C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 15:49:52 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id q77so19259571ybq.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 15:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=EXnnE/sfHoG61Zd+K0DaqEm2orRFlfcWgEjhMtg3MDQ=;
        b=J/u/Hey6V4MgojpKJtZDgsIlKsuYUzkbru5dM7WF/+/nkVq6BlzIK8zXacjybsG2TU
         ixGk+iruAb3fdUpmpBjGwFQG6rZ1aKFK0kt9ksRUUpcT8FCMPeG4MkbODbvJnLCQsFtg
         o8ZdOrSDMEa/zfWJrC/Eb8P2/7usxuBj/7L2njiOhQe9N/JYHInJpQODzB5YrHHOUieG
         oC1T+Wxqi7v7orOwWYiUvXIoOb4MN/ZFTbEK+LKFMT8XH2Ufst+3Ajc9Eqfy51Ac7d6p
         SbejDPcD6xBKZnu+tIuQwuoz3sCjzXG0FMusFqT0Cq+sDLl7bsFaz+3Fuyas6emuGix7
         QGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=EXnnE/sfHoG61Zd+K0DaqEm2orRFlfcWgEjhMtg3MDQ=;
        b=U0FsETOgO0HGtEAh0jWyzlmwhPGpZC1fHIwcElVqejP+DHjNamUd/bJih3oqj5EENg
         DSb4/QWsjwz7wrudeFLNhbEwy4DYf78VPZUBKMZKLbTlJ370fqscuF9NMhNYWOKH03KL
         xQfeZ8DPxhM2v0TRWL3vaMyLeVeg4Xv04GKWDTnCC5SxHhd4yZ9nOmTeURfxR3IxmStf
         76o5UJe6vCS/iGArj6aNMccJxnOW5bSo/QUWBKT9u1l/Piic0H3Em5kyXRf7wKSCcsD5
         gPxwmag/9gJ+Jod5SAl0Pl9X7OCgSponjnvlXTwyXLU+ieNhUuixJFxfOFKxG5nJCqFi
         2Zyw==
X-Gm-Message-State: AOAM531fc/Eg+QsaVLv/Vu85RVM9PuT0XaQigN3TZHYwAvqVWnfvOYT8
        djESrp+v3C9gSaRjspvSRruO/PfNCsA/
X-Google-Smtp-Source: ABdhPJz5rFaYL7uweYIVPHJMkhaCbsgFCJakCg/5mUDpPfEoSBza1Z9m60vYMRWTdUJoakw90KE5pR+jnnmk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:d4ed:310c:701:5d5a])
 (user=irogers job=sendgmr) by 2002:a25:af05:: with SMTP id
 a5mr489197ybh.86.1615333792198; Tue, 09 Mar 2021 15:49:52 -0800 (PST)
Date:   Tue,  9 Mar 2021 15:49:45 -0800
Message-Id: <20210309234945.419254-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH] perf synthetic events: Avoid write of uninitialized memory.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Account for alignment bytes in the zero-ing memset.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index b698046ec2db..31bf3dd6a1e0 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -424,7 +424,7 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 
 	while (!io.eof) {
 		static const char anonstr[] = "//anon";
-		size_t size;
+		size_t size, aligned_size;
 
 		/* ensure null termination since stack will be reused. */
 		event->mmap2.filename[0] = '\0';
@@ -484,11 +484,12 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 		}
 
 		size = strlen(event->mmap2.filename) + 1;
-		size = PERF_ALIGN(size, sizeof(u64));
+		aligned_size = PERF_ALIGN(size, sizeof(u64));
 		event->mmap2.len -= event->mmap.start;
 		event->mmap2.header.size = (sizeof(event->mmap2) -
-					(sizeof(event->mmap2.filename) - size));
-		memset(event->mmap2.filename + size, 0, machine->id_hdr_size);
+					(sizeof(event->mmap2.filename) - aligned_size));
+		memset(event->mmap2.filename + size, 0, machine->id_hdr_size +
+			(aligned_size - size));
 		event->mmap2.header.size += machine->id_hdr_size;
 		event->mmap2.pid = tgid;
 		event->mmap2.tid = pid;
-- 
2.30.1.766.gb4fecdf3b7-goog

