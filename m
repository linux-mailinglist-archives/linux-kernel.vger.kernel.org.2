Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62802459CEC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 08:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhKWHnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 02:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbhKWHnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 02:43:35 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42653C061714
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 23:40:28 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so2162198pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 23:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FU4j7ZlW6s0/nGNFeH/VOntHKSj0jmqQdIuYJuwkE3A=;
        b=wP8pX2CpvAPqPF9+rOUVpFM7ULqIwCJm/X5t7Q3zkcmaxxeIadq+QMZX7yRlAARi0B
         kw4r0VjRHfpXjXXuHyCCrkXXg7UMU5pdq2Y1aMEdfoQ/YPqCoEqzkwLxZA5OE/+xFoDM
         1UJF/PPPw8e/hfnmNdUdLEGoxfBgTHWmr+f2HZ1wYu1uj2nQLbA2do4DfJWzPFEtj9Ry
         JXSI1YPeiQPj9ezJXlD7rlA1Njb7LuPQ4caF6bgpHAn8sx9KFFDi7lwAlJ1Chy4T19JR
         NwAPvASpqxe/nGhCBskKqfvmfjNi4eff2MiibxLOmRSIOd2Xzki25bRuX7HluFCuy06F
         iLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FU4j7ZlW6s0/nGNFeH/VOntHKSj0jmqQdIuYJuwkE3A=;
        b=v2+Rqt1FKn60+LPh14zac5k6hGbme03531R0METjZXoe5X5aStvnX7sUZOEczxUzDB
         kpevZRqwmhLTKG/GLXW9tVuUj6a4W6F29oVlR90bskYXmk9HdF8Qg2qo4pCe+NHKnRve
         jAkGBLYxf/bmOWanFFXq/B0Z+GN0MVqnEokEZcIOgyzrlmBN9LcXyVVzsFCbyiVCQn8f
         yNGUj+JNeWQoKzmevIsZooXiVjdN59QgR2pVipn1Q5SNG3iDTSlSIptpAPEq3fa07YMg
         ylC137nACoy1mzJEQzgqq7JfSqVfNPm/EJCvezD5HuwlCQB6fPk8YkU9DHRXTj7rpnmP
         2Geg==
X-Gm-Message-State: AOAM530eLEJPXuy3lrFQNquHTFpg0CILlmejRYUgOtwKVBR9WrnusYda
        VWh0MqjzRMSebCmiPFh7Ob2hJg==
X-Google-Smtp-Source: ABdhPJxJQR5+gJtyytn8psebfqeWNFGRV+cTz5QPO7eM2tur3R8qIRQsK17dJc7tL0YUxgEXFGnKcg==
X-Received: by 2002:a17:90b:e83:: with SMTP id fv3mr453378pjb.115.1637653227844;
        Mon, 22 Nov 2021 23:40:27 -0800 (PST)
Received: from C02FT5A6MD6R.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id q32sm310086pja.4.2021.11.22.23.40.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Nov 2021 23:40:27 -0800 (PST)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Gang Li <ligang.bdlg@bytedance.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] perf trace: Enable ignore_missing_thread for trace
Date:   Tue, 23 Nov 2021 15:40:17 +0800
Message-Id: <20211123074018.11406-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf already support ignore_missing_thread for -u/-p, but not yet
applied to `perf trace`. This patch enable ignore_missing_thread
for `perf trace`.

ref:
Link: http://lkml.kernel.org/r/1481538943-21874-6-git-send-email-jolsa@kernel.org
Link: http://lkml.kernel.org/r/1513148513-6974-1-git-send-email-zhangmengting@huawei.com
Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
 tools/perf/builtin-trace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0b52e08e558e..94d62a92f1a1 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3950,6 +3950,9 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		evlist__add(evlist, pgfault_min);
 	}
 
+	/* Enable ignoring missing threads when -u/-p option is defined. */
+	trace->opts.ignore_missing_thread = trace->opts.target.uid != UINT_MAX || trace->opts.target.pid;
+
 	if (trace->sched &&
 	    evlist__add_newtp(evlist, "sched", "sched_stat_runtime", trace__sched_stat_runtime))
 		goto out_error_sched_stat_runtime;
-- 
2.20.1

