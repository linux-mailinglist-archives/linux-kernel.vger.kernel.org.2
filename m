Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155E342462E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 20:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238977AbhJFSmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 14:42:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32391 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229992AbhJFSmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 14:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633545627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OYtCMCdzeUAH5A7kvrEJVmvT/XFeYC2/Oa0mvBondw8=;
        b=h/pdA04v+WoA3Z876OUvDnnqfZG00UUpg7FPrunGW81bHgWXmWzCUMXaRLNFUSqbXR6rQg
        lB2dc5fA8v+xF/CFODDeZ2Tqk8ln/723r0i0K9ritLlxr5yX5FR33IUU7hpjDIyHilt389
        UjdHQJ9hd3fUynDWNgAYTILZzEbWmRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-uym_wXdROkONzeGgZuqjXw-1; Wed, 06 Oct 2021 14:40:24 -0400
X-MC-Unique: uym_wXdROkONzeGgZuqjXw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E863C814401;
        Wed,  6 Oct 2021 18:40:22 +0000 (UTC)
Received: from optiplex-lnx.redhat.com (unknown [10.3.128.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A5DA60657;
        Wed,  6 Oct 2021 18:40:21 +0000 (UTC)
From:   Rafael Aquini <aquini@redhat.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/swapfile: fix an integer overflow in swap_show()
Date:   Wed,  6 Oct 2021 14:40:11 -0400
Message-Id: <20211006184011.2579054-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This one is just a minor nuisance for people going through /proc/swaps if
any of their swapareas is bigger than, or equal to 1073741824 pages (4TB).

seq_printf() format string casts as uint the conversion from pages to KB,
and that will overflow in the aforementioned case.

Albeit being almost unthinkable that someone would actually set up such big
of a single swaparea, there is a ticket recently filed against RHEL:
https://bugzilla.redhat.com/show_bug.cgi?id=2008812

Given that all other codesites that use format strings for the same swap
pages-to-KB conversion do cast it as ulong, this patch just follows suit.

Signed-off-by: Rafael Aquini <aquini@redhat.com>
---
 mm/swapfile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 22d10f713848..29a7e3ebaaae 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2763,7 +2763,7 @@ static int swap_show(struct seq_file *swap, void *v)
 	struct swap_info_struct *si = v;
 	struct file *file;
 	int len;
-	unsigned int bytes, inuse;
+	unsigned long bytes, inuse;
 
 	if (si == SEQ_START_TOKEN) {
 		seq_puts(swap, "Filename\t\t\t\tType\t\tSize\t\tUsed\t\tPriority\n");
@@ -2775,7 +2775,7 @@ static int swap_show(struct seq_file *swap, void *v)
 
 	file = si->swap_file;
 	len = seq_file_path(swap, file, " \t\n\\");
-	seq_printf(swap, "%*s%s\t%u\t%s%u\t%s%d\n",
+	seq_printf(swap, "%*s%s\t%lu\t%s%lu\t%s%d\n",
 			len < 40 ? 40 - len : 1, " ",
 			S_ISBLK(file_inode(file)->i_mode) ?
 				"partition" : "file\t",
-- 
2.26.3

