Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF9C4046AA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 09:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhIIIAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 04:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbhIIIAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 04:00:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E95C0612A4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 00:59:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 124-20020a251182000000b005a027223ed9so1392797ybr.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 00:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dNgYyOEuwneISZy6bMS8spYpE0+tadrB7X64aczamSY=;
        b=FWXrXTigSElw4GFhEtzkhzC0bHl121mw1OhOmnEDLGekMkysv2m98A72j09VpN6Aef
         LR8zdwbOZ+J2zm1ezJnZxza2D6+9YY8G2puQK+uumEPMlZim2bbhGy1+HwKWoeS5yGSF
         KlLVwFuIZ6AlXR46MuFzm5CSXYhVG39uGudAzEXr8JGy9L2oidJiFNAkvpR4KUoeJ5Rh
         NVCabY9S/toVBT1Wn3YjkAlH519i4zhfdQOvnhTjAjfAM8k+hJyf7r9AXx+D2JoT/IGm
         rTXLDICDxbA/NchgfPWfYq64QvQKn7SV8Wk688gd25uXUN/uKXEawpKDLy6Q+S0DpXJ3
         +ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dNgYyOEuwneISZy6bMS8spYpE0+tadrB7X64aczamSY=;
        b=MLB+JH6BgLUcD2VIZjpDNAzC52WHVZzVT6+MM0ZVWb79B6I8OgkAOFhoU6hKertj40
         RXpL8t7Lj7Ncly8k0rQNoqQ6SOmcToSGeZhnnt2miKpgKc0Qs+0V6lHY6UDpqH6kOLQP
         01qhR5jdRFOaksgTuah3iXttZ4Dv0NfP1eJa/RbWbsuSwgkT4fjnoAjP3Ha3+5fArdOk
         WZIvM6zGX3Z1N8TS4w0yfIdcm/pRvtelutOl3n/9/9NzyL/731MU9LiUBGVe0mBcAIQ1
         tEBGiMMfGkfDlcaO1fxLsMlmDkHNgno7ZAprOnuDsT0SGj0+BAb0iwn+sebhppIjzWPy
         opzQ==
X-Gm-Message-State: AOAM531Yk8EYIF6xwNl+q1g1qs7/7cLJ9Dk1jAewv27C4I9wb+C6u7+P
        t/sLwniJ4+xv6AlVhIqY+k2dWO+uvwaat6ko0OHzgWSUFBwtql7/nkzY2bafDjtACcoTM9dgPmZ
        gTqSN0kNVvaDCwiwmfmVNgFsNAtHWdFOhOtUUd22QkM0c3Ejte4Y0W9hz9R7RrulbpszXdqhU
X-Google-Smtp-Source: ABdhPJzczq30DjAWyUjfROcgQh9gYK0iDSzcAH7bieYj2o2g1vClGVWdDUiKLejgiJLZUT1xR9274Ph7wtf7
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:f950:61f2:f1ec:ae8b])
 (user=eranian job=sendgmr) by 2002:a25:22c6:: with SMTP id
 i189mr2362195ybi.180.1631174346774; Thu, 09 Sep 2021 00:59:06 -0700 (PDT)
Date:   Thu,  9 Sep 2021 00:56:59 -0700
In-Reply-To: <20210909075700.4025355-1-eranian@google.com>
Message-Id: <20210909075700.4025355-13-eranian@google.com>
Mime-Version: 1.0
References: <20210909075700.4025355-1-eranian@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v1 12/13] perf tools: improve error handling of AMD Branch Sampling
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, acme@redhat.com, jolsa@redhat.com,
        kim.phillips@amd.com, namhyung@kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch improves the error message printed by perf when perf_event_open()
fails on AMD Zen3 when using the branch sampling feature. In the case of
EINVAL, there are two main reasons: frequency mode or period is smaller than
the depth of the branch sampling buffer (16). The patch checks the parameters
of the call and tries to print a relevant message to explain the error:

$ perf record -b -e cpu/branch-brs/ -c 10 ls
Error:
AMD Branch Sampling does not support sampling period smaller than what is reported in /sys/devices/cpu/caps/branches.

$ perf record -b -e cpu/branch-brs/ ls
Error:
AMD Branch Sampling does not support frequency mode sampling, must pass a fixed sampling period via -c option or cpu/branch-brs,period=xxxx/.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 tools/perf/util/evsel.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f203f178fdb9..8945f08f41b2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2824,6 +2824,14 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
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
2.33.0.153.gba50c8fa24-goog

