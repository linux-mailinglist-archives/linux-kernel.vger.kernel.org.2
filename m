Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC613A4370
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhFKN4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbhFKN4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03DAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 06:54:34 -0700 (PDT)
Date:   Fri, 11 Jun 2021 13:54:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419673;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=haSEjANq1KSoip18Jp4uze70eY4pH3gbYtniYJFeTRU=;
        b=L7OYs3n5K2Oio2ySgjZzWZSqg2X3JUQM29hr/GYVUnMxSFY6zU0wuMo5zNcnQyPj/+suF9
        lacpS4+PK4p3YPXtXs1cEXuRczzCEZXdsQJua2OGL7th8CCqBr68oliynkBWOTyF2UEMUw
        WB2F872ykHGkCXioa4rwBSmnH+vd5HY3Bgfhz/EZOj91vgShjMUA8aKUaemDtVd3JFDIFd
        ls4mr7yy0zGA74mmQmf5RH3OIS2NhJhlVsyms0MCPd8i5mX291ielKXsd4KUwAR6pEEn4f
        U7ZS+o76CBK2x2HMgX97cV09yXAoyKxlvdYMZhkNMF9yvCVKZNqioH8N1JUFYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419673;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=haSEjANq1KSoip18Jp4uze70eY4pH3gbYtniYJFeTRU=;
        b=Ea2PEzUq/Trdaut+fhwZAgSJv4vlWNf5bfLDmd/xaNxzoAsIQcZi+5Mp5fH/xFd9odqX6U
        DWogrQ9A3tXOnDDQ==
From:   "irqchip-bot for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v2m: Remove unnecessary oom message
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210609140534.14478-1-thunder.leizhen@huawei.com>
References: <20210609140534.14478-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Message-ID: <162341967268.19906.3777016160061128279.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     98ae089e1e6e5bab6f8c89412da5fc447e3580cb
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/98ae089e1e6e5bab6f8c89412da5fc447e3580cb
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Wed, 09 Jun 2021 22:05:34 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Jun 2021 14:19:32 +01:00

irqchip/gic-v2m: Remove unnecessary oom message

Fixes scripts/checkpatch.pl warning:
WARNING: Possible unnecessary 'out of memory' message

Remove it can help us save a bit of memory.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210609140534.14478-1-thunder.leizhen@huawei.com
---
 drivers/irqchip/irq-gic-v2m.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 4116b48..be9ea6f 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -323,10 +323,8 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 	struct v2m_data *v2m;
 
 	v2m = kzalloc(sizeof(struct v2m_data), GFP_KERNEL);
-	if (!v2m) {
-		pr_err("Failed to allocate struct v2m_data.\n");
+	if (!v2m)
 		return -ENOMEM;
-	}
 
 	INIT_LIST_HEAD(&v2m->entry);
 	v2m->fwnode = fwnode;
