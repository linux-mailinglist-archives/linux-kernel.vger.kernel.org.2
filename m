Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8453B094C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbhFVPmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:42:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55236 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232051AbhFVPlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624376374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ysfsv8h5v9t/4/segUsBxbWl85Eh2nMCyITuBj3+NA=;
        b=Ryux/8cZqx7YOzPwxyRhCoD1MkJOWIvLM5M10kfw/8iGx3S8vXJcvu/6ic0FV/VSEKbH4D
        +k0pl2LLHviqG5oL0fwgBdhgCTMCNzg7z92j/ihZunCDlkrfotXsvRqUequqYFie3Yan54
        291oD2x18IeLl1nbzFhegqLpAhki1AM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-wqyjl9zmN_-NrYm68sfdVg-1; Tue, 22 Jun 2021 11:39:33 -0400
X-MC-Unique: wqyjl9zmN_-NrYm68sfdVg-1
Received: by mail-wm1-f70.google.com with SMTP id g14-20020a05600c4eceb02901b609849650so855638wmq.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ysfsv8h5v9t/4/segUsBxbWl85Eh2nMCyITuBj3+NA=;
        b=c6/B77WcGW6utmP5R5h9EArI+Q0DSdptUkZJrWVYhiOj4EZZmzV8/W3AV7ypAbEhov
         wMGx5D5VEtB6kw5IHm/66Wme96V34AGvgqCjlYlOJL4kAPDAxojqNOgw+28IEldmDfve
         9saTAigDluHhVVN3O1SUEBkkECpisXVH4qcrm39IiHj1FNH7LwvOHUiCFNWOp17WzaMO
         OTunzrQHbGb1drknEeBw53oah+GJKViGwPzWzjZW8pdj5/6HG4BKrssf4Oqs/2cYMo9/
         xZrxRYRP+zVTvMCUVnR6U9xTGcp6c4M2NZEJx1nCtJonDLcdpuedUznWsWVbmism/ahi
         rKFw==
X-Gm-Message-State: AOAM530UX6nmnK5XM2yhW2JANYuanwpo0KHcKKBpANOXSEq5i6MyJnEg
        C/Ecqx13vraCVzD1JJLA2T8YzVatY4AjifrbgeqOD+1wY1yuKNLrUjmKYLwKeVSjdDm3zcd6CFg
        Cnp8W9CSihz1pI4ApUqEx3KwB
X-Received: by 2002:a5d:698a:: with SMTP id g10mr5430829wru.129.1624376372164;
        Tue, 22 Jun 2021 08:39:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWJIK37T6/RU6Gcg6cAXE2UHiTJh0UN/A4QNHZ4TX3H4nvf4Wvi//AX8SBay6sWOcuw616EA==
X-Received: by 2002:a5d:698a:: with SMTP id g10mr5430816wru.129.1624376372048;
        Tue, 22 Jun 2021 08:39:32 -0700 (PDT)
Received: from krava.redhat.com ([5.171.243.0])
        by smtp.gmail.com with ESMTPSA id e3sm11647962wro.26.2021.06.22.08.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 08:39:31 -0700 (PDT)
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
Subject: [PATCH 05/10] tools: Sync perf_event.h uapi
Date:   Tue, 22 Jun 2021 17:39:13 +0200
Message-Id: <20210622153918.688500-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622153918.688500-1-jolsa@kernel.org>
References: <20210622153918.688500-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update tools uapi headers with latest changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/include/uapi/linux/perf_event.h | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index f92880a15645..e742c8f43a18 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -296,16 +296,20 @@ enum {
  *
  * struct read_format {
  *	{ u64		value;
- *	  { u64		time_enabled; } && PERF_FORMAT_TOTAL_TIME_ENABLED
- *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
- *	  { u64		id;           } && PERF_FORMAT_ID
+ *	  { u64		time_enabled;    } && PERF_FORMAT_TOTAL_TIME_ENABLED
+ *	  { u64		time_running;    } && PERF_FORMAT_TOTAL_TIME_RUNNING
+ *	  { u64		id;              } && PERF_FORMAT_ID
+ *	  { u64		build_id_faults; } && PERF_FORMAT_BUILD_ID_FAULTS
+ *	  { u64		lost;            } && PERF_FORMAT_LOST
  *	} && !PERF_FORMAT_GROUP
  *
  *	{ u64		nr;
- *	  { u64		time_enabled; } && PERF_FORMAT_TOTAL_TIME_ENABLED
- *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
+ *	  { u64		time_enabled;    } && PERF_FORMAT_TOTAL_TIME_ENABLED
+ *	  { u64		time_running;    } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		value;
- *	    { u64	id;           } && PERF_FORMAT_ID
+ *	    { u64	id;              } && PERF_FORMAT_ID
+ *	    { u64	build_id_faults; } && PERF_FORMAT_BUILD_ID_FAULTS
+ *	    { u64	lost;            } && PERF_FORMAT_LOST
  *	  }		cntr[nr];
  *	} && PERF_FORMAT_GROUP
  * };
@@ -315,8 +319,10 @@ enum perf_event_read_format {
 	PERF_FORMAT_TOTAL_TIME_RUNNING		= 1U << 1,
 	PERF_FORMAT_ID				= 1U << 2,
 	PERF_FORMAT_GROUP			= 1U << 3,
+	PERF_FORMAT_BUILD_ID_FAULTS		= 1U << 4,
+	PERF_FORMAT_LOST			= 1U << 5,
 
-	PERF_FORMAT_MAX = 1U << 4,		/* non-ABI */
+	PERF_FORMAT_MAX = 1U << 6,		/* non-ABI */
 };
 
 #define PERF_ATTR_SIZE_VER0	64	/* sizeof first published struct */
-- 
2.31.1

