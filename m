Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9442A451D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhKPAbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345666AbhKOT3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:29:02 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93EAC06BCE9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:59:17 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id z6so15871970pfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pSUi2+kpqxZMVeYqD80ROQDgqt7JZMMjZIIlCp0yEtk=;
        b=G6MoOgbvzNNQtqZiSD8/K3soql42kJiSY7PB/Q5GykBx4HKqjTY0OqiP+f4IsINuOk
         XOUcTx26GxXg5dKW4gjtYDSezec+I4Q1N6xbJasQwfwCqJ+VqnT+09yGNTSOnNT4Kpmc
         NAIAIuszweVULkidU0CW1sqGbgeuJB1eZJWaRoKZ2/Osi5J1pAy/Mgu438UoSjeRxFD2
         7t6dNrUXBw6Cx+ET9k4gc+MbkM/GprmPCED/gcVSB/e+Kjv5EChStMjCqrRuNX7bcSaw
         iTbwAqKg6+vs8Cgya0PjPCefhoRPuvbjrEbV1gH5PI7QZtN3vuMtfawynRKCIBQSh27u
         wpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pSUi2+kpqxZMVeYqD80ROQDgqt7JZMMjZIIlCp0yEtk=;
        b=Wa21PbRUvkpAu3R8cunIFogygp7qMmIAowvXlwllMFwbNfXPQvP+66urbIC/BmA8c7
         EbQjCZEZceCso/xveJLLB+Nw4PGRI/3rJFORuEIEOYWEhJH5ir/gkKCz+VMvyn8GG+vp
         DB00yBzeAi8r7y0mWUfsvAEXZ35vAB/llrSPyMIoqzTSiq2s0XhyD9lG2e9DxGtmsIvc
         lERikulZ9HBHSKg/FwhhPGWSoMQDSXH0w0AM918r+Iz6GDoDIgP1f5fL6fXdC6KIe379
         B6uFb/Zigbth7B2calhKDm4M+aWamcUh7pYa59NKum+1Izd6IBVDbwOHKPl7kPO01Hs2
         W4qQ==
X-Gm-Message-State: AOAM531cbqEnbinmjbGl9cFu8Lgz2Pzb9/dDKFJ4OgE5wi3+GV2p8pkV
        9Qa3x9+my7kCNlHtX8bhw38=
X-Google-Smtp-Source: ABdhPJyTVlrU2ufUgiTIqfkdmqbn+i2qnwloef8v3S29vZM4IrQf4Ztu5eUAeCBUNR2GKxP4gq4zRw==
X-Received: by 2002:a63:6c49:: with SMTP id h70mr766458pgc.368.1637002757322;
        Mon, 15 Nov 2021 10:59:17 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:7a54:8083:4365:b23d])
        by smtp.gmail.com with ESMTPSA id c3sm11882941pfv.67.2021.11.15.10.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 10:59:16 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 4/9] zsmalloc: introduce obj_allocated
Date:   Mon, 15 Nov 2021 10:59:04 -0800
Message-Id: <20211115185909.3949505-5-minchan@kernel.org>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
In-Reply-To: <20211115185909.3949505-1-minchan@kernel.org>
References: <20211115185909.3949505-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usage pattern for obj_to_head is to check whether the zpage
is allocated or not. Thus, introduce obj_allocated.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/zsmalloc.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7a14090e4a53..6ca130c0f7dc 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -877,13 +877,21 @@ static unsigned long handle_to_obj(unsigned long handle)
 	return *(unsigned long *)handle;
 }
 
-static unsigned long obj_to_head(struct page *page, void *obj)
+static bool obj_allocated(struct page *page, void *obj, unsigned long *phandle)
 {
+	unsigned long handle;
+
 	if (unlikely(PageHugeObject(page))) {
 		VM_BUG_ON_PAGE(!is_first_page(page), page);
-		return page->index;
+		handle = page->index;
 	} else
-		return *(unsigned long *)obj;
+		handle = *(unsigned long *)obj;
+
+	if (!(handle & OBJ_ALLOCATED_TAG))
+		return false;
+
+	*phandle = handle & ~OBJ_ALLOCATED_TAG;
+	return true;
 }
 
 static inline int testpin_tag(unsigned long handle)
@@ -1606,7 +1614,6 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 static unsigned long find_alloced_obj(struct size_class *class,
 					struct page *page, int *obj_idx)
 {
-	unsigned long head;
 	int offset = 0;
 	int index = *obj_idx;
 	unsigned long handle = 0;
@@ -1616,9 +1623,7 @@ static unsigned long find_alloced_obj(struct size_class *class,
 	offset += class->size * index;
 
 	while (offset < PAGE_SIZE) {
-		head = obj_to_head(page, addr + offset);
-		if (head & OBJ_ALLOCATED_TAG) {
-			handle = head & ~OBJ_ALLOCATED_TAG;
+		if (obj_allocated(page, addr + offset, &handle)) {
 			if (trypin_tag(handle))
 				break;
 			handle = 0;
@@ -1928,7 +1933,7 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 	struct page *dummy;
 	void *s_addr, *d_addr, *addr;
 	int offset, pos;
-	unsigned long handle, head;
+	unsigned long handle;
 	unsigned long old_obj, new_obj;
 	unsigned int obj_idx;
 	int ret = -EAGAIN;
@@ -1964,9 +1969,7 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 	pos = offset;
 	s_addr = kmap_atomic(page);
 	while (pos < PAGE_SIZE) {
-		head = obj_to_head(page, s_addr + pos);
-		if (head & OBJ_ALLOCATED_TAG) {
-			handle = head & ~OBJ_ALLOCATED_TAG;
+		if (obj_allocated(page, s_addr + pos, &handle)) {
 			if (!trypin_tag(handle))
 				goto unpin_objects;
 		}
@@ -1982,9 +1985,7 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 
 	for (addr = s_addr + offset; addr < s_addr + pos;
 					addr += class->size) {
-		head = obj_to_head(page, addr);
-		if (head & OBJ_ALLOCATED_TAG) {
-			handle = head & ~OBJ_ALLOCATED_TAG;
+		if (obj_allocated(page, addr, &handle)) {
 			BUG_ON(!testpin_tag(handle));
 
 			old_obj = handle_to_obj(handle);
@@ -2029,9 +2030,7 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 unpin_objects:
 	for (addr = s_addr + offset; addr < s_addr + pos;
 						addr += class->size) {
-		head = obj_to_head(page, addr);
-		if (head & OBJ_ALLOCATED_TAG) {
-			handle = head & ~OBJ_ALLOCATED_TAG;
+		if (obj_allocated(page, addr, &handle)) {
 			BUG_ON(!testpin_tag(handle));
 			unpin_tag(handle);
 		}
-- 
2.34.0.rc1.387.gb447b232ab-goog

