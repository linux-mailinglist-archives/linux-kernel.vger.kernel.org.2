Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F9039CF20
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhFFMq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhFFMpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:45:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BFAC061766
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 05:43:53 -0700 (PDT)
Date:   Sun, 06 Jun 2021 12:43:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622983432;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kK/z4A0/awENdSug6YcrjhNFmz45khwPIcXK7u3iO/Q=;
        b=WL65QPwGKnLAx2q01GWQ6nU1+7grHne9xXuWxSRaZGJK7+31LBaJq22rlOmKsVZwAA33t/
        qzZ2oOpSxaed/jSYRrcBGsF0dqW4Ab42EapOhTSZNh/roF4Zx//FxGficWc6LIwhPEflOc
        4WERRvs1otFiGglzy+HFBckgXNQvrIFdpngHFAzNR6yQPM2VpUE7pYJv9wq0AG0n3fap0o
        x9L5RfpTJfjNKDnHKUnqA9XTGBMoQhEU2NODUVNVT4b+mnKRfJgouExdVxDXZsH5cVXzuG
        Hu2bDeqp8pkBvengiV6XjJAUPRN0wgNiqdyEprR3IEnQculbgIgcxQ5zwmh80A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622983432;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kK/z4A0/awENdSug6YcrjhNFmz45khwPIcXK7u3iO/Q=;
        b=Do9X4UfleU0CXNP1LM5z/TJjejJp/QljyUL120zx0DBSMvnSo30y46GzPIMrPtVH8yANxM
        N/ROm3gkOX32xYBg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] powerpc: Drop dependency between
 asm/irq.h and linux/irqdomain.h
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162298343129.29796.10381692252026350764.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     56a0ab7c713f1cb4b9034c5a6062a9d9aa772395
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/56a0ab7c713f1cb4b9034c5a6062a9d9aa772395
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 05 Apr 2021 11:15:27 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Jun 2021 14:34:48 +01:00

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
