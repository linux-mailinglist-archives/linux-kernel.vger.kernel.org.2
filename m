Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50983DDB9A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbhHBOyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:54:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233981AbhHBOyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:54:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15B5C60F70;
        Mon,  2 Aug 2021 14:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627916043;
        bh=fQXoJXlivB6wDU7j0FBMr/A85o96vueb6Bpx2iaZyXM=;
        h=From:To:Cc:Subject:Date:From;
        b=Qw+ALPUPYVb+FldQk+KQkR86a5Udf/jhTlBKwCqwMYuHM9+/M3SFcD3Q65h7zRHou
         k1y/iE/l+YdkFFe5DlH0E+Yg0pG5g50Ob2HxXQoly4Sm5T9Lf/jh9nlVVRTtdN16eH
         fBw2XjBo5xjdQGwpOKruI4HMGIAZ1Mx1p1wl4vAih5SXtEdLfQ3JVyJWCacDEy56P9
         Lp1T4aiWoAbdDKkwRfTUdW3FiJ7PxA5ZgvPfhWgpts0f4P4y5nKhHrY98RQj2niplA
         dfOVJaMsH0s3f5XB8++hAsvsBfM48bFg03EzBfY0x5kLdnxzHm+P3fgeezYYAMH2pI
         +vJ9mtrcP+erA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/asm: fix gcc-5 enqcmds() build failure
Date:   Mon,  2 Aug 2021 16:53:42 +0200
Message-Id: <20210802145356.1154321-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Building drivers/dma/idxd/submit.o with gcc-5.5 results in a cryptic
error messages:

arch/x86/include/asm/special_insns.h: Assembler messages:
arch/x86/include/asm/special_insns.h:286: Error: operand size mismatch for `setz'
make[5]: *** [scripts/Makefile.build:272: drivers/dma/idxd/submit.o] Error 1

It seems that this happens for 32-bit arguments when the instruction
expects an 8-bit argument. Change the type of the local variable
accordingly to get a clean build.

Fixes: 7f5933f81bd8 ("x86/asm: Add an enqcmds() wrapper for the ENQCMDS instruction")
Fixes: 8e50d392652f ("dmaengine: idxd: Add shared workqueue support") # guessed
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/special_insns.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index f3fbb84ff8a7..33264839f99e 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -275,7 +275,7 @@ static inline int enqcmds(void __iomem *dst, const void *src)
 {
 	const struct { char _[64]; } *__src = src;
 	struct { char _[64]; } __iomem *__dst = dst;
-	int zf;
+	u8 zf;
 
 	/*
 	 * ENQCMDS %(rdx), rax
-- 
2.29.2

