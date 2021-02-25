Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072FF325147
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 15:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhBYOJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 09:09:09 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13089 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbhBYOJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 09:09:03 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DmZN36C2Vz16CRc;
        Thu, 25 Feb 2021 22:06:43 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Feb 2021 22:08:11 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <gregory.herrero@oracle.com>, <rostedt@goodmis.org>,
        <catalin.marinas@arm.com>, <christophe.leroy@csgroup.eu>,
        <linux-kernel@vger.kernel.org>
CC:     <lihuafei1@huawei.com>, <zhangjinhao2@huawei.com>,
        <yangjihong1@huawei.com>, <xukuohai@huawei.com>
Subject: [PATCH] recordmcount: Fix the wrong use of w* in arm64_is_fake_mcount()
Date:   Thu, 25 Feb 2021 22:07:47 +0800
Message-ID: <20210225140747.10818-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When cross-compiling the kernel, the endian of the target machine and
the local machine may not match, at this time the recordmcount tool
needs byte reversal when processing elf's variables to get the correct
value. w* callback function is used to solve this problem, w is used for
4-byte variable processing, while w8 is used for 8-byte.

arm64_is_fake_mcount() is used to filter '_mcount' relocations that are
not used by ftrace. In arm64_is_fake_mcount(), rp->info is 8 bytes in
size, but w is used. This causes arm64_is_fake_mcount() to get the wrong
type of relocation when we cross-compile the arm64_be kernel image on an
x86_le machine, and all valid '_mcount' is filtered out. The
recordmcount tool does not collect any mcount function call locations.
At kernel startup, the following ftrace log is seen:

	ftrace: No functions to be traced?

and thus ftrace cannot be used.

Using w8 to get the value of rp->r_info will fix the problem.

Fixes: ea0eada45632 ("recordmcount: only record relocation of type
R_AARCH64_CALL26 on arm64")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
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
2.17.1

