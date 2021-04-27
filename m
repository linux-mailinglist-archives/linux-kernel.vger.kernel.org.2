Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F6036BDA8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 05:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbhD0DOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 23:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhD0DOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 23:14:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B52C061574;
        Mon, 26 Apr 2021 20:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=CgpK97dwQ7jxO/6Xiazk1B15iaHiHK4/6xEOZQpL8nc=; b=esSVxOBZiXjZRu/R53mWWIlSVr
        qTS4lxp3siZv6iEuYOLEAvQKD3PFP7ycbteCBLz7722M7K2ljd8WFZrPE/4q+xKwbfsWLUaju91Dl
        CxLfS0yvfW4nK1zOWgcbKwyiFOWG1Z0kWpbUrk60dh1hFoG7YZ2nDopoHwhkvYioK6f6rU22kme7d
        5xixmRVko7OY6QqUIhhgP5tv5b5QE+t2q+RkBIlIi6zdjpu14XQxqhLwvqhHDExSNvbeg7MzehRrL
        ZEeNe0oD9qZApHO/w7/zruuHpyHJOXOEUGOaud4gyW2/YeUiZ6Y4LpwUKLVoQpFHBBySLerbda9Ne
        zN59SHGg==;
Received: from [2601:1c0:6280:3f0::df68] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lbEAV-006PF2-A5; Tue, 27 Apr 2021 03:13:50 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org
Subject: [PATCH] clk: <linux/clk.h>: correct clk_get_parent() documentation
Date:   Mon, 26 Apr 2021 20:13:42 -0700
Message-Id: <20210427031342.5333-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the kernel-doc return value agree with both the stub implementation
in <linux/clk.h> and the non-stub function in drivers/clk/clk.c.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-clk@vger.kernel.org
---
There are several drivers that call clk_get_parent() and use its
return value as though it returns an ERR_PTR(). I am working on a
patch series to fix those.

 include/linux/clk.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20210426.orig/include/linux/clk.h
+++ linux-next-20210426/include/linux/clk.h
@@ -744,8 +744,8 @@ int clk_set_parent(struct clk *clk, stru
  * clk_get_parent - get the parent clock source for this clock
  * @clk: clock source
  *
- * Returns struct clk corresponding to parent clock source, or
- * valid IS_ERR() condition containing errno.
+ * Return: &struct clk corresponding to parent clock source, or
+ * %NULL if clk is %NULL.
  */
 struct clk *clk_get_parent(struct clk *clk);
 
