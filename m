Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17686437A4F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 17:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbhJVPvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 11:51:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229484AbhJVPvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:51:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A12E860EB1;
        Fri, 22 Oct 2021 15:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634917770;
        bh=2+ZmpooXLd9OVhYm+4cTrzNK/WyfNUmvykJEvKioDXs=;
        h=From:To:Cc:Subject:Date:From;
        b=MbvOFku6d144+2gWZ8DzQAuLsRrZwlHLSTD5ACTChX4QtQOF1r5zmGWniOPywnkvn
         fgC9zky5151+oexsbPwNh0LNoRT6ue1oU4kXvRJZJX81h/mhaX8dpci5oBlqFmqwG/
         UbxUYJXGpThhGsruWDKtjcaaO/eu6X4CFitXPiJxFJ1eo8w+E2AnjBmR/kyCKYF54Q
         YyLSQdttDZwS/D5mN3ayV9Y7YOdykGWLxzAL1KQrM8AuJPAfKuPL6oZ4/ZBs+++VrN
         F3sSqp8fSde2OgrXRByNQQfrO+EtXpDSeyIGYMw/BzelhzbZ8Funfc6EmJDj5LPuZA
         BRhr6nMuZqiBg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Saravana Kannan <saravanak@google.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip: fix compile-testing without CONFIG_OF
Date:   Fri, 22 Oct 2021 17:49:21 +0200
Message-Id: <20211022154927.920491-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

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
---
 include/linux/irqchip.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index 7f007b9c23f8..3a091d0710ae 100644
--- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -48,8 +48,9 @@ static const struct of_device_id drv_name##_irqchip_match_table[] = {
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
-- 
2.29.2

