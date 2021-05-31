Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A6A39668C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhEaRKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:10:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234580AbhEaRDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 13:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622480501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kNVwivzY2ftvvPnbhicqdoxbrU7Ly5BCIYSmWrLH5jU=;
        b=PvrYm1AuEwRIRLFEBQ0jKJ8L3s9n90brO3yX5cO7M28zsmmJaxbX6CptD/IcFAoArVG1Jk
        U0tvuUt+KlQ7dAjZUAj3uvaOLKaPV2mgQf7nugUXq4nk4TPgg7s0jQxiNdEzo8NoBXjXfw
        YYevwqqE2tITL5lVc4EwOBc27UDzbpk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-Fp09B0nPPuia4SiIu_x3YQ-1; Mon, 31 May 2021 13:01:39 -0400
X-MC-Unique: Fp09B0nPPuia4SiIu_x3YQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7421107ACED;
        Mon, 31 May 2021 17:01:38 +0000 (UTC)
Received: from max.com (unknown [10.40.192.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F3992BFDE;
        Mon, 31 May 2021 17:01:34 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Subject: [RFC 3/9] gfs2: Add gfs2_holder_is_compatible helper
Date:   Mon, 31 May 2021 19:01:17 +0200
Message-Id: <20210531170123.243771-4-agruenba@redhat.com>
In-Reply-To: <20210531170123.243771-1-agruenba@redhat.com>
References: <20210531170123.243771-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function checks if a glock holder's locking state is compatible with
another locking state.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index 31a8f2f649b5..f0ef6fd24ba4 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -49,6 +49,20 @@ enum {
 #define LM_ST_DEFERRED		2
 #define LM_ST_SHARED		3
 
+static inline bool gfs2_holder_is_compatible(struct gfs2_holder *gh, int state) {
+	BUG_ON(state == LM_ST_UNLOCKED);
+	switch(gh->gh_state) {
+	case LM_ST_EXCLUSIVE:
+		return state != LM_ST_DEFERRED;
+	case LM_ST_DEFERRED:
+		return state == LM_ST_DEFERRED;
+	case LM_ST_SHARED:
+		return state == LM_ST_SHARED;
+	default:
+		return false;
+	}
+}
+
 /*
  * lm_lock() flags
  *
-- 
2.26.3

