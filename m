Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F043EA73B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238409AbhHLPNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237862AbhHLPN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:13:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E42C0617AD
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 08:13:02 -0700 (PDT)
Date:   Thu, 12 Aug 2021 15:13:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628781181;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8A+eRJ5Z+TgcoKS1FgvA5KW5oEBi8DTvze4qYrJXMzo=;
        b=GW0s2HkH5sL/En45xlYqTMeXniFUedZU8eh9nRZ+o5JPvu0l4Zii2QqETCHAA2WSDLnzzA
        kj5OPc9dMt7WQiuBp5TqD57Jx/osAUshf+knQt3JOckbv4xrhQHqMhxQY/ZO6V98M03NAb
        nv95qVNIYl2l46itVy1YigBqIFty/iXDLSFxczKhWLeRBElOBvPbkXV0FxVzm0HSNVKyIk
        vpI7K+jH26Hmme6dZ67kigTvxjCGWXetnfy00+krhEPu6hg8E/97N2YrijchXFBhQ4nlrn
        cuqOVr2pyZCEdm0b1FgHcqywyAu79TOill3rISou+eir7BsICTY3lKoDXYN7kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628781181;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8A+eRJ5Z+TgcoKS1FgvA5KW5oEBi8DTvze4qYrJXMzo=;
        b=MBHXc8hY2ztF36yDlMA3HgcUQd5lmIahOJXgpzYWtPGXZOFIX+ldwl7D/dCp/RIUl1Yg28
        +JoH3GdjT460VzAQ==
From:   "irqchip-bot for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq/msi: Provide default .irq_eoi()
 for MSI chips
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210629125010.458872-9-valentin.schneider@arm.com>
References: <20210629125010.458872-9-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <162878118052.395.18205379902168224404.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     9b632bd34cea53fcfd3f41f89596d87573676050
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/9b632bd34cea53fcfd3f41f89596d87573676050
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Tue, 29 Jun 2021 13:50:05 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 15:48:20 +01:00

genirq/msi: Provide default .irq_eoi() for MSI chips

Currently only platform-MSI irqchips get a default .irq_eoi() when
MSI_FLAG_USE_DEF_CHIP_OPS is set. There's no reason PCI-MSI irqchips
couldn't benefit from this too, so let all MSI irqchips benefit from this
default.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210629125010.458872-9-valentin.schneider@arm.com
---
 drivers/base/platform-msi.c | 2 --
 kernel/irq/msi.c            | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 0b72b13..659881d 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -101,8 +101,6 @@ static void platform_msi_update_chip_ops(struct msi_domain_info *info)
 		chip->irq_mask = irq_chip_mask_parent;
 	if (!chip->irq_unmask)
 		chip->irq_unmask = irq_chip_unmask_parent;
-	if (!chip->irq_eoi)
-		chip->irq_eoi = irq_chip_eoi_parent;
 	if (!chip->irq_set_affinity)
 		chip->irq_set_affinity = msi_domain_set_affinity;
 	if (!chip->irq_write_msi_msg)
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index c41965e..c975909 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -274,6 +274,8 @@ static void msi_domain_update_chip_ops(struct msi_domain_info *info)
 	BUG_ON(!chip || !chip->irq_mask || !chip->irq_unmask);
 	if (!chip->irq_set_affinity)
 		chip->irq_set_affinity = msi_domain_set_affinity;
+	if (!chip->irq_eoi)
+		chip->irq_eoi = irq_chip_eoi_parent;
 }
 
 /**
