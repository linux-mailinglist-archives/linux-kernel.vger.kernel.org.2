Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291EF311E67
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 16:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhBFPY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 10:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhBFPYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 10:24:55 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7973FC061756
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 07:24:14 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id t5so12919128eds.12
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 07:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hojxOHd5o8QU0ARaDwSt3xNFY2ML96kutkiitTdDDTs=;
        b=FqHiOGCsSzFwDBxYydxb8TkeJvNfz6QiySKQp6c6tjLtJdeS25Fn3ETpEaPG/TAq0L
         qktg8G01+wh0/Y9nDHxpxoegSMkKo4BGZa0DUAGEw8HEXIyIuggWOcpBB6ahnoasY8bu
         KZsg8GkDhAitoCPLem7Pd4aUhyD5PSx+aktyHm702rFmSdRy5TLNj+GIoecYmc6Qqkc3
         pafQ1zjkJvaVYnYlUIVR6FnrHOR+RPeRYaW90vS8kk/4BMcO1Cp8OSjVAsliwEPRs5Pd
         ltR2coY4EdDT7lf63vUOW2KmatLtIhZxXGCwjbIX4Vjs6YbdhC5pis9iFawF3QokVSwF
         EpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hojxOHd5o8QU0ARaDwSt3xNFY2ML96kutkiitTdDDTs=;
        b=dkT55K5Fp7GhAfx9rHiObVjUXc11KnH5Tx/Xtv7YKRYXfBKjFDvDA8URVsnfdAfeFW
         nPqxnR/7bpi+/hntpwsQX9tPxMyIZbpmiNM3zI93iK+bA6CzHsIC3r28gXJ/VVRjIVXo
         Reymja0m4d6YQEDHdTbv2LV8GQjJrp+lNocHsMKzPI/V2+pzhEH0tuEyMF0waC+da+5d
         2fJHivFhvbvqOfeuk4Fal3DxRDN12ekLiL8Kl9QsaCz6xf49EsaelkSCKNpyi1/JabHD
         aeQnT6OfawI6W3WHJiwtZHs9GND81kQpXJI+MRIptkoIsp3j7ZpuHi2PuhPI5Ec/C6Br
         8diQ==
X-Gm-Message-State: AOAM532SL/7ircgc4IvpbSAtAZcvvv+oofbBSCeJSHx3zhALl07l+SxC
        F4T2DW2y+xF7e7pkf9XV1A==
X-Google-Smtp-Source: ABdhPJzs6FzvDMWuDqrrF6o3I5MdaJgCLP5kOfypcngni1HkljVNA7lizEOt0i+vJ0duDZZX1nv9hw==
X-Received: by 2002:aa7:cdc8:: with SMTP id h8mr8868350edw.244.1612625053283;
        Sat, 06 Feb 2021 07:24:13 -0800 (PST)
Received: from localhost.localdomain ([46.53.252.141])
        by smtp.gmail.com with ESMTPSA id l1sm5353174eje.12.2021.02.06.07.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 07:24:13 -0800 (PST)
Date:   Sat, 6 Feb 2021 18:24:11 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] sched: make nr_iowait_cpu() return 32-bit
Message-ID: <20210206152411.GD487103@localhost.localdomain>
References: <20210206151832.GA487103@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210206151832.GA487103@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Runqueue ->nr_iowait counters are 32-bit anyway.

Propagate 32-bitness into other code, but don't try too hard.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/cpuidle/governors/menu.c |    6 +++---
 include/linux/sched/stat.h       |    2 +-
 kernel/sched/core.c              |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -117,7 +117,7 @@ struct menu_device {
 	int		interval_ptr;
 };
 
-static inline int which_bucket(u64 duration_ns, unsigned long nr_iowaiters)
+static inline int which_bucket(u64 duration_ns, unsigned int nr_iowaiters)
 {
 	int bucket = 0;
 
@@ -150,7 +150,7 @@ static inline int which_bucket(u64 duration_ns, unsigned long nr_iowaiters)
  * to be, the higher this multiplier, and thus the higher
  * the barrier to go to an expensive C state.
  */
-static inline int performance_multiplier(unsigned long nr_iowaiters)
+static inline int performance_multiplier(unsigned int nr_iowaiters)
 {
 	/* for IO wait tasks (per cpu!) we add 10x each */
 	return 1 + 10 * nr_iowaiters;
@@ -270,7 +270,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	unsigned int predicted_us;
 	u64 predicted_ns;
 	u64 interactivity_req;
-	unsigned long nr_iowaiters;
+	unsigned int nr_iowaiters;
 	ktime_t delta_next;
 	int i, idx;
 
--- a/include/linux/sched/stat.h
+++ b/include/linux/sched/stat.h
@@ -19,7 +19,7 @@ extern int nr_processes(void);
 unsigned int nr_running(void);
 extern bool single_task_running(void);
 unsigned int nr_iowait(void);
-extern unsigned long nr_iowait_cpu(int cpu);
+unsigned int nr_iowait_cpu(int cpu);
 
 static inline int sched_info_on(void)
 {
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4383,7 +4383,7 @@ unsigned long long nr_context_switches(void)
  * it does become runnable.
  */
 
-unsigned long nr_iowait_cpu(int cpu)
+unsigned int nr_iowait_cpu(int cpu)
 {
 	return atomic_read(&cpu_rq(cpu)->nr_iowait);
 }
