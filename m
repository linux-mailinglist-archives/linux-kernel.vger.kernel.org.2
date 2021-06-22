Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CB13B0949
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhFVPly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:41:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232203AbhFVPlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624376369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6AIm7PaBH7gZ8T+LILMtWbdn7kTMkG9nBIfkqyGH6Ws=;
        b=PZE2t7g4rWzzNMZT3Tjrr3nPy4ieKHHETnv8dJeRI28bBzSsdgTyaxMM9ODlAx2DZqZp3b
        h3iLCzC8W8ukb55H8vYrhzz1dcNYJ4uLwfg/ISQBGoVrEm7zS6o185SmGsC/ADbhli3+HU
        ie0ZH1/SW2V4o7AuPfNGjIJ44hMlvx0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-nhH8z4ecMc-zWkjCJAFRJg-1; Tue, 22 Jun 2021 11:39:27 -0400
X-MC-Unique: nhH8z4ecMc-zWkjCJAFRJg-1
Received: by mail-wr1-f69.google.com with SMTP id i70-20020adf90cc0000b029011a8a299a4dso4967413wri.17
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6AIm7PaBH7gZ8T+LILMtWbdn7kTMkG9nBIfkqyGH6Ws=;
        b=iPFn1fesbxGohrusZLhzHiRmwPCl6TkRc6edXpdMcVMtrcfiQhCbG15p1ZqtapF/PF
         49GfhTVMNGRC8VV/k4tje/ULFU+fXokxgi3x0BjQsoEzzUZqga88rPkP6JjRqlKDDnbJ
         jc/p7HZCriB4lyVqJeP9vXUCbL4xSLLlgZ5sjuBer9ZLtAWaXFXJr+JtPYUey3ZUsSYH
         fOwqy4LKByPZJBG1PvecgfS1hA+9fsTVUZoqZ5VAOd+iuvnD/MIEnukOHxDnu1U97vtX
         L3G7+kIdWxN3vCoQoDySlGuuKQecFanOg/H0M71YCWLHfGfIy2OMEHDZGRySQKh74zpm
         P/MA==
X-Gm-Message-State: AOAM5319riXzHyWzNd6UpEEL1Uck+OX8iams/U+obNWoEIdiaBuq0ZWf
        0xwqo4REkhDrp3JdSA3lRwKs6ziU7gmCt5lyvL538uQ+U2qqrsb9sR1Ai6K3TmHUAasfIrR42FK
        N2y/VcHMFIZoEEle0nqmDZUpp
X-Received: by 2002:a05:6000:186c:: with SMTP id d12mr5588351wri.123.1624376366731;
        Tue, 22 Jun 2021 08:39:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxT68HEQUgUbrgqpuN0r4ORuMvEihiZ+kk7idl6wDmDYGGlRBsY0cMdpwgzARRF44E8mtfiSQ==
X-Received: by 2002:a05:6000:186c:: with SMTP id d12mr5588338wri.123.1624376366615;
        Tue, 22 Jun 2021 08:39:26 -0700 (PDT)
Received: from krava.redhat.com ([5.171.243.0])
        by smtp.gmail.com with ESMTPSA id e3sm11647962wro.26.2021.06.22.08.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 08:39:26 -0700 (PDT)
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
Subject: [PATCH 02/10] perf: Move build_id_parse to check only regular files
Date:   Tue, 22 Jun 2021 17:39:10 +0200
Message-Id: <20210622153918.688500-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622153918.688500-1-jolsa@kernel.org>
References: <20210622153918.688500-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving the build_id_parse function to place where it
parses only regular files.

There's no change wrt maps we generate the build id for,
because we get parsed build ids for only for regular
files (non-special files) anyway.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d83ccb58a3c1..3f1630c06195 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8336,6 +8336,12 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 		maj = MAJOR(dev);
 		min = MINOR(dev);
 
+		if (atomic_read(&nr_build_id_events) && *name == '/') {
+			int err = build_id_parse(vma, mmap_event->build_id,
+						 &mmap_event->build_id_size);
+			mmap_event->build_id_fault = err == -EFAULT;
+		}
+
 		goto got_name;
 	} else {
 		if (vma->vm_ops && vma->vm_ops->name) {
@@ -8390,12 +8396,6 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 
 	mmap_event->event_id.header.size = sizeof(mmap_event->event_id) + size;
 
-	if (atomic_read(&nr_build_id_events)) {
-		int err = build_id_parse(vma, mmap_event->build_id,
-					 &mmap_event->build_id_size);
-		mmap_event->build_id_fault = err == -EFAULT;
-	}
-
 	perf_iterate_sb(perf_event_mmap_output,
 		       mmap_event,
 		       NULL);
-- 
2.31.1

