Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E1943F560
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 05:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhJ2D3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 23:29:35 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25]:34496 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231694AbhJ2D3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 23:29:32 -0400
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-05 (Coremail) with SMTP id zQCowACnr7_zaXthIn6VBQ--.42300S2;
        Fri, 29 Oct 2021 11:26:43 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] genirq/matrix: Fix implicit type conversion
Date:   Fri, 29 Oct 2021 03:26:41 +0000
Message-Id: <1635478001-2572113-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: zQCowACnr7_zaXthIn6VBQ--.42300S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWxWFyfGrWkCrWDJF4xZwb_yoW8ZFy8pF
        40y3y7t3yjqa1jg347ZaykAa9Ikw1kJrn7t398ZrySyF93Jw1IvF1qv3sxZF1UWrZ5W3W7
        CF98t34kKF4DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
        GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUxb18UUU
        UU=
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'cpu' is defined as unsigned int.
However in the for_each_cpu, its values is assigned to -1.
That doesn't make sense and in the cpumask_next() it is implicitly
type conversed to int.
It is universally accepted that the implicit type conversion is
terrible.
Also, having the good programming custom will set an example for
others.
Thus, it might be better to change the definition of 'cpu' from
unsigned int to int.

Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 kernel/irq/matrix.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 578596e..825549a 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -129,7 +129,7 @@ static unsigned int matrix_alloc_area(struct irq_matrix *m, struct cpumap *cm,
 static unsigned int matrix_find_best_cpu(struct irq_matrix *m,
 					const struct cpumask *msk)
 {
-	unsigned int cpu, best_cpu, maxavl = 0;
+	int cpu, best_cpu, maxavl = 0;
 	struct cpumap *cm;
 
 	best_cpu = UINT_MAX;
@@ -150,7 +150,7 @@ static unsigned int matrix_find_best_cpu(struct irq_matrix *m,
 static unsigned int matrix_find_best_cpu_managed(struct irq_matrix *m,
 						const struct cpumask *msk)
 {
-	unsigned int cpu, best_cpu, allocated = UINT_MAX;
+	int cpu, best_cpu, allocated = UINT_MAX;
 	struct cpumap *cm;
 
 	best_cpu = UINT_MAX;
@@ -209,7 +209,7 @@ void irq_matrix_assign_system(struct irq_matrix *m, unsigned int bit,
  */
 int irq_matrix_reserve_managed(struct irq_matrix *m, const struct cpumask *msk)
 {
-	unsigned int cpu, failed_cpu;
+	int cpu, failed_cpu;
 
 	for_each_cpu(cpu, msk) {
 		struct cpumap *cm = per_cpu_ptr(m->maps, cpu);
@@ -250,7 +250,7 @@ int irq_matrix_reserve_managed(struct irq_matrix *m, const struct cpumask *msk)
  */
 void irq_matrix_remove_managed(struct irq_matrix *m, const struct cpumask *msk)
 {
-	unsigned int cpu;
+	int cpu;
 
 	for_each_cpu(cpu, msk) {
 		struct cpumap *cm = per_cpu_ptr(m->maps, cpu);
-- 
2.7.4

