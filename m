Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEB3439E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 20:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhJYSVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 14:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhJYSVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 14:21:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCB0C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 11:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ZUjha4DhPn98bTvVPY+JcUANbAx2g59wrv6gM1+ix+I=; b=LEaDBOiD45JaEtaEe0dVnWgwSS
        TL7+hD3Kt7dR7Ls6PWNwGh2qjoF5RgC6IPN3s7YSeMvovoNk2IZEUiDBTdYXi8CFsdj+HsdCI7HrN
        1al0pykeF4gXsc17uJuuWA/hg6rKcV/vSZnIz+xqH7E9NFOVy0dNNwgHw+V+2TL8Zmi144K5AaXOm
        88aw5XlSk8pPwq6gO8LjP+qKn+bd9MvOwfkOe0dsh62dQIJLZB/7LDP7TSPsPXhVl3fH2tsWrfqXw
        qA38PQ6vwCjBA6wrF3UUgisgEb42NYrgbvvSLSDiqNTsnT0/c0vbsevl99kUjjYM6QoeZKH9+l4J1
        ySCxoYIw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mf4WY-00GJuC-EZ; Mon, 25 Oct 2021 18:16:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jordy Zomer <jordy@pwning.systems>,
        Kees Cook <keescook@chromium.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] secretmem: Prevent secretmem_users from wrapping to zero
Date:   Mon, 25 Oct 2021 19:16:34 +0100
Message-Id: <20211025181634.3889666-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 110860541f44 ("mm/secretmem: use refcount_t instead of atomic_t")
attempted to fix the problem of secretmem_users wrapping to zero and
allowing suspend once again.  Prevent secretmem_users from wrapping to
zero by forbidding new users if the number of users has wrapped from
positive to negative.  This stops a long way short of reaching the
necessary 4 billion users, so there's no need to be clever with special
anti-wrap types or checking the return value from atomic_inc().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Jordy Zomer <jordy@pwning.systems>
Cc: Kees Cook <keescook@chromium.org>,
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/secretmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 030f02ddc7c1..c2dda408bb36 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -203,6 +203,8 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
 
 	if (flags & ~(SECRETMEM_FLAGS_MASK | O_CLOEXEC))
 		return -EINVAL;
+	if (atomic_read(&secretmem_users) < 0)
+		return -ENFILE;
 
 	fd = get_unused_fd_flags(flags & O_CLOEXEC);
 	if (fd < 0)
-- 
2.33.0

