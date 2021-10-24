Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3535C438B11
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 19:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhJXRqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 13:46:30 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:44542 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231730AbhJXRqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 13:46:25 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 19OHhxEC018389;
        Sun, 24 Oct 2021 19:43:59 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] tools/nolibc: x86-64: Use `mov $60,%eax` instead of `mov $60,%rax`
Date:   Sun, 24 Oct 2021 19:43:22 +0200
Message-Id: <20211024174323.18338-3-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20211024174323.18338-1-w@1wt.eu>
References: <20211024174323.18338-1-w@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ammar Faizi <ammar.faizi@students.amikom.ac.id>

Note that mov to 32-bit register will zero extend to 64-bit register.
Thus `mov $60,%eax` has the same effect with `mov $60,%rax`. Use the
shorter opcode to achieve the same thing.
```
  b8 3c 00 00 00       	mov    $60,%eax (5 bytes) [1]
  48 c7 c0 3c 00 00 00 	mov    $60,%rax (7 bytes) [2]
```
Currently, we use [2]. Change it to [1] for shorter code.

Signed-off-by: Ammar Faizi <ammar.faizi@students.amikom.ac.id>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/nolibc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index f9afe89ec6f2..4988866af0b5 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -420,7 +420,7 @@ asm(".section .text\n"
     "and $-16, %rsp\n"          // x86 ABI : esp must be 16-byte aligned before call
     "call main\n"               // main() returns the status code, we'll exit with it.
     "mov %eax, %edi\n"          // retrieve exit code (32 bit)
-    "mov $60, %rax\n"           // NR_exit == 60
+    "mov $60, %eax\n"           // NR_exit == 60
     "syscall\n"                 // really exit
     "hlt\n"                     // ensure it does not return
     "");
-- 
2.17.5

