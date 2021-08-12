Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F723EA312
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 12:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbhHLKr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 06:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbhHLKrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:47:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C59C061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 03:46:59 -0700 (PDT)
Date:   Thu, 12 Aug 2021 10:46:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628765217;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JIhmiHjaesw6ankIfEX03sRTxwdUphCZbQBFllaKq74=;
        b=TfZ0kSGnVG+hg+vlJaMM9D4AE9J5FMuKXm77U3tLjrxbpOYgvZyVtLCLh7wLaYyyCGP8ep
        fZ8LXALMtWe5b/GBaVwLsf9hLFhp/lfD88P+G1JSjts68Ma0dSJs9B4qcTWQt5+hvk2xce
        8c6Is38sbeH9eLYaoKOuVjVca2TPtuufhH8TGFFiAePUtO0FOtLIAsuAdbxpwXg8CB1jjb
        W6Yq0uToRxI/WlKMBECBWnqxSshSIT+DltIxJ7x2Py4qrvQ1LCmS0Q4EitEH3H3mJDSpMX
        PT5W2hE4eJmiU+IuMz72UhiAaMnddudzekWd8V0g19nG/e/YSZ4/VBJ3WbVz4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628765217;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JIhmiHjaesw6ankIfEX03sRTxwdUphCZbQBFllaKq74=;
        b=8jDEa/zOevScyGC5P+/DD486W3in09+mArXIwqCdioSqsp60T/DSAX4rjub1QcV74bUKiF
        r2rHTUALTnKq1pDQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] EDAC/altera: Convert to
 generic_handle_domain_irq()
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162876521697.395.9500127903676460491.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     eecb06813d7381dbee98034983e9db64bfb3a131
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/eecb06813d7381dbee98034983e9db64bfb3a131
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 04 May 2021 17:42:18 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 11:39:41 +01:00

EDAC/altera: Convert to generic_handle_domain_irq()

Replace generic_handle_irq(irq_linear_revmap()) with a single call to
generic_handle_domain_irq().

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/edac/altera_edac.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 61c21bd..2eb1d85 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1804,11 +1804,8 @@ static void altr_edac_a10_irq_handler(struct irq_desc *desc)
 	regmap_read(edac->ecc_mgr_map, sm_offset, &irq_status);
 
 	bits = irq_status;
-	for_each_set_bit(bit, &bits, 32) {
-		irq = irq_linear_revmap(edac->domain, dberr * 32 + bit);
-		if (irq)
-			generic_handle_irq(irq);
-	}
+	for_each_set_bit(bit, &bits, 32)
+		generic_handle_domain_irq(edac->domain, dberr * 32 + bit);
 
 	chained_irq_exit(chip, desc);
 }
