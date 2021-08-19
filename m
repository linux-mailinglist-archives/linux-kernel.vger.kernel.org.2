Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333383F20D3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 21:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbhHSTmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 15:42:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47657 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235097AbhHSTmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 15:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629402106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hlLVo70MeIlzSeNo8YqccKJkFJlfnahf31dyuu9o1Es=;
        b=h1tqYqSWuqgrMbfQnNpqy5ttpcROo+jR0ai1zLgTjPxKoULeVGD7Z2DVMWfsfOBedk9Xj7
        h20TXghIoXUsqBX8KbVVDxi8rkkEjheyPbqe1rzyc17KUmHvzMiLrkeBdMoZadnwQ5KNb3
        2y/F1ntB4b7V26EhRcNG785G0YxSS44=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-g0A_BYYtOzi8iNNeQxRZvg-1; Thu, 19 Aug 2021 15:41:41 -0400
X-MC-Unique: g0A_BYYtOzi8iNNeQxRZvg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3203E87D55C;
        Thu, 19 Aug 2021 19:41:40 +0000 (UTC)
Received: from max.com (unknown [10.40.194.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38E861B46B;
        Thu, 19 Aug 2021 19:41:37 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Bob Peterson <rpeterso@redhat.com>
Subject: [PATCH v6 08/19] gfs2: Eliminate vestigial HIF_FIRST
Date:   Thu, 19 Aug 2021 21:40:51 +0200
Message-Id: <20210819194102.1491495-9-agruenba@redhat.com>
In-Reply-To: <20210819194102.1491495-1-agruenba@redhat.com>
References: <20210819194102.1491495-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Peterson <rpeterso@redhat.com>

Holder flag HIF_FIRST is no longer used or needed, so remove it.

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
---
 fs/gfs2/glock.c  | 2 --
 fs/gfs2/incore.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 545b435f55ea..fd280b6c37ce 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2097,8 +2097,6 @@ static const char *hflags2str(char *buf, u16 flags, unsigned long iflags)
 		*p++ = 'H';
 	if (test_bit(HIF_WAIT, &iflags))
 		*p++ = 'W';
-	if (test_bit(HIF_FIRST, &iflags))
-		*p++ = 'F';
 	*p = 0;
 	return buf;
 }
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index e6f820f146cb..5c6b985254aa 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -253,7 +253,6 @@ struct gfs2_lkstats {
 enum {
 	/* States */
 	HIF_HOLDER		= 6,  /* Set for gh that "holds" the glock */
-	HIF_FIRST		= 7,
 	HIF_WAIT		= 10,
 };
 
-- 
2.26.3

