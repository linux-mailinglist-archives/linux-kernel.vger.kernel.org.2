Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDEF43E969
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 22:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhJ1UR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 16:17:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49880 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhJ1URx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 16:17:53 -0400
Date:   Thu, 28 Oct 2021 20:15:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635452125;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=akuf1P3ReGLDbx60EitA9ibylgdEPFka1HBsvSGBxI8=;
        b=pSoNmDi5oEGIPprbGs+U2WoWB3YS/vanWPbht0rDe6+8ypc3XBq+4/uILOOZfAmIqlDxhA
        NaZiplrP1WMH+jJ16dEef/2mq33MsRfCFwq6JxwgAv+5w0OXqx+OCzCdPvo/yg/6HtJU3t
        tE7oAUFneUXNUoNIGL1lRl9v+1bSol8mOme/NZAbrFtD83SnpW0K6a3poKcDEnWUzYJdLk
        Aez0dFIfCEVWoyK16nrnp/mvY4Hs5n6P6NywzhgaES0P29Db3ScZ+NebKQRZAIZEvraO4P
        Q8LrToHWdgP727vQiShPZxM3sQaScNt0UbF4e47e7qYVOXzhCbWrN91EGvct4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635452125;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=akuf1P3ReGLDbx60EitA9ibylgdEPFka1HBsvSGBxI8=;
        b=t4tQERnQYtJ3ZlFBB01ZKiPiJybENWZg5Q/dOGVR4PCw1EfCTq/ndlsvQEhb1fgLnuBtZP
        Jv+lDTHukhrGhWBA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] h8300: Fix linux/irqchip.h include mess
Cc:     Guenter Roeck <linux@roeck-us.net>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20211028172849.GA701812@roeck-us.net>
References: <20211028172849.GA701812@roeck-us.net>
MIME-Version: 1.0
Message-ID: <163545212372.626.13842745419251863344.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     837d7a8fe852cf93fff1cd3b73d707b3a6ae340f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/837d7a8fe852cf93fff1cd3b73d707b3a6ae340f
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 28 Oct 2021 19:24:25 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 28 Oct 2021 21:02:48 +01:00

h8300: Fix linux/irqchip.h include mess

h8300 drags linux/irqchip.h from asm/irq.h, which is in general a bad
idea (asm/*.h should avoid dragging linux/*.h, as it is usually supposed
to work the other way around).

Move the inclusion of linux/irqchip.h to the single location where it
actually matters in the arch code.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211028172849.GA701812@roeck-us.net
---
 arch/h8300/include/asm/irq.h | 2 --
 arch/h8300/kernel/irq.c      | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/h8300/include/asm/irq.h b/arch/h8300/include/asm/irq.h
index 5fc5b43..776cf06 100644
--- a/arch/h8300/include/asm/irq.h
+++ b/arch/h8300/include/asm/irq.h
@@ -2,8 +2,6 @@
 #ifndef _H8300_IRQ_H_
 #define _H8300_IRQ_H_
 
-#include <linux/irqchip.h>
-
 #if defined(CONFIG_CPU_H8300H)
 #define NR_IRQS 64
 #define IRQ_CHIP h8300h_irq_chip
diff --git a/arch/h8300/kernel/irq.c b/arch/h8300/kernel/irq.c
index 834e4d7..8ad6d70 100644
--- a/arch/h8300/kernel/irq.c
+++ b/arch/h8300/kernel/irq.c
@@ -8,6 +8,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
 #include <linux/irqdomain.h>
 #include <linux/of_irq.h>
 #include <asm/traps.h>
