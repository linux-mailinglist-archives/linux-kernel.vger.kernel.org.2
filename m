Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CF2451BCA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344750AbhKPAHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345675AbhKOT3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:29:02 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D48CC06BCF0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:59:24 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y7so15372087plp.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pSLrn5y02nFYb56rbdejNlZIJ15XWP3dy4aaYUGw/MI=;
        b=RYLXxS412x5P9PLxG/vpcXj0PeJFVvZsbSQUYS6T0nLuS8Oh3IpnpC5stTjDBfyEbg
         HrB6vour5ki1ihptvQ56/i2OiyZ6Bzdz6Fr/gZkRYicQwmz1btnU/OAKDB4IIq37dOys
         UT+LrPgPYUcg8PWFjPZJ4DuB6HR+NU8ij0ybDL3Qs/wMi/IuEBXGHLUEoPd2Q9YU2loR
         ALennVfrbcQAjUsi3r8iXSnS/S8M0vxi/rDTC9avuNnqySmErzxPwth+P7o5BWR0/o3V
         bSq8Yw4XiJiyTHaeaHAC2jDBrzmBiMowF5kFyRI0fa6sbrGvP0UXfAFHcjOYN5XGn/0z
         hCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pSLrn5y02nFYb56rbdejNlZIJ15XWP3dy4aaYUGw/MI=;
        b=oVS435GpzukTkPyavkFaL9EfnTxTklwC/we0KR80PJKe8bxVFP3N4T6SqmdmV6Zg9X
         gdi9GDIJC2v0y2TvdQoH2jtXVd/ptItcTSWa71ggvGqi473mgA3cyJS/j0aClt4diOva
         aQWcMW3scB/ygFaL/Q6qpRRV9WUmzHWH/IZRzSJuRIhjfpLi65MwrjUp4b5GTDFRA1sG
         cmAzHoEvplMgM6pUiFSvC57gCR++BYpn4HVVq4pyYVmiFRqJayqvRk084hCU/8HEHBwi
         ZbgkeeUVPs4IW+QfH6vf7rjV79f9aO2ExxcQeI0xoohIiw7f4coPMkww90CCKRDQAOxb
         kYQg==
X-Gm-Message-State: AOAM532iHNHFoUDA8U5DtrpLA/5O6Zckpfb+FbJCdI2XYCRmx8kpqP+X
        t2n+19/4+T4XhlnIZc9Zfkg=
X-Google-Smtp-Source: ABdhPJwrGFruznHxWpMGeZyh0kKzDStfOuXOf5UduhvpYVsBEjGiaE1wgASm37OzdreK+H5/sdFdeg==
X-Received: by 2002:a17:90b:4acd:: with SMTP id mh13mr68392410pjb.230.1637002763347;
        Mon, 15 Nov 2021 10:59:23 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:7a54:8083:4365:b23d])
        by smtp.gmail.com with ESMTPSA id c3sm11882941pfv.67.2021.11.15.10.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 10:59:22 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Mike Galbraith <umgwanakikbuti@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 9/9] zsmalloc: replace get_cpu_var with local_lock
Date:   Mon, 15 Nov 2021 10:59:09 -0800
Message-Id: <20211115185909.3949505-10-minchan@kernel.org>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
In-Reply-To: <20211115185909.3949505-1-minchan@kernel.org>
References: <20211115185909.3949505-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Galbraith <umgwanakikbuti@gmail.com>

The usage of get_cpu_var() in zs_map_object() is problematic because
it disables preemption and makes it impossible to acquire any sleeping
lock on PREEMPT_RT such as a spinlock_t.
Replace the get_cpu_var() usage with a local_lock_t which is embedded
struct mapping_area. It ensures that the access the struct is
synchronized against all users on the same CPU.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[minchan: remove the bit_spin_lock part and change the title]
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/zsmalloc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 5d4c4d254679..7e03cc9363bb 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -65,6 +65,7 @@
 #include <linux/wait.h>
 #include <linux/pagemap.h>
 #include <linux/fs.h>
+#include <linux/local_lock.h>
 
 #define ZSPAGE_MAGIC	0x58
 
@@ -276,6 +277,7 @@ struct zspage {
 };
 
 struct mapping_area {
+	local_lock_t lock;
 	char *vm_buf; /* copy buffer for objects that span pages */
 	char *vm_addr; /* address of kmap_atomic()'ed pages */
 	enum zs_mapmode vm_mm; /* mapping mode */
@@ -451,7 +453,9 @@ MODULE_ALIAS("zpool-zsmalloc");
 #endif /* CONFIG_ZPOOL */
 
 /* per-cpu VM mapping areas for zspage accesses that cross page boundaries */
-static DEFINE_PER_CPU(struct mapping_area, zs_map_area);
+static DEFINE_PER_CPU(struct mapping_area, zs_map_area) = {
+	.lock	= INIT_LOCAL_LOCK(lock),
+};
 
 static __maybe_unused int is_first_page(struct page *page)
 {
@@ -1269,7 +1273,8 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	class = zspage_class(pool, zspage);
 	off = (class->size * obj_idx) & ~PAGE_MASK;
 
-	area = &get_cpu_var(zs_map_area);
+	local_lock(&zs_map_area.lock);
+	area = this_cpu_ptr(&zs_map_area);
 	area->vm_mm = mm;
 	if (off + class->size <= PAGE_SIZE) {
 		/* this object is contained entirely within a page */
@@ -1320,7 +1325,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 
 		__zs_unmap_object(area, pages, off, class->size);
 	}
-	put_cpu_var(zs_map_area);
+	local_unlock(&zs_map_area.lock);
 
 	migrate_read_unlock(zspage);
 }
-- 
2.34.0.rc1.387.gb447b232ab-goog

