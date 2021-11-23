Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B5245A662
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 16:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbhKWPVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 10:21:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52665 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230512AbhKWPV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 10:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637680700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Yucss0P/W7Ns7hRqt2R2h+bJv+PBWpvJU78QTcRqsPY=;
        b=dV080XudyBBpH8zBj0AjevP7+TN5vsvqtDSOBO3soakIXgbD94tVKf9R8nkhnJBUYPyB3w
        W5d5D0Uyrs3QRrQfitx3muDbp2/MO/XRb4Y5Y7oxgFjtHVp8NVLbdTHuWud4GSzjH+Qwgm
        QSNk121hOdZpqjt3FyJ6fBS9qCc3u4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-BuobHiarO4urs2kKF32G8w-1; Tue, 23 Nov 2021 10:18:17 -0500
X-MC-Unique: BuobHiarO4urs2kKF32G8w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 345898066EC;
        Tue, 23 Nov 2021 15:18:16 +0000 (UTC)
Received: from max.com (unknown [10.40.192.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0357919D9F;
        Tue, 23 Nov 2021 15:18:13 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] fs/iomap: Fix write path page prefaulting
Date:   Tue, 23 Nov 2021 16:18:12 +0100
Message-Id: <20211123151812.361624-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When part of the user buffer passed to generic_perform_write() or
iomap_file_buffered_write() cannot be faulted in for reading, the entire
write currently fails.

The correct behavior would be to write all the data that can be written,
up to the point of failure.  Since commit a6294593e8a1 ("iov_iter: Turn
iov_iter_fault_in_readable into fault_in_iov_iter_readable"), we have
enough information to implement that, so change the code to do that.

We already take into account that pages faulted in may no longer be
resident by the time they are accessed, so the code will also behave
correctly when part of the buffer isn't faulted in in the first place.

This leads to an intentional user-visible change when the buffer passed
to write calls contains unmapped or poisoned pages.

(This change obsoletes commit 554c577cee95 ("gfs2: Prevent endless loops
in gfs2_file_buffered_write").)

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/buffered-io.c | 2 +-
 mm/filemap.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1753c26c8e76..54516ab464cd 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -750,7 +750,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		 * same page as we're writing to, without it being marked
 		 * up-to-date.
 		 */
-		if (unlikely(fault_in_iov_iter_readable(i, bytes))) {
+		if (unlikely(fault_in_iov_iter_readable(i, bytes) == bytes)) {
 			status = -EFAULT;
 			break;
 		}
diff --git a/mm/filemap.c b/mm/filemap.c
index daa0e23a6ee6..767202265048 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3743,7 +3743,7 @@ ssize_t generic_perform_write(struct file *file,
 		 * same page as we're writing to, without it being marked
 		 * up-to-date.
 		 */
-		if (unlikely(fault_in_iov_iter_readable(i, bytes))) {
+		if (unlikely(fault_in_iov_iter_readable(i, bytes) == bytes)) {
 			status = -EFAULT;
 			break;
 		}
-- 
2.31.1

