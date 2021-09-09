Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999214046A9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 09:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhIIIAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 04:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhIIIAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 04:00:14 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8A3C06175F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 00:59:05 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id p21-20020ac846150000b02902982d999bfbso2698944qtn.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 00:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=f5cBwH7kdw31CIR5J62DosBSFttoc1nOdgtRXR5dzZQ=;
        b=KUESZQUqUMNUTEl14gYh4PD144twMuySFUSSRn4sNvwyIVmslW1kx0wOETUDWZ9/7W
         g6AaF0dfqSIbIQNturtJuGi0iZHElO2vu7GOLTsbCiwSehax0vdxMBekA+AToFNmJyFX
         2VpBGugbAe7TqkyHXCzn1EtZBDrJj/1YGI0YDys+mkC/KFCp9GtO4Bva+1PLLU3FEdU+
         3Y7iWAi3RiMOAX2MxELOa91gmrUL8pXtV0wAfTL+2A2Qfcel/UY+oA3oOfgvrO5ZZghJ
         k24upX5wollZJmPW3zSzOtkb9IK0xcJ+e63LhW3k6OQlMu0hwVV3vIB0eY4P/+QwJLa+
         JTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=f5cBwH7kdw31CIR5J62DosBSFttoc1nOdgtRXR5dzZQ=;
        b=AFoUhzMMgMjfr7lF320z62akQxBQ3h+IJ6wwCr5cnrC0vF3+LPRoLRAvTRgDei/x69
         zUPenWQ7z3ipKWK/Cx96gRTVMKI0nwnYYH7I8jjUZBk9Zr79y+4tGDJadXKwBmgjTob8
         Yl+X3mQR+WlQo6BWTUMov9Rjw4reAUHB4XPRnLpbkA4Cd+aHVsi1WuA21G2Bd07X0tPL
         tCbqA57lRpgKF3+6Wfw0fR/6af4AETIkmyx/n6hQjVlmcmPQh4uPq5PazFXTpya1bR8S
         b3VCM5nKGvL2ciJy9Tucs88YjPaTDrgBzsdowwUmVRu5vptIBVmTA4yobUln7Hw9Yyyn
         bA1Q==
X-Gm-Message-State: AOAM532vgKuX1akC/NySyorbhs5pWCy41nXrCnSdElxZwFFhxzCPH+ur
        wvU44Nm2UhGK73SzgC/0cS6DOK2TG3BMzcTN9IfjOtfA65JIEDZhmypBMkoIzc2v8Ozg7GFzAFD
        EfmRfHPmB85v6QbSZfbXZd+eEH4g5grYLEHHEHQ4tDhxtlT+aXTnWPZxF4NYAkMrD5npMkUNo
X-Google-Smtp-Source: ABdhPJxAsfsftsazqr6hHp6i7TNp/a0ie8uxuAisPa618ndT99tVGG22bAoM+NRDJId0y3jI/s+DVg3TRiWW
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:f950:61f2:f1ec:ae8b])
 (user=eranian job=sendgmr) by 2002:a05:6214:12ee:: with SMTP id
 w14mr1653162qvv.52.1631174344321; Thu, 09 Sep 2021 00:59:04 -0700 (PDT)
Date:   Thu,  9 Sep 2021 00:56:58 -0700
In-Reply-To: <20210909075700.4025355-1-eranian@google.com>
Message-Id: <20210909075700.4025355-12-eranian@google.com>
Mime-Version: 1.0
References: <20210909075700.4025355-1-eranian@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v1 11/13] perf tools: improve IBS error handling
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, acme@redhat.com, jolsa@redhat.com,
        kim.phillips@amd.com, namhyung@kernel.org, irogers@google.com
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
index f61e5dd53f5d..f203f178fdb9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2684,12 +2684,52 @@ static bool find_process(const char *name)
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
@@ -2782,6 +2822,8 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size, "wrong clockid (%d).", clockid);
 		if (perf_missing_features.aux_output)
 			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
+		if (is_amd && (evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name, "ibs", 3)) && (evsel->core.attr.exclude_kernel))
+			return scnprintf(msg, size, "AMD IBS can't exclude kernel events.  Try running at a higher privilege level.");
 		break;
 	case ENODATA:
 		return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
-- 
2.33.0.153.gba50c8fa24-goog

