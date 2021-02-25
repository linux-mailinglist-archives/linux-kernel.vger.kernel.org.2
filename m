Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75320324A86
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 07:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhBYG0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 01:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhBYG00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 01:26:26 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C4EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 22:25:45 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id f8so2640419plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 22:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jUl0X4/P+gDwOLsjnjP1daXem7WzbtA+cYgNfshPHwo=;
        b=OoIzUr81AFJS/VO8GxBnTClOPbPiCiJXFQ2O/H7hCqkoiN0Xj6Sgq6+nJS8rzKTR+j
         3caj7QeCm2CpBcLLbWLjdZsEbi5YhnQwMGuhHjYLTYGLIVqvbeovsGWH0XzcspJrh61C
         xuMXLnKC4kLFqrlLsrbHTj6EqUbJqY0c1gzFVuUqbOIafDPva0IDhv+pgx9FdTkmeBCt
         ZqNEj1Ybw857P0Ua9Qwg19/n/m6R4ZJfGFLvqyUkhiOyMLryFJoqgN/wj94nhgAFYu4h
         Fryat3eOLMhC1Bjx6mAyVKVEQ4mINt+Ykae1m8le+DhHgc2R9fgNJC9yKp2xN85n8aE0
         i33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jUl0X4/P+gDwOLsjnjP1daXem7WzbtA+cYgNfshPHwo=;
        b=Q+z9/fvKfY3GJmFgoltkSgRUCuek6yBwlSAeLu2RkV9wJXjQJ8AGZN1AiwqaCMLqoK
         yKG4JylCgOSJylBwghetyj1VGOnXxj2Lr+ZZpV9xN4ug7tIDR+iiLm+PopfDuh5S51v6
         n4X6fHPQ1p4KywPfxmFPAbudUHMl/ptA/xPZ8k3ZpnOsbxZxLrMbZ+P4ertyzEQ1Q5q9
         w71lz0TwEcpLA4aYz/jGlzuzgokEfaYmkWc8FCQkp7NSVfcT/NOArbKTZsdeqes8wMk1
         uKtx+o17vflTa6z3fLhdt0zB20Tbd+SUVBjZ3B4mIVMHvIJzD/auM3G2FJXAzlwAYeL4
         sdQg==
X-Gm-Message-State: AOAM533Gzg/hvF5t/dryU83hjaPzrsxCu52cafaM5ncQ0iyVeyXF7BN9
        ATkxMwiNqwyqSz8LJfVIkoXzZwOZRDAaaw==
X-Google-Smtp-Source: ABdhPJyKueX7VliWYqq4CrNdFywLJ2z+X7EMwzaQiIIir7AWKQw9ixnpJVWQxa5VLj+B0vtoNxP6jw==
X-Received: by 2002:a17:903:181:b029:df:c7e5:8e39 with SMTP id z1-20020a1709030181b02900dfc7e58e39mr1819527plg.25.1614234344823;
        Wed, 24 Feb 2021 22:25:44 -0800 (PST)
Received: from localhost.localdomain (23.83.224.141.16clouds.com. [23.83.224.141])
        by smtp.gmail.com with ESMTPSA id y68sm5137276pgy.5.2021.02.24.22.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 22:25:44 -0800 (PST)
From:   Jackie Liu <jackieliu2113@gmail.com>
X-Google-Original-From: Jackie Liu <liuyun01@kylinos.cn>
To:     linux-kernel@vger.kernel.org
Cc:     Jackie Liu <liuyun01@kylinos.cn>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v2] perf tools: perf_event_paranoid and kptr_restrict may crash on 'perf top'
Date:   Thu, 25 Feb 2021 14:25:30 +0800
Message-Id: <20210225062530.25334-1-liuyun01@kylinos.cn>
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

Suggested-by: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 tools/perf/util/bpf-event.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 57d58c81a5f8..b1ce2d189d37 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -225,6 +225,11 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 		perf_env__fetch_btf(env, info->btf_id, btf);
 	}
 
+	if (!info->jited_ksyms) {
+		err = -1;
+		goto out;
+	}
+
 	/* Synthesize PERF_RECORD_KSYMBOL */
 	for (i = 0; i < sub_prog_cnt; i++) {
 		__u32 *prog_lens = (__u32 *)(uintptr_t)(info->jited_func_lens);
-- 
2.25.1

