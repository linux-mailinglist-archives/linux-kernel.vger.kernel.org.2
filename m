Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1389232CF09
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 09:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbhCDI6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 03:58:39 -0500
Received: from lucky1.263xmail.com ([211.157.147.132]:36210 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbhCDI6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 03:58:24 -0500
Received: from localhost (unknown [192.168.167.13])
        by lucky1.263xmail.com (Postfix) with ESMTP id 15D02F2E75;
        Thu,  4 Mar 2021 16:55:53 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P4300T140473634674432S1614848149085210_;
        Thu, 04 Mar 2021 16:55:53 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <8bd820151685312b0cf2c2d9ebb054b2>
X-RL-SENDER: maqianga@uniontech.com
X-SENDER: maqianga@uniontech.com
X-LOGIN-NAME: maqianga@uniontech.com
X-FST-TO: mpe@ellerman.id.au
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Qiang Ma <maqianga@uniontech.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH] powerpc: fix coding style issues
Date:   Thu,  4 Mar 2021 16:55:41 +0800
Message-Id: <20210304085541.766-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several style issues in this function,
so fix them.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 arch/powerpc/kernel/syscalls.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
index 078608ec2e92..bcbb5fb2a0c1 100644
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -81,15 +81,15 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, size_t, len,
 int
 ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, struct __kernel_old_timeval __user *tvp)
 {
-	if ( (unsigned long)n >= 4096 )
-	{
+	if ((unsigned long)n >= 4096) {
 		unsigned long __user *buffer = (unsigned long __user *)n;
-		if (!access_ok(buffer, 5*sizeof(unsigned long))
+		if (!access_ok(buffer, 5 * sizeof(unsigned long))
 		    || __get_user(n, buffer)
-		    || __get_user(inp, ((fd_set __user * __user *)(buffer+1)))
-		    || __get_user(outp, ((fd_set  __user * __user *)(buffer+2)))
-		    || __get_user(exp, ((fd_set  __user * __user *)(buffer+3)))
-		    || __get_user(tvp, ((struct __kernel_old_timeval  __user * __user *)(buffer+4))))
+		    || __get_user(inp, ((fd_set __user * __user *)(buffer + 1)))
+		    || __get_user(outp, ((fd_set  __user * __user *)(buffer + 2)))
+		    || __get_user(exp, ((fd_set  __user * __user *)(buffer + 3)))
+		    || __get_user(tvp,
+			    ((struct __kernel_old_timeval  __user * __user *)(buffer + 4))))
 			return -EFAULT;
 	}
 	return sys_select(n, inp, outp, exp, tvp);
-- 
2.20.1



