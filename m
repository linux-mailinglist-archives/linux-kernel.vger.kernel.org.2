Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4885F3D593D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhGZLeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 07:34:04 -0400
Received: from smtpbg587.qq.com ([113.96.223.105]:59948 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233713AbhGZLeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 07:34:03 -0400
X-QQ-mid: bizesmtp54t1627301668tw9qo2cb
Received: from ficus.lan (unknown [171.223.99.141])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 26 Jul 2021 20:14:27 +0800 (CST)
X-QQ-SSF: 0100000000200090B000B00A0000000
X-QQ-FEAT: se7HKUNMQYpSpsNgRHVqj17HwD69Q5+1VrzV4jIRdOJHrR4zRSCQ5TMIBmRIX
        Bscu7xQScTSS+vNlBXzpHTjWtSTH4E5fJnAkFpo9ZuYY7q696x4wqw/QkhAx3G6ysd8485g
        Dzm2s4UCbvN3Sd2qZcsv7NaAaiDsBm63aKSjbKdT1pDRaOts/oQwDsBdcS1MQPuzU88AFxb
        OPF3V+/KH3medoL7plz9JFRdTYADvy4VAopGUSfUzW+/CuGnVoqSj3z4fYRoN/k3L1i4RhB
        HYT9oO995GuXgbnmN4hQy5HPofQwnbTTzh0i48ee2lqD+GVb5UMvw4WSCcmQXRunVkXc+vM
        xV/h4q5
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     ysato@users.sourceforge.jp
Cc:     uclinux-h8-devel@lists.sourceforge.jp,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] h8300: change 'long int' with 'long'
Date:   Mon, 26 Jul 2021 20:14:22 +0800
Message-Id: <20210726121422.33121-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer 'long' over 'long int' as the int is unnecessary.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/h8300/include/asm/user.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/h8300/include/asm/user.h b/arch/h8300/include/asm/user.h
index 2298909f24c6..eb8b88c01c09 100644
--- a/arch/h8300/include/asm/user.h
+++ b/arch/h8300/include/asm/user.h
@@ -52,15 +52,15 @@ struct user {
 	struct user_regs_struct regs;	/* Where the registers are actually stored */
 /* ptrace does not yet supply these.  Someday.... */
 /* The rest of this junk is to help gdb figure out what goes where */
-	unsigned long int u_tsize;	/* Text segment size (pages). */
-	unsigned long int u_dsize;	/* Data segment size (pages). */
-	unsigned long int u_ssize;	/* Stack segment size (pages). */
+	unsigned long u_tsize;	/* Text segment size (pages). */
+	unsigned long u_dsize;	/* Data segment size (pages). */
+	unsigned long u_ssize;	/* Stack segment size (pages). */
 	unsigned long start_code;     /* Starting virtual address of text. */
 	unsigned long start_stack;	/* Starting virtual address of stack area.
 					   This is actually the bottom of the stack,
 					   the top of the stack is always found in the
 					   esp register.  */
-	long int signal;		/* Signal that caused the core dump. */
+	long signal;		/* Signal that caused the core dump. */
 	int reserved;			/* No longer used */
 	unsigned long u_ar0;		/* Used by gdb to help find the values for */
 	/* the registers. */
-- 
2.32.0

