Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2453C32D531
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 15:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241865AbhCDOVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 09:21:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:44826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240128AbhCDOVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 09:21:12 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15BD564F23;
        Thu,  4 Mar 2021 14:20:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lHoq6-001nvD-UP; Thu, 04 Mar 2021 09:20:30 -0500
Message-ID: <20210304142030.817013350@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Mar 2021 09:19:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>, Chen Jun <chenjun102@huawei.com>
Subject: [for-linus][PATCH 1/5] ftrace: Have recordmcount use w8 to read relp->r_info in
 arm64_is_fake_mcount
References: <20210304141952.446924335@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Jun <chenjun102@huawei.com>

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

Link: https://lkml.kernel.org/r/20210222135840.56250-1-chenjun102@huawei.com

Fixes: ea0eada45632 ("recordmcount: only record relocation of type R_AARCH64_CALL26 on arm64.")
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Chen Jun <chenjun102@huawei.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
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
2.30.0


