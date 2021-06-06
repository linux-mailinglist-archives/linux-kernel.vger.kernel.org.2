Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7468639CF29
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhFFMrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:47:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35034 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhFFMpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:45:45 -0400
Date:   Sun, 06 Jun 2021 12:43:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622983436;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AWcS7vnYKh6T7+KCzKgO0Eb5jQ13MvPb4H9f3M2mNqo=;
        b=fjIWC60+6JzBxt0gCNkFbo1BpylEd4haylVcASl4hDq/3gLAIlw4koHmek9RgP16hjJzly
        5N1fdvxDCErxUuy/IF6PdJCOSB7msv+EsM7MQchQsHGIjwPbHFSalj8W40rN0ZPTVFuMk9
        XhGzTVH1RlsT2lirDjw1jVYTBySNmfuIenST2nQk8dVJEUmhQXA6slFrVCnxlBKo/iXFn2
        PmmGVrZVZYRrITzHRpMHE+TdHQ3X0UHhDf0lVMwVgI2Y8LFbXkJ9YuLwhS7wn0GAf1429O
        7JgEwmxAvU4ZEiLUEku/0cpn3+bwOU+/U1ysVDZM632+pWDGj8Dj3obO+8VTkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622983436;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AWcS7vnYKh6T7+KCzKgO0Eb5jQ13MvPb4H9f3M2mNqo=;
        b=i59tjtEvMqMkbkOg/5UhjP1ham5I3SM3thusvA0HINsQ9b44OXbe3IQjIKM/siqvb8ZZ8I
        iPI7lsYCvQazDuDQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] mfd: ioc3: Directly include linux/irqdomain.h
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162298343531.29796.6960308947581515449.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     e541362279ea02c40f5503d8e3423a99d521a2c3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e541362279ea02c40f5503d8e3423a99d521a2c3
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 16 May 2021 17:57:15 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Jun 2021 14:34:47 +01:00

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
