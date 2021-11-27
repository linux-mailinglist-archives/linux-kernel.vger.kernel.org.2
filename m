Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7903E45FF48
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 15:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355443AbhK0Ocz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 09:32:55 -0500
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:64147 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbhK0Oaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 09:30:55 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id qyfxmWRlLUujjqyfxmVltV; Sat, 27 Nov 2021 15:27:39 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 27 Nov 2021 15:27:39 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] vsprintf: Use non-atomic bitmap API when applicable
Date:   Sat, 27 Nov 2021 15:27:35 +0100
Message-Id: <1abf81a5e509d372393bd22041eed4ebc07ef9f7.1638023178.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'set' bitmap is local to this function. No concurrent access to it is
possible.
So prefer the non-atomic '__[set|clear]_bit()' function to save a few
cycles.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 lib/vsprintf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 9a2bc00b5952..c130dcaca5e2 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -3566,7 +3566,7 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 				++fmt;
 
 			for ( ; *fmt && *fmt != ']'; ++fmt, ++len)
-				set_bit((u8)*fmt, set);
+				__set_bit((u8)*fmt, set);
 
 			/* no ']' or no character set found */
 			if (!*fmt || !len)
@@ -3576,7 +3576,7 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 			if (negate) {
 				bitmap_complement(set, set, 256);
 				/* exclude null '\0' byte */
-				clear_bit(0, set);
+				__clear_bit(0, set);
 			}
 
 			/* match must be non-empty */
-- 
2.30.2

