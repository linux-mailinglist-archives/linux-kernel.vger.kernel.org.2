Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F64367923
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 07:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhDVFRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 01:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhDVFRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 01:17:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0389EC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 22:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=9lqRM0u7jk+d4p6NEuHBBQT7nVxtfUYc+9AYmsJLxtA=; b=cmJpmVZxUactN+9KZClzROXLsz
        AQfBSx8CiVSpJ58s3/sWEyboOdmMYV00Uqf7v9e7jHo4wm+s31D3XIaa3cendo4ebA1Hyqs0lthiW
        UokHRB7vxlzzcPWbfgtGDcyR6bisdzcIBEZwpKOBeGu4ux6AdNTeXNitCb9dqLLeQIEguC2hSoIW4
        1OZE2bBYRnh8iVAMO0DLBtC7CBqKzQQpUJCxz0yNGfoKBa32VO/jZhka6+TDGuNNZRC3TAFl77/l7
        hrr6Dblk03TOjhSKVFeJ8z8Q9yrAIzIY7TueeVAoHyitwuE3r5Jd2FGebzlvYIKlR2tphumCGoiU5
        8Yi1h19w==;
Received: from [2601:1c0:6280:3f0::df68] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZRhQ-00HSuZ-1U; Thu, 22 Apr 2021 05:16:33 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Christian Ruppert <christian.ruppert@abilis.com>
Subject: [PATCH] irqchip: tb10x: use 'fallthrough' to eliminate a warning
Date:   Wed, 21 Apr 2021 22:16:20 -0700
Message-Id: <20210422051620.23021-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the 'fallthrough' macro to document that this switch case
does indeed fall through to the next case.

../drivers/irqchip/irq-tb10x.c: In function 'tb10x_irq_set_type':
../drivers/irqchip/irq-tb10x.c:62:13: warning: this statement may fall through [-Wimplicit-fallthrough=]
   62 |   flow_type = IRQ_TYPE_LEVEL_LOW;
../drivers/irqchip/irq-tb10x.c:63:2: note: here
   63 |  case IRQ_TYPE_LEVEL_LOW:
      |  ^~~~

Fixes: b06eb0173ef1 ("irqchip: Add TB10x interrupt controller driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Christian Ruppert <christian.ruppert@abilis.com>
---
 drivers/irqchip/irq-tb10x.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210420.orig/drivers/irqchip/irq-tb10x.c
+++ linux-next-20210420/drivers/irqchip/irq-tb10x.c
@@ -60,6 +60,7 @@ static int tb10x_irq_set_type(struct irq
 		break;
 	case IRQ_TYPE_NONE:
 		flow_type = IRQ_TYPE_LEVEL_LOW;
+		fallthrough;
 	case IRQ_TYPE_LEVEL_LOW:
 		mod ^= im;
 		pol ^= im;
