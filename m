Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68E43B5260
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 08:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhF0Gvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 02:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhF0Gvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 02:51:51 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E317AC061574
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 23:49:27 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id s14so10020374pfg.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 23:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oVnqg/9Uz/jrBGQTH2rE/TzZmjGVIhWdCvOmIPyfW8U=;
        b=pHeCnD6KJ7u3h8mDiGl1LbeKTg45FmFhaYFlmLkPfYr1hVgfmCZx6KTIqeaGHX+pLJ
         tcUmzu4AEMEQvAwyB6Rb22x68kFZM2h5YNWvAiGPEQdAzzlMuXy/fcbhM9qXP5+BLOfk
         VeAhG+TH7GORlS/EtUUPJ8Mamu7N+Pz4VrVeuqNLd9oRnlRDwWitHI9hA01j5IbQjf63
         /2Ra8+0QReme/u/evY+6fxhW80ceq5qEFwgNSJYnowm6849kPLKsKUfEx3kMyZXHH5kj
         +SHZdX+uKX1SuCWy8B6UBy6Zgy0YKPsbs4MUyz/cBQokGlJPceUcllx1WLNXQzliRgH3
         Pd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oVnqg/9Uz/jrBGQTH2rE/TzZmjGVIhWdCvOmIPyfW8U=;
        b=p8XsYvocLZ1wahJ9Tag5dNrBcFRXU6RZukNx5ZhQa9xps5WX0S9yQUoWEPr0j1+J8j
         ZQZfiL+BbC4GXnNYTOE+8p7/ys0dSpQZtbFLW6OfexfvUFveLHZB1t771+iRDQNBzR0o
         NNjl/tkVxKFPlObj1qO75BDGhPClJ9yBtEnIYRtdQ4DuD4qGQWwRZaHatPs9KFufBxgt
         NWBzwGeC4bEX4GxqlkvYIOU9qYpVg6boJA9HrYUitjhWRqPptAppyFQMWV6IH/IP7GwG
         1wRF3JbrYc91aD9OOMusIOAW4Gm6krFjwOW70sKRg4yR3F4SVzUwmJCHI5tS7+NtAhpN
         GDnA==
X-Gm-Message-State: AOAM533oE9R+r94q+wZ4HJQw7LcH2iV/ZVIHbDR2MTbwpDK7hhv3hK7d
        /5cqWvCwZPCQGAsLe2uqywcVDhi0oKC4ww==
X-Google-Smtp-Source: ABdhPJxrtS2KtVqPsi1j2fvyepkoTGLUIruF/8HZpc113mVKlUNRjusm+XNMzcATEfvdyykqgv0LsQ==
X-Received: by 2002:a63:338c:: with SMTP id z134mr17678546pgz.167.1624776566930;
        Sat, 26 Jun 2021 23:49:26 -0700 (PDT)
Received: from anisinha-lenovo.ba.nuagenetworks.net ([115.96.154.39])
        by smtp.googlemail.com with ESMTPSA id 71sm10846133pfw.13.2021.06.26.23.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 23:49:26 -0700 (PDT)
From:   Ani Sinha <ani@anisinha.ca>
To:     linux-kernel@vger.kernel.org
Cc:     anirban.sinha@nokia.com, tglx@linutronix.de,
        Ani Sinha <ani@anisinha.ca>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH v1] Print a log when the sched clock is marked unstable
Date:   Sun, 27 Jun 2021 12:19:11 +0530
Message-Id: <20210627064911.2179786-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In other parts of the kernel when the sched clock transitions from
stable to unstable and vice versa, a kernel info log is printed.
When the sched clock is marked explicitly as unstable, we should
print an information log as well. This patch addresses this. It is
useful in cases where for example, we want to understand why a
certain feature like NOHZ, which depends on a stable sched clock, is
not available.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 kernel/sched/clock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

See also thread
https://lkml.org/lkml/2021/6/20/32

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index c2b2859ddd82..5a403b2c9b3f 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -192,8 +192,10 @@ void clear_sched_clock_stable(void)
 
 	smp_mb(); /* matches sched_clock_init_late() */
 
-	if (static_key_count(&sched_clock_running.key) == 2)
+	if (static_key_count(&sched_clock_running.key) == 2) {
+		pr_info("sched_clock: Marking unstable.\n");
 		__clear_sched_clock_stable();
+	}
 }
 
 static void __sched_clock_gtod_offset(void)
-- 
2.25.1
