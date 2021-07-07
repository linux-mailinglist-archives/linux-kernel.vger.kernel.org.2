Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163F03BE6BE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 12:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhGGLAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 07:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhGGLAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 07:00:10 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B33C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 03:57:29 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id h4so1821573pgp.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 03:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fU7A6ndNdKecxzw5Hn6NNKv96i2NSUujsQpW4dcFImc=;
        b=0z0/ZKcCIP4fDWl/nuVzfmML0Toa760ZVGpuy3B1cpD1PKMV25jy6rk3LE8ggTEOng
         ovuWk45OmXC0aXRqNzYRsqznutREV58QK+zomBNsV2+6qWHIEz/wCs1AIeSGSPm4cvIE
         hfHuhrh3tXFj7gFzvs/GHDvbsqMq53yX1Cb9sxPtgxyWiz3B0S48cDIh2hsZl0dKMM+D
         TdqaAwXHhNdUMULgZOwoBrVYyrtlybnXnCzSGSv+0MmSkT4YCmXsYBZHthfnOejxkEpu
         y8Hg9XTsT6oy89SYg8y/24f4vAUh9ijHLMWz55KNXvrm2pH8ISJeyYTLtkEyNpalBrHW
         FJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fU7A6ndNdKecxzw5Hn6NNKv96i2NSUujsQpW4dcFImc=;
        b=G/SXF1jph7XVLxErzJFGGuNgPXkiXTum7pvakvN9XzYeRRgvoTGzU4JCgLbKcnf01s
         eFhMPCp59ppfXu7jSvAyIwzAvf1bpDyepf/qQEl0tzJxRSpPJ4lFGLrLSC6evepF6Z6g
         0OYv5798VKACgMiJQYg4hGC3+wmTlJSrKtVqG4EhrZVeFUX3DJhH1vFf3AnXJz6xTZ5F
         apjMyW6Xu5m//vCyx6mSXM9JnvhmBZ1/WGCSy/HAaW6H3aEx4ZpdMNIpw5ptoKpmCe5V
         DhMWNUyWr21j/PPJenUrc5pdiDbfHQP3Ne8EDTcNwy3KYuYHVVlHJhBZJjXkafsOX+U4
         54mQ==
X-Gm-Message-State: AOAM531vBKB32Z1AKi3jv9B+posrYuin7ZHZDPy5ccr6vIM3TvHoHfR9
        vvkrpUL0K3W9xQvZKcS/QEGw1bqJzrRhrA==
X-Google-Smtp-Source: ABdhPJxZ+hxh5/lOFdL8FDpw9Ayt4+DD9FmRyQ4u7Eu4+H7ymyzWeKXkCueP5l60ZN2e/RyUeqQJvg==
X-Received: by 2002:a05:6a00:1903:b029:31d:f720:133f with SMTP id y3-20020a056a001903b029031df720133fmr16942921pfi.46.1625655449050;
        Wed, 07 Jul 2021 03:57:29 -0700 (PDT)
Received: from anisinha-lenovo.ba.nuagenetworks.net ([115.96.127.142])
        by smtp.googlemail.com with ESMTPSA id a65sm16190345pfa.11.2021.07.07.03.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 03:57:28 -0700 (PDT)
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
Subject: [PATCH v2] sched/clock: print a log when the sched clock is marked unstable
Date:   Wed,  7 Jul 2021 16:26:59 +0530
Message-Id: <20210707105659.194171-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the sched clock transitions from stable to unstable and
vice versa, a kernel log is printed. When the sched clock
is marked explicitly as unstable, make __clear_sched_clock_stable()
emit a warning log. It is useful for example in understanding
why a certain feature like NOHZ that depends on availability of a
stable sched clock, is not available.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 kernel/sched/clock.c | 1 +
 1 file changed, 1 insertion(+)

Changelog:
V1: original patch
v2: print pr_warn from __clear_sched_clock_stable instead. Commit log
    updated with proper prefix and wording.

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index c2b2859ddd82..99484fec0335 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -183,6 +183,7 @@ static void __clear_sched_clock_stable(void)
 		return;
 
 	tick_dep_set(TICK_DEP_BIT_CLOCK_UNSTABLE);
+	pr_warn("sched_clock: Marking unstable.\n");
 	schedule_work(&sched_clock_work);
 }
 
-- 
2.25.1

