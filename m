Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64B73AE904
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhFUM0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhFUM0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:26:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC87C061574;
        Mon, 21 Jun 2021 05:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=9NgE+CsPzZsmK3YT9xKHoQr/hc5J5ijnpwLPHcf0gwc=; b=qLMJjFqo51thruc5kQ5MjEbPe6
        iFS3gwgzP5eUHLOvtTSBWXKEIVrlehpZUaBnXwEaWPvCLJPVTg6xZ1Ga38e6aUNQ2Zafre30OkxMj
        9DgU/ksQZya0iRzCVAnPzsNehuqMCV5rr1iotriF+txyR59XO81k4id+iw7/1C7CRwdgR+SCZzQBX
        5QwHDG2cdiZ6ZsbGXYRO1gCejyGl3cCdn2KvJmaho0Jr3OnFMiq8gKqO7TDVoGtzKczpzNuC7ydEN
        P3qEBMJ/QODFD6/i8foEVg4aFy0YRcJNU+Y2srd3cOO0SLxFSxmleU+RcqXbxatrSsISYQ+Qxonjp
        Qvs04WGg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvIyJ-00D4u7-QG; Mon, 21 Jun 2021 12:24:14 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] block: Include mm_types.h instead of mm.h
Date:   Mon, 21 Jun 2021 13:24:07 +0100
Message-Id: <20210621122407.3116975-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to include all of mm.h in bvec.h.  It only needs a few
things like the definition of struct page, PAGE_SIZE, PAGE_MASK and so
on, all of which are provided by mm_types.h.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/bvec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index ff832e698efb..a0f3ccc09aba 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -11,7 +11,7 @@
 #include <linux/errno.h>
 #include <linux/limits.h>
 #include <linux/minmax.h>
-#include <linux/mm.h>
+#include <linux/mm_types.h>
 #include <linux/types.h>
 
 struct page;
-- 
2.30.2

