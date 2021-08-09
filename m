Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037EB3E3E1C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 05:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhHIDIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 23:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhHIDIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 23:08:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30740C061757;
        Sun,  8 Aug 2021 20:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=horbXQOjZIRZ8FBSbpv2mepupGhB9Lf75u+uewvzT7E=; b=pN4ZQh9wtiZxDIDzmK+R3OZ5F/
        eeZMoe7hIh2BRlKUexii6Eom7jOGOxa1MbCX+B8wS88BXdZOHMd4lzs7/npXFVbHyH4JLUCT9t5NO
        wbsle8wghUocp5bSnskvw5ErHxzAw3HVtoFXlSxRgdgJRIuoKq4DZpXhR35dSOC4iafTGz3ogcusM
        AgMj0F7WL9WbTToxQcnYxXDLjtqY/0M6ZYwIFPV5T6DXm6SK4VOGazamJhqJ6RAI2i1mlAMQgePqg
        ZFyMv8bDEqH45vyPNeEblm7kJHdQU+ULOhfUR5lNprUoni14ld212WMiOyM29ZiD3q65kR2Xa+cY1
        8N+R62Eg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCveJ-00Gy3u-Jh; Mon, 09 Aug 2021 03:08:23 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>
Subject: [PATCH] alpha: agp: make empty macros use do-while-0 style
Date:   Sun,  8 Aug 2021 20:08:22 -0700
Message-Id: <20210809030822.20658-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copy these macros from ia64/include/asm/agp.h to avoid the
"empty-body" in 'if' statment warning.

drivers/char/agp/generic.c: In function 'agp_generic_destroy_page':
../drivers/char/agp/generic.c:1265:42: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
 1265 |                 unmap_page_from_agp(page);

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Airlie <airlied@linux.ie>
---
 arch/alpha/include/asm/agp.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20210806.orig/arch/alpha/include/asm/agp.h
+++ linux-next-20210806/arch/alpha/include/asm/agp.h
@@ -6,8 +6,8 @@
 
 /* dummy for now */
 
-#define map_page_into_agp(page) 
-#define unmap_page_from_agp(page) 
+#define map_page_into_agp(page)		do { } while (0)
+#define unmap_page_from_agp(page)	do { } while (0)
 #define flush_agp_cache() mb()
 
 /* GATT allocation. Returns/accepts GATT kernel virtual address. */
