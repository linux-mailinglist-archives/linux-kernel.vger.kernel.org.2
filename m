Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AF34390E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhJYIOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:14:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53258 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbhJYIOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:14:14 -0400
Date:   Mon, 25 Oct 2021 08:11:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635149511;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yZjqLOaREUpFP0Tbs9fP5VnqLWu0K2V7kZM7cKufCdE=;
        b=peQ955SzCl81MTmntgUOOP+bKNHmn8K4pGirBHalzQmX9EHbRLJMbKrETxVZdVIIqf1X6O
        qSM1FQXcLkbaHq2ayg+DfE/14LvC2KdknYKWgutM6qWpjdDtneDkQ5MdSTit6+YB9NEoM9
        ivqw4o7fYi39NdoNBb79jZpIWj9sJ+Wn5DCXhOhEq8VyTpX4Lz7VwuZK+FCb+TTBxf8e//
        KAgq+TxWt9CpFUB0+6c7L4RILEIfkq3CC4r36IqZbX2oZEaPa8JShfg0+H6xkxtaIsL3da
        NMWtIDcoXZGZkUuvQAVcfzxAh8bR2Y+ICtv5Dk8Bp0OmfNwvTKPwzijSq1wFHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635149511;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yZjqLOaREUpFP0Tbs9fP5VnqLWu0K2V7kZM7cKufCdE=;
        b=OVmgAp/i1YerAfqRzIhPwb2IdR4j5WXryjGDYfirwvcwzB32A30AOx+cQ+9TCs04SX9qCa
        BYCV0/7FHBAHyiDw==
From:   "irqchip-bot for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip: Fix compile-testing without CONFIG_OF
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211022154927.920491-1-arnd@kernel.org>
References: <20211022154927.920491-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <163514951015.626.4566172897212223672.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     1ba5478270a5c3a02b08052a3c003c282f2db94a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/1ba5478270a5c3a02b08052a3c003c282f2db94a
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Fri, 22 Oct 2021 17:49:21 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 25 Oct 2021 08:55:42 +01:00

irqchip: Fix compile-testing without CONFIG_OF

Drivers using the new IRQCHIP_PLATFORM_DRIVER_BEGIN helper
fail to link when compile-testing without CONFIG_OF,
as that means CONFIG_IRQCHIP is disabled as well:

ld.lld: error: undefined symbol: platform_irqchip_probe
>>> referenced by irq-meson-gpio.c
>>>               irqchip/irq-meson-gpio.o:(meson_gpio_intc_driver) in archive drivers/built-in.a
>>> referenced by irq-mchp-eic.c
>>>               irqchip/irq-mchp-eic.o:(mchp_eic_driver) in archive drivers/built-in.a

As the drivers are not actually used in this case, just
making the reference to this symbol conditional helps
avoid the link failure.

Fixes: f8410e626569 ("irqchip: Add IRQCHIP_PLATFORM_DRIVER_BEGIN/END and IRQCHIP_MATCH helper macros")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211022154927.920491-1-arnd@kernel.org
---
 include/linux/irqchip.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index 67351aa..29dbe67 100644
--- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -39,8 +39,9 @@ static const struct of_device_id drv_name##_irqchip_match_table[] = {
 	{},								\
 };									\
 MODULE_DEVICE_TABLE(of, drv_name##_irqchip_match_table);		\
-static struct platform_driver drv_name##_driver = {		\
-	.probe  = platform_irqchip_probe,				\
+static struct platform_driver drv_name##_driver = {			\
+	.probe  = IS_ENABLED(CONFIG_IRQCHIP) ? 				\
+			platform_irqchip_probe : NULL,			\
 	.driver = {							\
 		.name = #drv_name,					\
 		.owner = THIS_MODULE,					\
