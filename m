Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FC63282AA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236630AbhCAPin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:38:43 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:28524 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237266AbhCAPi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:38:27 -0500
Received: from oscar.flets-west.jp (softbank126026090165.bbtec.net [126.26.90.165]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 121Fawh6014128;
        Tue, 2 Mar 2021 00:36:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 121Fawh6014128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614613019;
        bh=JcQhrllxuFRDL1UZHLujpUigbOErMlV75Eq1H4imx38=;
        h=From:To:Cc:Subject:Date:From;
        b=fPftHurlRgDuhPQO2vly13iwVtArvLqq2thObmjs55bm2juNQDrSzWCHUN5GWuMiX
         vQ6cieuMxG5XN8gFBLed9fCWa3Et0wpSip7AHObAkR2jRB3s3fmHVlzPiiojAPfUJ3
         bMN2Ufrh9sJBp1PIuoFF5eTNVnybbrYytsBEScRX9RjmJJ+qP6ZB9cQ6PLUkhkZPbl
         SQjovBgaMaCHIcpiHznFQ3lqH8pz0jA1Cukd46vgFsl/cb88Ko1outwfqcUk06UPl9
         z00dulm9VLHSH3dJpSUovho8A+uGbZrK9MyIEzNBrK/iWXAzHVodxtJ45bYe70Sv+r
         mKOw9T55cZuPA==
X-Nifty-SrcIP: [126.26.90.165]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/3] xtensa: stop filling syscall array with sys_ni_syscall
Date:   Tue,  2 Mar 2021 00:36:54 +0900
Message-Id: <20210301153656.363839-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/xtensa/kernel/syscalls/syscalltbl.sh fills missing syscall numbers
with sys_ni_syscall.

So, the generated arch/xtensa/include/generated/asm/syscall_table.h
has no hole.

Hence, the line:

  [0 ... __NR_syscalls - 1] = (syscall_t)&sys_ni_syscall,

is meaningless.

The number of generated __SYSCALL() macros is the same as __NR_syscalls
(this is 442 as of v5.11).

Hence, the array size, [__NR_syscalls] is unneeded.

The designated initializer, '[nr] =', is also unneeded.

This file does not need to know __NR_syscalls. Drop the unneeded
<asm/unistd.h> include directive.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/xtensa/kernel/syscall.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/xtensa/kernel/syscall.c b/arch/xtensa/kernel/syscall.c
index 2c415fce6801..26fa09ce4d17 100644
--- a/arch/xtensa/kernel/syscall.c
+++ b/arch/xtensa/kernel/syscall.c
@@ -17,7 +17,6 @@
  */
 #include <linux/uaccess.h>
 #include <asm/syscall.h>
-#include <asm/unistd.h>
 #include <linux/linkage.h>
 #include <linux/stringify.h>
 #include <linux/errno.h>
@@ -28,10 +27,8 @@
 #include <linux/sched/mm.h>
 #include <linux/shm.h>
 
-syscall_t sys_call_table[__NR_syscalls] /* FIXME __cacheline_aligned */= {
-	[0 ... __NR_syscalls - 1] = (syscall_t)&sys_ni_syscall,
-
-#define __SYSCALL(nr, entry, nargs)[nr] = (syscall_t)entry,
+syscall_t sys_call_table[] /* FIXME __cacheline_aligned */= {
+#define __SYSCALL(nr, entry, nargs)	(syscall_t)entry,
 #include <asm/syscall_table.h>
 #undef __SYSCALL
 };
-- 
2.27.0

