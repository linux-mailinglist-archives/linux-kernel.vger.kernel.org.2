Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57EC39387E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 00:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbhE0WCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 18:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbhE0WC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 18:02:28 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4925AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 15:00:55 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t21so651354plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 15:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W5Ra8gya7DQUEVO/jLAuK/07T8s5rUXgLTgiQgdaPvQ=;
        b=WQ+Dq0ITAQ95iONVaD3B+evt043QWKTqUAwXjyoOq2sOQ+T/TxpiE4a2Q6hdtlyycE
         2adXFmW2ucUhNWj7hZO5fOpV4RQ0PmE0X7pf1WhZybFr2OqDqjAF8eXAem+7nYFt0kGn
         klegAab9A83L1NQMD+04uwMqBLjmLcMhmW9DaHhA6le/vo3bk5WBnImycgsGiffEwVyd
         QOTv/vq3Ipnt5WPtp8r+fzNOs3LFbSyKk+4GR06CBV4ucVKxw+9CluagIr0lgznZ+S1i
         AfaPchq87wQFzyvh3kAhd2xL4yCSyP90VvzLfaKGkFg7rqw013/uUPibIgsbHQwKJtLG
         VAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=W5Ra8gya7DQUEVO/jLAuK/07T8s5rUXgLTgiQgdaPvQ=;
        b=n9PeA7TKctF7OWfmZ2et3NX0w/B9AphVu3rJFM3Z+weBS4YL32yAdoaeEETbF9stdX
         ZznhVw1Cv2DU5KXmJ0VibVhuEULPjMTVo4GDRlY4y2ZwbrX0iAQhuCR5RkK74BWaTCpV
         QmPr6oHMUXujxOnuQKnIUS6ETYLpA1kjtxGSjSC7Z39rgcbSiz72crHTv/YLBur+mAqq
         v1JgQHda36zOEgNm05xCHxp1Dhm3aOQzl+TlqYsy9XfA1VRgNDwxKwptlSFRpCGxRhLN
         t9WVnOr61BnXRIMxot46Q7HqYR0lNs/IGVjTVuGr1NfPZiLdEQImGdQxFuFe86O7ns64
         Cx0A==
X-Gm-Message-State: AOAM533X95MZ5ON0qPoH2eHSKoXiLUe9sGV2bz9p33oaHimxp6K20vCY
        DPqftG5zIV9gLLj7vNdziAA=
X-Google-Smtp-Source: ABdhPJwuR4W8/uaq51UAKDYCNpK2TkIIUg4DDOIQaWwT/38W70EDweyguc9Wlh8PUdovQiUvcy3I7g==
X-Received: by 2002:a17:90a:ca85:: with SMTP id y5mr746307pjt.140.1622152854866;
        Thu, 27 May 2021 15:00:54 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:69c7:536f:96be:7229])
        by smtp.gmail.com with ESMTPSA id o27sm2613544pgb.70.2021.05.27.15.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 15:00:54 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH] perf stat: Fix error check for bpf_program__attach
Date:   Thu, 27 May 2021 15:00:52 -0700
Message-Id: <20210527220052.1657578-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the bpf_program__attach() returns a negative error code
instead of a NULL pointer in case of error.

Fixes: 7fac83aaf2ee ("perf stat: Introduce 'bperf' to share hardware PMCs with BPF")
Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_counter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index ddb52f748c8e..974f10e356f0 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -451,10 +451,10 @@ static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
 		goto out;
 	}
 
-	err = -1;
 	link = bpf_program__attach(skel->progs.on_switch);
-	if (!link) {
+	if (IS_ERR(link)) {
 		pr_err("Failed to attach leader program\n");
+		err = PTR_ERR(link);
 		goto out;
 	}
 
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

