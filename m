Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAD941AB43
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 10:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239721AbhI1I5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 04:57:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239254AbhI1I5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 04:57:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BFA9610E6;
        Tue, 28 Sep 2021 08:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632819358;
        bh=2PEfYQceru6YB1PlEdl/SbUJ3dkL4YrWAtGhL4nsi+A=;
        h=From:To:Cc:Subject:Date:From;
        b=j5CcT/PA4IouFvm5GLaWbysL9NosPn/FtakgLBMvkKgM77vCJAiXq8zEgM1Ebe/Eb
         QEGxmn/HSNNIvJL74bMbYI8iwVn9NXPHzFZj8sgwZYgCjD29Nhw+6eol1vZslQXoCG
         vACkQrS4BBLDjvaDPJsTRXidpksZp7of+tRAV0bL7mDli+EuMRxqQNXoOr3RAj/UTi
         lo1fq+KjHH2vxEr0My7Bx3qjlUZYR9KdUNYTs2SOH4tulYJWJsQ252UaXceH6V+X5d
         wWGzX9NcpS4BGCTUaf4H1WwPRuM+Rqhs0pcLapXHQIYKfaCUcH53RaxRlIvEjhidUr
         a8kQFQWdl5rQA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Kent Overstreet <kmo@daterainc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Coly Li <colyli@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] bcache: hide variable-sized types from uapi header check
Date:   Tue, 28 Sep 2021 10:55:50 +0200
Message-Id: <20210928085554.2299495-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The headers_check helper complains about a GNU extension in
one of the exported headers:

linux/bcache.h:354:2: warning: field '' with variable sized type 'union jset::(anonymous at ./usr/include/linux/bcache.h:354:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
        BKEY_PADDED(uuid_bucket);
        ^
linux/bcache.h:134:2: note: expanded from macro 'BKEY_PADDED'
        union { struct bkey key; __u64 key ## _pad[BKEY_PAD]; }
        ^

Address this by enclosing the GNU extensions in an #ifdef: Since the
header check is done with --std=c90, this shuts up the warning and makes
it possible to include the header file C90 user space applications, but
allows applications built with --std=gnu89 or higher to use those
parts.

Another alternative would be to exclude this header from the check,
but the GNU extension check seems more sensible.

Fixes: 81ab4190ac17 ("bcache: Pull on disk data structures out into a separate header")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: use __STRICT_ANSI__ check instead of __KERNEL__.

I think this version is better than the first, let me know if that
works for you.
---
 include/uapi/linux/bcache.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/bcache.h b/include/uapi/linux/bcache.h
index cf7399f03b71..b7901e986193 100644
--- a/include/uapi/linux/bcache.h
+++ b/include/uapi/linux/bcache.h
@@ -23,9 +23,13 @@ static inline void SET_##name(type *k, __u64 v)			\
 struct bkey {
 	__u64	high;
 	__u64	low;
+#ifndef __STRICT_ANSI__
+	/* gcc extension not meant for user space */
 	__u64	ptr[];
+#endif
 };
 
+#ifndef __STRICT_ANSI__
 #define KEY_FIELD(name, field, offset, size)				\
 	BITMASK(name, struct bkey, field, offset, size)
 
@@ -127,6 +131,8 @@ static inline struct bkey *bkey_idx(const struct bkey *k, unsigned int nr_keys)
 
 	return (struct bkey *) (d + nr_keys);
 }
+#endif
+
 /* Enough for a key with 6 pointers */
 #define BKEY_PAD		8
 
-- 
2.29.2

