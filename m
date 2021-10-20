Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3FF4352EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 20:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhJTSth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 14:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbhJTSt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 14:49:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BBEC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 11:47:14 -0700 (PDT)
Date:   Wed, 20 Oct 2021 18:47:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634755633;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h2ITyiP7sDrKaOQa2zA98QKpdJHuPfGzl5uc2AeW150=;
        b=2pmeVu6sFDhTTcJGyCv9dyvG8ybOto3BVM1PNsJ40yoPUtdSQgVloGXmVX2F2mSGLM5fS2
        sbM2ReUTcliecQKJZvRJ19gkJtYfOmrDl+wMNMsscZcfG3YmDDh8HC17E92Q8sm4F7oqiE
        Lj/qqPkZmMoe5K5EeTXhdGIsjdSdnm0dSd/ZXYRBRMrdjt+w4dXAdc88xespswKBMfwGeL
        6CPzEWM+ojLMc/frAQf6nlYZoZbEthxyJWbpCFtBAIxrLzjObnrIPf+AEqc+SccAfvamk7
        M3aK6OO+nPfysGzjsagXoJGq9GBIuaxmLJ+pLlrfkFqi8D4hB+7qA+EfiyL0Sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634755633;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h2ITyiP7sDrKaOQa2zA98QKpdJHuPfGzl5uc2AeW150=;
        b=uTwgb+85x4MMKnP2tI+1PbtK0WdPmIvLQChR+YD/k86sOF386id+cyH053mui5EnKFDHQj
        d2CnM+u8OUHt2TBQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip: Provide stronger type checking
 for IRQCHIP_MATCH/IRQCHIP_DECLARE
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211020104527.3066268-1-maz@kernel.org>
References: <20211020104527.3066268-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <163475563206.25758.2271119876482116679.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     f1985002839af80d6c84e9537834a81fb1364d6e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/f1985002839af80d6c84e9537834a81fb1364d6e
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 20 Oct 2021 09:33:21 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Oct 2021 19:33:53 +01:00

irqchip: Provide stronger type checking for IRQCHIP_MATCH/IRQCHIP_DECLARE

Both IRQCHIP_DECLARE() and IRQCHIP_MATCH() use an underlying of_device_id()
structure to encode the matching property and the init callback.
However, this callback is stored in as a void * pointer, which obviously
defeat any attempt at stronger type checking.

Work around this by providing a new macro that builds on top of the
__typecheck() primitive, and that can be used to warn when there is
a discrepency between the drivers and core code.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211020104527.3066268-1-maz@kernel.org
---
 include/linux/irqchip.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index 67351aa..5de0dfc 100644
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
