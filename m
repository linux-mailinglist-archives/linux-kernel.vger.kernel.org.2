Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924FE44F727
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 08:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbhKNHvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 02:51:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhKNHuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 02:50:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9AEB60F6B;
        Sun, 14 Nov 2021 07:47:56 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] time/sched_clock: Allow architecture to override cyc_to_ns()
Date:   Sun, 14 Nov 2021 15:47:04 +0800
Message-Id: <20211114074704.3508622-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current cyc_to_ns() implementation is like this:

static inline u64 notrace cyc_to_ns(u64 cyc, u32 mult, u32 shift)
{
	return (cyc * mult) >> shift;
}

But u64*u32 maybe overflow, so introduce ARCH_HAS_CYC_TO_NS to allow
architecture to override it.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 kernel/time/Kconfig       | 4 ++++
 kernel/time/sched_clock.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 04bfd62f5e5c..5093e67115e8 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -30,6 +30,10 @@ config GENERIC_TIME_VSYSCALL
 config GENERIC_CLOCKEVENTS
 	def_bool !LEGACY_TIMER_TICK
 
+# Architecture has its own cyc_to_ns() implementation
+config ARCH_HAS_CYC_TO_NS
+	bool
+
 # Architecture can handle broadcast in a driver-agnostic way
 config ARCH_HAS_TICK_BROADCAST
 	bool
diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index b1b9b12899f5..4496962e8e9f 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -63,10 +63,12 @@ static struct clock_data cd ____cacheline_aligned = {
 	.actual_read_sched_clock = jiffy_sched_clock_read,
 };
 
+#ifndef CONFIG_ARCH_HAS_CYC_TO_NS
 static inline u64 notrace cyc_to_ns(u64 cyc, u32 mult, u32 shift)
 {
 	return (cyc * mult) >> shift;
 }
+#endif
 
 notrace struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
 {
-- 
2.27.0

