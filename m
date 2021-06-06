Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C71D39CF27
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhFFMq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:46:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35082 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhFFMpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:45:45 -0400
Date:   Sun, 06 Jun 2021 12:43:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622983435;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2JnN0L28+A/8ls7YQBd5MtOFwbAJmQhSlJSWvs8H8xc=;
        b=a6uA+kAJzItz4vdkEk8pD69+hmiXiEPY3AGA7so38/MStPNnroH5wGu9TXu13p2pI/7CaR
        gg5zKpvz5N0sduH+OtikySBVHn8bcR4CqieHn9oC9WcVqQtIB9OqWLpH6AKdN8/QRoQML1
        CkdBMYRnhlGiD00JhDXvpbuk0hAFjG2ffOll+2r6CWXNUrOZs1U+nGzlT0IHjuj62heSqY
        /mmh4hX86BP2irFDl47TBBk2KsTGcHvNoVijFe2Z2J5ACLBVeW655w0kzpeAbKVQaEMmIj
        tYDBtrYvYIUaKCK0f6wdS6sPoKAQCQAfG0n00U4diI8DaSWKt+rLT8PT8JOvGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622983435;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2JnN0L28+A/8ls7YQBd5MtOFwbAJmQhSlJSWvs8H8xc=;
        b=5gYnygF98RyAJ7WEN8B0JG1m3SgP82JciSDv0RzoyRcWX6vWXiy6edNhcqiO1/wRwJ+bJM
        yKphbm/on7ADqPBA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/mips-gic: Directly include
 linux/irqdomain.h
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162298343441.29796.1685549921123937521.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     009ea522d834b6025dc2b69687897fd1f02f772e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/009ea522d834b6025dc2b69687897fd1f02f772e
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 13 Sep 2018 09:30:34 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Jun 2021 14:34:47 +01:00

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
