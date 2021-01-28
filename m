Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEB2306B4C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 03:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhA1C6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 21:58:44 -0500
Received: from inva021.nxp.com ([92.121.34.21]:58804 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhA1C6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 21:58:43 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 76752200B57;
        Thu, 28 Jan 2021 03:57:56 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 67FC1200D88;
        Thu, 28 Jan 2021 03:57:52 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id EFCF8402A9;
        Thu, 28 Jan 2021 03:57:46 +0100 (CET)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     mark.rutland@arm.com, leoyang.li@nxp.com, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org
Cc:     linux-kernel@vger.kernel.org, jiafei.pan@nxp.com,
        linux-arm-kernel@lists.infradead.org, ran.wang_1@nxp.com,
        Biwen Li <biwen.li@nxp.com>
Subject: [v3] irqchip: ls-extirq: add IRQCHIP_SKIP_SET_WAKE to the irqchip flags
Date:   Thu, 28 Jan 2021 11:06:27 +0800
Message-Id: <20210128030627.41022-1-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

The ls-extirq driver doesn't implement the irq_set_wake()
callback, while being wake-up capable. This results in
ugly behaviours across suspend/resume cycles.

Advertise this by adding IRQCHIP_SKIP_SET_WAKE to
the irqchip flags

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
Change in v3:
	- update description

Change in v2:
	- Update description

 drivers/irqchip/irq-ls-extirq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
index 564e6de0bd8e..3c6ed7b4744d 100644
--- a/drivers/irqchip/irq-ls-extirq.c
+++ b/drivers/irqchip/irq-ls-extirq.c
@@ -65,7 +65,7 @@ static struct irq_chip ls_extirq_chip = {
 	.irq_set_type		= ls_extirq_set_type,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
-	.flags                  = IRQCHIP_SET_TYPE_MASKED,
+	.flags                  = IRQCHIP_SET_TYPE_MASKED | IRQCHIP_SKIP_SET_WAKE,
 };
 
 static int
-- 
2.17.1

