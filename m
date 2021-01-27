Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD033057A5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbhA0KBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:01:43 -0500
Received: from inva020.nxp.com ([92.121.34.13]:35586 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232340AbhA0Irc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 03:47:32 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D62381A04FC;
        Wed, 27 Jan 2021 09:46:36 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BF2CD1A0248;
        Wed, 27 Jan 2021 09:46:32 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 08B88402A2;
        Wed, 27 Jan 2021 09:46:26 +0100 (CET)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     mark.rutland@arm.com, leoyang.li@nxp.com, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org
Cc:     linux-kernel@vger.kernel.org, jiafei.pan@nxp.com,
        linux-arm-kernel@lists.infradead.org, ran.wang_1@nxp.com,
        Biwen Li <biwen.li@nxp.com>
Subject: [PATCH] irqchip: ls-extirq: add flag IRQCHIP_SKIP_SET_WAKE to remove call trace
Date:   Wed, 27 Jan 2021 16:55:09 +0800
Message-Id: <20210127085509.18948-1-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

Add flag IRQCHIP_SKIP_SET_WAKE to remove call trace as follow,
...
[   45.605239] Unbalanced IRQ 120 wake disable
[   45.609445] WARNING: CPU: 0 PID: 1124 at kernel/irq/manage.c:800 irq_set_irq_wake+0x154/0x1a0
...
[   45.645141] pstate: 60000085 (nZCv daIf -PAN -UAO -TCO BTYPE=--)
[   45.651144] pc : irq_set_irq_wake+0x154/0x1a0
[   45.655497] lr : irq_set_irq_wake+0x154/0x1a0
...
[   45.742825] Call trace:
[   45.745268]  irq_set_irq_wake+0x154/0x1a0
[   45.749278]  ds3232_resume+0x38/0x50

On ls2088ardb:
In suspend progress(# echo mem > /sys/power/state),
pm_suspend()->suspend_devices_and_enter()->dpm_suspend()->device_suspend()
->ds3232_suspend()->enable_irq_wake()->irq_set_irq_wake()
->set_irq_wake_real(), return -ENXIO, there get
"Cannot set wakeup source" in ds3232_suspend().

In resume progress(wakeup by flextimer)
dpm_resume_end()->dpm_resume()
->device_resume()->ds3232_resume()
->disable_irq_wake()->irq_set_irq_wake()
->set_irq_wake_real(), there get
kernel call trace(Unbalanced IRQ 120 wake
disable)

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
Change in v2:
	- update description

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

