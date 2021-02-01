Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802B330A014
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 02:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhBABs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 20:48:26 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:28163 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhBABsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 20:48:23 -0500
Received: from oscar.flets-west.jp (softbank126026094251.bbtec.net [126.26.94.251]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 1111l8R0029564;
        Mon, 1 Feb 2021 10:47:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 1111l8R0029564
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1612144029;
        bh=TDJjRqIDSlDT60mv5gIfmfEEAk3G9c89/Xm2zgNLK6A=;
        h=From:To:Cc:Subject:Date:From;
        b=pLjQk1hscRI7Fy+qp8zttO+i+m4XzXjISej5LxbA5SiFH3l8dKV7g3fGSbHqpFlg/
         lbQnqKwJhInu9/tM4gPt8amW4r6EO2taBL+wL/eFubD9+o1OjP4/MoXoo6oSGbj+RQ
         fSouK8r0G6n503ykUg69gB1hOXtyzVG3qnIYhA2CvPwjzpt5eQXUagNcwtT2c74oCO
         T3si5Z0pexeziMNy2nxlBn/j5Wq5TKA8v05jj9yauKCZbJ+24YuXLDUxBdoLMVKAKj
         L/SUH04z/6q/VKnvrjBESw4Zfc3aQixMYYchYjGbMK+Lx7/Hxvxfhc3REd5Lqpx0Cw
         Q9h1iLKLpYoLw==
X-Nifty-SrcIP: [126.26.94.251]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] lib/cmdline: remove an unneeded local variable in next_arg()
Date:   Mon,  1 Feb 2021 10:47:07 +0900
Message-Id: <20210201014707.3828753-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local variable 'next' is unneeded because you can simply advance
the existing pointer 'args'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 lib/cmdline.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/cmdline.c b/lib/cmdline.c
index b390dd03363b..f9844ea417c0 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -215,7 +215,6 @@ char *next_arg(char *args, char **param, char **val)
 {
 	unsigned int i, equals = 0;
 	int in_quote = 0, quoted = 0;
-	char *next;
 
 	if (*args == '"') {
 		args++;
@@ -253,10 +252,10 @@ char *next_arg(char *args, char **param, char **val)
 
 	if (args[i]) {
 		args[i] = '\0';
-		next = args + i + 1;
+		args += i + 1;
 	} else
-		next = args + i;
+		args += i;
 
 	/* Chew up trailing spaces. */
-	return skip_spaces(next);
+	return skip_spaces(args);
 }
-- 
2.27.0

