Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3759A35987F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhDIJCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:02:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15648 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhDIJCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:02:11 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGsWK5J5rzpWkd;
        Fri,  9 Apr 2021 16:59:09 +0800 (CST)
Received: from huawei.com (10.174.28.241) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 17:01:48 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <cuibixuan@huawei.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Liu Shixin <liushixin2@huawei.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] powerpc/pseries: Make symbol '__pcpu_scope_hcall_stats' static
Date:   Fri, 9 Apr 2021 17:01:09 +0800
Message-ID: <20210409090109.59347-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.28.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

arch/powerpc/platforms/pseries/hvCall_inst.c:29:1: warning:
 symbol '__pcpu_scope_hcall_stats' was not declared. Should it be static?

This symbol is not used outside of hvCall_inst.c, so this
commit marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
 arch/powerpc/platforms/pseries/hvCall_inst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/hvCall_inst.c b/arch/powerpc/platforms/pseries/hvCall_inst.c
index 2c59b4986ea5..3a50612a78db 100644
--- a/arch/powerpc/platforms/pseries/hvCall_inst.c
+++ b/arch/powerpc/platforms/pseries/hvCall_inst.c
@@ -26,7 +26,7 @@ struct hcall_stats {
 };
 #define HCALL_STAT_ARRAY_SIZE	((MAX_HCALL_OPCODE >> 2) + 1)
 
-DEFINE_PER_CPU(struct hcall_stats[HCALL_STAT_ARRAY_SIZE], hcall_stats);
+static DEFINE_PER_CPU(struct hcall_stats[HCALL_STAT_ARRAY_SIZE], hcall_stats);
 
 /*
  * Routines for displaying the statistics in debugfs

