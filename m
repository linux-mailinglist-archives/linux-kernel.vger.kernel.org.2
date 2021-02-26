Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEE43269D3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 23:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhBZWPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 17:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhBZWPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 17:15:21 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CBAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 14:14:40 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id o9so11277581yba.18
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 14:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=JsBBABLzKcrH/70TNpRbu5bpTMsoyM/6m7MdSXMmoA4=;
        b=HCSlKdVdz+DK+YffwyMd2BOWhgKplThbh3P6H/0JuwuHmBxLEWWE2uObxi9quNuDo3
         dIHjhI/vzToBGrEt4diTKBInihx51DKDfedNVD4sB/KOpWhVGuO2sUZIANlAFZTqiCz0
         OOsApd8J+w+zrnDde7rnKx5nSjNxGrH7wzQ2KXrdFlsP+ippszhYRm+Cziz7gjo2TiUW
         66QahQYQ9zlAsgIEw24NxCgUVl3SJCDyKrmwjAu6AhYeYaO+Q9UNO9MaLlHnzUS5Bke8
         HPVah9taq08HW6vSsfifBjalBNCTzrKNVv358jYt8PuawH+J5qG1vs4VfPgcbYeJJ703
         M7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=JsBBABLzKcrH/70TNpRbu5bpTMsoyM/6m7MdSXMmoA4=;
        b=IViNueyGK02ff0/qAN6XzY5m2MgPyN/kLA2o71JMM8yuybIC94kahrx8Mx2uCV9biS
         JNiwqQMdCKd9Yb3yLDU0ZGs6Ls484ZbauSmlOU4O77ofZij4xO7Wz5cJeJNOCQ1JtZ8j
         mfy22R5cuGWl160CJqLMvgFPPy0gzdQipZrIk1EaAdpqFThJlUsVbSLnkgrwX61yZ6GC
         b48B2X8RmxwR7HnfLnsgYdadGnq4OrKx9YpsW4lBeDeycOMhkFSJIWFzsLoqIfdu5rTT
         fObHKnqIGcFr2K9/EOnRwuACVHohlBy2tdT6WHm635/sIlKpg5NmdqIcBNxPHiwlbVb0
         Q6/Q==
X-Gm-Message-State: AOAM530kHNJK445NIJCnVmr9/0LIyEvfBbMTBey+heN4Ef46rep5pkP9
        7kQQNg7TiU7291mCYrU1QxJxBvgYGTcK
X-Google-Smtp-Source: ABdhPJyA5FjXkWp+p3vw+CJN4gNRrALjmaMZbpzIIpMknshfpeQN1xPZdpugF8KuQgoKr89gWydacx8cjUw1
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:985c:25dd:9e93:fb43])
 (user=irogers job=sendgmr) by 2002:a25:40d7:: with SMTP id
 n206mr7494742yba.285.1614377679921; Fri, 26 Feb 2021 14:14:39 -0800 (PST)
Date:   Fri, 26 Feb 2021 14:14:31 -0800
Message-Id: <20210226221431.1985458-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH] perf trace: Ensure read cmdlines are null terminated.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Issue detected by address sanitizer.

Fixes: cd4ceb63438e (perf util: Save pid-cmdline mapping into tracing header)
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/trace-event-read.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index f507dff713c9..8a01af783310 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -361,6 +361,7 @@ static int read_saved_cmdline(struct tep_handle *pevent)
 		pr_debug("error reading saved cmdlines\n");
 		goto out;
 	}
+	buf[ret] = '\0';
 
 	parse_saved_cmdline(pevent, buf, size);
 	ret = 0;
-- 
2.30.1.766.gb4fecdf3b7-goog

