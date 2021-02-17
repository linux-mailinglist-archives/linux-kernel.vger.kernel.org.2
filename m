Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CBC31D7F7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 12:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhBQLKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 06:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbhBQLH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:07:57 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4454C061756
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 03:07:14 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id a207so3245585wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 03:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0viQUj5Dr40nhdd+nbH060vF+sT9j2nptYrLWR14fgQ=;
        b=inXAa2Oc3moxxLXWr3kSM1NnCVXHDIZJdoCbdo/Otczc2T55Yld5fb0Xcz6tg2GchS
         Yhn5FPcXkRsE0L4mHJM+u8o4WAxye0KqBCxxqxc88n/gFD3a1OfQZEYIh1bTSUgs7Mdg
         FQj0tH9DTUKwJur5CsX0JzDw/0kBCfz2lokqNgZYAoPTna6H8LVufUeeLazj3TYbYHvc
         sm6McUnM6kqWkbzUuOGaxTS4O7cP3pc6iK7Fs4PqqLE5mxA5f2MDAeK6aUM/IVCB6F6Z
         aPg70gSaHnnlDkLO8xZfqU08ClFEtOaHH2ZwU6tONh5QHoFnhouS6AXEswBBf0R2dKXS
         p+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0viQUj5Dr40nhdd+nbH060vF+sT9j2nptYrLWR14fgQ=;
        b=LLpcBffUvR/R6zQzrEA9wrBle1OXlwo5xFHlEkMy2taQBaEYkEnOBKkCOlyx/x/t1Y
         ko7RcjY5qPeGMEUDH2MmKKb9BYW2AArpsFT+aVx5lpkI0W2ltl+0i0Pqdo6fMDM3y4qw
         ug8XAZNC+OTqitpvBBkT2ml1oKWYtrtpEbCp2hhVzn1RbaKCSuCMrBisSOh0r1zqMRgq
         PFDrDahQnhP04Xpw4V3eaCyn+iF7sGjgBoAczF3Ku2YrZ6CvUVf62C594IwOzqgPtObr
         kwT2MRsoB7b0spb06bzvZrQXBJGDISj/JkDhAmuaEUHCHJ45VgyOKTb8NHiUNH3/rx0G
         Abqw==
X-Gm-Message-State: AOAM530zmkHxnOQwpyac/uayi7KpVbqbLZrX5wlC77MVkgQiyl2atW98
        OCUHwhfSgQBQWKbaMLUOGbA=
X-Google-Smtp-Source: ABdhPJwcMRjozqtTz0qQ9Hsbqsaw5xZcXHmRuIkFQHT8j1PJ/vVSRVS5HYYSD7mYLWz5NXF+5gwi/A==
X-Received: by 2002:a7b:c055:: with SMTP id u21mr6894105wmc.68.1613560033609;
        Wed, 17 Feb 2021 03:07:13 -0800 (PST)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id y1sm3594073wrr.41.2021.02.17.03.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 03:07:13 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     tglx@linutronix.de, daniel.lezcano@linaro.org
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>
Subject: [PATCH 0/2] Fix missing entropy on Zynq arch due to get_cycles() not supported
Date:   Wed, 17 Feb 2021 12:07:07 +0100
Message-Id: <20210217110709.17250-1-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A real-world problem has been seen with a Zynq-based board running
Debian 10, where ssh daemon takes a really long time to come up at boot.
This is due to lack of random numbers.

Since commit 50ee7529ec450 ("random: try to actively add entropy rather
than passively wait for it") we try to generate entropy whenever we are
in short of random numbers and someone needs them.

This trick works only when CPU cycle counter is available. On ARM this
means that get_cycles() works and in turn read_current_timer() works.

Zynq HW includes two "cadence TTC" timers and the "ARM global timer".
All these pieces of HW are fed by the CPU clock, which dynamically
changes whenever CPU frequency scaling is enabled.

In timer-cadence-ttc driver this scenario is handled by looking at parent
clock changes and adjusting things when required. This is the only usable
clocksource when CPU frequency scaling is in use. arm_global_timer driver
is disabled in Kconfig when CPU_FREQ is enabled for Zynq arch.

Unfortunately timer-cadence-ttc driver does register itself via
register_current_timer_delay() and that ultimately ends up in get_cycles()
to always return zero, causing the aforementioned lack of entropy problem.
I believe that the reason for this is because Cadence TTC counter on Zynq
silicon is only 16-bit wide.

This patchset works around this by implementing in ARM global timer driver
a mechanism to compensate for parent clock variations, similarly to what
it's done in Cadence TTC timer driver, so that it can be used together
with CPU frequency scaling on Zynq arch.

This proved to finally fix the problem on my Zynq-based Z-turn board.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Sören Brinkmann <soren.brinkmann@xilinx.com>

Andrea Merello (2):
  clocksource: arm_global_timer: implement rate compensation whenever
    source clock changes
  arm: zynq: don't disable CONFIG_ARM_GLOBAL_TIMER due to
    CONFIG_CPU_FREQ anymore

 arch/arm/mach-zynq/Kconfig             |   2 +-
 drivers/clocksource/Kconfig            |  14 +++
 drivers/clocksource/arm_global_timer.c | 122 +++++++++++++++++++++++--
 3 files changed, 127 insertions(+), 11 deletions(-)

--
2.17.1
