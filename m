Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C313A4391
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhFKN5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbhFKN4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9304C0613A3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 06:54:45 -0700 (PDT)
Date:   Fri, 11 Jun 2021 13:54:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419684;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0VMStQHkUnAT9pAHURiibUu2DXt/zdBmszsYkVFMqgI=;
        b=FSsgXlTcdagTe4cUZ4BMi9MDoPyi+kU2GR4FRn5Gr+aD4Vjg5FuEIAvUHiqHo/kcAO+Nt/
        G3Z7pJlCjTFkTGdHt3URBQlQg0QVBstG/75ywpXyRDYYdtRuuhxy/rFhxzgtcjIdqJFKkX
        0fVPTNwBEDlGoIFjWQc0aqB+IuGTbFGGOjMSNsw9rNzWEANR5lr3x5yAfZkInL0eW90PMN
        jIuABXJErSmIapNVe+EP9x69M7bfN3YwlieTuiQk0l1Volu7Qxy7Wm2h18LSZyuEoCLMOd
        Y1Al1poRqHoVxa03fQdLIwDO19sBedm9Lj23db8HMy/45LnV1xbwcJ89LTfhEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419684;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0VMStQHkUnAT9pAHURiibUu2DXt/zdBmszsYkVFMqgI=;
        b=GTWIEOPkyKRK1AQCSJERcPx0qE4Ch5j5JLLqUDXEY/DG5CTa+dmUWySMw9PxMl+UDmhuFA
        51nxeS9FoWB/GUBg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/mips-gic: Directly include
 linux/irqdomain.h
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162341968384.19906.6614938213147830939.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     1982752f6ba6a9d74a214b008ae9e336339276e8
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/1982752f6ba6a9d74a214b008ae9e336339276e8
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 13 Sep 2018 09:30:34 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 10 Jun 2021 13:09:15 +01:00

irqchip/mips-gic: Directly include linux/irqdomain.h

This drivers currently obtains linux/irqdomain.h by luck and
a chain of bizarre inclusions, which we're about to fix.

Let's include the required file directly.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-mips-gic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 2158859..a2cbf0a 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
+#include <linux/irqdomain.h>
 #include <linux/of_address.h>
 #include <linux/percpu.h>
 #include <linux/sched.h>
