Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BFE4137E9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 18:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhIURAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 13:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhIURAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 13:00:08 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05F4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 09:58:39 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id g14so85945pfm.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 09:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UKEwcbJEyUP0PqyzuU1jDgKq63XLBjLh4Ta6kc0XTvE=;
        b=PUqZB0dLwluGdzZQ4zV6cjuxUbh0c2kg+B3SeVT/lrJ1XbYCAhKV1VZtrAdLXONOxW
         nUcSGGIpjRpDvyVsZZDn4irjNUynHXB4c3UNObGKO95LknN+ZmW45CfUsc06Dm6+//kM
         OWnstcShvsSnaXvXOzSiKaw+XfhxnsKo9DnQp8+THp5oY8z0AvLBMgqUGGUmxikPJ69C
         DpdA591UCBC4s6bvd6HNkrHdzcReEk3jeJR5Jw91cBAwjpDMGjikq93/DJ3pLoQiCj9o
         fGpIbX+H1/o9R0yhAIyIiW15ycbzc5feAFJXQOfLzeQg0UorYhHbmKOz5f51Vt5HoYAg
         JQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UKEwcbJEyUP0PqyzuU1jDgKq63XLBjLh4Ta6kc0XTvE=;
        b=jizNvjnOEydIK9Q93E7fj5Ge63RnOfSfEEePZyhnyF3bSHiwM48HB2bRrV6wWOC+42
         FdVx4F5uqyqsNZAk6BB23mUl2gX0jzYaueJOYGI7/0jzM4ghBuu2KbOG6WSWXtHqgZR5
         lQvltJyI3De0fC2iq3FpliAuIgJ/g9AUydpVuHeZDjqdynNrYcjmTSA0voWysV7wM3RR
         mJBkWgUauw3OqSRjZNgGDkbYk6TaxSMFEdCMFPjmJ4bn/XfJDQhPXn4wf3VWQeiIfrzm
         mnvPf6J7gUKCh4ZGQW3QToWGvIFbGoUAo2Uud8Qt5RJMbzu/nxkqF7hvP0rYXIxBuSsb
         z5Yw==
X-Gm-Message-State: AOAM532izuZB1tVvXNBiPAsCN3FlLi69I3QaDBHvafQgGvlqVPmV8kJx
        zxdspageuUssghJsMBWC2XyBlbYkvlw=
X-Google-Smtp-Source: ABdhPJz6Y8VTto6N/f8XpSs196/Bx/hN5/wj5eYVotLR+BYvB69rKLFBGf/tchVE93j8JiRzHpHVCQ==
X-Received: by 2002:aa7:97b2:0:b0:439:14a9:2bf5 with SMTP id d18-20020aa797b2000000b0043914a92bf5mr31535117pfq.45.1632243519433;
        Tue, 21 Sep 2021 09:58:39 -0700 (PDT)
Received: from sultan-box.localdomain ([204.152.215.247])
        by smtp.gmail.com with ESMTPSA id h6sm18237584pfr.121.2021.09.21.09.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 09:58:39 -0700 (PDT)
Sender: Sultan Alsawaf <sultan.kerneltoast@gmail.com>
From:   Sultan Alsawaf <sultan@kerneltoast.com>
X-Google-Original-From: Sultan Alsawaf
To:     sultan@kerneltoast.com
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@suse.de, mhocko@suse.com,
        rientjes@google.com
Subject: [PATCH v2] mm: Mark the OOM reaper thread as freezable
Date:   Tue, 21 Sep 2021 09:57:58 -0700
Message-Id: <20210921165758.6154-1-sultan@kerneltoast.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918233920.9174-1-sultan@kerneltoast.com>
References: <20210918233920.9174-1-sultan@kerneltoast.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sultan Alsawaf <sultan@kerneltoast.com>

The OOM reaper alters user address space which might theoretically alter
the snapshot if reaping is allowed to happen after the freezer quiescent
state. To this end, the reaper kthread uses wait_event_freezable() while
waiting for any work so that it cannot run while the system freezes.

However, the current implementation doesn't respect the freezer because
all kernel threads are created with the PF_NOFREEZE flag, so they are
automatically excluded from freezing operations. This means that the OOM
reaper can race with system snapshotting if it has work to do while the
system is being frozen.

Fix this by adding a set_freezable() call which will clear the
PF_NOFREEZE flag and thus make the OOM reaper visible to the freezer.

Please note that the OOM reaper altering the snapshot this way is mostly
a theoretical concern and has not been observed in practice.

Fixes: aac453635549 ("mm, oom: introduce oom reaper")
Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/oom_kill.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 831340e7ad8b..46a742b57735 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -641,6 +641,8 @@ static void oom_reap_task(struct task_struct *tsk)
 
 static int oom_reaper(void *unused)
 {
+	set_freezable();
+
 	while (true) {
 		struct task_struct *tsk = NULL;
 
-- 
2.33.0

