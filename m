Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4704C32AA2E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443632AbhCBTLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:11:45 -0500
Received: from mga07.intel.com ([134.134.136.100]:7535 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1839377AbhCBQRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 11:17:32 -0500
IronPort-SDR: cFTkh3JKH3wBngPDNjHT8hfMoW0lisMfEqWLQJsWmSNfXGh09b4ANLy7QcleQkMsAdeF/QNkMp
 gJgeQ+A3tNfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="250918179"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="250918179"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 08:15:42 -0800
IronPort-SDR: Vt0QZCUuEOnMzMJNZlcPL/Mol5hhraqHKiC+kdIuQpx3T0VndNvPZNbGrS5y2K9DIKPObdVzf1
 rNFGQGmtjYqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="435746077"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 02 Mar 2021 08:15:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F082113A; Tue,  2 Mar 2021 18:14:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] genirq/irq_sim: Fix typos in kernel doc (fnode -> fwnode)
Date:   Tue,  2 Mar 2021 18:14:53 +0200
Message-Id: <20210302161453.28540-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typos in kernel doc, otherwise validation script complains:

.../irq_sim.c:170: warning: Function parameter or member 'fwnode' not described in 'irq_domain_create_sim'
.../irq_sim.c:170: warning: Excess function parameter 'fnode' description in 'irq_domain_create_sim'
.../irq_sim.c:240: warning: Function parameter or member 'fwnode' not described in 'devm_irq_domain_create_sim'
.../irq_sim.c:240: warning: Excess function parameter 'fnode' description in 'devm_irq_domain_create_sim'

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/irq/irq_sim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 48006608baf0..40880c350b95 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -159,7 +159,7 @@ static const struct irq_domain_ops irq_sim_domain_ops = {
  * irq_domain_create_sim - Create a new interrupt simulator irq_domain and
  *                         allocate a range of dummy interrupts.
  *
- * @fnode:      struct fwnode_handle to be associated with this domain.
+ * @fwnode:     struct fwnode_handle to be associated with this domain.
  * @num_irqs:   Number of interrupts to allocate.
  *
  * On success: return a new irq_domain object.
@@ -228,7 +228,7 @@ static void devm_irq_domain_release_sim(struct device *dev, void *res)
  *                              a managed device.
  *
  * @dev:        Device to initialize the simulator object for.
- * @fnode:      struct fwnode_handle to be associated with this domain.
+ * @fwnode:     struct fwnode_handle to be associated with this domain.
  * @num_irqs:   Number of interrupts to allocate
  *
  * On success: return a new irq_domain object.
-- 
2.30.1

