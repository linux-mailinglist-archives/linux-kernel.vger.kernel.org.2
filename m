Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF6F43AFDC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbhJZKTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbhJZKSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:18:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDDAC061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 03:16:09 -0700 (PDT)
Date:   Tue, 26 Oct 2021 10:16:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635243367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Xo1uXZPOOsOZjRr+qok00lmoSVidBoShmi7QWLRI9aA=;
        b=JuKSvUGMNRjXKLEbrH297BmzDwJqALrDuIEZCPnKomTvQ7brtACG3IxIFR+XkeE1kjZwZB
        OoqX6Oyq2cPHtnFwGLZtrHGJ9CLmwFvBlD0rIT41IFDPyOLeOZKGcWU8mOLgtSjnjRbRFX
        2nmYpCAVS8kVIPuwBV3mjFlxByWVzsZlbdn5O8FVh+pt2P5dT8HPrblnawwNCc2nWKPyMj
        yJmapDzJhviyarzXhkeqa1vTydARR80T3huZGsMVd76K3/ugW0vmS5URZmsTDdzlLQTx1C
        9YhCkfu6laRsAM5bqCFhSg/6bbd/KQrJBRzT8BwXRefBk5zjgDM1pkvUVmmXSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635243367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Xo1uXZPOOsOZjRr+qok00lmoSVidBoShmi7QWLRI9aA=;
        b=SWce6szwKhDP2ojiV4ocF4D40Ppjsfl8jGy4vw7wg1VPm0l4uyFfprdAsUVS5zKa71rd+q
        5DtYjLuprrKCUsDw==
From:   "irqchip-bot for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irq: unexport handle_irq_desc()
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
MIME-Version: 1.0
Message-ID: <163524336684.626.1094301663093917414.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     76adc5be6f505d0c137b210a95ad00dbd089473d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/76adc5be6f505d0c137b210a95ad00dbd089473d
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Fri, 22 Oct 2021 15:35:04 +01:00
Committer:     Mark Rutland <mark.rutland@arm.com>
CommitterDate: Mon, 25 Oct 2021 10:05:11 +01:00

irq: unexport handle_irq_desc()

There are no modular users of handle_irq_desc(). Remove the export
before we gain any.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Suggested-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/irqdesc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index b07d0e1..e25d4bd 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -646,7 +646,6 @@ int handle_irq_desc(struct irq_desc *desc)
 	generic_handle_irq_desc(desc);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(handle_irq_desc);
 
 /**
  * generic_handle_irq - Invoke the handler for a particular irq
