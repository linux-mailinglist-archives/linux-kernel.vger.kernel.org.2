Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66390321A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhBVOXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:23:16 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12638 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhBVOBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 09:01:03 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DkkLF39Sbz16BWn;
        Mon, 22 Feb 2021 21:58:45 +0800 (CST)
Received: from mdc.huawei.com (10.175.112.208) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Mon, 22 Feb 2021 22:00:13 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregory.herrero@oracle.com>, <catalin.marinas@arm.com>,
        <rostedt@goodmis.org>, <rui.xiang@huawei.com>
Subject: [PATCH] recordmcount: use w8 to read relp->r_info in arm64_is_fake_mcount
Date:   Mon, 22 Feb 2021 13:58:40 +0000
Message-ID: <20210222135840.56250-1-chenjun102@huawei.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On little endian system, Use aarch64_be(gcc v7.3) downloaded from
linaro.org to build image with CONFIG_CPU_BIG_ENDIAN = y,
CONFIG_FTRACE = y, CONFIG_DYNAMIC_FTRACE = y.

gcc will create symbols of _mcount but recordmcount can not create
mcount_loc for *.o.
aarch64_be-linux-gnu-objdump -r fs/namei.o | grep mcount
00000000000000d0 R_AARCH64_CALL26  _mcount
...
0000000000007190 R_AARCH64_CALL26  _mcount

The reason is than funciton arm64_is_fake_mcount can not work correctly.
A symbol of _mcount in *.o compiled with big endian compiler likes:
00 00 00 2d 00 00 01 1b
w(rp->r_info) will return 0x2d instead of 0x011b. Because w() takes
uint32_t as parameter, which truncates rp->r_info.

Use w8() instead w() to read relp->r_info

Fixes: ea0eada45632 ("recordmcount: only record relocation of type R_AARCH64_CALL26 on arm64.")
Signed-off-by: Chen Jun <chenjun102@huawei.com>
---
 scripts/recordmcount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index b9c2ee7ab43f..cce12e1971d8 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -438,7 +438,7 @@ static int arm_is_fake_mcount(Elf32_Rel const *rp)
 
 static int arm64_is_fake_mcount(Elf64_Rel const *rp)
 {
-	return ELF64_R_TYPE(w(rp->r_info)) != R_AARCH64_CALL26;
+	return ELF64_R_TYPE(w8(rp->r_info)) != R_AARCH64_CALL26;
 }
 
 /* 64-bit EM_MIPS has weird ELF64_Rela.r_info.
-- 
2.25.0

