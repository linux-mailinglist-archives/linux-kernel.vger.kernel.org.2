Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2811639CF21
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhFFMqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:46:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35034 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhFFMpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:45:43 -0400
Date:   Sun, 06 Jun 2021 12:43:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622983433;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=z6lC1VCuJA2+qYMkpw9gFACfUzHzslr94F+9ruXi3ks=;
        b=QRQhhAbqT0Wc9iBtQLH3lT0UZYtwSMFhpxGcMrny0Q4oOlvS4KqEF7tIjYqffNQUrmhpT7
        0fW8D6mrWVHxst/meA3U8h2nyaVJv+stZ7TZ5tjJ3RR8r6JFwgkZhLZVqK78Kh5qxsSd+h
        5OwfdKMKuydENXcX/Vu5iS73epudpWUrF0udCdsL+AsAn7Grx8Vh1TPAAmjG7FgWIj9zNK
        V3Y9xWJtqcieSRxRs/7GWV54MO+GyhyJmqtaS81Ea0S/xjWu4XPOVph2z0Q0oS9iZ5clGw
        mtWn7At2dsfVemCQL4OMA/w3WemOvDu/Y3aw8fV4lCmRIAkDg7AwzbW9/zS/Hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622983433;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=z6lC1VCuJA2+qYMkpw9gFACfUzHzslr94F+9ruXi3ks=;
        b=rpaFZa1TIDLto0kJTdgOhrW+pVwaoX/VJMkQHCZ16W3Rp31fjcIu9t/kghEyaQjwPpQUmu
        yk0rJzdsfHgi1qBA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] MIPS: Do not include linux/irqdomain.h
 from asm/irq.h
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162298343311.29796.14184763483794137414.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     86e8aea3d7a70068fad33aa5b7d7e3084240b23a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/86e8aea3d7a70068fad33aa5b7d7e3084240b23a
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 12 Sep 2018 16:11:20 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Jun 2021 14:34:47 +01:00

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
 
