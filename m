Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0C3342C53
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhCTLj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhCTLjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:39:23 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C4DC0613E7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 04:39:23 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id l1so5447838pgb.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 04:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=454zObPRENQ6uFGwegwHYlLweYN9GHwoL7+qoqCvmPQ=;
        b=CBDqS2HqwXCwJPkVMk2p5UAlD+5EMnsFL2PTpH9U2JQ6BkTK9YHeoAcgg8rFuQJ7P9
         pceckTfIbQfa8F+NAMSswxC2NBlIUhCeUq+/cMHzA7bDj2b7rjKGcPel4OrU8TJPk9gP
         X3cbODanu1IHypFOSvxZfxXvkhHajStL/lPJlEKeydGvvwHJf5/PVKnlzG7bQKTm+CYr
         agg1d2yrUuMLdQeq2p2FAnzEjXvfEFfc+OPKwy7nMpBoKR4jGRFN2CZIQ5LdC9uj2dWk
         BGZFT9tc5cIdjlkz8XSOljSJGwcKnmRnJEIQM2+s4QV5qs4bL/jps4fIqVpS10CDwH3F
         2amA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=454zObPRENQ6uFGwegwHYlLweYN9GHwoL7+qoqCvmPQ=;
        b=HupsuAMwpRlOpWCxSczLWGg9jnQUVmLXVCOKaSfBuE77mMLvjcylI9OmJ7+euccjjW
         ZerSJgJMSOj+oqVFr035kaEQMtuZaxIINTu/YBCi+Q0K1a7T5MpZOnvTQn19ZiB5OTt9
         rB/UpmHpM2GNPVcnQJLRd2aA0TXj+jxhZb5iJAcnZ9rUnuD56L8f+U0euOfHJBWZbZmf
         IvU+BF05XP2lRlnIDy0er0KtMaN7Y69/CJkAbo60TikenwaXdsVo9bGQBk1uK+udPEmz
         v18Zpu3XFydM+WzcTUujL8EDDnNv9mSQPJuDcPmnxhT1nNSy04RrrorDdzKtUUcToO5+
         DzMg==
X-Gm-Message-State: AOAM532aC8Zgl3p4MN9V8hxKr6l82s04+RD6NtoE6CHfraiGtkrCG3JK
        s8r1KQ5Qpw0+Ip1ft5nc+Aw=
X-Google-Smtp-Source: ABdhPJwp5jh1Db5e+jvFFQ9zfrK6Dm6i4R+pzGLIEJik8qb0n8PHr5G1a2ueTRIXRdCNglTIjmERcg==
X-Received: by 2002:a63:5b47:: with SMTP id l7mr15135128pgm.209.1616240362917;
        Sat, 20 Mar 2021 04:39:22 -0700 (PDT)
Received: from localhost (60-248-225-230.HINET-IP.hinet.net. [60.248.225.230])
        by smtp.gmail.com with ESMTPSA id s194sm8500303pfs.57.2021.03.20.04.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 04:39:22 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] tracing: Update create_system_filter() kernel-doc comment
Date:   Sat, 20 Mar 2021 11:39:16 +0000
Message-Id: <20210320113916.22175-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit f306cc82a93d ("tracing: Update event filters for multibuffer")
added the parameter @tr for create_system_filter().

commit bb9ef1cb7d86 ("tracing: Change apply_subsystem_event_filter() paths to
check file->system == dir")
changed the parameter from @system to @dir.

commit 1e144d73f729 ("tracing: Add trace_array parameter to
create_event_filter()")
added the parameter @tr for create_filter().

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 kernel/trace/trace_events_filter.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index e91259f6a722..00e78a012de9 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1693,6 +1693,7 @@ static void create_filter_finish(struct filter_parse_error *pe)
 
 /**
  * create_filter - create a filter for a trace_event_call
+ * @tr: the trace array associated with these events
  * @call: trace_event_call to create a filter for
  * @filter_str: filter string
  * @set_str: remember @filter_str and enable detailed error in filter
@@ -1741,8 +1742,9 @@ int create_event_filter(struct trace_array *tr,
 }
 
 /**
- * create_system_filter - create a filter for an event_subsystem
- * @system: event_subsystem to create a filter for
+ * create_system_filter - create a filter for an event_subsystem_dir
+ * @dir: event_subsystem_dir to create a filter for
+ * @tr: the trace array associated with these events
  * @filter_str: filter string
  * @filterp: out param for created filter (always updated on return)
  *
-- 
2.25.1

