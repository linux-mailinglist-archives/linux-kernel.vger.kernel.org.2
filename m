Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9002D4538BC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 18:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239050AbhKPRr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 12:47:26 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:35875 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238906AbhKPRrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 12:47:20 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HttjK4RZJz9sSD;
        Tue, 16 Nov 2021 18:44:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5fICMPG7UyIJ; Tue, 16 Nov 2021 18:44:21 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HttjK3kSvz9sSC;
        Tue, 16 Nov 2021 18:44:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6B3618B7AF;
        Tue, 16 Nov 2021 18:44:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NhgUqVfQH72O; Tue, 16 Nov 2021 18:44:21 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.234.8])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 36F318B763;
        Tue, 16 Nov 2021 18:44:21 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 1AGHiAa3063990
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 18:44:10 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 1AGHi99T063988;
        Tue, 16 Nov 2021 18:44:09 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] gup: Avoid multiple user access locking/unlocking in fault_in_{read/write}able
Date:   Tue, 16 Nov 2021 18:43:57 +0100
Message-Id: <720dcf79314acca1a78fae56d478cc851952149d.1637084492.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1637084636; l=2057; s=20211009; h=from:subject:message-id; bh=fhDcpjOtwou8iZfA1W7BxN9s1FsuoPsOmduFg92JpxI=; b=A09G105PO7NdnBsD33IOQj1QCzcEOtb/mDObw7ysCJH+BA5zioXHEdaWG5yfyESaI7Xc1nlD5p/K xdXOUuFCBPS2jjl5YKXQIXbcqnU9Aqu7YmASbm8tFyVW9hVc/3Ei
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fault_in_readable() and fault_in_writeable() perform __get_user()
and __put_user() in a loop, implying multiple user access
locking/unlocking.

To avoid that, use user access blocks.

Cc: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 mm/gup.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 2c51e9748a6a..be2a41feec7d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1672,21 +1672,22 @@ size_t fault_in_writeable(char __user *uaddr, size_t size)
 
 	if (unlikely(size == 0))
 		return 0;
+	if (!user_write_access_begin(uaddr, size))
+		return size;
 	if (!PAGE_ALIGNED(uaddr)) {
-		if (unlikely(__put_user(0, uaddr) != 0))
-			return size;
+		unsafe_put_user(0, uaddr, out);
 		uaddr = (char __user *)PAGE_ALIGN((unsigned long)uaddr);
 	}
 	end = (char __user *)PAGE_ALIGN((unsigned long)start + size);
 	if (unlikely(end < start))
 		end = NULL;
 	while (uaddr != end) {
-		if (unlikely(__put_user(0, uaddr) != 0))
-			goto out;
+		unsafe_put_user(0, uaddr, out);
 		uaddr += PAGE_SIZE;
 	}
 
 out:
+	user_write_access_end();
 	if (size > uaddr - start)
 		return size - (uaddr - start);
 	return 0;
@@ -1771,21 +1772,22 @@ size_t fault_in_readable(const char __user *uaddr, size_t size)
 
 	if (unlikely(size == 0))
 		return 0;
+	if (!user_read_access_begin(uaddr, size))
+		return size;
 	if (!PAGE_ALIGNED(uaddr)) {
-		if (unlikely(__get_user(c, uaddr) != 0))
-			return size;
+		unsafe_get_user(c, uaddr, out);
 		uaddr = (const char __user *)PAGE_ALIGN((unsigned long)uaddr);
 	}
 	end = (const char __user *)PAGE_ALIGN((unsigned long)start + size);
 	if (unlikely(end < start))
 		end = NULL;
 	while (uaddr != end) {
-		if (unlikely(__get_user(c, uaddr) != 0))
-			goto out;
+		unsafe_get_user(c, uaddr, out);
 		uaddr += PAGE_SIZE;
 	}
 
 out:
+	user_read_access_end();
 	(void)c;
 	if (size > uaddr - start)
 		return size - (uaddr - start);
-- 
2.31.1

