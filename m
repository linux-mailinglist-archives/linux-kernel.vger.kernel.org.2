Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C193B5957
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhF1HCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhF1HCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:02:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5970FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:00:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id v20so9552474eji.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/ZTnZkYKek+5EDiWJLcDLFzzSu7VX9SBVVqHtordz78=;
        b=KdTQmykmJOGUbeEE6oEB5bGZTq63btGbVnCfp9JgeTiG3lj6tYaS2LzIUu+xvHkiy4
         FAyd02jW0DpRPpk4IzYKZ3b6BwvHB9MaZixrzgaxDXAzD3nclAzSlpIJrTdtuiuhURK1
         yYSPJi9UYDXY294a5QeaZGHUrvfsHbI6xTPWkCJoAJfwhvQur6g9X+5sJFBqFgT2+y/r
         k6SXx8ahIkb68D7nuQRt5wE7vmMMF/gITDHEBCOW7oQRRudVCo68DVYEyHCN0lYm3ZB4
         UJWbRoemdyJc8tC9ti1tGH5i4x6j9jmJXbcwbglH/bzBTI3HhaIPx2fcAK1LUhYXg4ne
         epbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=/ZTnZkYKek+5EDiWJLcDLFzzSu7VX9SBVVqHtordz78=;
        b=MuD3GtCSc8XeTsFtdErLvJN1cSe9nvG+YBQTokQ7CJPfs7imqDMTLx3ITtsczKoqLZ
         +p3FxLvvoDU9GqAj+H1HOQrRn9CR9TjdzsBRP/iHaq2IAitXKQiQGcHkXMwlx0BFAv9w
         MzX0qXwIJKPUVEXFoyl6TNNrBJQV+J2/NOxI95XZn1Zwat8aWgEgu69i2iwC09cEzL54
         UnskJig+sY8W4dFOLJFPjJ+Ao7H2cb02vjvvU8Y9SovPnUaoGdVtWgdC3YGUcM2glAvz
         l8qeilLF+cZzqhy2/S0hxyPNDKArd2bl+cxGa0KIMbkdQR1y8EL+Q0i5rW0XUf62ccEK
         gAwQ==
X-Gm-Message-State: AOAM533m06MXGDE88+j4ZuhszH0Q5BupXzdT8WPMXh3ATkNlgbI8FYFP
        QCHS2b06n4x2ltEk+CTLWh0HeU01SuE=
X-Google-Smtp-Source: ABdhPJyu6H+i6XA4mpGDRZ1N7TQmyTvt8dtGj9LtVHgkT67q5y8kw1LBum3Tp25sglOGZxmfikhXgw==
X-Received: by 2002:a17:907:9fd:: with SMTP id ce29mr21953245ejc.62.1624863617954;
        Mon, 28 Jun 2021 00:00:17 -0700 (PDT)
Received: from gmail.com (94-21-131-96.pool.digikabel.hu. [94.21.131.96])
        by smtp.gmail.com with ESMTPSA id x2sm612347edv.61.2021.06.28.00.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 00:00:17 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 28 Jun 2021 09:00:15 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] timers/nohz updates for v5.14
Message-ID: <YNlzf+i1j/4wIUtC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest timers/nohz git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-nohz-2021-06-28

   # HEAD: 09fe880ed7a160ebbffb84a0a9096a075e314d2f MAINTAINERS: Add myself as context tracking maintainer

Updates to the tick/nohz code in this cycle:

 - Micro-optimize tick_nohz_full_cpu()

 - Optimize idle exit tick restarts to be less eager

 - Optimize tick_nohz_dep_set_task() to only wake up
   a single CPU. This reduces IPIs and interruptions
   on nohz_full CPUs.

 - Optimize tick_nohz_dep_set_signal() in a similar
   fashion.

 - Skip IPIs in tick_nohz_kick_task() when trying
   to kick a non-running task.

 - Micro-optimize tick_nohz_task_switch() IRQ flags
   handling to reduce context switching costs.

 - Misc cleanups and fixes

 Thanks,

	Ingo

------------------>
Frederic Weisbecker (4):
      tick/nohz: Remove superflous check for CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
      tick/nohz: Update nohz_full Kconfig help
      tick/nohz: Only wake up a single target cpu when kicking a task
      MAINTAINERS: Add myself as context tracking maintainer

Marcelo Tosatti (2):
      tick/nohz: Change signal tick dependency to wake up CPUs of member tasks
      tick/nohz: Kick only _queued_ task whose tick dependency is updated

Peter Zijlstra (2):
      tick/nohz: Evaluate the CPU expression after the static key
      tick/nohz: Call tick_nohz_task_switch() with interrupts disabled

Yunfeng Ye (2):
      tick/nohz: Conditionally restart tick on idle exit
      tick/nohz: Update idle_exittime on actual idle exit


 MAINTAINERS                    |   6 ++
 include/linux/sched.h          |   2 +
 include/linux/tick.h           |  26 +++++----
 kernel/sched/core.c            |   7 ++-
 kernel/time/Kconfig            |  11 ++--
 kernel/time/posix-cpu-timers.c |   4 +-
 kernel/time/tick-sched.c       | 129 ++++++++++++++++++++++++++++-------------
 7 files changed, 125 insertions(+), 60 deletions(-)
