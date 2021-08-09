Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472893E3F4A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 07:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbhHIFRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 01:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbhHIFRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 01:17:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722D8C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 22:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=yOCXxJNJC7NkOSL+GguHSuO1cbstODpX5rkv0qL5ll4=; b=jlaFl/QaGutsB8c4wKzt+l8tmx
        Q4JhRy1K84sSfiEg//hGs4M9tm9YOnTLi0v5R+9R1gFA0H2C0tLxdsa8oUaA3L8fHzwe0BAHZz2Ov
        mwGi9i8ogik+pxknPz5JAGZdz/Jd6LO+l8piJeeZFu/8xLudnS1ySxa5B8Hec1rUnwvq3KGUWZEav
        d+UaV+azTckXQCEv9tlJ/pU/hcq5FjAV3RIjNH8/Du6AabJvUsz9aC6gHvHbVbR54ZHOH441b/Zb5
        cP1JqAlzwNxzWBxPe2UMsEWrUY09ZvXEkUNb0mQ3JUVA+yuHB5xR3ZTwTWKUEt+2rXuOfAg2MDR5/
        a2vs02aQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCxeV-00H9MK-VM; Mon, 09 Aug 2021 05:16:44 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] lib/dump_stack: correct kernel-doc notation
Date:   Sun,  8 Aug 2021 22:16:43 -0700
Message-Id: <20210809051643.17567-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc warnings in dump_stack.c:

lib/dump_stack.c:97: warning: Function parameter or member 'log_lvl' not described in 'dump_stack_lvl'
lib/dump_stack.c:97: warning: expecting prototype for dump_stack(). Prototype was for dump_stack_lvl() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/dump_stack.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20210806.orig/lib/dump_stack.c
+++ linux-next-20210806/lib/dump_stack.c
@@ -89,7 +89,8 @@ static void __dump_stack(const char *log
 }
 
 /**
- * dump_stack - dump the current task information and its stack trace
+ * dump_stack_lvl - dump the current task information and its stack trace
+ * @log_lvl: log level
  *
  * Architectures can override this implementation by implementing its own.
  */
