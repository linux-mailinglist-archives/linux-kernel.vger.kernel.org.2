Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5003EA317
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 12:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbhHLKrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 06:47:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57674 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbhHLKr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:47:26 -0400
Date:   Thu, 12 Aug 2021 10:47:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628765220;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IYq5SLwKtcl1siyodW+SI2eD5hjHwFEfnzU/Icl/5Zk=;
        b=0sA2yR5b4FsZNOHsuwWwz/wPwIxBijKszLQD+VpxSMJCi4GfGAIS8Gb+T5RWPouMtzkwa1
        WY+goQJqSa4YdJlRArfMCAzgL0b8XTskjByBebmlLupXpjA6VepapMjw7qad9Agz8Lrsf1
        VdgGC+yWWZzCTydsJGGCnj6KolQaExb1UlGtjsIAHJ2D5CrrHCbtaaDslgDsmqrJiQms5k
        Q/dqotMyHv32qobYB2z10PY8EOtwE/564TplfmxRLd9K1Sp0jETWgdGF4uLPtIYfQ4Vwj8
        ZJQ4sO4jPwRcxooVp8f5M2gDBKc3Fihez6seLLSJSlPuoOjxv5FH5HJVGeI2sA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628765220;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IYq5SLwKtcl1siyodW+SI2eD5hjHwFEfnzU/Icl/5Zk=;
        b=d3bGD+Zai8gnKDpX5nb5WhJOWi6UfjoaeNnh/6BPLwlfy6I9itKUZ6X3Ns4nRCG8xxDh2V
        Jc2UOg4bzB0KVkAw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] gpu: Bulk conversion to
 generic_handle_domain_irq()
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162876522008.395.10214820333808987035.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     66c6594b6dd66e04909d35dd5281c67cb81ecd2c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/66c6594b6dd66e04909d35dd5281c67cb81ecd2c
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 04 May 2021 17:42:18 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 11:39:40 +01:00

gpu: Bulk conversion to generic_handle_domain_irq()

Wherever possible, replace constructs that match either
generic_handle_irq(irq_find_mapping()) or
generic_handle_irq(irq_linear_revmap()) to a single call to
generic_handle_domain_irq().

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c   |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c  | 15 ++++-----------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c |  3 +--
 drivers/gpu/ipu-v3/ipu-common.c           | 11 ++++-------
 4 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 83af307..cd2e18f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -502,7 +502,7 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
 
 	} else if ((client_id == AMDGPU_IRQ_CLIENTID_LEGACY) &&
 		   adev->irq.virq[src_id]) {
-		generic_handle_irq(irq_find_mapping(adev->irq.domain, src_id));
+		generic_handle_domain_irq(adev->irq.domain, src_id);
 
 	} else if (!adev->irq.client[client_id].sources) {
 		DRM_DEBUG("Unregistered interrupt client_id: %d src_id: %d\n",
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
index 6b0a7bc..b466784 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
@@ -45,20 +45,13 @@ static void dpu_mdss_irq(struct irq_desc *desc)
 
 	while (interrupts) {
 		irq_hw_number_t hwirq = fls(interrupts) - 1;
-		unsigned int mapping;
 		int rc;
 
-		mapping = irq_find_mapping(dpu_mdss->irq_controller.domain,
-					   hwirq);
-		if (mapping == 0) {
-			DRM_ERROR("couldn't find irq mapping for %lu\n", hwirq);
-			break;
-		}
-
-		rc = generic_handle_irq(mapping);
+		rc = generic_handle_domain_irq(dpu_mdss->irq_controller.domain,
+					       hwirq);
 		if (rc < 0) {
-			DRM_ERROR("handle irq fail: irq=%lu mapping=%u rc=%d\n",
-				  hwirq, mapping, rc);
+			DRM_ERROR("handle irq fail: irq=%lu rc=%d\n",
+				  hwirq, rc);
 			break;
 		}
 
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c
index 09bd46a..2f4895b 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c
@@ -50,8 +50,7 @@ static irqreturn_t mdss_irq(int irq, void *arg)
 	while (intr) {
 		irq_hw_number_t hwirq = fls(intr) - 1;
 
-		generic_handle_irq(irq_find_mapping(
-				mdp5_mdss->irqcontroller.domain, hwirq));
+		generic_handle_domain_irq(mdp5_mdss->irqcontroller.domain, hwirq);
 		intr &= ~(1 << hwirq);
 	}
 
diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index d166ee2..1183185 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -1003,19 +1003,16 @@ err_cpmem:
 static void ipu_irq_handle(struct ipu_soc *ipu, const int *regs, int num_regs)
 {
 	unsigned long status;
-	int i, bit, irq;
+	int i, bit;
 
 	for (i = 0; i < num_regs; i++) {
 
 		status = ipu_cm_read(ipu, IPU_INT_STAT(regs[i]));
 		status &= ipu_cm_read(ipu, IPU_INT_CTRL(regs[i]));
 
-		for_each_set_bit(bit, &status, 32) {
-			irq = irq_linear_revmap(ipu->domain,
-						regs[i] * 32 + bit);
-			if (irq)
-				generic_handle_irq(irq);
-		}
+		for_each_set_bit(bit, &status, 32)
+			generic_handle_domain_irq(ipu->domain,
+						  regs[i] * 32 + bit);
 	}
 }
 
