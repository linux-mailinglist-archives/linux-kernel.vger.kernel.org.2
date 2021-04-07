Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4E9356C57
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352339AbhDGMjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352249AbhDGMi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:38:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C3EC061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 05:38:17 -0700 (PDT)
Date:   Wed, 07 Apr 2021 12:38:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617799093;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5QtZSXIK3BgtjFyohiVrzVfSKr/0wz1TShGyQh7YR/A=;
        b=nxqPXufUHhJftMtWVX/by3i5WZ3lON5CjfoKSwbwWU1lBs7wHMVkIjl7/8nI7y268KZLo3
        hc74qGdt7nFW1VRX+DbArDacxQTODwkKsbQBoEivT7QXzY9CQpOz4eKd5ppF/P/8ozYbQb
        67G22yahcfVaLlBMmoymMsozPnv9Of3yIIrrGB/eISAlvcdGW5O4+PSfCnCT01nPp/2kKa
        K38CZG5m7CwBDkskIkdf3E7HtdKw8ZFPgk6Luzs/QvB7U/VxmVxElnJbtkxbTbFIVxJJDv
        u/S1i+wb4YeLMD8W5bZjIp5+ix3AIHwRyAraUXxemv6XxOOmZq0I8ZWjV6aDnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617799093;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5QtZSXIK3BgtjFyohiVrzVfSKr/0wz1TShGyQh7YR/A=;
        b=FAcSVXnr7llGNraFa1MweDqb4vx+3p92g06LmYiH4AGGtPFyBPOoaVgiCry2FRttUWabog
        YbVkluUO41NICbBg==
From:   "irqchip-bot for Erwan Le Ray" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/stm32: Add usart instances exti
 direct event support
Cc:     Erwan Le Ray <erwan.leray@foss.st.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210319184253.5841-4-erwan.leray@foss.st.com>
References: <20210319184253.5841-4-erwan.leray@foss.st.com>
MIME-Version: 1.0
Message-ID: <161779909326.29796.193657241521429232.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     e12c455055e9abc7403ce532616c0124a9d85ee7
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e12c455055e9abc7403ce532616c0124a9d85ee7
Author:        Erwan Le Ray <erwan.leray@foss.st.com>
AuthorDate:    Fri, 19 Mar 2021 19:42:51 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 07 Apr 2021 13:25:52 +01:00

irqchip/stm32: Add usart instances exti direct event support

Add following usart instances exti direct event support (used for UART wake
up).
- exti 26 (USART1) is mapped to GIC 37
- exti 27 (USART2) is mapped to GIC 38
- exti 28 (USART3) is mapped to GIC 39
- exti 29 (USART6) is mapped to GIC 71
- exti 31 (UART5) is mapped to GIC 53
- exti 32 (UART7) is mapped to GIC 82
- exti 33 (UART8) is mapped to GIC 83

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210319184253.5841-4-erwan.leray@foss.st.com
---
 drivers/irqchip/irq-stm32-exti.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 8662d7b..b9db90c 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -193,7 +193,14 @@ static const struct stm32_desc_irq stm32mp1_desc_irq[] = {
 	{ .exti = 23, .irq_parent = 72, .chip = &stm32_exti_h_chip_direct },
 	{ .exti = 24, .irq_parent = 95, .chip = &stm32_exti_h_chip_direct },
 	{ .exti = 25, .irq_parent = 107, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 26, .irq_parent = 37, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 27, .irq_parent = 38, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 28, .irq_parent = 39, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 29, .irq_parent = 71, .chip = &stm32_exti_h_chip_direct },
 	{ .exti = 30, .irq_parent = 52, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 31, .irq_parent = 53, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 32, .irq_parent = 82, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 33, .irq_parent = 83, .chip = &stm32_exti_h_chip_direct },
 	{ .exti = 47, .irq_parent = 93, .chip = &stm32_exti_h_chip_direct },
 	{ .exti = 48, .irq_parent = 138, .chip = &stm32_exti_h_chip_direct },
 	{ .exti = 50, .irq_parent = 139, .chip = &stm32_exti_h_chip_direct },
