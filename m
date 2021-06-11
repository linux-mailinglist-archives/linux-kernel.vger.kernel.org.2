Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7197F3A436F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhFKN4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbhFKN4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BF2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 06:54:34 -0700 (PDT)
Date:   Fri, 11 Jun 2021 13:54:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419672;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iipeQeN6zlFQgWa+QFiYtljx4Kpe4PHQBi5Z3g6+BFI=;
        b=oOCXrEOL3H3I4H0UN44hXISaHFskKsX/ebaIHtemwbdYTIzDZVXFQY9C+yC9rp+hJKyj9W
        jaIN40lKUt4F8jxgmEs+62mp2T4bmDc7YRZCop1x0V90brbGsMdbwJjpufXGZ5w6SbQa31
        JDS0WB8HXntLMyBqauih8/WkFUzoUQC3VxSmpHpN08k8q9SNEHWbJDe8k06KqMSLoi6fkd
        KZYRmINkv76MtoL6kmkLgngWUYFLks691Kdmv7olPZKRRC0hNKnGtpEXgxs8U6Qzjk5VST
        AqB7m5W0kArHQ8NCIyarXyyASQEuFw2jEfv7DOBWdcmUGFVS6ITwMnwR1NgELA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419672;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iipeQeN6zlFQgWa+QFiYtljx4Kpe4PHQBi5Z3g6+BFI=;
        b=u+xfHnvBDp8UsqUOxMhfqvwukWV8CHDbYvv794RGfJUBmVwsF5XeqCrWqu5+U8oD9k1U5A
        yafWrWNie2fZGQBA==
From:   "irqchip-bot for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3-its: Remove unnecessary
 oom message
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210609140643.14531-1-thunder.leizhen@huawei.com>
References: <20210609140643.14531-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Message-ID: <162341967215.19906.7767512823804512028.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     944a1a17d399b33410af6dfcf2b5a0f74b42b3d0
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/944a1a17d399b33410af6dfcf2b5a0f74b42b3d0
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Wed, 09 Jun 2021 22:06:42 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Jun 2021 14:19:39 +01:00

irqchip/gic-v3-its: Remove unnecessary oom message

Fixes scripts/checkpatch.pl warning:
WARNING: Possible unnecessary 'out of memory' message

Remove it can help us save a bit of memory.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210609140643.14531-1-thunder.leizhen@huawei.com
---
 drivers/irqchip/irq-gic-v3-its.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 2e6923c..ba39668 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4895,10 +4895,8 @@ static int its_init_vpe_domain(void)
 	entries = roundup_pow_of_two(nr_cpu_ids);
 	vpe_proxy.vpes = kcalloc(entries, sizeof(*vpe_proxy.vpes),
 				 GFP_KERNEL);
-	if (!vpe_proxy.vpes) {
-		pr_err("ITS: Can't allocate GICv4 proxy device array\n");
+	if (!vpe_proxy.vpes)
 		return -ENOMEM;
-	}
 
 	/* Use the last possible DevID */
 	devid = GENMASK(device_ids(its) - 1, 0);
@@ -5314,10 +5312,8 @@ static void __init acpi_table_parse_srat_its(void)
 
 	its_srat_maps = kmalloc_array(count, sizeof(struct its_srat_map),
 				      GFP_KERNEL);
-	if (!its_srat_maps) {
-		pr_warn("SRAT: Failed to allocate memory for its_srat_maps!\n");
+	if (!its_srat_maps)
 		return;
-	}
 
 	acpi_table_parse_entries(ACPI_SIG_SRAT,
 			sizeof(struct acpi_table_srat),
