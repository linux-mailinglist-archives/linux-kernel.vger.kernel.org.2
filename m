Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A3935546D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237885AbhDFNBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 09:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344271AbhDFNBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:01:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECDAC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 06:00:53 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x15so4929339wrq.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 06:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TQsxexa3T+Z496By8VAQlabZky9oEX79or1BvBToCMI=;
        b=j3UgDym77mqTaUemj+qpZDsP5qaZUMgN5MZHPGE0+mWcWHU8delNisgG16lrO1n8wP
         zBvMKh5nk/nLPVKU/u1hIsWGwosMw2i8+KhUIGpSIkEpXpu+GxyGHboxxHn799dwKCCk
         ZdKVG3q5BWvct0wrCg00/lTaxnt4efNlt9e9AXOJKXpkhbeGGkyu/0zPgZmtP5rbst+S
         TxA9mXOemACJTtbCf3ejuYsaxzhmGt0jxfou1X2Ofpc8mJRIA9mMAv5J0wN3bDLCdk7I
         uLeYMH6/p2WfJaOAmpQvKUJcgf8Ry26sPs448oPF8TZpgc/LfV3Z3zSZD5J9GptV5ll3
         1IBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TQsxexa3T+Z496By8VAQlabZky9oEX79or1BvBToCMI=;
        b=PHa5I1ZogKd/ls3sy1U7i7W66jPykQDgXkq7yj+fprXWCbxwfcG0Ze6puvDibQLYmE
         yU+VSUv3MdCP2fycNrred9qoX84EbUCT842bpT4wPwo84+5kF6GuPa5V2PyMUNidl2Gx
         fhT+tAYToMnbns9AYM/HKjWQUivhe6J+2/kn2VlrdLBO3BQOcdMihSYTSk8FIuu3Aa1k
         h1FkhyenQwpKtYNAFFrZKjVkPwIEc6yHzslnEeyVQDmWRFtbkATBjt8G/p4ogZYsTgBZ
         sADLSBuHZHcv4M30sreOUZXvHln3GAuO6dHjaUglE0MhetNe2TRRkh+Zqz99q/TrfmXX
         oteQ==
X-Gm-Message-State: AOAM5307cfVYQsUh4XWN3S91h/o+M+vTykCfnXz+HuB1bs5M5ZlwDzKw
        BpcQ+9p96zM3H0EQo1go9n0=
X-Google-Smtp-Source: ABdhPJwNVtaa0vmr5cSzf2w77xmw5/OAqp+Y5y2cXWEiGRivxA+ukdZ1+Nf2KhxdjGvNpxYhbnYsHQ==
X-Received: by 2002:a5d:58e5:: with SMTP id f5mr21171671wrd.131.1617714051923;
        Tue, 06 Apr 2021 06:00:51 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id p5sm2251371wme.23.2021.04.06.06.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 06:00:51 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     tglx@linutronix.de, daniel.lezcano@linaro.org
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>
Subject: [PATCH v2 0/2] Fix missing entropy on Zynq arch due to get_cycles() not supported
Date:   Tue,  6 Apr 2021 15:00:43 +0200
Message-Id: <20210406130045.15491-1-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes wrt v1:
 - rebased on latest kernel tree
 - fix cover letter: does -> doesn't

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

Unfortunately timer-cadence-ttc driver doesn't register itself via
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
