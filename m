Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5084073CE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbhIJXYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhIJXYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:24:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D64C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 16:22:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f8-20020a2585480000b02905937897e3daso4588031ybn.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 16:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=A/ezR4Ofeh4QWbDFg8gsprJ3lNIyVX/YPJuv/wW2Gu0=;
        b=PmML4m6yioSdQsuVAS57iaRzPFYLUZB+JA1EnNTkKm3JgmkyHmSzznPo8jIrWBranS
         +J76FA9CQbtyJKeHVFSLtByZi9HIfG9yv1XTbh4E0krjQwWPi+VDi8FZqcZuYgra1H4W
         yXOk+aY1Vx51COkhHTCDqSEfhtwPPpn82bj1G+kb992++/b+L1F/JrjbwUD3vpMDRHZI
         6AhF3/Z0003ABiOqjz27pxEybEsQ4I7VxFNo3unT2EeW6TrzGg0K+vWuO+xqRh6hI1/z
         TcIT2sYgPEhUMJ9ZN44VoOvMQPch5eQCNQRL1WM2Mfkb+x3urGTJzyIpDhzSSalgoPSM
         FzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=A/ezR4Ofeh4QWbDFg8gsprJ3lNIyVX/YPJuv/wW2Gu0=;
        b=WPEyeLX7vBuBQOWRP/BgKxXJ08KvaZbbjpDdNryvDxlDQYoCLpAMKwh3de/5xsG8Tn
         09m4acketezR1yJCZzRjfqhj1kwUdjAYbmjLV7aUE6POOsBS/Yuqmn7Pf01/DsQPeTcI
         oc+vId3Eapn+5jsB4igzew/m5caSpc+/VH3qgd+pC6OFT0cqfVTuXOnpqGFLZf9VoPuP
         LtTkZ6qlX8T0RROMHEm0U9YSLDtw/vwuUkfWNfL3UPRxHgWyZoz0rIQoL8Fxwuu74a6o
         lzokrGukTCMWEI59hEWDxmeEDaKjw710KFYtWW/ZPUq46NCXNoyf9QqDzxTO+F/qxILc
         RRYg==
X-Gm-Message-State: AOAM533MBv/ogMoaHgCnFlnv9mrJPCSUWpO+V0hNAoxkIRbGJKqK9n5m
        uK9OGvH7f0YuCJmBbGFYG3R6HR1i+6fg
X-Google-Smtp-Source: ABdhPJwcxpjPWnvKHsOhaNyaVrgUPsC18bqDB+wPG9fEOtT1cU7h4Cq+ZDJ0DcJU0xQeEc+dszZhbWBByfTB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:245:160a:d9eb:a3dc])
 (user=irogers job=sendgmr) by 2002:a05:6902:150d:: with SMTP id
 q13mr275812ybu.515.1631316175887; Fri, 10 Sep 2021 16:22:55 -0700 (PDT)
Date:   Fri, 10 Sep 2021 16:22:49 -0700
Message-Id: <20210910232249.739661-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH] perf tools: Ignore Documentation dependency file
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Fixes: a81df63a5df3 ("perf doc: Fix doc.dep")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index e555e9729758..8e0163b7ef01 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -39,3 +39,4 @@ pmu-events/jevents
 feature/
 fixdep
 libtraceevent-dynamic-list
+Documentation/doc.dep
-- 
2.33.0.309.g3052b89438-goog

