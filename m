Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C3030EDBB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 08:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbhBDHtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 02:49:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:53496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231941AbhBDHtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:49:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E614864F58;
        Thu,  4 Feb 2021 07:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612424945;
        bh=vldJ8HGaaMvyR/5mHcV4ad1G9JhEqGjP67/WFiw35Kg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fZyhS9gscElkLINZbfkvRSFLrGTzrsKSgWZ1CyaNEEI203aan1IoceypiUYcEM8bw
         PMhxxenzwJHbzjp6I1zl1YhLqFCHeyz0ukjDwboSgRaY87S6l/LBIIWpTGut5bdSJJ
         oLyDBlFF3XzKhWydwf2EX14WyvRm12xd2U8l+GHKKCHhJCbkdw6PzMGt7HKDyyYZle
         fkYIksC6hs9z4/Q0LBcAjNoYULOyFW1CLbuG74z5G3a2bE5xlVZnd7sdwhHkS3w8Vi
         Lbo1L9x7sLX6Yg1no0EMXSZnMqcUCps4rW//kw0I7MroQ6F2daMksGcMpkab61/cDK
         9HdlDHCiKWBzA==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v2 2/2] drivers/clocksource: Fixup csky,mptimer compile error with CPU_CK610
Date:   Thu,  4 Feb 2021 15:46:09 +0800
Message-Id: <20210204074609.3553018-2-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210204074609.3553018-1-guoren@kernel.org>
References: <20210204074609.3553018-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The timer-mp-csky.c only could support CPU_CK860 and it will
compile error with CPU_CK610.

It has been selected in arch/csky/Kconfig.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/clocksource/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---
v2: Drop the string after bool,
    as suggested by Marc Zyngier <maz@kernel.org>

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 14c7c4712478..d39e6ca86d25 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -662,7 +662,7 @@ config CLINT_TIMER
 	  driver is usually used for NoMMU RISC-V systems.
 
 config CSKY_MP_TIMER
-	bool "SMP Timer for the C-SKY platform" if COMPILE_TEST
+	bool
 	depends on CSKY
 	select TIMER_OF
 	help
-- 
2.17.1

