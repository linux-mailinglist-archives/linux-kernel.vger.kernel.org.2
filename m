Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE9A451D9B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346606AbhKPAbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345669AbhKOT3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:29:02 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D9BC06BCE7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:59:15 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y7so15371807plp.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DTS88cwpZRhNdCWVFjW1Uni2clTkdxNvhvbd9hJHl9Q=;
        b=da6IwRTzPyK70awYlgE0TSC0pnxwDgovl10PZugFz0nSCXgF/M3bHXusjkMbSiGEOd
         M9Vc0uIfWa8+0U6z9vMK8g06eYPzbzC7XiVg0yj1fCgkV7dMXea/QPn9ifrNbmtPJ/Qr
         pskfzpzHiUgzbxDmPaGh0JXTvkIpgtGeWDoT0Pp0A8XRirme8UnTUY6l8ZWyv/e9uS2i
         NXbMdwxPNjFvv7rOzAgv1L+GEGVRWsZg2eXmy1lrja8xt/qVp5dhku2yaG+NOx/Avcy4
         gU7HQdbyybIhiFVC+AxFd3nXRotqAL8XMYBf1kTtNPC6IMnpRXFuL5+Lqr7rAFzODrbF
         6+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DTS88cwpZRhNdCWVFjW1Uni2clTkdxNvhvbd9hJHl9Q=;
        b=UwJWrjBIwY/CzxccGcJyGeMVgUU3Hh6NQAoiWGW0clvKpQcSQLoDlQ0XAsFeKf4+38
         1hNMtsvMvqzF8mpdQVmx2hbXVbESDAnzZvvQ2hOmVbEFdxVuayuy8CcRiJWPeWWS8lp9
         GkeeJA+X/jDR9zScnvX/uisQppQ0d0gCedI0bWf0gzUsmk69fTwQPRoWXiIwb4HCGSaF
         OfUkOkchwZnVjN5b48aRoqAOOh5bwIAULnCKpQESn3CH0g6QB0lsfOk3YgWSxc2HTavO
         QcNuor/jmzjp0D8STVO395rLxxGz5VboH+m1TzDnZx/Fm+pTbBn0MCF5vMzxDK8eHAHk
         w26g==
X-Gm-Message-State: AOAM533VhuFTu+Ino3cQQ6FoEshu3fXMS+q9QcXyAH1rY3JTI6+oY506
        8E+ny5KdN1DVWlNPIaftY5I=
X-Google-Smtp-Source: ABdhPJzxfgbtwijPOncIcmJbV2TmcVA+OjV2UZGher8++1JTm+1DFMz36WOHauXa42QkDTYF1C6bUA==
X-Received: by 2002:a17:902:8214:b0:142:61cf:7be with SMTP id x20-20020a170902821400b0014261cf07bemr38182979pln.0.1637002755117;
        Mon, 15 Nov 2021 10:59:15 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:7a54:8083:4365:b23d])
        by smtp.gmail.com with ESMTPSA id c3sm11882941pfv.67.2021.11.15.10.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 10:59:14 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 2/9] zsmalloc: rename zs_stat_type to class_stat_type
Date:   Mon, 15 Nov 2021 10:59:02 -0800
Message-Id: <20211115185909.3949505-3-minchan@kernel.org>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
In-Reply-To: <20211115185909.3949505-1-minchan@kernel.org>
References: <20211115185909.3949505-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stat aims for class stat, not zspage so rename it.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/zsmalloc.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index f8c63bacd22e..c149ccf734ba 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -158,7 +158,7 @@ enum fullness_group {
 	NR_ZS_FULLNESS,
 };
 
-enum zs_stat_type {
+enum class_stat_type {
 	CLASS_EMPTY,
 	CLASS_ALMOST_EMPTY,
 	CLASS_ALMOST_FULL,
@@ -549,21 +549,21 @@ static int get_size_class_index(int size)
 	return min_t(int, ZS_SIZE_CLASSES - 1, idx);
 }
 
-/* type can be of enum type zs_stat_type or fullness_group */
-static inline void zs_stat_inc(struct size_class *class,
+/* type can be of enum type class_stat_type or fullness_group */
+static inline void class_stat_inc(struct size_class *class,
 				int type, unsigned long cnt)
 {
 	class->stats.objs[type] += cnt;
 }
 
-/* type can be of enum type zs_stat_type or fullness_group */
-static inline void zs_stat_dec(struct size_class *class,
+/* type can be of enum type class_stat_type or fullness_group */
+static inline void class_stat_dec(struct size_class *class,
 				int type, unsigned long cnt)
 {
 	class->stats.objs[type] -= cnt;
 }
 
-/* type can be of enum type zs_stat_type or fullness_group */
+/* type can be of enum type class_stat_type or fullness_group */
 static inline unsigned long zs_stat_get(struct size_class *class,
 				int type)
 {
@@ -725,7 +725,7 @@ static void insert_zspage(struct size_class *class,
 {
 	struct zspage *head;
 
-	zs_stat_inc(class, fullness, 1);
+	class_stat_inc(class, fullness, 1);
 	head = list_first_entry_or_null(&class->fullness_list[fullness],
 					struct zspage, list);
 	/*
@@ -750,7 +750,7 @@ static void remove_zspage(struct size_class *class,
 	VM_BUG_ON(is_zspage_isolated(zspage));
 
 	list_del_init(&zspage->list);
-	zs_stat_dec(class, fullness, 1);
+	class_stat_dec(class, fullness, 1);
 }
 
 /*
@@ -964,7 +964,7 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 
 	cache_free_zspage(pool, zspage);
 
-	zs_stat_dec(class, OBJ_ALLOCATED, class->objs_per_zspage);
+	class_stat_dec(class, OBJ_ALLOCATED, class->objs_per_zspage);
 	atomic_long_sub(class->pages_per_zspage,
 					&pool->pages_allocated);
 }
@@ -1394,7 +1394,7 @@ static unsigned long obj_malloc(struct size_class *class,
 
 	kunmap_atomic(vaddr);
 	mod_zspage_inuse(zspage, 1);
-	zs_stat_inc(class, OBJ_USED, 1);
+	class_stat_inc(class, OBJ_USED, 1);
 
 	obj = location_to_obj(m_page, obj);
 
@@ -1458,7 +1458,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	record_obj(handle, obj);
 	atomic_long_add(class->pages_per_zspage,
 				&pool->pages_allocated);
-	zs_stat_inc(class, OBJ_ALLOCATED, class->objs_per_zspage);
+	class_stat_inc(class, OBJ_ALLOCATED, class->objs_per_zspage);
 
 	/* We completely set up zspage so mark them as movable */
 	SetZsPageMovable(pool, zspage);
@@ -1489,7 +1489,7 @@ static void obj_free(struct size_class *class, unsigned long obj)
 	kunmap_atomic(vaddr);
 	set_freeobj(zspage, f_objidx);
 	mod_zspage_inuse(zspage, -1);
-	zs_stat_dec(class, OBJ_USED, 1);
+	class_stat_dec(class, OBJ_USED, 1);
 }
 
 void zs_free(struct zs_pool *pool, unsigned long handle)
-- 
2.34.0.rc1.387.gb447b232ab-goog

