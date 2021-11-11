Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D0344D374
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbhKKIyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbhKKIy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:54:29 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7860C06120E
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:51:40 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id d9-20020a251d09000000b005c208092922so8329998ybd.20
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ROxxM6hHcra/j8EsLM3cl2SjDYqC0tvSML/WqoheuOk=;
        b=RUnAfWfAsP4ozJNxRBemZzGQAE8+QVwRPg6ZyJlYni8l1/gNm+PlSupz95DtfoPV1b
         1zKsRBjSSdAlR0rU6lEOEz1A9kUpOnh9aX51ImHRKrARPql7QfkChc/UDWinedRhFSsk
         UWRakXGmKEJdwjgA18sCOop7as2Z0lCJqpVfXRJYgf+vMgzcr/5Sjg2F452ig855X+/R
         7BDgfgSIn5Qf4SYt4+RVq9Q8oO92vSfJD5tgavnpD9u5/CzWtaskdFt6JrDhyrq46Ojd
         czTUmo5H+OuTJvOratKO/c2Vq/bA2ZulTvPG6a1miCay6/NEHzOQm8uHJoB413+cYLqC
         iP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ROxxM6hHcra/j8EsLM3cl2SjDYqC0tvSML/WqoheuOk=;
        b=HHM04S/AFKSIptk67kdsU7yeOV+s4YLGntstIxlHgiBX6T8cwz5DbYMXIJLjhO3oV0
         KoqB2OEbJ0y2FwOmKxMieHiitBe2Q7dtj+G5JuRVWIWQ7ATbpmxzzk616OPKtMF0cAEm
         UFi6+ceSWRqH0tzscnmQA0oEmrKUW7n6oTuS29ePIK5rBXq0N0/pMr854ogsTCBK188O
         AEI4xtbfzkCbUhxjwr7rQyYqQj6Sc1W8m5siKtHxtttMfKaEyvINGRd3N9N0SRgkuWqm
         oeM04aAQS9bC0U3VtXcs+x8RxBf0UY94hymbCVHW/UxMR9/MxLBbO5W0tMHZ/+8tJ37R
         s4nA==
X-Gm-Message-State: AOAM533IWndORwP598uKYYErJ037rfQGwqiHevdz/hxok5phNjt/Z6Zu
        GXloPrdEHdwuQqtVFJpqoGbi5yOXGbmLU8eNbDwat6J9/nClZMdCJLPsEkxzvHNkyJfH9sgedvL
        y30FhFjoB3VkrDpvA5AmgvsIPTcHBTSvqaiiEXpbCHdUwI+b29WPSuIx2C6zYC9XdmjFuaaOm
X-Google-Smtp-Source: ABdhPJzKPf5lKmQSoLbrFqGMwJdYaq4ubSmacNm6J7c7+FVzoy6Aa9xK8dMLs5SIEHNRA9o602eQ70XMS6Jt
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:cdfe:134b:9d27:6cbf])
 (user=eranian job=sendgmr) by 2002:a25:74c8:: with SMTP id
 p191mr6094325ybc.157.1636620699931; Thu, 11 Nov 2021 00:51:39 -0800 (PST)
Date:   Thu, 11 Nov 2021 00:44:13 -0800
In-Reply-To: <20211111084415.663951-1-eranian@google.com>
Message-Id: <20211111084415.663951-12-eranian@google.com>
Mime-Version: 1.0
References: <20211111084415.663951-1-eranian@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v2 11/13] perf tools: improve IBS error handling
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@amd.com>

This patch improves the error message returned on failed perf_event_open() on
AMD when using IBS.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
 tools/perf/util/evsel.c | 42 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbfeceb2546c..1b24b3000d66 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2743,12 +2743,52 @@ static bool find_process(const char *name)
 	return ret ? false : true;
 }
 
+static bool is_amd;
+
+static char *fgrep(FILE *inf, const char *str)
+{
+	char line[256];
+	int slen = strlen(str);
+
+	while (!feof(inf)) {
+		if (!fgets(line, 256, inf))
+			break;
+		if (strncmp(line, str, slen))
+			continue;
+
+		return strdup(line);
+	}
+
+	return NULL;
+}
+
+static void detect_amd(void)
+{
+	FILE *inf = fopen("/proc/cpuinfo", "r");
+	char *res;
+
+	if (!inf)
+		return;
+
+	res = fgrep(inf, "vendor_id");
+
+	if (res) {
+		char *s = strchr(res, ':');
+
+		is_amd = s && !strcmp(s, ": AuthenticAMD\n");
+		free(res);
+	}
+	fclose(inf);
+}
+
 int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			 int err, char *msg, size_t size)
 {
 	char sbuf[STRERR_BUFSIZE];
 	int printed = 0, enforced = 0;
 
+	detect_amd();
+
 	switch (err) {
 	case EPERM:
 	case EACCES:
@@ -2841,6 +2881,8 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size, "wrong clockid (%d).", clockid);
 		if (perf_missing_features.aux_output)
 			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
+		if (is_amd && (evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name, "ibs", 3)) && (evsel->core.attr.exclude_kernel))
+			return scnprintf(msg, size, "AMD IBS can't exclude kernel events.  Try running at a higher privilege level.");
 		break;
 	case ENODATA:
 		return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
-- 
2.34.0.rc0.344.g81b53c2807-goog

