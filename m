Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB7A378EB7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240867AbhEJNXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 09:23:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36798 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237069AbhEJNRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 09:17:20 -0400
Date:   Mon, 10 May 2021 13:16:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620652567;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aZNKMR4h/Zzes7iAi6bYvhemum1MtW7y9awfP3I8xwc=;
        b=qwFKWzNfffj10IwEwO1I2999td0/0DLtv/5wrmim1mqZ5cQeimEiw/a7ZsDTu0BnwQC9Xt
        tsOXwhi8/KRTs9BbIrO3o/n0vmspm7Sr0kzaQ06lTob5H72pTi5C7oH6CZa+NNloIffBle
        JO4HAqjTiHBqN/V1u4Z5E/wWeNUy84nQRa6vQgxYfMsCDoLevNPhQTxBhUElxG5EpJmY6Z
        gSVLhvpyB6BxEPrmP19Zso+LSQaCs5dvOhgtuw652DhVktyBiPsEesBFN11vSuRKG/KVnI
        Jna5xoEf0S/xQyaTySp6B7IR7lH5riR0GZU8RFNvM4oQpf5vwwtV6yJHRwVmpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620652567;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aZNKMR4h/Zzes7iAi6bYvhemum1MtW7y9awfP3I8xwc=;
        b=8r1NDttBzjshHhwBL0+XS8873u/X8zI67091tXLt6blA/D2Uu+oc2wK1e9xdLNN6R7Ni3Y
        vdP9xq7XdpFu1NBw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] ARM: PXA: Fix cplds irqdesc allocation
 when using legacy mode
Cc:     Guenter Roeck <linux@roeck-us.net>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20210426223942.GA213931@roeck-us.net>
References: <20210426223942.GA213931@roeck-us.net>
MIME-Version: 1.0
Message-ID: <162065256707.29796.16984262022305122668.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     be1c2bb3ba5a39c20b1d54e01ffbcb2b1ca7e46c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/be1c2bb3ba5a39c20b1d54e01ffbcb2b1ca7e46c
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 27 Apr 2021 09:00:28 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 10 May 2021 14:12:25 +01:00

ARM: PXA: Fix cplds irqdesc allocation when using legacy mode

The Mainstone PXA platform uses CONFIG_SPARSE_IRQ, and thus we
cannot rely on the irq descriptors to be readilly allocated
before creating the irqdomain in legacy mode. The kernel then
complains loudly about not being able to associate the interrupt
in the domain -- can't blame it.

Fix it by allocating the irqdescs upfront in the legacy case.

Fixes: b68761da0111 ("ARM: PXA: Kill use of irq_create_strict_mappings()")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210426223942.GA213931@roeck-us.net
---
 arch/arm/mach-pxa/pxa_cplds_irqs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/pxa_cplds_irqs.c b/arch/arm/mach-pxa/pxa_cplds_irqs.c
index ec0d9b0..bddfc7c 100644
--- a/arch/arm/mach-pxa/pxa_cplds_irqs.c
+++ b/arch/arm/mach-pxa/pxa_cplds_irqs.c
@@ -121,8 +121,13 @@ static int cplds_probe(struct platform_device *pdev)
 		return fpga->irq;
 
 	base_irq = platform_get_irq(pdev, 1);
-	if (base_irq < 0)
+	if (base_irq < 0) {
 		base_irq = 0;
+	} else {
+		ret = devm_irq_alloc_descs(&pdev->dev, base_irq, base_irq, CPLDS_NB_IRQ, 0);
+		if (ret < 0)
+			return ret;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	fpga->base = devm_ioremap_resource(&pdev->dev, res);
