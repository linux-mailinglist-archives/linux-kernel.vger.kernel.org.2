Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93AE3B5C96
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 12:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbhF1KnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 06:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbhF1KnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 06:43:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B10C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 03:40:53 -0700 (PDT)
Date:   Mon, 28 Jun 2021 10:40:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624876849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nfdkU/rdEQZ5jalOPmDjeWzm8anw2QHtBSkZGmhmpfY=;
        b=Vt/Ab/5e8mmZjduT5PU10ztLwGzTjsV5gNNjPYHkFFlLDrisknjZD/zBnppLJ4Ym4FaoBe
        B9yVdKFOZp2dfSqPzkoHTQ7Vwz+NDurUaYmYluUhZymUs+Veo22OaK7kwKEEQ58RLZIRMV
        QV2ithw5QaMah1pv23pQbAVk6adVYve3Wv5QEg3BczSk12TuSLLEjNg7j2cdt0RUlyJNSN
        +XZOxm2XXW1JWtG/W9jAyUSGxnJffSdiiXycJ398G0QWr0HheR7g1g2l70dXD6AYwl6eMn
        lMPxyPYhRW/Im7t85ae4Rjs8ga68Sy1GZbSTMR7hgwmzxqPYiVia9t5fbH3RpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624876849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nfdkU/rdEQZ5jalOPmDjeWzm8anw2QHtBSkZGmhmpfY=;
        b=mXq0/a+nCxxraGpabfGrCm5wRY43VLUETXGZ8gnDnQsRBcaOC6xKNk4C46PhBEkwwist7a
        mYQbcQ7G0CY8rTBQ==
From:   "irqchip-bot for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] genirq/irqdesc: Drop excess kernel-doc
 entry @lookup
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210628004044.9011-1-rdunlap@infradead.org>
References: <20210628004044.9011-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <162487684828.395.17339592309062658352.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     0e3c1f30b03599f2ee8ff3327eca53c99564ba13
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/0e3c1f30b03599f2ee8ff3327eca53c99564ba13
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Sun, 27 Jun 2021 17:40:44 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 28 Jun 2021 11:33:32 +01:00

genirq/irqdesc: Drop excess kernel-doc entry @lookup

Fix kernel-doc warning in irqdesc.c:

../kernel/irq/irqdesc.c:692: warning: Excess function parameter 'lookup' description in 'handle_domain_irq'

Fixes: e1c054918c6c ("genirq: Move non-irqdomain handle_domain_irq() handling into ARM's handle_IRQ()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210628004044.9011-1-rdunlap@infradead.org
---
 kernel/irq/irqdesc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index f4dd518..fadb937 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -682,7 +682,6 @@ EXPORT_SYMBOL_GPL(generic_handle_domain_irq);
  *                     usually for a root interrupt controller
  * @domain:	The domain where to perform the lookup
  * @hwirq:	The HW irq number to convert to a logical one
- * @lookup:	Whether to perform the domain lookup or not
  * @regs:	Register file coming from the low-level handling code
  *
  * Returns:	0 on success, or -EINVAL if conversion has failed
