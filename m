Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4BB430891
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 14:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245599AbhJQMGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 08:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbhJQMGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 08:06:48 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DC4C061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 05:04:38 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id f5so13141658pgc.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 05:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qq03a+PidrCNh8KWEP4qyu9+wQdfQDZm37dtOyQ0wD8=;
        b=S7KVlzb3R8FtndW0L60yfi7xIYMIilDD11/IuCB1DgBvi+hhDo9ytDmM0OnBhzDG13
         ehpXjlaAC4G5NZAo/RAaDLsUHEkL/t72lMqE48vapd1YMzzSW5VW5icGB1hutj/iqB3s
         LZgY0JzT0vKl6u7D/aehvSwR9uZyqoIgnpL9pGmYjrgSthLVJbdsCrhfVcUx/mJG4dBi
         RYNCy/oOCykLxoUNNEagEq1gEcyCzsnNOcXzZRk1intPC69zuTrqL4ccmMviBwggTJzq
         HFZa6wvmcunshbIzqbOOx8G72ZwuiIKfn642mB/7rryfrM5POMEv+nh59DHIQzzF3ax4
         JQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qq03a+PidrCNh8KWEP4qyu9+wQdfQDZm37dtOyQ0wD8=;
        b=8GeeGFJPPPbzdvDPIKaW+Lcg3I91bgdqLFZH4a5DrQZ1yQFsYXHDuq5yC3TdX9U3Qq
         ROq2ZeA8/PSKFjWaWhmQGfAHAzvvlYOCPf7T0TKjAI4J70K80V8m5XNIsROHLb3xBEgU
         K+a/lUk+uyvmAaIaSAxMcO/Nz3oFsEQxZHMXoXOA56tF9I5vj27WxCQsJhCdrYJdfkP0
         CDIrrUYRjeKXa625+yk4zs7A7IE+U/dMvjteKAwjJMvxPwXNUzeq5UfXVa+77L1KizhZ
         k8guXx7W94zXIQhvvGH4eYzJROpu7e8F7Uv/wE25ex1HFWdljaWYcN2KpJQNhOD1i1Ob
         FGHw==
X-Gm-Message-State: AOAM5330xoNeu1eqy2cF0HqZw6LbBMBByykHXeBz60daTXC7x2dnMZhh
        zaTnOZz0X307j1qKka8FTk/solp4u9SpsA==
X-Google-Smtp-Source: ABdhPJwKR4opiNwNEH+N6oK18PSufkLg3oecl7aOvTzJCoqkMXWLSuwHgMy85PN5QrI6TGPdqn2GCA==
X-Received: by 2002:a05:6a00:a10:b0:412:448c:89c7 with SMTP id p16-20020a056a000a1000b00412448c89c7mr22544171pfh.83.1634472278446;
        Sun, 17 Oct 2021 05:04:38 -0700 (PDT)
Received: from desktop.cluster.local ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id z4sm10530413pfz.99.2021.10.17.05.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 05:04:37 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     tj@kernel.org
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        mengensun@tencent.com, Menglong Dong <imagedong@tencent.com>
Subject: [PATCH v2] workqueue: make sysfs of unbound kworker cpumask more clever
Date:   Sun, 17 Oct 2021 20:04:02 +0800
Message-Id: <20211017120402.2423524-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Menglong Dong <imagedong@tencent.com>

Some unfriendly component, such as dpdk, write the same mask to
unbound kworker cpumask again and again. Every time it write to
this interface some work is queue to cpu, even though the mask
is same with the original mask.

So, fix it by return success and do nothing if the cpumask is
equal with the old one.

Signed-off-by: Mengen Sun <mengensun@tencent.com>
Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
v2:
- reorganize the code to avoid unnecessary saved_cpumask alloc
---
 kernel/workqueue.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1b3eb1e9531f..76988f39ed5a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5384,9 +5384,6 @@ int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
 	int ret = -EINVAL;
 	cpumask_var_t saved_cpumask;
 
-	if (!zalloc_cpumask_var(&saved_cpumask, GFP_KERNEL))
-		return -ENOMEM;
-
 	/*
 	 * Not excluding isolated cpus on purpose.
 	 * If the user wishes to include them, we allow that.
@@ -5394,6 +5391,15 @@ int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
 	cpumask_and(cpumask, cpumask, cpu_possible_mask);
 	if (!cpumask_empty(cpumask)) {
 		apply_wqattrs_lock();
+		if (cpumask_equal(cpumask, wq_unbound_cpumask)) {
+			ret = 0;
+			goto out_unlock;
+		}
+
+		if (!zalloc_cpumask_var(&saved_cpumask, GFP_KERNEL)) {
+			ret = -ENOMEM;
+			goto out_unlock;
+		}
 
 		/* save the old wq_unbound_cpumask. */
 		cpumask_copy(saved_cpumask, wq_unbound_cpumask);
@@ -5406,10 +5412,11 @@ int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
 		if (ret < 0)
 			cpumask_copy(wq_unbound_cpumask, saved_cpumask);
 
+		free_cpumask_var(saved_cpumask);
+out_unlock:
 		apply_wqattrs_unlock();
 	}
 
-	free_cpumask_var(saved_cpumask);
 	return ret;
 }
 
-- 
2.27.0

