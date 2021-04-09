Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DF23595FB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 09:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbhDIHCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 03:02:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16109 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbhDIHCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 03:02:09 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGpsW3GSXz1BGM9;
        Fri,  9 Apr 2021 14:59:43 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.98) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Fri, 9 Apr 2021 15:01:46 +0800
From:   Pu Lehui <pulehui@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <jniethe5@gmail.com>, <alistair@popple.id.au>,
        <ravi.bangoria@linux.ibm.com>, <pmladek@suse.com>,
        <john.ogness@linutronix.de>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <rppt@kernel.org>,
        <maddy@linux.ibm.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <pulehui@huawei.com>, <yangjihong1@huawei.com>,
        <zhangjinhao2@huawei.com>
Subject: [PATCH -next] powerpc/xmon: Make symbol 'spu_inst_dump' static
Date:   Fri, 9 Apr 2021 15:01:51 +0800
Message-ID: <20210409070151.163424-1-pulehui@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.98]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

arch/powerpc/xmon/xmon.c:4216:1: warning:
 symbol 'spu_inst_dump' was not declared. Should it be static?

This symbol is not used outside of xmon.c, so make it static.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/powerpc/xmon/xmon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index bf7d69625a2e..d4ae2a25781f 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -4212,8 +4212,7 @@ static void dump_spu_fields(struct spu *spu)
 	DUMP_FIELD(spu, "0x%p", pdata);
 }
 
-int
-spu_inst_dump(unsigned long adr, long count, int praddr)
+static int spu_inst_dump(unsigned long adr, long count, int praddr)
 {
 	return generic_inst_dump(adr, count, praddr, print_insn_spu);
 }
-- 
2.17.1

