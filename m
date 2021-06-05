Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7825439C63A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 08:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhFEG0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 02:26:49 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3065 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFEG0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 02:26:48 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FxqHc4zwFzWnvT
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 14:20:12 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 5 Jun 2021 14:24:59 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 5 Jun 2021
 14:24:58 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] genirq/matrix: fix doc warnings in matrix.c
Date:   Sat, 5 Jun 2021 14:34:13 +0800
Message-ID: <20210605063413.684085-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

kernel/irq/matrix.c:287: warning: Function parameter or
 member 'msk' not described in 'irq_matrix_alloc_managed'
kernel/irq/matrix.c:287: warning: Function parameter or
 member 'mapped_cpu' not described in 'irq_matrix_alloc_managed'
kernel/irq/matrix.c:287: warning: Excess function
 parameter 'cpu' description in 'irq_matrix_alloc_managed'

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 kernel/irq/matrix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 578596e41cb6..bbfb26489aa1 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -280,7 +280,8 @@ void irq_matrix_remove_managed(struct irq_matrix *m, const struct cpumask *msk)
 /**
  * irq_matrix_alloc_managed - Allocate a managed interrupt in a CPU map
  * @m:		Matrix pointer
- * @cpu:	On which CPU the interrupt should be allocated
+ * @msk:	Which CPUs to search in
+ * @mapped_cpu:	Pointer to store the CPU for which the irq was allocated
  */
 int irq_matrix_alloc_managed(struct irq_matrix *m, const struct cpumask *msk,
 			     unsigned int *mapped_cpu)
-- 
2.31.1

