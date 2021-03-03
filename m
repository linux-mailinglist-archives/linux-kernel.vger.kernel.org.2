Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF5132BDEE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379104AbhCCQji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:39:38 -0500
Received: from lucky1.263xmail.com ([211.157.147.134]:55918 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344732AbhCCME1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 07:04:27 -0500
Received: from localhost (unknown [192.168.167.13])
        by lucky1.263xmail.com (Postfix) with ESMTP id E7B09C75D3;
        Wed,  3 Mar 2021 19:57:16 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P4300T140473571735296S1614772632866484_;
        Wed, 03 Mar 2021 19:57:18 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <ba80ddaa333c65d3e86d5ece2779404c>
X-RL-SENDER: maqianga@uniontech.com
X-SENDER: maqianga@uniontech.com
X-LOGIN-NAME: maqianga@uniontech.com
X-FST-TO: mpe@ellerman.id.au
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   maqiang <maqianga@uniontech.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        maqiang <maqianga@uniontech.com>
Subject: [PATCH] powerpc: remove redundant space
Date:   Wed,  3 Mar 2021 19:57:10 +0800
Message-Id: <20210303115710.30886-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These one line of code don't meet the kernel coding style,
so remove the redundant space.

Signed-off-by: maqiang <maqianga@uniontech.com>
---
 arch/powerpc/kernel/syscalls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
index 078608ec2e92..9248288752d5 100644
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -81,7 +81,7 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, size_t, len,
 int
 ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, struct __kernel_old_timeval __user *tvp)
 {
-	if ( (unsigned long)n >= 4096 )
+	if ((unsigned long)n >= 4096)
 	{
 		unsigned long __user *buffer = (unsigned long __user *)n;
 		if (!access_ok(buffer, 5*sizeof(unsigned long))
-- 
2.20.1



