Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1063D313D77
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbhBHS1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbhBHPx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:53:57 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61A7C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 07:53:17 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id e7so1536119pge.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 07:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=delphix.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bv31c/MDD+J9/ofoLSaaCjpSKbdjhNAUexmwFwimhPM=;
        b=fWcAPommuKM/IFRTzUIO/AweTrcvpcC2yZfhuldGppsRcp5aDoCIShY0yNhUTDVBC/
         3q0DLLYxPHjNpIEc+1KAo0tgx+RSvA+ogLIcd2ie3Pw8l1GIWqamVnBdT1b9K7mqvls3
         m07o5G88evuPMnIQo8CowWg5mtQITzXrpMHIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bv31c/MDD+J9/ofoLSaaCjpSKbdjhNAUexmwFwimhPM=;
        b=rE0qlkncHb6id5eq5gFAp1GWTSUcbtI9IyOAXghrW+/LokRDC9LEfTuWdMiQcPtb5h
         e6bf/KRtv8Rq5ShedEJ3Hzmsw5wsHK/DbJ6UlAjILkEHxwpNKkGj2AItFJY9/eWIoQTn
         9jnyegbB5Nl5faTQalNMvq0qxSCvNdwmO3tcYDNIA6t8c2VerqlociQAeLlwJZmOQJ2g
         vhAI1ag2cyggTSW5F2zULfJlR+a0W9+NlRJSArwI2KRtD8v+yHd4frSKehP4/a2f6nd/
         hSCj89LL9u+Ck1r85EssVFJ15WLdl41eFOcAziyRA+JbneX9TPS0zJXJXqxPwGWjzMXJ
         ZU+g==
X-Gm-Message-State: AOAM531/nktLmhAdp0DpwhkNw/3hyegWe03e6MhVuRCZ3+j4Gpt7yoKQ
        Lf/VQvDLwTsxyxN314J2W5Dk+g==
X-Google-Smtp-Source: ABdhPJzZVqXn4S2LaV+CAbkdMLUFRYLPB7Lbycu+tTQD4ybzSfOoN7KknTaeBTt2lt/2D6cZj9UJKw==
X-Received: by 2002:aa7:98d2:0:b029:1da:3374:4777 with SMTP id e18-20020aa798d20000b02901da33744777mr11031393pfm.45.1612799597208;
        Mon, 08 Feb 2021 07:53:17 -0800 (PST)
Received: from sd-kernel.dcol2.delphix.com (DELPHIX-COR.ear1.SanJose1.Level3.net. [4.15.123.66])
        by smtp.googlemail.com with ESMTPSA id cm7sm5048427pjb.43.2021.02.08.07.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 07:53:16 -0800 (PST)
From:   Serapheim Dimitropoulos <serapheim.dimitro@delphix.com>
X-Google-Original-From: Serapheim Dimitropoulos <serapheim@delphix.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, osandov@osandov.com,
        serapheim@delphix.com
Subject: [PATCH] mm/vmalloc: use rb_tree instead of list for vread() lookups
Date:   Mon,  8 Feb 2021 15:53:03 +0000
Message-Id: <20210208155303.10523-1-serapheim@delphix.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vread() has been linearly searching vmap_area_list for looking up
vmalloc areas to read from. These same areas are also tracked by
a rb_tree (vmap_area_root) which offers logarithmic lookup.

This patch modifies vread() to use the rb_tree structure instead
of the list and the speedup for heavy /proc/kcore readers can
be pretty significant. Below are the wall clock measurements of
a Python application that leverages the drgn debugging library
to read and interpret data read from /proc/kcore.

Before the patch:
-----
$ time sudo sdb -e 'dbuf | head 2500 | wc'
(unsigned long)2500

real	0m21.128s
user	0m2.321s
sys	0m19.227s
-----

With the patch:
-----
$ time sudo sdb -e 'dbuf | head 2500 | wc'
(unsigned long)2500

real	0m1.870s
user	0m1.628s
sys	0m0.660s
-----

Signed-off-by: Serapheim Dimitropoulos <serapheim@delphix.com>
---
 mm/vmalloc.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 49ab9b6c001d..86343b879938 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2851,6 +2851,7 @@ long vread(char *buf, char *addr, unsigned long count)
 {
 	struct vmap_area *va;
 	struct vm_struct *vm;
+	struct rb_node *node;
 	char *vaddr, *buf_start = buf;
 	unsigned long buflen = count;
 	unsigned long n;
@@ -2860,17 +2861,15 @@ long vread(char *buf, char *addr, unsigned long count)
 		count = -(unsigned long) addr;
 
 	spin_lock(&vmap_area_lock);
-	list_for_each_entry(va, &vmap_area_list, list) {
-		if (!count)
-			break;
-
+	va = __find_vmap_area((unsigned long)addr);
+	if (!va)
+		goto finished;
+	while (count) {
 		if (!va->vm)
-			continue;
+			goto next_node;
 
 		vm = va->vm;
 		vaddr = (char *) vm->addr;
-		if (addr >= vaddr + get_vm_area_size(vm))
-			continue;
 		while (addr < vaddr) {
 			if (count == 0)
 				goto finished;
@@ -2889,6 +2888,12 @@ long vread(char *buf, char *addr, unsigned long count)
 		buf += n;
 		addr += n;
 		count -= n;
+
+next_node:
+		node = rb_next(&va->rb_node);
+		if (!node)
+			break;
+		va = rb_entry(node, struct vmap_area, rb_node);
 	}
 finished:
 	spin_unlock(&vmap_area_lock);
-- 
2.17.1

