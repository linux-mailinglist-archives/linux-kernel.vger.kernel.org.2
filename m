Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B90A38B4CC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbhETRAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:00:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238845AbhETQ7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:59:22 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E3C261353;
        Thu, 20 May 2021 16:58:00 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1ljlgX-002d7b-IV; Thu, 20 May 2021 17:38:10 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kernel-team@android.com
Subject: [PATCH 13/39] irqdomain: Kill irq_domain_add_legacy_isa
Date:   Thu, 20 May 2021 17:37:25 +0100
Message-Id: <20210520163751.27325-14-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210520163751.27325-1-maz@kernel.org>
References: <20210520163751.27325-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, ley.foon.tan@intel.com, chris@zankel.net, jcmvbkbc@gmail.com, vgupta@synopsys.com, tsbogend@alpha.franken.de, robert.jarzmik@free.fr, linux@armlinux.org.uk, krzysztof.kozlowski@canonical.com, ysato@users.sourceforge.jp, dalias@libc.org, geert@linux-m68k.org, alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch, robdclark@gmail.com, linus.walleij@linaro.org, lee.jones@linaro.org, lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com, bgolaszewski@baylibre.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper doesn't have a user anymore, let's remove it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 Documentation/core-api/irq/irq-domain.rst |  1 -
 include/linux/irqdomain.h                 | 11 -----------
 2 files changed, 12 deletions(-)

diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
index 8214e215a8bf..53283b3729a1 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -146,7 +146,6 @@ Legacy
 
 	irq_domain_add_simple()
 	irq_domain_add_legacy()
-	irq_domain_add_legacy_isa()
 	irq_domain_create_simple()
 	irq_domain_create_legacy()
 
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 62a8e3d23829..9f884c948739 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -45,9 +45,6 @@ struct cpumask;
 struct seq_file;
 struct irq_affinity_desc;
 
-/* Number of irqs reserved for a legacy isa controller */
-#define NUM_ISA_INTERRUPTS	16
-
 #define IRQ_DOMAIN_IRQ_SPEC_PARAMS 16
 
 /**
@@ -355,14 +352,6 @@ static inline struct irq_domain *irq_domain_add_nomap(struct device_node *of_nod
 {
 	return __irq_domain_add(of_node_to_fwnode(of_node), 0, max_irq, max_irq, ops, host_data);
 }
-static inline struct irq_domain *irq_domain_add_legacy_isa(
-				struct device_node *of_node,
-				const struct irq_domain_ops *ops,
-				void *host_data)
-{
-	return irq_domain_add_legacy(of_node, NUM_ISA_INTERRUPTS, 0, 0, ops,
-				     host_data);
-}
 static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_node,
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
-- 
2.30.2

