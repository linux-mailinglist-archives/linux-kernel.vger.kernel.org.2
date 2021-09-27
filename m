Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A9F419456
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbhI0Mfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:35:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234380AbhI0Mfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:35:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1663260F41;
        Mon, 27 Sep 2021 12:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632746054;
        bh=v1e7o9ssesrrv0FjjmOHXWBrSNI63Fo4T0tWhLdrK6Y=;
        h=From:To:Cc:Subject:Date:From;
        b=bitLkdGaKnBkt4/SajOgg3BSWzb6UAUrUK4POeLVRHlJQiWjx6ew9konY9iXvdHGh
         YuAMZXN3GKS6Gjw2b5quKFvzQ02a6JwewxI9UGPzyhgushELU7JJEx4UJwSxTyhjLa
         qzgG4wYRYNo6LO6QgpnCpybWvc5XxCGpNibieeLLCYbcS5dNK8+dAI7viiXZbNRv5S
         lfxCHrsyK52oiL1RdJbAz0ibQrRMYOwWidHkp61lxxjCS4+nulp4bNiZREoiFWdGKn
         yuEmGrq7PoGDXusXNRBHT5PishtPZXTHkxW1drXh0+4MgNytzb4PwIpfCHc/OPQgBn
         iliRqqkIbqwkQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v3] printf: fix errname.c list
Date:   Mon, 27 Sep 2021 14:33:07 +0200
Message-Id: <20210927123409.1109737-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

On most architectures, gcc -Wextra warns about the list of error
numbers containing both EDEADLK and EDEADLOCK:

lib/errname.c:15:67: warning: initialized field overwritten [-Woverride-init]
   15 | #define E(err) [err + BUILD_BUG_ON_ZERO(err <= 0 || err > 300)] = "-" #err
      |                                                                   ^~~
lib/errname.c:172:2: note: in expansion of macro 'E'
  172 |  E(EDEADLK), /* EDEADLOCK */
      |  ^

On parisc, a similar error happens with -ECANCELLED, which is an
alias for ECANCELED.

Make the EDEADLK printing conditional on the number being distinct
from EDEADLOCK, and remove the -ECANCELLED bit completely as it
can never be hit.

To ensure these are correct, add static_assert lines that verify
all the remaining aliases are in fact identical to the canonical
name.

Fixes: 57f5677e535b ("printf: add support for printing symbolic error names")
Cc: Petr Mladek <pmladek@suse.com>
Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Acked-by: Uwe Kleine-König <uwe@kleine-koenig.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/all/20210514213456.745039-1-arnd@kernel.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
It looks I promised to resend this one in May but never did.
The patch is still useful, please apply.
---
 lib/errname.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/lib/errname.c b/lib/errname.c
index 05cbf731545f..67739b174a8c 100644
--- a/lib/errname.c
+++ b/lib/errname.c
@@ -21,6 +21,7 @@ static const char *names_0[] = {
 	E(EADDRNOTAVAIL),
 	E(EADV),
 	E(EAFNOSUPPORT),
+	E(EAGAIN), /* EWOULDBLOCK */
 	E(EALREADY),
 	E(EBADE),
 	E(EBADF),
@@ -31,15 +32,17 @@ static const char *names_0[] = {
 	E(EBADSLT),
 	E(EBFONT),
 	E(EBUSY),
-#ifdef ECANCELLED
-	E(ECANCELLED),
-#endif
+	E(ECANCELED), /* ECANCELLED */
 	E(ECHILD),
 	E(ECHRNG),
 	E(ECOMM),
 	E(ECONNABORTED),
+	E(ECONNREFUSED), /* EREFUSED */
 	E(ECONNRESET),
+	E(EDEADLK), /* EDEADLOCK */
+#if EDEADLK != EDEADLOCK /* mips, sparc, powerpc */
 	E(EDEADLOCK),
+#endif
 	E(EDESTADDRREQ),
 	E(EDOM),
 	E(EDOTDOT),
@@ -166,14 +169,17 @@ static const char *names_0[] = {
 	E(EUSERS),
 	E(EXDEV),
 	E(EXFULL),
-
-	E(ECANCELED), /* ECANCELLED */
-	E(EAGAIN), /* EWOULDBLOCK */
-	E(ECONNREFUSED), /* EREFUSED */
-	E(EDEADLK), /* EDEADLOCK */
 };
 #undef E
 
+#ifdef EREFUSED /* parisc */
+static_assert(EREFUSED == ECONNREFUSED);
+#endif
+#ifdef ECANCELLED /* parisc */
+static_assert(ECANCELLED == ECANCELED);
+#endif
+static_assert(EAGAIN == EWOULDBLOCK); /* everywhere */
+
 #define E(err) [err - 512 + BUILD_BUG_ON_ZERO(err < 512 || err > 550)] = "-" #err
 static const char *names_512[] = {
 	E(ERESTARTSYS),
-- 
2.29.2

