Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A552E3EAEB7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 04:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238518AbhHMCvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 22:51:10 -0400
Received: from smtpbgsg1.qq.com ([54.254.200.92]:54888 "EHLO smtpbgsg1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238493AbhHMCvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 22:51:07 -0400
X-QQ-mid: bizesmtp46t1628823028tijooz83
Received: from localhost.localdomain (unknown [124.126.19.250])
        by esmtp6.qq.com (ESMTP) with 
        id ; Fri, 13 Aug 2021 10:50:26 +0800 (CST)
X-QQ-SSF: 0140000000200030C000B00A0000000
X-QQ-FEAT: uPKj8ga2w7ESWVvJHcmLVBUglknZ1E0sLKTu7P2qT8OYmTUvr96VidDPVKua7
        T2X1JM/vks1y4uRxQ82D4VGrU53vhF1KOx053mpkxu1mJUlY7nOZq6KPqpkdj95qucz0pTu
        Yyt6jBE8CWj06DQ9NX+2elety9yXdFp/E/nVFGxXiIFOPlMlNvVL7xbQ3OoDBifes2VIORr
        NbNtjUMtg8t5HuI9FdiHFDAX7irw0GdFXGBMIJ3Y2LDYpBuzqr2Yj2ymX36AEKuTfjya1TD
        37dnamWzq2N2a3epJj3JyfRW96Y43JSH2UY27fWb5ssuv4VfECDp7EoV/SHJE5uz1Up5Zue
        cly1YHqSnSYaKJViTw=
X-QQ-GoodBg: 2
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     chenhc@lemote.com
Cc:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] MIPS: Loongson64: Make some functions static in irq.c
Date:   Fri, 13 Aug 2021 10:50:25 +0800
Message-Id: <20210813025025.26580-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make some functions static to fix the following sparse warnings:
arch/mips/loongson64/loongson-3/irq.c:15:14: warning: symbol 'irq_cpu' was not declared. Should it be static?
arch/mips/loongson64/loongson-3/irq.c:16:14: warning: symbol 'ht_irq' was not declared. Should it be static?
arch/mips/loongson64/loongson-3/irq.c:17:14: warning: symbol 'local_irq' was not declared. Should it be static?
arch/mips/loongson64/loongson-3/irq.c:19:5: warning: symbol 'plat_set_irq_affinity' was not declared. Should it be static?
arch/mips/loongson64/loongson-3/irq.c:112:6: warning: symbol 'irq_router_init' was not declared. Should it be static?

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 arch/mips/loongson64/loongson-3/irq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/loongson64/loongson-3/irq.c b/arch/mips/loongson64/loongson-3/irq.c
index 5605061f5f98..f68098c6d0f6 100644
--- a/arch/mips/loongson64/loongson-3/irq.c
+++ b/arch/mips/loongson64/loongson-3/irq.c
@@ -12,11 +12,11 @@
 
 extern void loongson3_send_irq_by_ipi(int cpu, int irqs);
 
-unsigned int irq_cpu[16] = {[0 ... 15] = -1};
-unsigned int ht_irq[] = {0, 1, 3, 4, 5, 6, 7, 8, 12, 14, 15};
-unsigned int local_irq = 1<<0 | 1<<1 | 1<<2 | 1<<7 | 1<<8 | 1<<12;
+static unsigned int irq_cpu[16] = {[0 ... 15] = -1};
+static unsigned int ht_irq[] = {0, 1, 3, 4, 5, 6, 7, 8, 12, 14, 15};
+static unsigned int local_irq = 1<<0 | 1<<1 | 1<<2 | 1<<7 | 1<<8 | 1<<12;
 
-int plat_set_irq_affinity(struct irq_data *d, const struct cpumask *affinity,
+static int plat_set_irq_affinity(struct irq_data *d, const struct cpumask *affinity,
 			  bool force)
 {
 	unsigned int cpu;
@@ -109,7 +109,7 @@ static struct irq_chip loongson_irq_chip = {
 	.irq_eoi	= unmask_loongson_irq,
 };
 
-void irq_router_init(void)
+static void irq_router_init(void)
 {
 	int i;
 
-- 
2.20.1



