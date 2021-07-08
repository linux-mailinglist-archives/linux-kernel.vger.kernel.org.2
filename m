Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016DE3C1C33
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 01:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhGHXmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 19:42:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhGHXmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 19:42:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BB7D61409;
        Thu,  8 Jul 2021 23:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625787592;
        bh=kfQyKRysnqk2rwMhGbwxmhAhfrh6e/bHBlkPvbh8xX4=;
        h=From:To:Cc:Subject:Date:From;
        b=lXpCmUHcL3GCOKWWsZ4Svs6avH76vsfB03TkOw1vTUFKjontO124Snt0vckmqQjcs
         xjbip2YWWHxMODSWKSW5eaeAsRi4HToYsdZb95JNmHrnY0ZPDb2/4XDG8vdjViXjOG
         2FGN5UxPbSZE/UcnaLCCe0Ve0ZpXrdkQyaNVvvPlWcoIFSAfQrJu9WtDV7HMYpnuIb
         I4zFaMHlRi59Uvn2SHhj8khwUnfi7NkudrU6D5roXj5LM9alMnH2xDoRI3D2SQRfUJ
         oswtYDfgD4svfdARUgfnVuIumG2F+1ub8Kygt5DV9JJTfGjQtPs6elbk3WHEsYdTRO
         s6mzNkRPsAhyw==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Brian Cain <bcain@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] Hexagon: Export raw I/O routines for modules
Date:   Thu,  8 Jul 2021 16:38:50 -0700
Message-Id: <20210708233849.3140194-1-nathan@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building ARCH=hexagon allmodconfig, the following errors occur:

ERROR: modpost: "__raw_readsl" [drivers/i3c/master/svc-i3c-master.ko] undefined!
ERROR: modpost: "__raw_writesl" [drivers/i3c/master/dw-i3c-master.ko] undefined!
ERROR: modpost: "__raw_readsl" [drivers/i3c/master/dw-i3c-master.ko] undefined!
ERROR: modpost: "__raw_writesl" [drivers/i3c/master/i3c-master-cdns.ko] undefined!
ERROR: modpost: "__raw_readsl" [drivers/i3c/master/i3c-master-cdns.ko] undefined!

Export these symbols so that modules can use them without any errors.

Fixes: 013bf24c3829 ("Hexagon: Provide basic implementation and/or stubs for I/O routines.")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

It would be nice if this could get into 5.14 at some point so that we
can build ARCH=hexagon allmodconfig in our CI.

 arch/hexagon/lib/io.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/hexagon/lib/io.c b/arch/hexagon/lib/io.c
index d35d69d6588c..55f75392857b 100644
--- a/arch/hexagon/lib/io.c
+++ b/arch/hexagon/lib/io.c
@@ -27,6 +27,7 @@ void __raw_readsw(const void __iomem *addr, void *data, int len)
 		*dst++ = *src;
 
 }
+EXPORT_SYMBOL(__raw_readsw);
 
 /*
  * __raw_writesw - read words a short at a time
@@ -47,6 +48,7 @@ void __raw_writesw(void __iomem *addr, const void *data, int len)
 
 
 }
+EXPORT_SYMBOL(__raw_writesw);
 
 /*  Pretty sure len is pre-adjusted for the length of the access already */
 void __raw_readsl(const void __iomem *addr, void *data, int len)
@@ -62,6 +64,7 @@ void __raw_readsl(const void __iomem *addr, void *data, int len)
 
 
 }
+EXPORT_SYMBOL(__raw_readsl);
 
 void __raw_writesl(void __iomem *addr, const void *data, int len)
 {
@@ -76,3 +79,4 @@ void __raw_writesl(void __iomem *addr, const void *data, int len)
 
 
 }
+EXPORT_SYMBOL(__raw_writesl);

base-commit: f55966571d5eb2876a11e48e798b4592fa1ffbb7
-- 
2.32.0.93.g670b81a890

