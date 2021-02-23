Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58F73225E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 07:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhBWG3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 01:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhBWGZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 01:25:46 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03B5C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 22:25:05 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id p21so11734111pgl.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 22:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FF4oGW4VLyqPGJBiGHDxEnKNgYMMV0mhj/Id5vPb+mI=;
        b=GuL0tixNE6M85E/xu57WaK4rdMUEYIrvVx7g8dvQPTTTMjdDehSmFnmIgdBpYJxxWq
         nyzC5v8isEzqMDAVoYKFtiIm6gAQ93UIyq8triMniYjIDggixbj+JdeB754HEgQQFGFH
         xNjFZcUecfTma0zy9IzB4hM84j2BAiMT2Dv4AiPgvPQU5RwtVI/LE5+LMvf0ODPsli+C
         oq/+AzRUgVAXSK8Jph6meVZaWITWWoFXi03SXo67kfw1VjmooaJk91O9PIow3jI2Fw/4
         Q2ORrk0Q3V9kXq+pD4EGt+gksDkTdtKjkfHviQtyRG/ENlDNS2KwyGWJlU5VIM39uPS+
         X5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FF4oGW4VLyqPGJBiGHDxEnKNgYMMV0mhj/Id5vPb+mI=;
        b=jpOVV9CZdK86PJNZOSwBpbL7CrHzEbGcFCgR6nIfNwYHdJlgvMnw6mP9SnwqeZ8QuE
         Sik7YMKnBqygbAtQqHJ66T7byMCO4K5JI5L1M7HdPcnq3KP+4MrFlI54r3LrA4Iu78Fj
         /sLaLJRFFYCsztSmBzIUGm8DR9klQ5aCKNoWYuVEo9c/K7dYcv3x1+rHuA2y8DpjHoki
         jVVT2VDpLKfXtBXPGqP8VYTkKn8yx5kDpBrZjTzMNPFKF2xX3O7zTa/mD6ZC1sQtLYw3
         c4IDZdgoEBKCoOqEJdZhcNOXlgd2TAgJ1sd1iVI+s5ZJeHY6TX13/tTDaYjyJmvPZfmf
         Xs0A==
X-Gm-Message-State: AOAM532vvxaWgQ3PfOwfdBv/lw7fAh2+fycuFTiX2VzMa95ZYn8MQm27
        1ZEj2DKoZ0RjctoxCIk8tyFi6WQ7Xgym2Kxr
X-Google-Smtp-Source: ABdhPJxDUcpFOhsYM9HAbqz8hjUBNcg8zUsvx+tLTfj6sBt3huMHg1l7MUOZsdfKVgF/kyLHq6sbZA==
X-Received: by 2002:a62:8606:0:b029:1ed:55db:22b7 with SMTP id x6-20020a6286060000b02901ed55db22b7mr16925133pfd.75.1614061505144;
        Mon, 22 Feb 2021 22:25:05 -0800 (PST)
Received: from localhost.localdomain (23.83.224.141.16clouds.com. [23.83.224.141])
        by smtp.gmail.com with ESMTPSA id h11sm1550456pjc.27.2021.02.22.22.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 22:25:04 -0800 (PST)
From:   Jackie Liu <jackieliu2113@gmail.com>
X-Google-Original-From: Jackie Liu <liuyun01@kylinos.cn>
To:     linux-kernel@vger.kernel.org
Cc:     Jackie Liu <liuyun01@kylinos.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] perf tools: check perf_event_paranoid and kptr_restrict on 'perf top'
Date:   Tue, 23 Feb 2021 14:24:40 +0800
Message-Id: <20210223062440.15848-1-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf top will segfault, we should give prompt information like perf
record instead of crashing directly.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 tools/perf/builtin-top.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 3673c04d16b6..b257fadba3bd 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1239,6 +1239,14 @@ static int __cmd_top(struct perf_top *top)
 			return ret;
 	}
 
+	if (symbol_conf.kptr_restrict && !evlist__exclude_kernel(top->evlist)) {
+		pr_warning(
+"Kernel address maps (/proc/{kallsyms,modules}) are restricted.\n\n"
+"Check /proc/sys/kernel/kptr_restrict and /proc/sys/kernel/perf_event_paranoid.\n\n"
+"Kernel samples will not be resolved.\n");
+		return -1;
+	}
+
 	ret = callchain_param__setup_sample_type(&callchain_param);
 	if (ret)
 		return ret;
-- 
2.25.1

