Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B733A436C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhFKN4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbhFKN4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A49C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 06:54:33 -0700 (PDT)
Date:   Fri, 11 Jun 2021 13:54:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IlqPMhWiOii8IcLAM5zGOO6+HcgkdKANbmuUR7kes84=;
        b=QXSyRh/bFoXn46oAA6O4cnJMpb4VqNlicwDLIRIgKzIqbpLzWP1Ej73iX6+zh0Pd2Ui+Sc
        RQFdfKHG+i4MBwhYhvPAz1UGlPxP09QJvb2MA4B3GLUq2kla6rB27KKxfjriEsZZzqsA6f
        3FbVO+lsacFwXFtQ2NPktmeeVHnXV04mNMgUpo5nH/5CRuVWEMF6vnUVfkJgstgS8/gifL
        a8JcT0YIFIsE1I34icLDxVlV8j1RTMZRtjoSTD7ogonMk3GUGpbBskVJeM2IUxJoCdIejE
        vwSLRi5v9vjwrv3pdUGuHY8hPpTkID6Jau1ViMwdGoooere43JCOhDdlduALuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IlqPMhWiOii8IcLAM5zGOO6+HcgkdKANbmuUR7kes84=;
        b=d0NB2yMMKxbkuf5RigDot5QeJHw6fG++tii0y6Z3E1h1sYH2g8PdL4TrI7P6YKwTk2lwFy
        pYrWA5UpHO+4hnDA==
From:   "irqchip-bot for Chunfeng Yun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip: gic-pm: Remove redundant error
 log of clock bulk
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <1617937474-24630-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1617937474-24630-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Message-ID: <162341966997.19906.3809509432325377205.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     21a496179c6e3a9fc03d1296b36afd14046db88f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/21a496179c6e3a9fc03d1296b36afd14046db88f
Author:        Chunfeng Yun <chunfeng.yun@mediatek.com>
AuthorDate:    Fri, 09 Apr 2021 11:04:34 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Jun 2021 14:21:04 +01:00

irqchip: gic-pm: Remove redundant error log of clock bulk

There is error log in clk_bulk_prepare/enable()

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1617937474-24630-1-git-send-email-chunfeng.yun@mediatek.com
---
 drivers/irqchip/irq-gic-pm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-pm.c b/drivers/irqchip/irq-gic-pm.c
index 1337cec..b60e185 100644
--- a/drivers/irqchip/irq-gic-pm.c
+++ b/drivers/irqchip/irq-gic-pm.c
@@ -30,10 +30,8 @@ static int gic_runtime_resume(struct device *dev)
 	int ret;
 
 	ret = clk_bulk_prepare_enable(data->num_clocks, chip_pm->clks);
-	if (ret) {
-		dev_err(dev, "clk_enable failed: %d\n", ret);
+	if (ret)
 		return ret;
-	}
 
 	/*
 	 * On the very first resume, the pointer to chip_pm->chip_data
