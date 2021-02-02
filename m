Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D06630B85D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 08:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhBBHHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 02:07:03 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:64966 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbhBBHGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 02:06:54 -0500
Received: from oscar.flets-west.jp (softbank126026094251.bbtec.net [126.26.94.251]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 11274eAr003392;
        Tue, 2 Feb 2021 16:04:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 11274eAr003392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1612249483;
        bh=X2Mtsvd9wqHo6PszEqliqbcMVkMHrgetwqikPgHneG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aLRu7j5eIonRaqVr0WYY5C6R9iGFBhv4/WQYd+4PmSIAYPW+SdjiQzOioCZS/0oc7
         xIoMlmLAGenbTvaVVoe4IpOC8fbv17YwyfMVQ0J6SbhXn04IOCBw5aot35DihBwM6O
         5o9pUBvZQaNPf4fRkWSq19FFA+a977MjkVXfuWXL4XzE7LGD/nhIy6/tmPXvVYa0eD
         f4AUtAHodH9DqGxqNsr64ihLuaJtBW2oq9NMFAYN2jTKoj8zjZrU08u0/VwP3p1mAN
         MNLGNI3hsH3E95xaPXPYkv/0Rf/mGDMKVXaNKtc92lL8lOAAnkA+58gUddKgGQ/rbP
         hR6lkwO8400/w==
X-Nifty-SrcIP: [126.26.94.251]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 3/3] printk: move CONSOLE_EXT_LOG_MAX to kernel/printk/printk.c
Date:   Tue,  2 Feb 2021 16:02:18 +0900
Message-Id: <20210202070218.856847-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210202070218.856847-1-masahiroy@kernel.org>
References: <20210202070218.856847-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro is only used in kernel/printk/printk.c

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/linux/printk.h | 2 --
 kernel/printk/printk.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index ceaf0486c01c..d2c9c2a6e471 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -44,8 +44,6 @@ static inline const char *printk_skip_headers(const char *buffer)
 	return buffer;
 }
 
-#define CONSOLE_EXT_LOG_MAX	8192
-
 /* We show everything that is MORE important than this.. */
 #define CONSOLE_LOGLEVEL_SILENT  0 /* Mum's the word */
 #define CONSOLE_LOGLEVEL_DEBUG	10 /* issue debug messages */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 7b50298d52e3..d83a5860fe93 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -617,6 +617,8 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 	return len;
 }
 
+#define CONSOLE_EXT_LOG_MAX	8192
+
 /* /dev/kmsg - userspace message inject/listen interface */
 struct devkmsg_user {
 	u64 seq;
-- 
2.27.0

