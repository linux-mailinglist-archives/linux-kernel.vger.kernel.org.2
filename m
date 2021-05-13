Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245BF37F28F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 07:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhEMFUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 01:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhEMFUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 01:20:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582C5C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 22:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Cm54OP8Ip4n5Z4caMv5bXkbmyXna7O0BsIgm7mDjFxw=; b=PVxxZ8WKF02OpATB54M0eiJnh5
        m+iITP7Och1az5lKnmCGTONxLRezOY3hf+WFT4SLokRXNcRkZySL0Lz/21fszgseZLhRZy6BWoM0m
        zicbHZgdxd5SMfNGSl0epOW8MNuk+UnTJaWrqfCJe5k3EGCJU4lcmkPg0WHGAQw/WcX/PEzYvnOg2
        7zOBiDiymweNw5vkg/8LiXuMa9zl2BULwN9lsIfM8cIpvfQR9lVbUsa5H5AWDjZ/ZERg3hIG47zOM
        i88uX8K6OW7da358Bfa10YOw7u8pUR5a303aN8GI2QXtvhxbhBi7Dr5shdJ1ytoqYfE6QTYBraJBI
        6V70MXyw==;
Received: from [2601:1c0:6280:3f0::7376] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lh3kn-00B1Q0-Jd; Thu, 13 May 2021 05:19:21 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Oliver Glitta <glittao@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH -mm] slub: STACKDEPOT: rename save_stack_trace()
Date:   Wed, 12 May 2021 22:19:20 -0700
Message-Id: <20210513051920.29320-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

save_stack_trace() already exists, so change the one in
CONFIG_STACKDEPOT to be save_stack_depot_trace().

Fixes this build error:

../mm/slub.c:607:29: error: conflicting types for ‘save_stack_trace’
 static depot_stack_handle_t save_stack_trace(gfp_t flags)
                             ^~~~~~~~~~~~~~~~
In file included from ../include/linux/page_ext.h:6:0,
                 from ../include/linux/mm.h:25,
                 from ../mm/slub.c:13:
../include/linux/stacktrace.h:86:13: note: previous declaration of ‘save_stack_trace’ was here
 extern void save_stack_trace(struct stack_trace *trace);
             ^~~~~~~~~~~~~~~~

from this patch in mmotm:
  Subject: mm/slub: use stackdepot to save stack trace in objects


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Oliver Glitta <glittao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 mm/slub.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- mmotm-2021-0512-2146.orig/mm/slub.c
+++ mmotm-2021-0512-2146/mm/slub.c
@@ -604,7 +604,7 @@ static struct track *get_track(struct km
 }
 
 #ifdef CONFIG_STACKDEPOT
-static depot_stack_handle_t save_stack_trace(gfp_t flags)
+static depot_stack_handle_t save_stack_depot_trace(gfp_t flags)
 {
 	unsigned long entries[TRACK_ADDRS_COUNT];
 	depot_stack_handle_t handle;
@@ -623,7 +623,7 @@ static void set_track(struct kmem_cache
 
 	if (addr) {
 #ifdef CONFIG_STACKDEPOT
-		p->handle = save_stack_trace(GFP_KERNEL);
+		p->handle = save_stack_depot_trace(GFP_KERNEL);
 #endif
 		p->addr = addr;
 		p->cpu = smp_processor_id();
