Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E15343C269
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 07:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbhJ0F6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 01:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbhJ0F6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 01:58:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298ABC061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 22:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=uUfWJrLd6zEoYmRP410NAAsU5tIioJ+f9QyGQWf6eEI=; b=vSacETVDQdOnRDgH9QMM7dMrXZ
        iwAl10OfpFbyVZC/zy7zFdGHWWqPzyoRLGiCnOZsuiBAvsEKgTb6W7qtKE8FvsryNKI6iRhuKj090
        SDpigjJqAiQor0ENGV1wwXKXWvrgEe8nSufnEjx1zm6S0rEB1crekflcdnGalhfVKTzHkuARiY8xv
        8i5dKSTwop1Te7hnvIUzG1u0cTZrLp/G7YWjsTCHajRo+SfwU1RUnmLNacIWfwvM4TY3udclWojUD
        ywP5WKcgsetCxc3tKUVKB+KMKpCs89tMajf+NT19Xz30lq+PBBaiSlGtASPrsVskxeXKNpIcZQpyx
        uLAZAW8w==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfbul-003wC2-Ez; Wed, 27 Oct 2021 05:55:55 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zong Li <zong@andestech.com>, Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>
Subject: [PATCH] nds32: ftrace: fix pointer comparison warning
Date:   Tue, 26 Oct 2021 22:55:54 -0700
Message-Id: <20211027055554.19372-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 11.1.0 for nds32 (nds32le if it matters) complains:

../arch/nds32/kernel/ftrace.c: In function '_mcount':
../arch/nds32/kernel/ftrace.c:24:35: error: comparison of distinct pointer types lacks a cast [-Werror]
   24 |         if (ftrace_trace_function != ftrace_stub)
      |                                   ^~

Cast the second function (pointer) to (void *) to avoid the warning.

Fixes: a18082575c66 ("nds32/ftrace: Support static function tracer")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
To: Greentime Hu <green.hu@gmail.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Zong Li <zong@andestech.com>
Cc: Nick Hu <nickhu@andestech.com>
Cc: Vincent Chen <deanbo422@gmail.com>
---
 arch/nds32/kernel/ftrace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20211026.orig/arch/nds32/kernel/ftrace.c
+++ linux-next-20211026/arch/nds32/kernel/ftrace.c
@@ -21,7 +21,7 @@ noinline void _mcount(unsigned long pare
 
 	unsigned long ip = (unsigned long)__builtin_return_address(0);
 
-	if (ftrace_trace_function != ftrace_stub)
+	if (ftrace_trace_function != (void *)ftrace_stub)
 		ftrace_trace_function(ip - MCOUNT_INSN_SIZE, parent_ip,
 				      NULL, NULL);
 
