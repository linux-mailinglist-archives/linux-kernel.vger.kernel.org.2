Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BB4357C78
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhDHGUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:20:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15174 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhDHGUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:20:31 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FG9zJ5WS5zpVdL;
        Thu,  8 Apr 2021 14:17:32 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.98) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 14:20:08 +0800
From:   Pu Lehui <pulehui@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <joel@jms.id.au>, <christophe.leroy@c-s.fr>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <zhangjinhao2@huawei.com>, <yangjihong1@huawei.com>,
        <pulehui@huawei.com>
Subject: [PATCH -next] powerpc/fadump: make symbol 'rtas_fadump_set_regval' static
Date:   Thu, 8 Apr 2021 14:20:12 +0800
Message-ID: <20210408062012.85973-1-pulehui@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.98]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings:

arch/powerpc/platforms/pseries/rtas-fadump.c:250:6: warning:
 symbol 'rtas_fadump_set_regval' was not declared. Should it be static?

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/powerpc/platforms/pseries/rtas-fadump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.c b/arch/powerpc/platforms/pseries/rtas-fadump.c
index 81343908ed33..f8f73b47b107 100644
--- a/arch/powerpc/platforms/pseries/rtas-fadump.c
+++ b/arch/powerpc/platforms/pseries/rtas-fadump.c
@@ -247,7 +247,7 @@ static inline int rtas_fadump_gpr_index(u64 id)
 	return i;
 }
 
-void rtas_fadump_set_regval(struct pt_regs *regs, u64 reg_id, u64 reg_val)
+static void rtas_fadump_set_regval(struct pt_regs *regs, u64 reg_id, u64 reg_val)
 {
 	int i;
 
-- 
2.17.1

