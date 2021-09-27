Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA764194EF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 15:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbhI0NTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 09:19:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234421AbhI0NTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 09:19:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26F1760F12;
        Mon, 27 Sep 2021 13:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632748679;
        bh=uFqO+1jnmCX9nfTiURK9XQ8PfCqV6zEhlQO3ToJ040g=;
        h=From:To:Cc:Subject:Date:From;
        b=koMygb7TX3kiBcxXaZVly2RcdzwQYT6PpFyIvedGAI9Bk+Pj272u2UFF06He+xKpv
         Xxuc2m0dRsoVyvowZV+cfYN4DEbb72CDuyb5CpNCBrZfOZQaFr4HLRIrlilXFo1/p0
         LkVsBCWflIfEqg+pMvBVNcO4XHu+OHXZZurQa5LCS5FkqVXW+K/gE74Thj1zlakdRw
         kK815j/PpscM99CI4CqJ6Q8/NwbRhAV1m62zuqMocLlByGyXNr6SnPQhbYjK8Cizhw
         6bCOKFQilbA1WJLDSF94vXueP8N8o1/8JjWN6WGojopLmMI42vgRIFxkW55E8TD7iy
         /HhqQX74X9Egg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Barry Song <baohua@kernel.org>,
        Andrea Merello <andrea.merello@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource: ti-dmtimer: select TIMER_OF when needed
Date:   Mon, 27 Sep 2021 15:17:49 +0200
Message-Id: <20210927131754.1587924-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_OF is enabled but CONFIG_TIMER_OF is not, building the
dm systimer driver produces a warning:

arm-linux-gnueabi-ld: warning: orphan section `__timer_of_table' from `drivers/clocksource/timer-ti-dm-systimer.o' being placed in section `__timer_of_table'

Address this by selecting the TIMER_OF symbol in this configuration.
If CONFIG_OF is disabled, the table entry is not created, so there
is no warning, and no reason to have the infrastructure.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clocksource/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 0f5e3983951a..f006d29e50f5 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -24,6 +24,7 @@ config I8253_LOCK
 
 config OMAP_DM_TIMER
 	bool
+	select TIMER_OF if OF
 
 config CLKBLD_I8253
 	def_bool y if CLKSRC_I8253 || CLKEVT_I8253 || I8253_LOCK
-- 
2.29.2

