Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FBC41947E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbhI0MpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234331AbhI0MpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:45:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D14366108E;
        Mon, 27 Sep 2021 12:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632746614;
        bh=d1/vlnmumepMGL2f2BuI5PtRTt/Pb/38LmLQkaqWqKU=;
        h=From:To:Cc:Subject:Date:From;
        b=KjmPihjoVj9Q9OPxRDTcOjizasCNO/phYZSVFyC4w0x5Yz8rr9SDWCKXz1QHgrVn2
         zdmztzWdy2yhEpbzzjMagEM7M3f2+O/u1wpt/+wFZo+lbXet/gLgg21eJ0hwsd0uFl
         Fgkb3faXTsXcJH2UeI4eub410Fr+1VcwgNyzJ1eA3O8V36aiRwkhlCFK3edLLBwXkn
         w6BRPttWzI2ggDSg7Z7JZhK1ECuzLY49IgfXQsER3ZKpkeH5W2VVenB/JLIvlhXLfs
         bIbm6XWhRzp7PgV317+X7mlNt9xj97IbfTmpWVfAI6UgxHCYK9k5ATjEmxusjZRtPA
         V0zoa4wlv1vCQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Kent Overstreet <kmo@daterainc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Coly Li <colyli@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] [RFC] bcache: hide variable-sized types from uapi headers
Date:   Mon, 27 Sep 2021 14:43:24 +0200
Message-Id: <20210927124331.1487876-1-arnd@kernel.org>
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

We could either try to shut up the warning or remove those parts from
the user-visible section of this header. This does the second,
under the assumption that they are not actually used.

Fixes: 81ab4190ac17 ("bcache: Pull on disk data structures out into a separate header")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Coli, Kent: can you check to see if the hidden parts are used anywhere
from user space, and apply the patch if not?

Any other ideas for addressing this warning?
---
 include/uapi/linux/bcache.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/bcache.h b/include/uapi/linux/bcache.h
index cf7399f03b71..e3e4889aa53e 100644
--- a/include/uapi/linux/bcache.h
+++ b/include/uapi/linux/bcache.h
@@ -23,9 +23,13 @@ static inline void SET_##name(type *k, __u64 v)			\
 struct bkey {
 	__u64	high;
 	__u64	low;
+#ifdef __KERNEL__
+	/* gcc extension not meant for user space */
 	__u64	ptr[];
+#endif
 };
 
+#ifdef __KERNEL__
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

