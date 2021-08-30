Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BA73FBAF7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbhH3Rax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhH3Raw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:30:52 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02284C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:29:59 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id fy13-20020a17090b020d00b001939890b4d6so1972353pjb.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LVV3UHlk75yje1xXSFFRWyfRbrh8OImERx560ZLqV78=;
        b=IvtVU2ecU6KZCoDqCW093hiZ2lhwtQIofFW8UZrOYtk+4S6cXBZM8LYiHxTLo4DA62
         Mcsr5juVYUrOy8rNyG1yZ7voTbgtLZowhpm4tnGY655pEJvnJp7fyMZTqiMH1sQS94hr
         9UX3sA2Bb364oAvBYogFtLGQ1YCTDOAgIbFSxHqXCrfUwhq49GCKEQbLyH/0HeZAZCCH
         T5ilQHDzPuxCXeyzVeQjK6gBJHf4UkTwnOl2zR/K51CKwqjq2xQmcZYfaxYnOM37SYRS
         8CIAN6O9Bq5BWHogtAPODwYydCw1lsWmC5+GKMkgJl7k0H6KCXzSLTMvK8Mejsyaoirg
         ajVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LVV3UHlk75yje1xXSFFRWyfRbrh8OImERx560ZLqV78=;
        b=Z+UcFiTHnfyxvPnbjeEoVBBFsklFqZGNwoRUSUQBePMKJarDY2C3VnZTDmafl5+tGI
         htUC9mX7fhyhjxtJMFUBbQd4C3E9DV6M0oX0qFJMPbW5A7FfQfCetQJpLwx6QaQ8ZR4a
         Pb1jITzgM5LT+s7gzQccoDDHzkhlOQZjLmPBVQy3lAsltfXmK68vWu9iO/Cy9FjHYdIl
         oAxF/i0HoXUs1WJX46coywlcuCHU51Tb40/8uoP7zpTVadKOrFyUaLA0klx2TXQKrGgK
         QJIb7+g8rno28fmTfUamSHv0ozCAOdJvWYHMq3geqVeqefcVQgkPIfTRtPUvrq4mChZS
         7Obw==
X-Gm-Message-State: AOAM5303Ewege3kXezf7Y2xeYNYHUEQdvv/QAl/aTqFgnAPDTIdluxH6
        h2fahlC/RXBucl5PDGreuPkIXL6sfdr1Bw==
X-Google-Smtp-Source: ABdhPJzCcC4VvlzbbigWq9Ik0NqIKJYOOVsEeFdC4+tI++PBliuKJgwEngIraYu+cMozuc9V7j3OEuD8/wksKQ==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:cc09:9ca3:397b:a20c])
 (user=shakeelb job=sendgmr) by 2002:a65:6658:: with SMTP id
 z24mr22641670pgv.266.1630344598441; Mon, 30 Aug 2021 10:29:58 -0700 (PDT)
Date:   Mon, 30 Aug 2021 10:29:53 -0700
Message-Id: <20210830172953.207257-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH] memcg: make memcg->event_list_lock irqsafe
From:   Shakeel Butt <shakeelb@google.com>
To:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memcg->event_list_lock is usually taken in the normal context but
when the userspace closes the corresponding eventfd, eventfd_release
through memcg_event_wake takes memcg->event_list_lock with interrupts
disabled. This is not an issue on its own but it creates a nested
dependency from eventfd_ctx->wqh.lock to memcg->event_list_lock.

Independently, for unrelated eventfd, eventfd_signal() can be called in
the irq context, thus making eventfd_ctx->wqh.lock an irq lock. For
example, FPGA DFL driver, VHOST VPDA driver and couple of VFIO drivers.
This will force memcg->event_list_lock to be an irqsafe lock as well.

One way to break the nested dependency between eventfd_ctx->wqh.lock and
memcg->event_list_lock is to add an indirection. However the simplest
solution would be to make memcg->event_list_lock irqsafe. This is cgroup
v1 feature, is in maintenance and may get deprecated in near future. So,
no need to add more code.

BTW this has been discussed previously [1] but there weren't irq users
of eventfd_signal() at the time.

[1] https://www.spinics.net/lists/cgroups/msg06248.html

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 999e626f4111..a73689caee5d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4851,9 +4851,9 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 
 	vfs_poll(efile.file, &event->pt);
 
-	spin_lock(&memcg->event_list_lock);
+	spin_lock_irq(&memcg->event_list_lock);
 	list_add(&event->list, &memcg->event_list);
-	spin_unlock(&memcg->event_list_lock);
+	spin_unlock_irq(&memcg->event_list_lock);
 
 	fdput(cfile);
 	fdput(efile);
@@ -5280,12 +5280,12 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	 * Notify userspace about cgroup removing only after rmdir of cgroup
 	 * directory to avoid race between userspace and kernelspace.
 	 */
-	spin_lock(&memcg->event_list_lock);
+	spin_lock_irq(&memcg->event_list_lock);
 	list_for_each_entry_safe(event, tmp, &memcg->event_list, list) {
 		list_del_init(&event->list);
 		schedule_work(&event->remove);
 	}
-	spin_unlock(&memcg->event_list_lock);
+	spin_unlock_irq(&memcg->event_list_lock);
 
 	page_counter_set_min(&memcg->memory, 0);
 	page_counter_set_low(&memcg->memory, 0);
-- 
2.33.0.259.gc128427fd7-goog

