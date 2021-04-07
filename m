Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC50356C44
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352283AbhDGMij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:38:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36392 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347204AbhDGMiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:38:24 -0400
Date:   Wed, 07 Apr 2021 12:38:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617799094;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=po8HPnXAOYikLokEypE7OHeYcpgw+gaLrOibrq/o9Ic=;
        b=S71stYYUV8+Q4/ks3wvatcWUOUts10P2LRCvCZ82V2qCssLyN2sm2iy1W2yZAh5+gFUVyC
        Wq3TykJ7zd5xwvcIGg1WI3FX1mhxF1KqACSuQ79ry3EkNas8XnS8LDDO5UyXwndjGbWm2n
        AzYsYr2E+RfLOWf7wCXXVQznx1lWqfYhk5bYhv4ZJ49Mf/z3DXoWhzOG9zdRzPwoNbgvq6
        ekJWRVp95cWzrnyXdY9KXEjw/9hLiWGDfxUvvh9MKJcUwpibR8aG6inXVPSY/QoGiFSzjd
        LEZW6QvXawEzxfE3+11OfnzhoSvFFHMkVEpxeZBSWKHiaCmxpeUQzNnajgzqRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617799094;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=po8HPnXAOYikLokEypE7OHeYcpgw+gaLrOibrq/o9Ic=;
        b=m+I5hhuu9viGNYUEUNQGlaVvUwkWeow5ZtwnO/Ke0zo+rBavBR4Sp0wASe/FU7VjWPRoz7
        g/aUiyWV1LWJMjAA==
From:   "irqchip-bot for Jisheng Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/sifive-plic: Mark two global
 variables __ro_after_init
Cc:     Jisheng Zhang <jszhang@kernel.org>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20210330020911.26423e9e@xhacker>
References: <20210330020911.26423e9e@xhacker>
MIME-Version: 1.0
Message-ID: <161779909401.29796.955163996057547689.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     e03b7c1bcbfad6f27b4682f638b98627c4e416ba
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e03b7c1bcbfad6f27b4682f638b98627c4e416ba
Author:        Jisheng Zhang <jszhang@kernel.org>
AuthorDate:    Tue, 30 Mar 2021 02:09:11 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 07 Apr 2021 13:25:52 +01:00

irqchip/sifive-plic: Mark two global variables __ro_after_init

All of these two are never modified after init, so they can be
 __ro_after_init.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210330020911.26423e9e@xhacker
---
 drivers/irqchip/irq-sifive-plic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 6f432d2..97d4d04 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -77,8 +77,8 @@ struct plic_handler {
 	void __iomem		*enable_base;
 	struct plic_priv	*priv;
 };
-static int plic_parent_irq;
-static bool plic_cpuhp_setup_done;
+static int plic_parent_irq __ro_after_init;
+static bool plic_cpuhp_setup_done __ro_after_init;
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
 static inline void plic_toggle(struct plic_handler *handler,
