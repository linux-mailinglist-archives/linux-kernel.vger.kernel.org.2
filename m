Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF1730B85E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 08:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbhBBHHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 02:07:08 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:64965 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbhBBHGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 02:06:53 -0500
Received: from oscar.flets-west.jp (softbank126026094251.bbtec.net [126.26.94.251]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 11274eAq003392;
        Tue, 2 Feb 2021 16:04:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 11274eAq003392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1612249482;
        bh=Ku0JemULnSrWuXAxFO97EhG22ff+aHsKP81hB1VE4es=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J1OgYcrYJvHe3hSTeGZZLui75WMd8eNDRvuIaGqB4/FWtnt2GCFo+8pye5aLpAOKy
         bawcqNEFWIeM95cFAH7iKqOS21soUCyGuFH2NySCcIF3vIGH4UkmNy1fvWTqTvkZ5I
         FCavDk98AccvlitOnfGte8Tr2mnsKoWNmwhfnt01C5EiawWDHIAw4L0lNfHLZwoKVj
         NgbyxRkbpeCD8iB0BpEY/vCbQbbX3h0cSVSDiYQltfhEDMv+fbMuTiwWKKc21c1B/4
         Q9A1YVFujg4oMV5qwnJ0WMTQPh3T2R6OZrVHeWgmXVTv5MrjFIU1Kuarqd+D2sSpn5
         puXKRjHnhQ8JQ==
X-Nifty-SrcIP: [126.26.94.251]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/3] printk: hard-code CONSOLE_LOGLEVEL_MIN in printk.c
Date:   Tue,  2 Feb 2021 16:02:17 +0900
Message-Id: <20210202070218.856847-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210202070218.856847-1-masahiroy@kernel.org>
References: <20210202070218.856847-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONSOLE_LOGLEVEL_MIN is only used in kernel/printk/printk.c.

You do not need to expose it to all printk() users.

I could move it to kernel/printk/printk.c, but I do not think this
macro would contribute to the code readability or maintainability.

I just hard-coded it.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/linux/printk.h | 1 -
 kernel/printk/printk.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index fd34b3aa2f90..ceaf0486c01c 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -48,7 +48,6 @@ static inline const char *printk_skip_headers(const char *buffer)
 
 /* We show everything that is MORE important than this.. */
 #define CONSOLE_LOGLEVEL_SILENT  0 /* Mum's the word */
-#define CONSOLE_LOGLEVEL_MIN	 1 /* Minimum loglevel we let people use */
 #define CONSOLE_LOGLEVEL_DEBUG	10 /* issue debug messages */
 #define CONSOLE_LOGLEVEL_MOTORMOUTH 15	/* You can't shut this one up */
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 92b93340905c..7b50298d52e3 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -63,7 +63,7 @@
 int console_printk[4] = {
 	CONFIG_CONSOLE_LOGLEVEL_DEFAULT,	/* console_loglevel */
 	CONFIG_MESSAGE_LOGLEVEL_DEFAULT,	/* default_message_loglevel */
-	CONSOLE_LOGLEVEL_MIN,		/* minimum_console_loglevel */
+	1,					/* minimum_console_loglevel */
 	CONFIG_CONSOLE_LOGLEVEL_DEFAULT,	/* default_console_loglevel */
 };
 EXPORT_SYMBOL_GPL(console_printk);
-- 
2.27.0

