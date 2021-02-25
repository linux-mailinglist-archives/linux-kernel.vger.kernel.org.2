Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F892324EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 12:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbhBYLQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 06:16:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:55758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233632AbhBYLPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 06:15:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D678C64F0A;
        Thu, 25 Feb 2021 11:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614251710;
        bh=Oi+SraEGODKqOTiXfFk5238MjRgZX5tRsLs16fRyUXI=;
        h=From:To:Cc:Subject:Date:From;
        b=CWcpDMBIlZJJ3+vI1ouKIBd0UyOm1DiD/+tYUCeitD+4sfskrwqhZ4NjnO4y2+v54
         UrvXh+3gteq66kAtOq69lHW92VZt8O4SlDwq9Ep/kLS0sxW24+lT+Lt0kBod3GCirj
         fjhNN7RTo4czWD5qkgLP7KbyKUBtNlyVam+SBMUgrgnZkbf1bHl6/EVBZ2mlKmF8/W
         y3yScuRGsWQKmp7mBUtZFAKRxpaOF60HdzKbxym96N3zpVGK/60nRoDYfm2ZN8Fwrn
         Pd2pT69P6k5RcVYbb+yDruzeNuEmulccVhkpPaZJkE6s2K1BgjGhdecFUAjFFXgeu3
         0gGJpHpQtFZjQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [RFT] m68k: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Date:   Thu, 25 Feb 2021 12:14:45 +0100
Message-Id: <20210225111505.1936566-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

While experimenting with CONFIG_TRIM_UNUSED_KSYMS across architectures,
I noticed that this unsurprisingly works best when combined with the
--gc-sections linker flag, which is not currently allowed on m68k.

Enabling it with this patch shows significant improvements
for kernel size, looking at m68k defconfig with gcc-10, I get

4005135 1374302 167108 5546545 54a231 vmlinux-normal
3916254 1378078 167108 5461440 5355c0 vmlinux+trim
4012933 1362514 164280 5539727 54878f vmlinux+gcsection
3797884 1334194 164640 5296718 50d24e vmlinux+gcsection+trim

There are probably bugs somewhere, but if someone is able to test this
patch and fix any issues that come up, would be a useful improvement
for memory-limited machines.

Link: https://lore.kernel.org/lkml/CAK8P3a05VZ9hSKRzVTxTn+1nf9E+gqebJWTj6N23nfm+ELHt9A@mail.gmail.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index c186733562b3..5f1aafa7b2e2 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -24,6 +24,7 @@ config M68K
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_FUTEX_CMPXCHG if MMU && FUTEX
 	select HAVE_IDE
+	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_UID16
 	select MMU_GATHER_NO_RANGE if MMU
-- 
2.29.2

