Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C69396690
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbhEaRL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:11:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48118 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234561AbhEaRD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 13:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622480505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=87JowEd1S3/KydoKdPj22y1RTGzOJZZsVj9TKC1DTWI=;
        b=bc6EM351pTgmBELtsg4romq1EUoi+6qnFwhhMbcFvuMd5ZThWOuAjXbDrAjz7vxewzaTrx
        0wCZ35bdznuIJqR/Nt/B+D9nSpjM8Lv2zKoUusawkY23UDmslpRcjU4lRYvd9h5fOAwPMm
        lHFP6+9t6dz6wxnkrjUJLlNoOsS9kKA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-uvZbeSWgNoqHCmT-1hxfBA-1; Mon, 31 May 2021 13:01:44 -0400
X-MC-Unique: uvZbeSWgNoqHCmT-1hxfBA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C28B38030CF;
        Mon, 31 May 2021 17:01:42 +0000 (UTC)
Received: from max.com (unknown [10.40.192.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E3BB2DAD0;
        Mon, 31 May 2021 17:01:40 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Subject: [RFC 5/9] iov_iter: Add iov_iter_fault_in_writeable()
Date:   Mon, 31 May 2021 19:01:19 +0200
Message-Id: <20210531170123.243771-6-agruenba@redhat.com>
In-Reply-To: <20210531170123.243771-1-agruenba@redhat.com>
References: <20210531170123.243771-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the equivalent of iov_iter_fault_in_readable(), but for pages that
will be written to.

While at it, fix an indentation error in iov_iter_fault_in_readable().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 include/linux/uio.h |  1 +
 lib/iov_iter.c      | 20 +++++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index d3ec87706d75..6811eb6ac6e3 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -124,6 +124,7 @@ size_t iov_iter_copy_from_user_atomic(struct page *page,
 void iov_iter_advance(struct iov_iter *i, size_t bytes);
 void iov_iter_revert(struct iov_iter *i, size_t bytes);
 int iov_iter_fault_in_readable(struct iov_iter *i, size_t bytes);
+int iov_iter_fault_in_writeable(struct iov_iter *i, size_t bytes);
 size_t iov_iter_single_seg_count(const struct iov_iter *i);
 size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index c701b7a187f2..317c94eac907 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -480,13 +480,31 @@ int iov_iter_fault_in_readable(struct iov_iter *i, size_t bytes)
 		iterate_iovec(i, bytes, v, iov, skip, ({
 			err = fault_in_pages_readable(v.iov_base, v.iov_len);
 			if (unlikely(err))
-			return err;
+				return err;
 		0;}))
 	}
 	return 0;
 }
 EXPORT_SYMBOL(iov_iter_fault_in_readable);
 
+int iov_iter_fault_in_writeable(struct iov_iter *i, size_t bytes)
+{
+	size_t skip = i->iov_offset;
+	const struct iovec *iov;
+	int err;
+	struct iovec v;
+
+	if (!(i->type & (ITER_BVEC|ITER_KVEC))) {
+		iterate_iovec(i, bytes, v, iov, skip, ({
+			err = fault_in_pages_writeable(v.iov_base, v.iov_len);
+			if (unlikely(err))
+				return err;
+		0;}))
+	}
+	return 0;
+}
+EXPORT_SYMBOL(iov_iter_fault_in_writeable);
+
 void iov_iter_init(struct iov_iter *i, unsigned int direction,
 			const struct iovec *iov, unsigned long nr_segs,
 			size_t count)
-- 
2.26.3

