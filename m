Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4504339C50
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 07:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhCMGDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 01:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhCMGDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 01:03:11 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3931C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 22:03:10 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id a8so6389561plp.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 22:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pFMGV7Zh8AJYaCXyeddMO2M34LbN4NgzHr/xv0PeInI=;
        b=J36nER57FJsGE7qJ/S+klcms0rZ0Kow2nbDQKdOeDMn9J0kBp/dsisfTBN7NMfu9IN
         kdCgp1wTWhrKezPr1Xn2JRT9w7inK4xAchNabGGxxFs+2CEth+xyBrCl1C8Z/R+ba6xe
         S3HTTxBa/FGph0HsdGpUhUObvt/dSqtA94tmDk0T2wERTLgvVaNFE+IlSLFsMSXfSwVd
         nF6RdCAmh07Yw/vp2CgR6MTSPwa8/TDWeDhSOB0D8khDgHMQPgt0OZBhBsPHwoM7r0ZF
         xp4KoA7zie+VuKKXmbSH8gG4xydNaImHurMJfw1NRXonEX694LD3WdsK6UlnbbaKnrmm
         iTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pFMGV7Zh8AJYaCXyeddMO2M34LbN4NgzHr/xv0PeInI=;
        b=LmX2wjvD1uWodBlx6BjP4bCqAb2H1TC9H1JT3sYyHxm60X2a2YIIQlgUEMuFjvfd4j
         egxYHmBWa5DAHqdM0tOHTFzkv35HgfBGS2C8leHMJr+wmqK3S/t56Mlx5Ljran5Y0Ejr
         QHKk6IZML6Q5j1d1ak+8CNWJX1WuqGBDLKKEWnXmRfEG8gUla2KbtcifsQnttMYSX3Se
         pZyCmT7/SxguwJBEkrtsR2+rQntsfDzCVEGYa0LXn6CgmhWnlJUX19X0DqO4AKxhCFDl
         hRa+m0RYcmZVospm810WC9AYDLDJ/Yp9Al5xkvQKDFphLo13zKqqIMO+N+w4rjdV/jJb
         pCqQ==
X-Gm-Message-State: AOAM531onDgpJQwOI3ImcHaMwPRCMxjHDYZh+zJZJ+LEVBFSi1DN3bXF
        iEJfDcoYeF+ZE8BeHNH+xSU=
X-Google-Smtp-Source: ABdhPJz0Ha2g+LSr44rgA1mChWMaxRlIJLd6okJT5YPH0wPHYxOM/4I8RjlW6b6oJjmnlrPtJsyu3Q==
X-Received: by 2002:a17:902:8d86:b029:e6:45a0:b16e with SMTP id v6-20020a1709028d86b02900e645a0b16emr2000765plo.34.1615615389433;
        Fri, 12 Mar 2021 22:03:09 -0800 (PST)
Received: from localhost.localdomain (23.83.224.125.16clouds.com. [23.83.224.125])
        by smtp.gmail.com with ESMTPSA id x4sm6908651pfn.134.2021.03.12.22.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 22:03:09 -0800 (PST)
From:   Jackie Liu <jackieliu2113@gmail.com>
X-Google-Original-From: Jackie Liu <liuyun01@kylinos.cn>
To:     jolsa@redhat.com, linux-kernel@vger.kernel.org
Cc:     Jackie Liu <liuyun01@kylinos.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v3] perf tools: perf_event_paranoid and kptr_restrict may crash on 'perf top'
Date:   Sat, 13 Mar 2021 14:02:46 +0800
Message-Id: <20210313060246.37116-1-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After install the libelf-dev package and compiling perf, kptr_restrict=2
and perf_event_paranoid=3 will cause perf top to crash, because the
value of /proc/kallsyms cannot be obtained, which leads to
info->jited_ksyms == NULL. In order to solve this problem, Add a
judgment before use.

V2->V3:
free info_linear memory and move code above, don't do those extra btf
checks.

Suggested-by: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 tools/perf/util/bpf-event.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 57d58c81a5f8..3c03c782bac6 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -201,12 +201,18 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 	}
 
 	info = &info_linear->info;
+	if (!info->jited_ksyms) {
+		free(info_linear);
+		return -1;
+	}
 
 	/* number of ksyms, func_lengths, and tags should match */
 	sub_prog_cnt = info->nr_jited_ksyms;
 	if (sub_prog_cnt != info->nr_prog_tags ||
-	    sub_prog_cnt != info->nr_jited_func_lens)
+	    sub_prog_cnt != info->nr_jited_func_lens) {
+		free(info_linear);
 		return -1;
+	}
 
 	/* check BTF func info support */
 	if (info->btf_id && info->nr_func_info && info->func_info_rec_size) {
-- 
2.25.1

