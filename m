Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA673207D0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 01:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhBUA0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 19:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhBUA0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 19:26:48 -0500
Received: from smtp.gentoo.org (dev.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DA6C061574;
        Sat, 20 Feb 2021 16:26:07 -0800 (PST)
Received: by sf.home (Postfix, from userid 1000)
        id 58FC65A2208E; Sun, 21 Feb 2021 00:25:59 +0000 (GMT)
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Sergei Trofimovich <slyfox@gentoo.org>, linux-ia64@vger.kernel.org,
        "Dmitry V . Levin" <ldv@altlinux.org>
Subject: [PATCH] ia64: fix ptrace(PTRACE_SYSCALL_INFO_EXIT) sign
Date:   Sun, 21 Feb 2021 00:25:54 +0000
Message-Id: <20210221002554.333076-2-slyfox@gentoo.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210221002554.333076-1-slyfox@gentoo.org>
References: <20210221002554.333076-1-slyfox@gentoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In https://bugs.gentoo.org/769614 Dmitry noticed that
`ptrace(PTRACE_GET_SYSCALL_INFO)` does not return error sign properly.

The bug is in mismatch between get/set errors:

static inline long syscall_get_error(struct task_struct *task,
                                     struct pt_regs *regs)
{
        return regs->r10 == -1 ? regs->r8:0;
}

static inline long syscall_get_return_value(struct task_struct *task,
                                            struct pt_regs *regs)
{
        return regs->r8;
}

static inline void syscall_set_return_value(struct task_struct *task,
                                            struct pt_regs *regs,
                                            int error, long val)
{
        if (error) {
                /* error < 0, but ia64 uses > 0 return value */
                regs->r8 = -error;
                regs->r10 = -1;
        } else {
                regs->r8 = val;
                regs->r10 = 0;
        }
}

Tested on v5.10 on rx3600 machine (ia64 9040 CPU).

CC: linux-ia64@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Dmitry V. Levin <ldv@altlinux.org>
Bug: https://bugs.gentoo.org/769614
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
 arch/ia64/include/asm/syscall.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/include/asm/syscall.h b/arch/ia64/include/asm/syscall.h
index 6c6f16e409a8..0d23c0049301 100644
--- a/arch/ia64/include/asm/syscall.h
+++ b/arch/ia64/include/asm/syscall.h
@@ -32,7 +32,7 @@ static inline void syscall_rollback(struct task_struct *task,
 static inline long syscall_get_error(struct task_struct *task,
 				     struct pt_regs *regs)
 {
-	return regs->r10 == -1 ? regs->r8:0;
+	return regs->r10 == -1 ? -regs->r8:0;
 }
 
 static inline long syscall_get_return_value(struct task_struct *task,
-- 
2.30.1

