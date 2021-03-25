Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F763496A3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCYQTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhCYQTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:19:19 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09289C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 09:19:19 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g15so2583124pfq.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 09:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MCV8tTXwt23kg/ET1qXEihrVIfNfi06vHFXn1NDdH3A=;
        b=nZZetF9JWy5xcMCmo3Yn0UK7VYeG8tMRcqTK7ptGVmKWp72v+hNnYiNSGRAJP4uRlv
         f+Umlb47elqWESHI9rnOzq9NUmHhXdwRmrqnY1XKu2iuU6kUsRhOm6GT4rHrjW0arGgT
         HJiNsPTnf/d3FJMNk22f3rAEJj+bY8lyLBKNKIYJe/ccU3IyaGlJaXoHaxoxl9VirEyI
         1tyMyKT2noLFOcRLKPVbMyfNPpjA4w44jIZpiKqczMyu3tGWTg1SoM45lfQ1HyADX5g+
         HsbujivDo+NDH3Jyp06AU0X6VMAF1pziMt1hSlxgb4SMMmrjOn9ar4PkTX2zI44j46uE
         nUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MCV8tTXwt23kg/ET1qXEihrVIfNfi06vHFXn1NDdH3A=;
        b=Gs/rnfcLUbzfRqJJ9mDiA8B4qZPyLrlw8f/bwYGSNe9U9HB9iBrNnhY5FSWXJ1PDgq
         8BK4M6eDvVrIoYYRv/GYPTcf1pZcU/vJlMRtfspAML3GYvc8eY2aXqa3gUSbGr9/SUeG
         Ms9btD4Rij9j6mqslc2Moh0fakiz5Bfx1VlEKQwSsULWOeVhzXU1B3lKpDLx7jeZ/u+6
         akZxcJMh2E/GvRYEmDtUJsm2DM579x42LoRu5R//8QZop29M3LjRIVCdfhYRP5m9/4Og
         T0zULJ/lzYesUUdP98p/rSSxRQQgHIjSGLaw3oiOgbCLjNWQgWVU1HMC8+M4zVzu+8pC
         yfCg==
X-Gm-Message-State: AOAM531O2w/rqUST/4iPEeBCxRascLdvsu0n3ibmWfSuEKud6lg87UGS
        vGUD59iTKx6Y6rtUX4Xd3ZI=
X-Google-Smtp-Source: ABdhPJyUSLogmtUdpYJjkJY0a2rIxIHDfyXLYseaWe7rp6TpI4hlBnKoLmkcIa73vJ5ChIXh/S2oBg==
X-Received: by 2002:a62:7ed2:0:b029:21d:1806:fe30 with SMTP id z201-20020a627ed20000b029021d1806fe30mr8828200pfc.5.1616689158635;
        Thu, 25 Mar 2021 09:19:18 -0700 (PDT)
Received: from localhost (li1758-18.members.linode.com. [172.104.167.18])
        by smtp.gmail.com with ESMTPSA id q19sm6608224pff.91.2021.03.25.09.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 09:19:18 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH v2] tracing: Update create_system_filter() kernel-doc comment
Date:   Thu, 25 Mar 2021 16:19:10 +0000
Message-Id: <20210325161911.123452-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit f306cc82a93d ("tracing: Update event filters for multibuffer")
added the parameter @tr for create_system_filter().

commit bb9ef1cb7d86 ("tracing: Change apply_subsystem_event_filter()
paths to
check file->system == dir")
changed the parameter from @system to @dir.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
v2:
Update the description of @dir, and leave @tr to another patch.
---
 kernel/trace/trace_events_filter.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index e91259f6a722..e6efb5dfec5d 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1693,6 +1693,7 @@ static void create_filter_finish(struct filter_parse_error *pe)
 
 /**
  * create_filter - create a filter for a trace_event_call
+ * @tr: the trace array associated with these events
  * @call: trace_event_call to create a filter for
  * @filter_str: filter string
  * @set_str: remember @filter_str and enable detailed error in filter
@@ -1741,8 +1742,8 @@ int create_event_filter(struct trace_array *tr,
 }
 
 /**
- * create_system_filter - create a filter for an event_subsystem
- * @system: event_subsystem to create a filter for
+ * create_system_filter - create a filter for an event subsystem
+ * @dir: the descriptor for the subsystem directory
  * @filter_str: filter string
  * @filterp: out param for created filter (always updated on return)
  *
-- 
2.25.1

