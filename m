Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A1E356C48
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352276AbhDGMiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:38:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36396 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352235AbhDGMiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:38:25 -0400
Date:   Wed, 07 Apr 2021 12:38:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617799095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LCbEgVfG57tjZ581n0k2EJnV+gRsi8SeGv6qu5fKZNc=;
        b=cGw08K86dcuybS/mUav54i6DR1NQR/QSOxu4sc85asrmOvJBDqPEgdVV4A0wwlpuWtXoIL
        n6L9oJ+mvyGJ3U0/PcII4p+fCcUHo3bWIk4jrHJSF7stybSYoVZJJAyBvIt2mgOUmbK6XZ
        Dy3OJ+Riw6W/DNz6OlujUF7QtymU9bMW7KCTuVopOSl5EtMY7oxpV7AZxqNhHMHdbtnxvm
        9nGp66q84+WN48mJJm42iFkxoqyxHyOr+KgcNedu6C4tZhqVxkxKLoScOtP7YemRCd8Hy1
        2K+YECGQV8wv1vPrB5G8+WbAgtcdkYTUxnL2nAlovjWDYYQ8Q7+j3l/4+/F8/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617799095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LCbEgVfG57tjZ581n0k2EJnV+gRsi8SeGv6qu5fKZNc=;
        b=gUBzx3QjF4wxFGU92/+VJ8WLU1UFa3FpqVoiYDg0a9VRb8oxTu4LfNRNfvXAg1ynz+geNW
        cgTCeW5uUYm9KSAA==
From:   "irqchip-bot for Hao Fang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/hisi: Use the correct HiSilicon copyright
Cc:     Hao Fang <fanghao11@huawei.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <1617086780-8521-1-git-send-email-fanghao11@huawei.com>
References: <1617086780-8521-1-git-send-email-fanghao11@huawei.com>
MIME-Version: 1.0
Message-ID: <161779909441.29796.12071837957118545903.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     64ec2ad3b84d43926e618bb515f2382c266535ee
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/64ec2ad3b84d43926e618bb515f2382c266535ee
Author:        Hao Fang <fanghao11@huawei.com>
AuthorDate:    Tue, 30 Mar 2021 14:46:20 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 07 Apr 2021 13:25:52 +01:00

irqchip/hisi: Use the correct HiSilicon copyright

s/Hisilicon/HiSilicon/
It should use capital S, according to
https://www.hisilicon.com/en/terms-of-use.

Signed-off-by: Hao Fang <fanghao11@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1617086780-8521-1-git-send-email-fanghao11@huawei.com
---
 drivers/irqchip/irq-hip04.c  | 4 ++--
 drivers/irqchip/irq-mbigen.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
index a6ed877..058ebae 100644
--- a/drivers/irqchip/irq-hip04.c
+++ b/drivers/irqchip/irq-hip04.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Hisilicon HiP04 INTC
+ * HiSilicon HiP04 INTC
  *
  * Copyright (C) 2002-2014 ARM Limited.
- * Copyright (c) 2013-2014 Hisilicon Ltd.
+ * Copyright (c) 2013-2014 HiSilicon Ltd.
  * Copyright (c) 2013-2014 Linaro Ltd.
  *
  * Interrupt architecture for the HIP04 INTC:
diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index ff7627b..2cb45c6 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2015 Hisilicon Limited, All Rights Reserved.
+ * Copyright (C) 2015 HiSilicon Limited, All Rights Reserved.
  * Author: Jun Ma <majun258@huawei.com>
  * Author: Yun Wu <wuyun.wu@huawei.com>
  */
@@ -390,4 +390,4 @@ module_platform_driver(mbigen_platform_driver);
 MODULE_AUTHOR("Jun Ma <majun258@huawei.com>");
 MODULE_AUTHOR("Yun Wu <wuyun.wu@huawei.com>");
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Hisilicon MBI Generator driver");
+MODULE_DESCRIPTION("HiSilicon MBI Generator driver");
