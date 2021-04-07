Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49618356C43
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352271AbhDGMie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:38:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36386 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245566AbhDGMiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:38:24 -0400
Date:   Wed, 07 Apr 2021 12:38:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617799094;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YpazOy5WMoaQocENGwsTuJoSihbm3EtZrdg/3sFERII=;
        b=kDKnvwrDQh0wi599YY6hLT48sMrQsdizRR7tCx0kfFJXEFmwZ+c/bUbdaZMwIwP0Gg/vjg
        U/ZyIw0sQhyDJXogQAtssD21BS890Z7oV/hJ/o1AgkOPYDnNQqAp0jji9FGkMxFOBj8KGy
        9xHR4+ZR4dOic9IH1F2EaStIewMuHK6XMO7eCEg67UmNX/39O7mKdmAX32gDgYv1XQsRpK
        fc62D3ScyAeFhxqO3xH6iOUnIxOnbGjV2ZtENf+1L10UTmcdGFnJbQGTwVylMvx43okMqU
        9KpNekSf3s0MHfzSQPbaQckTZqDWWIWQPO/TrjFLiaDZXDyJBOh9NAUl4SkoYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617799094;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YpazOy5WMoaQocENGwsTuJoSihbm3EtZrdg/3sFERII=;
        b=jH3CLNthXEs8JD7kva+0bbX7sNDG77q3hMcQ5eBjJFuvKHBfqrlLgH2DTrKlSrUTil9e5h
        5Do/iqH8VL2OQMAw==
From:   "irqchip-bot for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3: Fix OF_BAD_ADDR error handling
Cc:     Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20210323131842.2773094-1-arnd@kernel.org>
References: <20210323131842.2773094-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <161779909366.29796.10784806676911385698.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     8e13d96670a4c050d4883e6743a9e9858e5cfe10
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/8e13d96670a4c050d4883e6743a9e9858e5cfe10
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 23 Mar 2021 14:18:35 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 07 Apr 2021 13:25:52 +01:00

irqchip/gic-v3: Fix OF_BAD_ADDR error handling

When building with extra warnings enabled, clang points out a
mistake in the error handling:

drivers/irqchip/irq-gic-v3-mbi.c:306:21: error: result of comparison of constant 18446744073709551615 with expression of type 'phys_addr_t' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
                if (mbi_phys_base == OF_BAD_ADDR) {

Truncate the constant to the same type as the variable it gets compared
to, to shut make the check work and void the warning.

Fixes: 505287525c24 ("irqchip/gic-v3: Add support for Message Based Interrupts as an MSI controller")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210323131842.2773094-1-arnd@kernel.org
---
 drivers/irqchip/irq-gic-v3-mbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index 563a9b3..e81e89a 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -303,7 +303,7 @@ int __init mbi_init(struct fwnode_handle *fwnode, struct irq_domain *parent)
 	reg = of_get_property(np, "mbi-alias", NULL);
 	if (reg) {
 		mbi_phys_base = of_translate_address(np, reg);
-		if (mbi_phys_base == OF_BAD_ADDR) {
+		if (mbi_phys_base == (phys_addr_t)OF_BAD_ADDR) {
 			ret = -ENXIO;
 			goto err_free_mbi;
 		}
