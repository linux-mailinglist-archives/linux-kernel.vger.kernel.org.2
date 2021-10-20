Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3218434945
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 12:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhJTKsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 06:48:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229998AbhJTKsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 06:48:04 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C992610EA;
        Wed, 20 Oct 2021 10:45:50 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1md96S-000PUH-8O; Wed, 20 Oct 2021 11:45:48 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] irqchip: Provide stronger type checking for IRQCHIP_MATCH/IRQCHIP_DECLARE
Date:   Wed, 20 Oct 2021 11:45:27 +0100
Message-Id: <20211020104527.3066268-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, kernel-team@android.com, f.fainelli@gmail.com, robh@kernel.org, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both IRQCHIP_DECLARE() and IRQCHIP_MATCH() use an underlying of_device_id()
structure to encode the matching property and the init callback.
However, this callback is stored in as a void * pointer, which obviously
defeat any attempt at stronger type checking.

Work around this by providing a new macro that builds on top of the
__typecheck() primitive, and that can be used to warn when there is
a discrepency between the drivers and core code.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqchip.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index 67351aac65ef..5de0dfc5d64d 100644
--- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -14,8 +14,15 @@
 #include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 
+/* Undefined on purpose */
+extern of_irq_init_cb_t typecheck_irq_init_cb;
+
+#define typecheck_irq_init_cb(fn)					\
+	(__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
+
 /*
  * This macro must be used by the different irqchip drivers to declare
  * the association between their DT compatible string and their
@@ -26,14 +33,16 @@
  * @compstr: compatible string of the irqchip driver
  * @fn: initialization function
  */
-#define IRQCHIP_DECLARE(name, compat, fn) OF_DECLARE_2(irqchip, name, compat, fn)
+#define IRQCHIP_DECLARE(name, compat, fn)	\
+	OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
 
 extern int platform_irqchip_probe(struct platform_device *pdev);
 
 #define IRQCHIP_PLATFORM_DRIVER_BEGIN(drv_name) \
 static const struct of_device_id drv_name##_irqchip_match_table[] = {
 
-#define IRQCHIP_MATCH(compat, fn) { .compatible = compat, .data = fn },
+#define IRQCHIP_MATCH(compat, fn) { .compatible = compat,		\
+				    .data = typecheck_irq_init_cb(fn), },
 
 #define IRQCHIP_PLATFORM_DRIVER_END(drv_name)				\
 	{},								\
-- 
2.30.2

