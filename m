Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA503C85A3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 15:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239364AbhGNN5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 09:57:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231941AbhGNN5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 09:57:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 763F7613BE;
        Wed, 14 Jul 2021 13:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626270870;
        bh=t+6P8ruMEieGtHTBjM2M2aNiGF22kEbrvG+svMNP+AI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u7w58994SAuYUULuNNKE9wHQEbF243glAKHGQhS4i2VBpa9s0uONXPgE++p8edcgi
         s3IkO48btLm/ozz1XY4qULf7ThaL8djeIgGhgqFSgABu12d12pyy7GwSbf831pXHXp
         sS/NXX2S+jrHVBGpfnYzYb1vOBLvcNJtzrQL74ORG7kX3wCZfDrYGSRxq1DuZUWBNP
         XykgYEe9CseC6Yg4ZZ0WAHAQnYeEXRtX1q/V0kb3iu8VXVhM10sF59Cc2latwh1DBo
         Nplw2wge8CMwVUfKRdgDou909WDHuFrQWaxDKDfjPkG31DhS5w27PX7Ir+HLq7sOuJ
         JGpxMGBf4l6MQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        Christoph Lameter <cl@gentwo.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Zefan Li cgroups @ vger . kernel . org" <lizefan.x@bytedance.com>
Subject: [RFC PATCH 1/6] pci: Decouple HK_FLAG_WQ and HK_FLAG_DOMAIN cpumask fetch
Date:   Wed, 14 Jul 2021 15:54:15 +0200
Message-Id: <20210714135420.69624-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210714135420.69624-1-frederic@kernel.org>
References: <20210714135420.69624-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare for supporting each feature of the housekeeping cpumask
toward cpuset, prepare for HK_FLAG_DOMAIN to move to its own cpumask.
This will allow to modify the set passed through "isolcpus=" kernel boot
parameter on runtime.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Nitesh Lal <nilal@redhat.com>
Cc: Nicolas Saenz <nsaenzju@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Lameter <cl@gentwo.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Alex Belits <abelits@marvell.com>
---
 drivers/pci/pci-driver.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 3a72352aa5cf..ab84fa81c29a 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -336,7 +336,6 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 			  const struct pci_device_id *id)
 {
 	int error, node, cpu;
-	int hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
 	struct drv_dev_and_id ddi = { drv, dev, id };
 
 	/*
@@ -354,17 +353,29 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 	 * device is probed from work_on_cpu() of the Physical device.
 	 */
 	if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
-	    pci_physfn_is_probed(dev))
+	    pci_physfn_is_probed(dev)) {
 		cpu = nr_cpu_ids;
-	else
+	} else {
+		cpumask_var_t wq_domain_mask;
+
+		if (!zalloc_cpumask_var(&wq_domain_mask, GFP_KERNEL)) {
+			error = -ENOMEM;
+			goto out;
+		}
+		cpumask_and(wq_domain_mask,
+			    housekeeping_cpumask(HK_FLAG_WQ),
+			    housekeeping_cpumask(HK_FLAG_DOMAIN));
+
 		cpu = cpumask_any_and(cpumask_of_node(node),
-				      housekeeping_cpumask(hk_flags));
+				      wq_domain_mask);
+		free_cpumask_var(wq_domain_mask);
+	}
 
 	if (cpu < nr_cpu_ids)
 		error = work_on_cpu(cpu, local_pci_probe, &ddi);
 	else
 		error = local_pci_probe(&ddi);
-
+out:
 	dev->is_probed = 0;
 	cpu_hotplug_enable();
 	return error;
-- 
2.25.1

