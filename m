Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18923A438A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhFKN5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:57:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40022 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhFKN4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:41 -0400
Date:   Fri, 11 Jun 2021 13:54:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419683;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7K+52mlZ3l0vqL5S2aNWpAqVMKwjwdiji/6Hm+dm7fk=;
        b=ZfjcS2k7SD+RQl5knyCPAxU55ogjC9mJvFNcpkl+2nBMiOy0HMXkKR8NnpiKE0dIOlJfAT
        2b0+/b5LAk0wLlZ1NiRz/u9jcXFUuv7r+tAqSNt8yX/q8ka4wHnKwiH0t1Ry6py7/REJuY
        qwlEIc4pF0v/DyD5XZuPTAFRqDBF1B6aZ803t8IkeX0H0qcs26+MRUKsBj5TYv+UwOmbvR
        4MJASTH4aWb2H3HOWPQEYXL1PC76a9UrS7M0odXA8K+p0/Cpzk+sxv6C8WMUgdQ1qY/U8I
        tBM6zufkY8Q2VPevIl8yZCq9SxsdmhfVOEp04sxyxaypsE3008XxFAGFlqBJ2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419683;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7K+52mlZ3l0vqL5S2aNWpAqVMKwjwdiji/6Hm+dm7fk=;
        b=qMscjQHXtYR83FLMo36SYB0RRaGYbw8F7sbaxlhrObSL95K8fP5arvS/mcvR3vd1zpXPCq
        nM3r/N8FDxyU55CA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] MIPS: Do not include linux/irqdomain.h
 from asm/irq.h
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162341968233.19906.4804539672657378978.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     a12a9c5c03072ec6b1f4f9bd7a554a718ecf234a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/a12a9c5c03072ec6b1f4f9bd7a554a718ecf234a
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 12 Sep 2018 16:11:20 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 10 Jun 2021 13:09:16 +01:00

MIPS: Do not include linux/irqdomain.h from asm/irq.h

Including linux/irqdomain.h from asm/irq.h is going to break
as soon as linux/irqdomain.h will include linux/irq.h, so
let's fix this. Code relying on linux/irqomain.h should include
it directly.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/mips/include/asm/irq.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
index f021de6..d1477ec 100644
--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -11,7 +11,6 @@
 
 #include <linux/linkage.h>
 #include <linux/smp.h>
-#include <linux/irqdomain.h>
 
 #include <asm/mipsmtregs.h>
 
