Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206143A4390
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhFKN5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:57:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40028 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbhFKN4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:43 -0400
Date:   Fri, 11 Jun 2021 13:54:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=P/rlUUEJ1L+vl/9c5vAOx4ZkXQzQQNJwsAdcXxquvI8=;
        b=sMPbU7PumsyQieRmxKQJvpEA+zr4koNxaVGihiSTinszR7PlqaIawsflo4muaFk6pWmXaE
        LLaka68l0yOGRsUBkelcDPfE8NgyO30xLIAo3ZeiReQH3Od/PmNBySw2ObpkZdh9ecEjlU
        paoV2GUZJjk9ACBJGYADvJM5TuLX1l8DDFX6bZTXVWBNJB9RLGzkM0aIaZqjAs9MncMfXG
        wwJYu3yA6Cd4OaK127YYMviLFXXYhgL0prYyZQC77r8sb/BaNV9Qwlji1AK+fJdMAQM9PF
        drEx7Dfrv4rhLO56w9xBUEG2KmUKa8KFS/Nveqam+ZCpuPUKDQ8Qx4fN7rIPZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=P/rlUUEJ1L+vl/9c5vAOx4ZkXQzQQNJwsAdcXxquvI8=;
        b=Xz5go8vT1uah7J5mY+rDMmlUU6wvfSZP6cvnSvjg5w1i0HVg1pb9+K7sLR2CvL4eQEg8JZ
        TvQBqIA8YUhrLbCg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] mfd: ioc3: Directly include linux/irqdomain.h
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162341968477.19906.17631173742904819360.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     c7d49545997eab111aec14be152842f56a0cabc4
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/c7d49545997eab111aec14be152842f56a0cabc4
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 16 May 2021 17:57:15 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 10 Jun 2021 13:09:15 +01:00

mfd: ioc3: Directly include linux/irqdomain.h

This driver include linux/irqdomain.h via a bizarre set of
indirection, which we are about to break.

Directly include the required file.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/mfd/ioc3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/ioc3.c b/drivers/mfd/ioc3.c
index c73ec78..99b9c11 100644
--- a/drivers/mfd/ioc3.c
+++ b/drivers/mfd/ioc3.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/pci.h>
