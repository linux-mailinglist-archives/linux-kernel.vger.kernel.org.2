Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA3A38C1E1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 10:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhEUIdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 04:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbhEUIdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 04:33:43 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A706EC061763
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 01:32:20 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id u126-20020a3792840000b02902e769005fe1so15572558qkd.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 01:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eNYE7zpSOCj7plZZAyS+5aDrL5u+MfadoSDP0vm8/WQ=;
        b=XraWczXc5cxxOBDBtVGGfGFtPPc7wcCkrF3GfJOY2jod0PMBW5S0idtcykIynrztOj
         /8GPrUQbzqot1wTmeVWAetIzkEZC1/S5Vu+rB42C87I91OCbcj4/QLTjHI/aPfJDdCTP
         EKWcZBs9XSVgYlFXMB5dMLRsOVyVLy1EghdzRqGbvvRj7PdWjT2UdYdOPZixtq183drw
         ZFueMNvZ81RSFOJAehdyIKbW1168dtTXlz3Sfc+dU3I7Xj+0sk4N9kJkIhPwY56OJTjE
         0sotraP2uChwuL7Oo1h5ZZT6BV+qihPMQ9SFXO73vCLDONZnkh/H0+3yWIa8J4paZ8pA
         5BCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eNYE7zpSOCj7plZZAyS+5aDrL5u+MfadoSDP0vm8/WQ=;
        b=j9/N8fvaS8l7AjaJTeeG+31Q6xxdz2MgrzuLZXcEuQuomBOGZKZu5H5NMRDLYhd1Sx
         i8Ai2LWqZDm75oD5RjI7EIlhVduhJGm7x3HyY0gI+AExSTUZ+nGpgGNaQN63zwXcpUjP
         UDPsMFVE4u+r5BIyKnUQyy0QVZ5r+og6bSxvthyFMmIC3nxtI1XvNJijf2+Y7gtkNU2O
         DQjwIvnNIU3tSA/nCesDg5TTSFkcxCyyZi+OxIjxmJSa6/hJvWgn/D3emyLXhE450i3y
         Md7pWThBz0NOcqwDI9XKEiFnjWk+yVAB6I3lFgXcbe0pge5DYET5HVoYbqJ6BYwbBDdt
         aBtg==
X-Gm-Message-State: AOAM531SOg6/y+ZfOGlZO/I9zBdC3k8Qd2jH/lvKZfLXjIXue4+RCtpu
        nT5tvoZuEH8EmbQGzEU7jFMLFENZRA==
X-Google-Smtp-Source: ABdhPJxOtHW/s436pbUSNtX/1MJ9ezmdnT2dciQSffLNozLx/dfNTPZEQC900wdnfyRocBsiRRPvt7cIHg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:a932:cdd6:7230:17ba])
 (user=elver job=sendgmr) by 2002:a0c:dc07:: with SMTP id s7mr11433864qvk.26.1621585939685;
 Fri, 21 May 2021 01:32:19 -0700 (PDT)
Date:   Fri, 21 May 2021 10:32:09 +0200
Message-Id: <20210521083209.3740269-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH] kfence: use TASK_IDLE when awaiting allocation
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, Mel Gorman <mgorman@suse.de>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since wait_event() uses TASK_UNINTERRUPTIBLE by default, waiting for an
allocation counts towards load. However, for KFENCE, this does not make
any sense, since there is no busy work we're awaiting.

Instead, use TASK_IDLE via wait_event_idle() to not count towards load.

BugLink: https://bugzilla.suse.com/show_bug.cgi?id=1185565
Fixes: 407f1d8c1b5f ("kfence: await for allocation using wait_event")
Signed-off-by: Marco Elver <elver@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: <stable@vger.kernel.org> # v5.12+
---
 mm/kfence/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index e18fbbd5d9b4..4d21ac44d5d3 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -627,10 +627,10 @@ static void toggle_allocation_gate(struct work_struct *work)
 		 * During low activity with no allocations we might wait a
 		 * while; let's avoid the hung task warning.
 		 */
-		wait_event_timeout(allocation_wait, atomic_read(&kfence_allocation_gate),
-				   sysctl_hung_task_timeout_secs * HZ / 2);
+		wait_event_idle_timeout(allocation_wait, atomic_read(&kfence_allocation_gate),
+					sysctl_hung_task_timeout_secs * HZ / 2);
 	} else {
-		wait_event(allocation_wait, atomic_read(&kfence_allocation_gate));
+		wait_event_idle(allocation_wait, atomic_read(&kfence_allocation_gate));
 	}
 
 	/* Disable static key and reset timer. */
-- 
2.31.1.818.g46aad6cb9e-goog

