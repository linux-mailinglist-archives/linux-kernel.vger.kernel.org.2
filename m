Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D803916C2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 13:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbhEZL4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 07:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbhEZL4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 07:56:14 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993A4C06138C;
        Wed, 26 May 2021 04:52:45 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id f22so762215pfn.0;
        Wed, 26 May 2021 04:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FZHL/iuYMdL1Q5Q0lbUGAA5ha/63sGJlTW3uVbXhIq4=;
        b=LBfdsrA5AaIQJShxcbrYHOjbXMKuvoO/bYvHPsuEMh6/Vd5y/mXbO+rExXgiCSD4xr
         YxTWoYSiHqafW4GnoJRLcofEBwkA2AlyQgqhKgxuTjKVzZ5l0mezt5WaZ1iSd/V7usSE
         VdwfuSQl3kWiUXf60cS+ywVUJvAVo3zU6X9zZukctX20Ch63DybhOoXW7kOIOcMvaVi7
         8TbN9rX+daAhK2v5WE3vVKQGvPQEELkLAabi/nLVt2cecEY6c09PhXsg2J4KrGs2nhoG
         Xvv/S/hVCnBC26sgcjtbJSKFgZRzR9EaADF6+YV3DQTKQPgaasFKPtXf2CM49CrqFlcr
         4ADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FZHL/iuYMdL1Q5Q0lbUGAA5ha/63sGJlTW3uVbXhIq4=;
        b=BHE7zva7zp633SFGBC1OCBSshgYYFXb9S8rH9f1clUjtnCkxkpST626hWASHZjVjMU
         xoRhMbC2ir/rSXxXajd5CdLxHtUfdTUHGf3AveIzXvmZhEHJi0j3/R9xkq/+AQWYY8pn
         eUn51DDmX2gEDRtcqt8nGQGkEX7gUTa+iEPFQ5jv2WLLaIKcekZaamgwAZriyAhVdKYU
         c6Ee4wHemCaKPk2jZxmPS9cipwGln6c+gqsASbpsrRkzwP/7gOL1wEMMJL1YBmcH2n3S
         oqOAlO4WPJyQ+BpJ7jb8/+K/3Lq57FQqPvU/+Tb5TNZrmH+adAQ+UEAZMWcfQxLxwB5X
         IfJw==
X-Gm-Message-State: AOAM531r3WAoaGsy+ktbCbDF2IEVzS/xlekrUkQXMbaGCt1j3+zUAOuY
        UifBJpDJ+NVF2bsX6vyKZxE=
X-Google-Smtp-Source: ABdhPJxOf3zzbxuyCPIXNbr/s14+o4+NkL3mIKdcikVvQRPUavggsjoyNTl3waUm6qi/R7d1dVBgKA==
X-Received: by 2002:a05:6a00:234f:b029:2c4:b8d6:843 with SMTP id j15-20020a056a00234fb02902c4b8d60843mr34899949pfj.71.1622029965250;
        Wed, 26 May 2021 04:52:45 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id s48sm15328843pfw.205.2021.05.26.04.52.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 04:52:44 -0700 (PDT)
From:   Haocheng Xie <xiehaocheng.cn@gmail.com>
To:     mingo@kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Haocheng Xie <xiehaocheng.cn@gmail.com>
Subject: [PATCH 2/3] perf core: Fix some kernel-doc warnings.
Date:   Wed, 26 May 2021 19:52:19 +0800
Message-Id: <20210526115220.19134-3-xiehaocheng.cn@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210526115220.19134-1-xiehaocheng.cn@gmail.com>
References: <20210526115220.19134-1-xiehaocheng.cn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following W=1 kernel build warning(s):
kernel/events/core.c:143: warning: Function parameter or member 'cpu' not described in 'cpu_function_call'
kernel/events/core.c:11924: warning: Function parameter or member 'flags' not described in 'sys_perf_event_open'
kernel/events/core.c:12382: warning: Function parameter or member 'overflow_handler' not described in 'perf_event_create_kernel_counter'
kernel/events/core.c:12382: warning: Function parameter or member 'context' not described in 'perf_event_create_kernel_counter'

Signed-off-by: Haocheng Xie <xiehaocheng.cn@gmail.com>
---
 kernel/events/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0d98d6a..7988e40 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -132,6 +132,7 @@ task_function_call(struct task_struct *p, remote_function_f func, void *info)
 
 /**
  * cpu_function_call - call a function on the cpu
+ * @cpu:	target cpu to queue this function
  * @func:	the function to be called
  * @info:	the function call argument
  *
@@ -11917,6 +11918,7 @@ __perf_event_ctx_lock_double(struct perf_event *group_leader,
  * @pid:		target pid
  * @cpu:		target cpu
  * @group_fd:		group leader event fd
+ * @flags:		perf event open flags
  */
 SYSCALL_DEFINE5(perf_event_open,
 		struct perf_event_attr __user *, attr_uptr,
@@ -12373,6 +12375,8 @@ SYSCALL_DEFINE5(perf_event_open,
  * @attr: attributes of the counter to create
  * @cpu: cpu in which the counter is bound
  * @task: task to profile (NULL for percpu)
+ * @overflow_handler: callback to trigger when we hit the event
+ * @context: context data could be used in overflow_handler callback
  */
 struct perf_event *
 perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
-- 
2.9.5

