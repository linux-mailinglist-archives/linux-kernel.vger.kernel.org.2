Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD3E39CF2A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhFFMrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:47:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35032 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhFFMpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:45:46 -0400
Date:   Sun, 06 Jun 2021 12:43:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622983436;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BKzJ+EZM7QtdZGQro9O8mQaXJr8C17fDCg9ykXdFMFQ=;
        b=A2eHhgJU+NplBmSRDacHiai2ecyNqHHPxXXsKqg0WTJR7bAE8DKkxnMKVCRnvv1zU1bWlz
        v8LQuuxLpybD8dBFWoOoYd4GFjqOuGvo0WCDJ2r8ncQL8B5TvH9wvjZDDakoioy1Vqx3OA
        bc0OWrFuYR8vNMU41/g2GL3jFGKxpsnp71JnbX1a++oKD78l+5HoUtJdLBox9/tIWiB+Ry
        TkU/DDrK/iiL7MQrmvN9/V4aexJC0/ocHKf55dX2HiG4kPhpSU0HQwx35OnTxOVSmf0SMl
        NBaK9APVkdKMpcVMgS3B7UbSeIPa9ir3GIQLh+kWszwJKM+bwgZfYCQFAVF1FQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622983436;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BKzJ+EZM7QtdZGQro9O8mQaXJr8C17fDCg9ykXdFMFQ=;
        b=CwnbdeIhSlu6hHDFUz3+Nq1rBeeRFhFl2XmR1IZlJy0Jp9IJyEcAy3TUTyN4CCRMIw83Gz
        wGJhOTJxxohcUCBw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] nios2: Do not include linux/irqdomain.h
 from asm/irq.h
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162298343616.29796.542984438945877584.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     41188caed10a9d23f08ff5b693c84863fbfbc21e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/41188caed10a9d23f08ff5b693c84863fbfbc21e
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 13 Sep 2018 10:59:03 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Jun 2021 14:34:46 +01:00

nios2: Do not include linux/irqdomain.h from asm/irq.h

Including linux/irqdomain.h from asm/irq.h is going to break
as soon as linux/irqdomain.h will include linux/irq.h, so
let's fix this. Code relying on linux/irqomain.h should include
it directly.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/nios2/include/asm/irq.h | 1 -
 arch/nios2/kernel/irq.c      | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/nios2/include/asm/irq.h b/arch/nios2/include/asm/irq.h
index 13ce372..c52c948 100644
--- a/arch/nios2/include/asm/irq.h
+++ b/arch/nios2/include/asm/irq.h
@@ -10,6 +10,5 @@
 #define NIOS2_CPU_NR_IRQS	32
 
 #include <asm-generic/irq.h>
-#include <linux/irqdomain.h>
 
 #endif
diff --git a/arch/nios2/kernel/irq.c b/arch/nios2/kernel/irq.c
index 5f3555c..c6a1a9f 100644
--- a/arch/nios2/kernel/irq.c
+++ b/arch/nios2/kernel/irq.c
@@ -11,6 +11,7 @@
 
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/of.h>
 
 static u32 ienable;
