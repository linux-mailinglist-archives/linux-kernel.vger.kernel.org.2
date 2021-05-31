Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05AC396693
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbhEaRLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:11:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53831 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234600AbhEaRDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 13:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622480515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0KKzZ4Pnlj7CSEmGXCGwC261e/Tx/i3YqW/wwa1VS6k=;
        b=Q//Lb8TI8H5DzHyVDNaMli/kc+s3f49mPvuosSfWEmH2gQ294ePyLIiuMM2K726iZ3nfDN
        gJpMyg/9UJnjvVf+nycSj8GJj/9c6IW//15yWR7DVlLW7eyOq2ziXP2wp/1o5WjB5ZgKF+
        ojwUYBS57YhK/Bh58hTT82SgyvsQTv8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-rXcu5bMkONK4pormYisKFw-1; Mon, 31 May 2021 13:01:53 -0400
X-MC-Unique: rXcu5bMkONK4pormYisKFw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BCDD107ACCD;
        Mon, 31 May 2021 17:01:52 +0000 (UTC)
Received: from max.com (unknown [10.40.192.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BE626062C;
        Mon, 31 May 2021 17:01:50 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Subject: [RFC 7/9] gfs2: Encode glock holding and retry flags in journal_info
Date:   Mon, 31 May 2021 19:01:21 +0200
Message-Id: <20210531170123.243771-8-agruenba@redhat.com>
In-Reply-To: <20210531170123.243771-1-agruenba@redhat.com>
References: <20210531170123.243771-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the lowest two bits in current->journal_info to encode when
we're holding a glock, and when an operation holding a glock
needs to be retried.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/incore.h | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index aa8d1a23132d..e32433df119c 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -871,14 +871,45 @@ static inline unsigned gfs2_max_stuffed_size(const struct gfs2_inode *ip)
 	return GFS2_SB(&ip->i_inode)->sd_sb.sb_bsize - sizeof(struct gfs2_dinode);
 }
 
+/*
+ * Transactions are always memory aligned, so we use bit 0 of
+ * current->journal_info to indicate when we're holding a glock and so taking
+ * random additional glocks might deadlock, and bit 1 to indicate when such an
+ * operation needs to be retried after dropping and re-acquiring that "outer"
+ * glock.
+ */
+
 static inline struct gfs2_trans *current_trans(void)
 {
-	return current->journal_info;
+	return (void *)((long)current->journal_info & ~3);
 }
 
 static inline void set_current_trans(struct gfs2_trans *tr)
 {
-	current->journal_info = tr;
+	long flags = (long)current->journal_info & 3;
+	current->journal_info = (void *)((long)tr | flags);
+}
+
+static inline bool current_holds_glock(void)
+{
+	return (long)current->journal_info & 1;
+}
+
+static inline bool current_needs_retry(void)
+{
+	return (long)current->journal_info & 2;
+}
+
+static inline void set_current_holds_glock(bool b)
+{
+	current->journal_info =
+		(void *)(((long)current->journal_info & ~1) | b);
+}
+
+static inline void set_current_needs_retry(bool b)
+{
+	current->journal_info =
+		(void *)(((long)current->journal_info & ~2) | (b << 1));
 }
 
 #endif /* __INCORE_DOT_H__ */
-- 
2.26.3

