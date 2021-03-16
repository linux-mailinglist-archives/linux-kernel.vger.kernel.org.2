Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65AF33CAE0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 02:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhCPBZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 21:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbhCPBZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 21:25:20 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBB1C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 18:25:20 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so506865pjh.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 18:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Undm6DN4bz9JznMBV7wenQxTrxS4EoxINCTGYg1PmRk=;
        b=FWGt82CoxTqZKXOV+So5rYJH0qfzY1uKaLV57wujnAp3ojMv684aWJnJzkCqLs/s+4
         87pOvumcA33t2Rwy8yOgXN4755Zv0bfWPCmk1rWf4QOGcyuvo0M9DHx3r4qNJdBXLsEn
         brCjzwACz6mrPSN1HPf2AXokV9fwewXB36TRPcO7cfvrOT1XmqOzr78e9NcJJlj8NTDC
         uCAYuqcth0gKLrWMqFF1HKYWwDQjJGOTrxwxEwQqvLjlmVkqv12r0JXwrNncVXk4U817
         PDKb2hq7rJYVMckbIuTLod4XwZSogcMPEHLRLyiY0B8HSNo8Kv2O8O2VGD4amxuz86Fq
         Htpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Undm6DN4bz9JznMBV7wenQxTrxS4EoxINCTGYg1PmRk=;
        b=obfnchqJzEvuRrn55vH6NmT7dYYvCsxnICVnDIo4nY9RBlRT8FAW/daDd2417nIPvU
         Uq/z8GnRcVO3bOZ9XIALEMiRqFvc2QrpHu9NND/qNXT7C71DBM0H2Kz+FFi0UO0fjDgF
         xETyHOirN4JzCSoLHbY9GPAQ+W8I0bCCeM2Gfbi70rPiO/GcLNkTgfbJTigHL0KqHkDH
         Jm1xlQ0TrzkYOWeFYW0k880pl4aQSNqQXLBQI8b5WWq70lItvARqghPzVpA4RX3l1ewa
         1xa+kxbLOnlHGmJLe5CaXwySEaxkZDs2TXVW+NTHCeSSziwaqRHqRftP5Qyy18lPBu0Q
         ju9A==
X-Gm-Message-State: AOAM530ecporYxnoI2CdoMV4lZVaQrsxylsrmkMXkiUgsLHggc7832wB
        6TWdlSw20PfyklNLs4PgiJSVx4sS95Q=
X-Google-Smtp-Source: ABdhPJwhlJOA6YgEKdyzL+qr3K44q2zZg9Fuz+cmJSad8QNmvdNHSNpcUByTOmEgPTZ9w8CycLz5CA==
X-Received: by 2002:a17:902:7889:b029:e6:b9c3:bc0d with SMTP id q9-20020a1709027889b02900e6b9c3bc0dmr4600232pll.23.1615857919921;
        Mon, 15 Mar 2021 18:25:19 -0700 (PDT)
Received: from localhost.localdomain (23.83.224.125.16clouds.com. [23.83.224.125])
        by smtp.gmail.com with ESMTPSA id y24sm14481600pfn.213.2021.03.15.18.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 18:25:19 -0700 (PDT)
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
Subject: [PATCH v4] perf tools: perf_event_paranoid and kptr_restrict may crash on 'perf top'
Date:   Tue, 16 Mar 2021 09:24:53 +0800
Message-Id: <20210316012453.1156-1-liuyun01@kylinos.cn>
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

v3->v4:
Fix memory leaks in more places

v2->v3:
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
 tools/perf/util/bpf-event.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 57d58c81a5f8..cdecda1ddd36 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -196,25 +196,32 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 	}
 
 	if (info_linear->info_len < offsetof(struct bpf_prog_info, prog_tags)) {
+		free(info_linear);
 		pr_debug("%s: the kernel is too old, aborting\n", __func__);
 		return -2;
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
 		/* btf func info number should be same as sub_prog_cnt */
 		if (sub_prog_cnt != info->nr_func_info) {
 			pr_debug("%s: mismatch in BPF sub program count and BTF function info count, aborting\n", __func__);
-			err = -1;
-			goto out;
+			free(info_linear);
+			return -1;
 		}
 		if (btf__get_from_id(info->btf_id, &btf)) {
 			pr_debug("%s: failed to get BTF of id %u, aborting\n", __func__, info->btf_id);
-- 
2.25.1

