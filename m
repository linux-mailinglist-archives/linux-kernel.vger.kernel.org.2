Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F80396F28
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbhFAIn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:43:56 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3491 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhFAIny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:43:54 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FvQZ74j7TzYrxh;
        Tue,  1 Jun 2021 16:39:27 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 16:42:11 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 1 Jun 2021
 16:42:10 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <jk@ozlabs.org>, <arnd@arndb.de>, <mpe@ellerman.id.au>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] powerpc/spufs: disp: Remove set but not used variable 'dummy'
Date:   Tue, 1 Jun 2021 16:51:27 +0800
Message-ID: <20210601085127.139598-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

arch/powerpc/platforms/cell/spufs/switch.c: In function 'check_ppu_mb_stat':
arch/powerpc/platforms/cell/spufs/switch.c:1660:6: warning:
variable ‘dummy’ set but not used [-Wunused-but-set-variable]

arch/powerpc/platforms/cell/spufs/switch.c: In function 'check_ppuint_mb_stat':
arch/powerpc/platforms/cell/spufs/switch.c:1675:6: warning:
variable ‘dummy’ set but not used [-Wunused-but-set-variable]

It never used since introduction.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 arch/powerpc/platforms/cell/spufs/switch.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/switch.c b/arch/powerpc/platforms/cell/spufs/switch.c
index d56b4e3241cd..b41e81b22fdc 100644
--- a/arch/powerpc/platforms/cell/spufs/switch.c
+++ b/arch/powerpc/platforms/cell/spufs/switch.c
@@ -1657,14 +1657,13 @@ static inline void restore_spu_mb(struct spu_state *csa, struct spu *spu)
 static inline void check_ppu_mb_stat(struct spu_state *csa, struct spu *spu)
 {
 	struct spu_problem __iomem *prob = spu->problem;
-	u32 dummy = 0;
 
 	/* Restore, Step 66:
 	 *     If CSA.MB_Stat[P]=0 (mailbox empty) then
 	 *     read from the PPU_MB register.
 	 */
 	if ((csa->prob.mb_stat_R & 0xFF) == 0) {
-		dummy = in_be32(&prob->pu_mb_R);
+		in_be32(&prob->pu_mb_R);
 		eieio();
 	}
 }
@@ -1672,14 +1671,13 @@ static inline void check_ppu_mb_stat(struct spu_state *csa, struct spu *spu)
 static inline void check_ppuint_mb_stat(struct spu_state *csa, struct spu *spu)
 {
 	struct spu_priv2 __iomem *priv2 = spu->priv2;
-	u64 dummy = 0UL;
 
 	/* Restore, Step 66:
 	 *     If CSA.MB_Stat[I]=0 (mailbox empty) then
 	 *     read from the PPUINT_MB register.
 	 */
 	if ((csa->prob.mb_stat_R & 0xFF0000) == 0) {
-		dummy = in_be64(&priv2->puint_mb_R);
+		in_be64(&priv2->puint_mb_R);
 		eieio();
 		spu_int_stat_clear(spu, 2, CLASS2_ENABLE_MAILBOX_INTR);
 		eieio();
-- 
2.31.1

