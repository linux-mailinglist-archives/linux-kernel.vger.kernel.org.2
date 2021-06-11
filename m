Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A7A3A4384
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhFKN5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:57:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40068 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbhFKN4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:39 -0400
Date:   Fri, 11 Jun 2021 13:54:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419681;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ei4+kJTTkFcRDBbG+fnYgio8UIlRgOuR6urrtp8PA+Q=;
        b=pVKZqNJ7zadrfe6WNYfWxtrEDPPb+db5JKq5ChhGeqydg8AXMTiSXmfIaxFAym7BXIAPFJ
        maMdZr2H++eb8HDY7KElEd7FrlmatS8ET3XgvrMAEi24oC9RfDWZG+9qxB5xmFovXVIIrR
        jceM274LW2xitbF4Lhf2KSCmnZ9x8DTAmCSCBG/ksOtgx8wbO95j+UlxcOTvDyZrOpQdXl
        5ZzrrdV7dzq3ZguKiLwiIccg/oK6lRbp7IZzDL7/aX05PpoRO5T9MO2Y8CK+t5indteb63
        o9lKe257F68kxyUcahRcq1rspl7opPITWVUDs4F+LoJXagJD+7lzITffLnVpBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419681;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ei4+kJTTkFcRDBbG+fnYgio8UIlRgOuR6urrtp8PA+Q=;
        b=QjiZl2ld+c66gE7ckMNuOWjLm5PU9EBHLvuMy/pDxsuVt9XLcr0tRka0cYpbMwFmgDB3xk
        bQHIxtCOxYuhHYDw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] powerpc: Drop dependency between
 asm/irq.h and linux/irqdomain.h
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162341968040.19906.16507802024408750554.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     582f5aa1dbb3bd7bd3dd12de7e87f6dafb3f8258
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/582f5aa1dbb3bd7bd3dd12de7e87f6dafb3f8258
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 05 Apr 2021 11:15:27 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 10 Jun 2021 13:09:17 +01:00

powerpc: Drop dependency between asm/irq.h and linux/irqdomain.h

Directly including linux/irqdomain.h was hiding all sort of sins,
which have now been fixed. Drop the spurious include.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/powerpc/include/asm/irq.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index c1eda91..4982f37 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -6,7 +6,6 @@
 /*
  */
 
-#include <linux/irqdomain.h>
 #include <linux/threads.h>
 #include <linux/list.h>
 #include <linux/radix-tree.h>
