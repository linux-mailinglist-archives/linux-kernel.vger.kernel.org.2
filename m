Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD15419502
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 15:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbhI0NZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 09:25:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234058AbhI0NZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 09:25:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 222FD61052;
        Mon, 27 Sep 2021 13:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632749052;
        bh=uFqO+1jnmCX9nfTiURK9XQ8PfCqV6zEhlQO3ToJ040g=;
        h=From:To:Cc:Subject:Date:From;
        b=DfELuey8r0YSmv9YrPVdS25huolGBwVeUXzml7G0UH7Y+vWe88IPmDcNGvvYsNGzJ
         bfW+jcoZNf/FYFjo6uOeikTlQHU1VZssG8wWHVFqTyFKVUpNTD67174TNsPH2WOHoM
         /POf/3vJ8D+DL8z2Rsgpr1Lmx9c4QQWBQHTf4g5AdI1W+d9B/NyxBnzTJzZcLvyFZs
         ygiXVkYhFF8CS/NC3dJWxmK0eIqEOPk8/IgaRYtSJgYSd++RkESu/mTbxkyiTm5PR+
         mQKaLt7xpOkxoyaQgRhIeZxJ0290kK1Ze5vzZMnxrnhb+Bhfm7Mvt2vzkH4CkgwsPC
         tGi0jNjLX5uOg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource: ti-dmtimer: select TIMER_OF when needed
Date:   Mon, 27 Sep 2021 15:23:54 +0200
Message-Id: <20210927132408.1588697-1-arnd@kernel.org>
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

