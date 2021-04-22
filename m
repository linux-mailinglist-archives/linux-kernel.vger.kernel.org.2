Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04871367A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 08:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhDVGpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 02:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbhDVGpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 02:45:36 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA85CC06138C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 23:45:01 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id n67-20020a1c59460000b0290114d1a03f5bso1301816wmb.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 23:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Sugwskr8rXy42pZ1xDG6/Yn9grQzLU2kaW/tniDjvCM=;
        b=rlmZAOT4B8TFqAZfZ08hCQP6c8Lo5iDRtrCmUNvvQfPE2MM8TQVihWTTmzMuSendWu
         yX+RaWI3/1avKzx9airDR9aL48aJWg8GIWMZcHboD9GKsYqKNJkl1Sd8UbVlDroUbRxT
         B6+HRfVChEHZtk9KTA1SSqpw+ZHUQvGm1Uz1fY6Rz2kq/qq6GvJzN/41hCtme7AQ5rsp
         PodsoHWH/gfa1Fbt9QmGwRjIM04KLoBHQpmiECbBz3g+6LRJ4YfkGhpRTe7QZIFbLGH+
         JKqayl8XPz7Stk7eXLPT/KB6A163xlvaydZwEuEw5tln8PZfuCouXuz3CO5LpRH2KTE8
         fKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Sugwskr8rXy42pZ1xDG6/Yn9grQzLU2kaW/tniDjvCM=;
        b=r96pi1JfEkf3wJQvAqaT4MMURt+Z9W9bu8S1yRTDeC8d1j3q+NwtPTgJ0kKr3lPCP8
         /zgVmTEINm/YuCjZbJSU9A+wcs3ubjUU4FjvbfmQHkEwaYfAA0j9cEeiADxLcPsPo6f5
         hjMWy4IG2LCamY2DD4yz0YLKTBdeENOvcjKT/s2yavfuNa/cIimLkzMlMYypluPx13sT
         2xeFScDR0NpfTRNL0CPQvhTrVNCJYmRb2YDoNxCqPfNnYf8aYs8vdme1WAnOmYmiidS3
         xtoP411L29zSN5x9NWe3e+HbfCb14P6LUE34k+mn+eHpsOnKSHTuustE0NJcoo+4IfqF
         Wugg==
X-Gm-Message-State: AOAM530hnTb8l6q3f08QH2O5CgaVTTSzYOm/CxLDIpnA+TJ0SURQp4tW
        C3z+c1XlrdiBhZGKd4Mr4yJK2tY1Hg==
X-Google-Smtp-Source: ABdhPJy+hre1G5RN1jq0nJSfzX61loPh+welwRzkqIFqp7alxaEk/o/Xx49s2TFsWZg2yfvXi5JrJ0YSHg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:6273:c89a:6562:e1ba])
 (user=elver job=sendgmr) by 2002:a05:600c:35cf:: with SMTP id
 r15mr12248413wmq.183.1619073899334; Wed, 21 Apr 2021 23:44:59 -0700 (PDT)
Date:   Thu, 22 Apr 2021 08:44:37 +0200
In-Reply-To: <20210422064437.3577327-1-elver@google.com>
Message-Id: <20210422064437.3577327-2-elver@google.com>
Mime-Version: 1.0
References: <20210422064437.3577327-1-elver@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH tip 2/2] signal, perf: Add missing TRAP_PERF case in siginfo_layout()
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org, mingo@redhat.com,
        tglx@linutronix.de
Cc:     m.szyprowski@samsung.com, jonathanh@nvidia.com, dvyukov@google.com,
        glider@google.com, arnd@arndb.de, christian@brauner.io,
        axboe@kernel.dk, pcc@google.com, oleg@redhat.com,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing TRAP_PERF case in siginfo_layout() for interpreting the
layout correctly as SIL_PERF_EVENT instead of just SIL_FAULT. This
ensures the si_perf field is copied and not just the si_addr field.

This was caught and tested by running the perf_events/sigtrap_threads
kselftest as a 32-bit binary with a 64-bit kernel.

Fixes: fb6cc127e0b6 ("signal: Introduce TRAP_PERF si_code and si_perf to siginfo")
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/signal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index 9ed81ee4ff17..b354655a0e57 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3251,6 +3251,8 @@ enum siginfo_layout siginfo_layout(unsigned sig, int si_code)
 			else if ((sig == SIGSEGV) && (si_code == SEGV_PKUERR))
 				layout = SIL_FAULT_PKUERR;
 #endif
+			else if ((sig == SIGTRAP) && (si_code == TRAP_PERF))
+				layout = SIL_PERF_EVENT;
 		}
 		else if (si_code <= NSIGPOLL)
 			layout = SIL_POLL;
-- 
2.31.1.498.g6c1eba8ee3d-goog

