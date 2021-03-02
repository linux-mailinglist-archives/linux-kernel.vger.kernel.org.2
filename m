Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E97032ADD9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1840084AbhCBWPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:15:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:55178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238168AbhCBUCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 15:02:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A6CC60201;
        Tue,  2 Mar 2021 19:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614714646;
        bh=S5zLlyqTS4bPCDBeQLQlrq+lr35udnmJMzLYiOmY8f8=;
        h=From:To:Cc:Subject:Date:From;
        b=d6eV35ZP5ds1iqC9d0QYDkq5pojZ2icNP1P+w9EXalsdPml0LtRCCZINGg2QYzbJY
         Mu1t5lBk+gUMPwskrQkjAWgndAv3mYpd9otYcI3ZF8dEqR1jsHB9dKOVkxUTYDIEnx
         TEo8TB7bOY6ZHRRRAuhnrQWOfuc+HQpS80rkMutcWhbQrv12PDEemF8RqlYg+EgDdf
         3XHe/ZZfdKr90xGC16DpKkv/Ws984SDRbtDh2RYZ/un6/tCSzwwX7HLA1B0hjH58Sd
         phkESWQw+62mvh7zqOwIUcF/SpsBLAuMqCOmj+KDB+x5Dn8QFiEXa6MG1WDCUHAYqL
         7/VlXhfwPG+fg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] powerpc/fadump: Mark fadump_calculate_reserve_size as __init
Date:   Tue,  2 Mar 2021 12:50:14 -0700
Message-Id: <20210302195013.2626335-1-nathan@kernel.org>
X-Mailer: git-send-email 2.31.0.rc0.75.gec125d1bc1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If fadump_calculate_reserve_size() is not inlined, there is a modpost
warning:

WARNING: modpost: vmlinux.o(.text+0x5196c): Section mismatch in
reference from the function fadump_calculate_reserve_size() to the
function .init.text:parse_crashkernel()
The function fadump_calculate_reserve_size() references
the function __init parse_crashkernel().
This is often because fadump_calculate_reserve_size lacks a __init
annotation or the annotation of parse_crashkernel is wrong.

fadump_calculate_reserve_size() calls parse_crashkernel(), which is
marked as __init and fadump_calculate_reserve_size() is called from
within fadump_reserve_mem(), which is also marked as __init.

Mark fadump_calculate_reserve_size() as __init to fix the section
mismatch. Additionally, remove the inline keyword as it is not necessary
to inline this function; the compiler is still free to do so if it feels
it is worthwhile since commit 889b3c1245de ("compiler: remove
CONFIG_OPTIMIZE_INLINING entirely").

Fixes: 11550dc0a00b ("powerpc/fadump: reuse crashkernel parameter for fadump memory reservation")
Link: https://github.com/ClangBuiltLinux/linux/issues/1300
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

Send while streaming at https://www.twitch.tv/nathanchance :P

 arch/powerpc/kernel/fadump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 8482739d42f3..eddf362caedc 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -292,7 +292,7 @@ static void fadump_show_config(void)
  * that is required for a kernel to boot successfully.
  *
  */
-static inline u64 fadump_calculate_reserve_size(void)
+static __init u64 fadump_calculate_reserve_size(void)
 {
 	u64 base, size, bootmem_min;
 	int ret;

base-commit: 5c88a17e15795226b56d83f579cbb9b7a4864f79
-- 
2.31.0.rc0.75.gec125d1bc1

