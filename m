Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96993EA2D1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 12:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbhHLKLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 06:11:03 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:35189 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234677AbhHLKLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:11:02 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id C235A320079B;
        Thu, 12 Aug 2021 06:10:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 12 Aug 2021 06:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=SwJEYo/gCeYJ1PODsUSdC0nhKr
        VM+B8+h8O+pAj/MfY=; b=DnQVGsoz5xG5380WBCtyD2kmRGa9Ucy9JgFJ9TIlJ8
        hRpyAvDN+GJFZyp9ezJnZgoTBRjg3eYf9s8LDvVgTtu4EOyPdBJHEmm5cA2si18E
        g5kLjUN/ogg+RhFWbZLIF0LWB7Npl2FJFKjnyEDyuRRSebVxps8kpg9f4HhF+/RM
        jENuv3RHIpwK7nRTIN5IPY5U+SmEcWEPusg5bozDUTHsw7A4yUUJ/JDn8bAGWacP
        k3x/uyniU5QSz33TsZvEHimmqi3/x0hCOJnzb3LNB5GE5lEfM1Cl2CZYFkeZCCix
        KiVmCHuFSyNPtlkTo3vP9JbT6151vxzbokQKcoeBGE9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=SwJEYo/gCeYJ1PODs
        USdC0nhKrVM+B8+h8O+pAj/MfY=; b=b9TPXfkMSPwfpJ2xtqfIk9eD9GU0ncOiC
        kTR73NZ5PcPPDOVi2c/SgBXKVYfvV3zNq7yjuvQZpE349oL43AuJWZfBkAQ4ltMK
        GFNnJnArCZc4T4iQ6CVwMaQ2jt50VPl/lcPUPK8EriZLC9/7XRIXd9CT6whVHJmI
        sYNEap/rwX+TmqLdrxWyOkWJh0xWQg0r3TRAolyi8O159e6Nwcs+3GwjsbiRkUNO
        wrLXexFIfSrMPbTzJQx1JDJTnpiHoGQJPArssq+nzw67+4QPJU7ab1cG8/eWrVBM
        ZhB2NKaYKlKRmHw60CNvKWnHjV4UXIJitxY+NNcfuIh2s+McbQtvw==
X-ME-Sender: <xms:mvMUYeojZnIexCqKYEuONIITqj6JLqcZBLJKjVTUWYbq8xnoY8M5EA>
    <xme:mvMUYcqib8nW-CjZgQ2STndkvnueHBNeXxXQL7eCQ6PzePl0WrWHROWIU0YOafjOh
    TDrLVWJwfXC7cANlzw>
X-ME-Received: <xmr:mvMUYTMkYkZSGetCeYtfQor44C4Jl9SLmQAvvXRy_x20Vcm4v8QGdgMWJkVip2onqk7UBSdpbpBwOfrU2V9lJ12u8ZoL43kcQE-fDwdacwYOyPlt1GX_NZGg1HQpjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkeefgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhvvghnucfrvght
    vghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
    eugfelkedvtdejffefjeehveelfeevkefgudduhfeghfefgedtheevjeefffffgfenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhessh
    hvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:mvMUYd6nNgJzfZiMSO9OO9sj_LJQaXE1KnTwqSXbP-04y81yV2RlvQ>
    <xmx:mvMUYd6xAo0nWUnSSNlxn16qf8V9OSBDQjOS9iX701GeE3Wm2wgmnw>
    <xmx:mvMUYdjLgXNlXFUZuSQKl9_vQfhZL_V4s_6ohOj2Pv83vihSMM-ySA>
    <xmx:nPMUYbTyARdhkySVWDhQPqpXrLRE5WFCwRpPZ-cubQXLH5MfdqtoaQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Aug 2021 06:10:33 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Hector Martin <marcan@marcan.st>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip/apple-aic: fix irq_disable from within irq handlers
Date:   Thu, 12 Aug 2021 12:09:42 +0200
Message-Id: <20210812100942.17206-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When disable_irq_nosync for an interrupt is called from within its
interrupt handler, this interrupt is only marked as disabled with the
intention to mask it when it triggers again.
The AIC hardware however automatically masks the interrupt when it is read.
aic_irq_eoi then unmasks it again if it's not disabled *and* not masked.
This results in a state mismatch between the hardware state and the
state kept in irq_data: The hardware interrupt is masked but
IRQD_IRQ_MASKED is not set. Any further calls to unmask_irq will directly
return and the interrupt can never be enabled again.

Fix this by keeping the hardware and irq_data state in sync by unmasking in
aic_irq_eoi if and only if the irq_data state also assumes the interrupt to
be unmasked.

Fixes: 76cde2639411 ("irqchip/apple-aic: Add support for the Apple Interrupt Controller")
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/irqchip/irq-apple-aic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index b8c06bd8659e..6fc145aacaf0 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -226,7 +226,7 @@ static void aic_irq_eoi(struct irq_data *d)
 	 * Reading the interrupt reason automatically acknowledges and masks
 	 * the IRQ, so we just unmask it here if needed.
 	 */
-	if (!irqd_irq_disabled(d) && !irqd_irq_masked(d))
+	if (!irqd_irq_masked(d))
 		aic_irq_unmask(d);
 }
 
-- 
2.25.1

