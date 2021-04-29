Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339E736E307
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 03:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbhD2BoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 21:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhD2BoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 21:44:20 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA69C06138B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 18:43:35 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c17so10389817pfn.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 18:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W4UwE2Dbwa47OkyVoSFrNDymke2/cl1Ry9ysp9qho4Q=;
        b=wPkGlcF0955iBFFTsDYmWzReIFFILvyj3Xl9zQnh7GaknUyB4JiENrsp/rXfc+Yy+w
         WiqX3MN+IsYJZw4Gc3O5aUB658hl5UVck+EbetD0CdOIPGBIviL2QS/jmc+mCG3ejutf
         qqtZOYh1zAiEoV/yNlxFk6DrwoanvMo6vZqaicPk5om9J0eEvUVXt+6tpzpj8EzRBxlW
         f64AS4S4KPORiCRI8rcjV20PPruqh1YuYzdvWIR4CHksWpxRT0vf72UhyLaAO/UUiz+j
         puyBfKWzyO/U/SGwaZGdbgt0RH+Gl6N/CSCCsKcr31RVcAl2EjijJwRSfKWd+PdB98NN
         +P1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W4UwE2Dbwa47OkyVoSFrNDymke2/cl1Ry9ysp9qho4Q=;
        b=RiI3OE4FgDu2xqWBPR8qAJz2v7+tXr8H9M6yxB+MvBHPjXDLa9h7m6SJWvgdPp/EWh
         07Gd77JK0OhUp7GO8wQazWcGEBzqlpSXaB2kZrxAldn7dQHYk4F/e3mF5Wo/EnUREodm
         9KrxgFihDIG2Cv9RoPBBZhMgY5zeYHdExHR+ZJGfj3YoiJ0aGFB0YCdD393ZjXLU0xAl
         FhX9PSY3sZbGSUYGIbMrYMtu6z4MtTis/z0B9oIHgae+Un0+zxGIM8OWfMnnBxgCLvTS
         Cfkb9cqCZzk4j5o4Hmom5j4Y8W0LQfjURs0xefYmntANTIUaCRJDcuuqAj30rkFQ2eWA
         WUkA==
X-Gm-Message-State: AOAM531O9AWUgSxsIBorQ2V6yGT/gd+E4/Cz4Qr1Kcl+5GwKSGPUrCLs
        ojOqPRTOUnaUWGZZrb/GSrqX3Q==
X-Google-Smtp-Source: ABdhPJzmOB6NKYjVpqO6pigE8zHGwwDPUl3pMRk7roD7Cj4XxjhQ/7kOYTe6sgaayGF4i8Vm7yNbig==
X-Received: by 2002:a62:8747:0:b029:27f:6a61:c742 with SMTP id i68-20020a6287470000b029027f6a61c742mr988846pfe.3.1619660614717;
        Wed, 28 Apr 2021 18:43:34 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id in1sm5776107pjb.23.2021.04.28.18.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 18:43:34 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miroslav Benes <mbenes@suse.cz>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] arm64: stacktrace: Stop unwinding when the PC is zero
Date:   Thu, 29 Apr 2021 09:43:21 +0800
Message-Id: <20210429014321.196606-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When use ftrace for stack trace, it reports the spurious frame with the
PC value is zero.  This can be reproduced with commands:

  # cd /sys/kernel/debug/tracing/
  # echo "prev_pid == 0" > events/sched/sched_switch/filter
  # echo stacktrace > events/sched/sched_switch/trigger
  # echo 1 > events/sched/sched_switch/enable
  # cat trace

           <idle>-0       [005] d..2   259.621390: sched_switch: ...
           <idle>-0       [005] d..3   259.621394: <stack trace>
  => __schedule
  => schedule_idle
  => do_idle
  => cpu_startup_entry
  => secondary_start_kernel
  => 0

The kernel initializes FP/PC values as zero for swapper threads in
head.S, when walk the stack frame, this patch stops unwinding if detect
the PC value is zero, therefore can avoid the spurious frame.

Below is the stacktrace after applying the change:

  # cat trace

           <idle>-0       [005] d..2   259.621390: sched_switch: ...
           <idle>-0       [005] d..3   259.621394: <stack trace>
  => __schedule
  => schedule_idle
  => do_idle
  => cpu_startup_entry
  => secondary_start_kernel

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/kernel/stacktrace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 84b676bcf867..02b1e85b2026 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -145,7 +145,11 @@ void notrace walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
 		if (!fn(data, frame->pc))
 			break;
 		ret = unwind_frame(tsk, frame);
-		if (ret < 0)
+		/*
+		 * When the frame->pc is zero, it has reached to the initial pc
+		 * and fp values; stop unwinding for this case.
+		 */
+		if (ret < 0 || !frame->pc)
 			break;
 	}
 }
-- 
2.25.1

