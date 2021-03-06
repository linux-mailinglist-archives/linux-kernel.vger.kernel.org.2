Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3354C32F8EA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 09:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhCFIJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 03:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhCFIIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 03:08:49 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FA6C06175F
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 00:08:49 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id o9so5324972yba.18
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 00:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=sJ0sKWt3uhXVbZBIDtZzhf0eFcKzyJkgAyc4OIeGAH4=;
        b=rTywmRHSsVA6AO766i/FNo/BBKMGmbxMv8aj2ZjEXh4rhZ3SZsGt4bS3AxeSFxFmiO
         1eWUGoBZopPuEVM8fZTthwv5TPyqb1OYIn4g0buTNZK0/vpzlRSLj8zWxxGIP+TkmNc8
         oUI/Rlz7/vR7JiRzkKOcab+wVeJKpWSnagfPn/Vq+jINkYkBe3PBXDHAtfxN35CfHtiG
         ij27C37Aes1sl9YcQXJkPcUMrMEQV3TddzK+A3a8VMdOdyFJiAem+yOVl2OM1vaX+cQr
         3+HILqqDzU1GbZUQkaEmoR577OAe+HRhgajaghPwtPLkFxmiMQwnROFJA19lmJ2hI0RE
         rQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sJ0sKWt3uhXVbZBIDtZzhf0eFcKzyJkgAyc4OIeGAH4=;
        b=UCd9/C+ZDmCPvJXzn5hMpn+G8TyZAP3jRAlVxomwQUibzVvAB7VQSgUZfREkc42v72
         sy+Smukd53FglGtZOwAPaQ1EVHbGjEJ9XjsTMd2lwJVjIoBWFAyIQO11nmvXZPOMCQ6/
         PtB1uddafy7h8zLF+ei4TUtPE/kQdbxxUpSyDq5sopiJj4pEYn+scVDkN4eYWu9sCX45
         p2PUqY2n2CT6hmjYoOXk3pK35B/w4O+kXOiZ7CFp/0GsLyjhvuW0tBWvFjK+uMWn/Yo8
         tEGMgv08UbP7ULcfgVTu6EkZykAhmJCTqV5kndQQwowZabhxdUaK3nu7bK9tp6nH2pGI
         r2kw==
X-Gm-Message-State: AOAM531Mw3lKE5scaQOkfE9H3Ea2AVdhKZHRmn10siyUiwvNoxkhFqo3
        zC98fwtVwto3z19Lk00zra302Lk97NuW
X-Google-Smtp-Source: ABdhPJyJh0uc56mFa9kC9IkN34JVaQSEeYTA2H+l/omv5+wkksEPwEfZZC1IUGiSFqTnTBMN5pm08j6o5HWx
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:d9f:b4b1:d43b:2030])
 (user=irogers job=sendgmr) by 2002:a25:5ed5:: with SMTP id
 s204mr20222780ybb.121.1615018128901; Sat, 06 Mar 2021 00:08:48 -0800 (PST)
Date:   Sat,  6 Mar 2021 00:08:40 -0800
In-Reply-To: <20210306080840.3785816-1-irogers@google.com>
Message-Id: <20210306080840.3785816-3-irogers@google.com>
Mime-Version: 1.0
References: <20210306080840.3785816-1-irogers@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 3/3] perf bpf: Minor whitespace cleanup.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missed space after #include.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_counter.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_counter.h b/tools/perf/util/bpf_counter.h
index 2eca210e5dc1..cb9c532e0a07 100644
--- a/tools/perf/util/bpf_counter.h
+++ b/tools/perf/util/bpf_counter.h
@@ -38,7 +38,7 @@ int bpf_counter__install_pe(struct evsel *evsel, int cpu, int fd);
 
 #else /* HAVE_BPF_SKEL */
 
-#include<linux/err.h>
+#include <linux/err.h>
 
 static inline int bpf_counter__load(struct evsel *evsel __maybe_unused,
 				    struct target *target __maybe_unused)
-- 
2.30.1.766.gb4fecdf3b7-goog

