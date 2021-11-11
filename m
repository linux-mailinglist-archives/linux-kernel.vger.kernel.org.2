Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8806B44D376
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbhKKIy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbhKKIyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:54:31 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1411BC061210
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:51:43 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id m78-20020a252651000000b005c1f44d3c7bso8255957ybm.22
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jX5+E5W3OZvA78QqpGYLI/MNCikhypEUJfT06Bfe2cM=;
        b=NvVxkrq+s7JWQoRxCLSxwHpgk6gJI9MdeJh939TE8jFLK8oueUGzR5hgJaDa47VkGn
         arqLgRhI4BobDLtu1tANmqSpoqqvmsqTubqkXa8x5gLjgR1/fvOUVpl2VkIDUggHPdP/
         xfpXXNVFTr/cjg5YgFekdfqXjXDdb3g6zYRnGPbzM4XFcDdYtPnZY2eNzE7T4JnZzz+O
         73R0JLU6uVHQxBeqv9a5qqCHspLbJwNWXGleJF95cq6v6v+e8m/Xy4gNlFzs/Y7QQvkU
         GsMh9dCDfH+IMcXkgYdT393tvMBF4VdSL3GLTkayrTEFW++VPsE/frDlx0BKdr8wxPkt
         fLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jX5+E5W3OZvA78QqpGYLI/MNCikhypEUJfT06Bfe2cM=;
        b=Ltjleijnwo1JIGzeyf9+kAPVv+bzF6KZ8N60P0ai3x4hihE3/aBba1eMqyfZ83gM7K
         YZLbGcjOY0U2LDt5m8VKSYmyrdObEnpumCBFld4K/1411q1OZ5I9hn3NXX508qgyuu4e
         knKhmNDvvcUUnTEGWlE7lX0J9t0o/9ZafHIh69spp2lgK4e3wounuVChebg8ZHis49Cs
         86Y3gIbhQ4g9+fNHEosPpduS/FSDr4zDo8AaEmyF1bp9RCmMJhiiCajLGFUeZH+gQA6e
         QTgsgk7qoEToO/YnG0LRGnh9yEDnlYlWR4B2kPzNA/RBZpeYBHrxcLT8PXCiNK+bjn0O
         umZw==
X-Gm-Message-State: AOAM532elZsjCCFz9u9TJkOhNLBw/negx3e1vg1/6zJkFwoSfO0TjaOx
        bNk8PBOEoYdN2t7gC3tRTw1VXwDKFOjB+mPpBWpAS0pKcTfQj7kAvyZnHUFIoKzGoejExOgoCcC
        hyI/dGRYGIOb+JRsQmg+PQcooKc/aV7UEmTOgnSJ2EPa+om41/L5aOxN7gA2cVsyrc3qrqPe7
X-Google-Smtp-Source: ABdhPJxe1Ksez3bvH7jGVgFT9OOG48XTPqV1/H6XZxX0DFP/TzlgUcCHCDCQSKX9MeSvvLlYTef1nZhRhYay
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:cdfe:134b:9d27:6cbf])
 (user=eranian job=sendgmr) by 2002:a25:bb0b:: with SMTP id
 z11mr6569346ybg.108.1636620702185; Thu, 11 Nov 2021 00:51:42 -0800 (PST)
Date:   Thu, 11 Nov 2021 00:44:14 -0800
In-Reply-To: <20211111084415.663951-1-eranian@google.com>
Message-Id: <20211111084415.663951-13-eranian@google.com>
Mime-Version: 1.0
References: <20211111084415.663951-1-eranian@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v2 12/13] perf tools: improve error handling of AMD Branch Sampling
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch improves the error message printed by perf when perf_event_open()
fails on AMD Zen3 when using the branch sampling feature. In the case of
EINVAL, there are two main reasons: frequency mode or period is smaller than
the depth of the branch sampling buffer (16). The patch checks the parameters
of the call and tries to print a relevant message to explain the error:

$ perf record -b -e cpu/branch-brs/ -c 10 ls Error: AMD Branch Sampling does
not support sampling period smaller than what is reported in
/sys/devices/cpu/caps/branches.

$ perf record -b -e cpu/branch-brs/ ls Error: AMD Branch Sampling does not
support frequency mode sampling, must pass a fixed sampling period via -c
option or cpu/branch-brs,period=xxxx/.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 tools/perf/util/evsel.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1b24b3000d66..11aa6c28a9e4 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2883,6 +2883,14 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
 		if (is_amd && (evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name, "ibs", 3)) && (evsel->core.attr.exclude_kernel))
 			return scnprintf(msg, size, "AMD IBS can't exclude kernel events.  Try running at a higher privilege level.");
+
+		if (is_amd && ((evsel->core.attr.config & 0xff) == 0xc4) && (evsel->core.attr.sample_type & PERF_SAMPLE_BRANCH_STACK)) {
+			if (evsel->core.attr.freq)
+				return scnprintf(msg, size, "AMD Branch Sampling does not support frequency mode sampling, must pass a fixed sampling period via -c option or cpu/branch-brs,period=xxxx/.");
+			/* another reason is that the period is too small */
+			return scnprintf(msg, size, "AMD Branch Sampling does not support sampling period smaller than what is reported in /sys/devices/cpu/caps/branches.");
+		}
+
 		break;
 	case ENODATA:
 		return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
-- 
2.34.0.rc0.344.g81b53c2807-goog

