Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D7144ACCA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 12:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343561AbhKILpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 06:45:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47399 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343558AbhKILpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 06:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636458141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/olsdjO1SBrRzczNTsIu4zmW949ua0nH6+NAeICI4fE=;
        b=KHom23NuVR9xhR4qlMdW4srVpQFPcML/prfU2ved0ynj3Njk0oQ5+wy99DqY2XFOsDby1c
        7/LAkhknw9hs1aTtd1H/I+OF3jbvJkCaxdVgoJPse6dgwBtJ4h8Chy6osQgQ64SheEN27M
        ox5xOcWgam1Idz0eMgWc5p/QWvpRyb4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-LH2eBbrrPHuu8dMs0UT0oQ-1; Tue, 09 Nov 2021 06:42:20 -0500
X-MC-Unique: LH2eBbrrPHuu8dMs0UT0oQ-1
Received: by mail-qt1-f199.google.com with SMTP id o14-20020a05622a138e00b002a79da5b350so14421044qtk.15
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 03:42:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/olsdjO1SBrRzczNTsIu4zmW949ua0nH6+NAeICI4fE=;
        b=plrg3JC9YZdGqgAETAf4RUzFMER2+y7i32gGtfW1q6Gdaxd3GErj0WYz7j+VTYhQON
         JRl0lsGHZytjiIeI61KfSYlwC4MaIkDPSbG5tmR8kssHrYG9PBxb8VB/Ez/1Vy6iIYp+
         podBIcPDQyjyLeuJv0x6eIShJ2e1qe1FxmXkQ6UA/qaC2becfI5Zyts0sPlRzL+W0VbA
         iOkMt9eIOKIU6IlPBWjaLjz9jEqFAi+pY/AVxKJh32ETi1A38j/Adzk+T0CwUPUzS3Mz
         Lgl5RuE3DJYliMMHVgA3z3ZMCZWdiQQh21pIxQ7S+OI0K+DuUMn8F6Wj4UhjGVLYVOvx
         QhHg==
X-Gm-Message-State: AOAM532DMODW/RxKPOVuWqX4wmyeq+9KXete+DfJXF8MrI/QzD5JX6nV
        WUzgad9IZduQBZg/C8kKHh3YREUCfJSyiZ1dsZRN5yW0JCTcZTfLGZCjXpNAC8IYaTlmGxs6ZXw
        JHSfYjy8r8HyUypZOnYuR71Ky
X-Received: by 2002:a05:622a:244:: with SMTP id c4mr7568195qtx.186.1636458140378;
        Tue, 09 Nov 2021 03:42:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVe4qsUcKEnI/wFP4RrNu8cR0bVzR0TmAjcn9X026xJDnxkLGwR45FU3IMe6tJK3s4PtH5SQ==
X-Received: by 2002:a05:622a:244:: with SMTP id c4mr7568172qtx.186.1636458140190;
        Tue, 09 Nov 2021 03:42:20 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id s22sm11850914qko.88.2021.11.09.03.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 03:42:19 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] ftrace/direct: Fix lockup in modify_ftrace_direct_multi
Date:   Tue,  9 Nov 2021 12:42:17 +0100
Message-Id: <20211109114217.1645296-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't call unregister_ftrace_function under ftrace_lock.

Fixes: ed29271894aa ("ftrace/direct: Do not disable when switching direct callers")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/ftrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index b4ed1a301232..fc49e8809a56 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5602,10 +5602,11 @@ int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 		}
 	}
 
+	mutex_unlock(&ftrace_lock);
+
 	/* Removing the tmp_ops will add the updated direct callers to the functions */
 	unregister_ftrace_function(&tmp_ops);
 
-	mutex_unlock(&ftrace_lock);
  out_direct:
 	mutex_unlock(&direct_mutex);
 	return err;
-- 
2.32.0

