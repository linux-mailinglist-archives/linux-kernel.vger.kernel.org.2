Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE79403262
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 03:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346961AbhIHBvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 21:51:23 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:15249 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbhIHBvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 21:51:22 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4H44nG6xMkz1DG6c;
        Wed,  8 Sep 2021 09:49:22 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:50:13 +0800
Received: from huawei.com (10.174.28.241) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 09:50:13 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <tglx@linutronix.de>, <john.wanghui@huawei.com>
Subject: [PATCH -next] irqdomain: fix overflow error
Date:   Wed, 8 Sep 2021 09:46:23 +0800
Message-ID: <20210908014623.61357-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.28.241]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function ‘kmalloc_node’,
    inlined from ‘kzalloc_node.constprop’ at ./include/linux/slab.h:743:9,
    inlined from ‘__irq_domain_add’ at kernel/irq/irqdomain.c:153:9:
./include/linux/slab.h:618:9: error: argument 1 value ‘18446744073709551615’ exceeds maximum object size 9223372036854775807 [-Werror=alloc-size-larger-than=]
  return __kmalloc_node(size, flags, node);

The 'size' can be negative here, which will then get turned into a giant
size argument for kzalloc_node(). Changing the size to 'unsigned int'
instead seems more appropriate.

Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
 include/linux/irqdomain.h | 2 +-
 kernel/irq/irqdomain.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 23e4ee523576..9ee238ad29ce 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -251,7 +251,7 @@ static inline struct fwnode_handle *irq_domain_alloc_fwnode(phys_addr_t *pa)
 }
 
 void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
-struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
+struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int size,
 				    irq_hw_number_t hwirq_max, int direct_max,
 				    const struct irq_domain_ops *ops,
 				    void *host_data);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 19e83e9b723c..4d8fc65cf38f 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -136,7 +136,7 @@ EXPORT_SYMBOL_GPL(irq_domain_free_fwnode);
  * Allocates and initializes an irq_domain structure.
  * Returns pointer to IRQ domain, or NULL on failure.
  */
-struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
+struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int size,
 				    irq_hw_number_t hwirq_max, int direct_max,
 				    const struct irq_domain_ops *ops,
 				    void *host_data)
-- 
2.17.1

