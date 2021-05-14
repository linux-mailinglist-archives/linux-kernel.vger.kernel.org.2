Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F673381322
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 23:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbhENVhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 17:37:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233513AbhENVg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 17:36:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 132906143F;
        Fri, 14 May 2021 21:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621028146;
        bh=00pu7fRzCavIm91cklhq4VrgHJQZBLYX+VMMn4KhGm4=;
        h=From:To:Cc:Subject:Date:From;
        b=pYGZ+Jr7YjP1bG+HBKIAjo49/PTMRO2cz+j5tRYrAXcWYaq5WABr8L8AAc5VsbPJR
         GrSBAkjzRKJBJbd13W6W2kZOCwWqvUS2YqT5Pm0A9j4QNSlwx5+GKjTjHsZLTgq0Xv
         Mi2/Q/g53b+chnQY9jzrkdeoGTr9cPBbFb7O2lKnzi3bdK5y2xm84HZp94oeJfkiLD
         E5be6c6pP6oOeR5mgNp7hieUMhxy3TxsDNlfIiVU3QN0PQoo35iuduJ/wDeFzIkELT
         7FOz32wa1AAjYUlkkbkoT7JwmDcSAKS44eEWR+3rcy75bdQl8Z/Gk8N3ztCZFoyvJ2
         lHAzW4eQVXqWw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] printf: fix errname.c list
Date:   Fri, 14 May 2021 23:34:50 +0200
Message-Id: <20210514213456.745039-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
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
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/errname.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/lib/errname.c b/lib/errname.c
index 05cbf731545f..6c5c0aa4de75 100644
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
@@ -38,8 +39,12 @@ static const char *names_0[] = {
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
@@ -166,14 +171,17 @@ static const char *names_0[] = {
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

