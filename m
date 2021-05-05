Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF44637340A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 05:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhEEDzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 23:55:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55832 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231223AbhEEDzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 23:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620186890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FdYnIi3+wvcewiyb12JYscUQLF6f+8/X4sFgHiL/c/s=;
        b=W92L8L1suAdEwMLNHJ1pAlN3D/LwIx6Rg/EDmx78E1NFgr5xXRrn3D0u3yIJ1075iuhKNL
        JICOgJ7y/LKIt9oPLKPN9Ejhw4vF64bBIYRAW3M4bJO3y0S75zufNPK0wwRUXSAfgP+Naa
        /i0WzTx66fMLmSFHGwEg1iUJf6+4VAk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-i94IWRkRO6GZ6Gq7awREJg-1; Tue, 04 May 2021 23:54:49 -0400
X-MC-Unique: i94IWRkRO6GZ6Gq7awREJg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60918818401;
        Wed,  5 May 2021 03:54:47 +0000 (UTC)
Received: from treble.redhat.com (ovpn-115-93.rdu2.redhat.com [10.10.115.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D7C810190A7;
        Wed,  5 May 2021 03:54:44 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@aculab.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH v4 1/4] uaccess: Always inline strn*_user() helper functions
Date:   Tue,  4 May 2021 22:54:29 -0500
Message-Id: <8cf8f43ae31e63be1858d156d18a2180813c8702.1620186182.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1620186182.git.jpoimboe@redhat.com>
References: <cover.1620186182.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DEBUG_SECTION_MISMATCH uses -fno-inline-functions-called-once,
causing these single-called helper functions to not get inlined:

  lib/strncpy_from_user.o: warning: objtool: strncpy_from_user()+0xa3: call to do_strncpy_from_user() with UACCESS enabled
  lib/strnlen_user.o: warning: objtool: strnlen_user()+0x73: call to do_strnlen_user() with UACCESS enabled

Always inline them regardless.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 lib/strncpy_from_user.c | 6 ++++--
 lib/strnlen_user.c      | 4 +++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index 122d8d0e253c..388539951116 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -25,8 +25,10 @@
  * hit it), 'max' is the address space maximum (and we return
  * -EFAULT if we hit it).
  */
-static inline long do_strncpy_from_user(char *dst, const char __user *src,
-					unsigned long count, unsigned long max)
+static __always_inline long do_strncpy_from_user(char *dst,
+						 const char __user *src,
+						 unsigned long count,
+						 unsigned long max)
 {
 	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
 	unsigned long res = 0;
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 1616710b8a82..378744e96039 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -20,7 +20,9 @@
  * if it fits in a aligned 'long'. The caller needs to check
  * the return value against "> max".
  */
-static inline long do_strnlen_user(const char __user *src, unsigned long count, unsigned long max)
+static __always_inline long do_strnlen_user(const char __user *src,
+					    unsigned long count,
+					    unsigned long max)
 {
 	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
 	unsigned long align, res = 0;
-- 
2.31.1

