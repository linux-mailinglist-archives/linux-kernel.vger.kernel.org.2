Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A433ABBFA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 20:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhFQSop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 14:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbhFQSoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 14:44:39 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BEAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 11:42:31 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id d12-20020ac8668c0000b0290246e35b30f8so2078228qtp.21
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 11:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PFZQwytkaiwWlIlKohYqf6fjHhndSooLEMwUFHht7ds=;
        b=iyJ1e2QDwkO2dM31gs2gGxDqbXMTnBTPHawrQ46ZYkK1iL09n0hHmRo50WUvVWMF1o
         j4i74zlkPXYgC9ZQTxakKY2nVhpaODFg8TpjOWOjtPqCOSjpleV/gByQbmj98wgYlYsO
         yWmn4LHLY1bbJw87u3Y4/6hUVR4xVy8fkz8WCUCHuASES/yhxsr8BMhA0szo/Xs9XKX+
         vGHQTsCVj812n/TeIQeuWwu6R9kwVQ3IhDNEhmh2BIDjD7NbVboT9QT1adqLGA1y9njG
         E1SeuhymSiP6QdRYN7r8f4l9i6lTW/sGCCX2kV26XDTKmfDO3coo19/4fKOaodfvO02T
         ckzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PFZQwytkaiwWlIlKohYqf6fjHhndSooLEMwUFHht7ds=;
        b=XpurIHs+mVFWpEz7RtxONnvr/heE2kVUZTZyhlXXsQv2M3kkr/xA40v2JyHeVxJBIS
         to31crBu3jKbq/cLuHuX1rbFLuG8qDHT5tq3gr/e2ZlnThl2y2Fuk2nMIrLVGkl5Pqvo
         7gJm0fNk24spNCbRzZUDP19JvdgX9ZrUhnxxOvPtaIjyp/kBwGDsweTFA3ZfomDfU6Ol
         TPM9NqxEBrOsyBSwIzzPC0lSDgcQJ90HFS8Ozyf28d0KFbHBdr/nxE75zM9nxIbcp7lH
         t5YqFhndQ1jxNRUuJfElLAVxNDD0dRZmLCEwTMf1Hc6oJGNirilSj1B84uE9Yfymc34E
         DMpQ==
X-Gm-Message-State: AOAM531D+CQeUsEqH6Kpvt7Lq+8bhLRoQdyW0wDJcVy6plcLaQeaRLHb
        knOBJCUwvuAHVy/kVoLkSbYWBDHd79tK
X-Google-Smtp-Source: ABdhPJxCHi9VcrdwhllY0LhoGwLekF7I6iEiE23gPOhHNruIdT2wgVP0bd5Vr4d54ca3YYS+iZblTXZdWg4a
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ef90:beff:e92f:7ce0])
 (user=irogers job=sendgmr) by 2002:a25:c243:: with SMTP id
 s64mr8032005ybf.171.1623955350902; Thu, 17 Jun 2021 11:42:30 -0700 (PDT)
Date:   Thu, 17 Jun 2021 11:42:14 -0700
In-Reply-To: <20210617184216.2075588-1-irogers@google.com>
Message-Id: <20210617184216.2075588-2-irogers@google.com>
Mime-Version: 1.0
References: <20210617184216.2075588-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 2/4] perf test: Pass the verbose option to shell tests
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having a verbose option will allow shell tests to provide extra failure
details when the fail or skip.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index cbbfe48ab802..a8160b1684de 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -577,11 +577,14 @@ struct shell_test {
 static int shell_test__run(struct test *test, int subdir __maybe_unused)
 {
 	int err;
-	char script[PATH_MAX];
+	char script[PATH_MAX + 3];
 	struct shell_test *st = test->priv;
 
 	path__join(script, sizeof(script), st->dir, st->file);
 
+	if (verbose)
+		strncat(script, " -v", sizeof(script));
+
 	err = system(script);
 	if (!err)
 		return TEST_OK;
-- 
2.32.0.288.g62a8d224e6-goog

