Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE083084CA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 06:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhA2FB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 00:01:27 -0500
Received: from mail.synology.com ([211.23.38.101]:52824 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229461AbhA2FB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 00:01:26 -0500
Received: from localhost.localdomain (unknown [10.17.36.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id D9EE5CE781DE;
        Fri, 29 Jan 2021 13:00:44 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1611896445; bh=308sfgn1GWDHCkC2JeXOdBhC7ljH0Q25kX54VwQ6jyQ=;
        h=From:To:Cc:Subject:Date;
        b=l2yvupBNNOQUR51Ai3GKidSZNgYxTg8C+v41d1yQjWnaFhppQvlNf98x62jSmG0XB
         1kxj77eKEsMQm9i0x4sNCFwWEp5WdGoL5jr3uRYjTVV7a6NBynlVPiXyUWCKcPLHXA
         jqu/2acnl3Xwm0uOW0MAA4f6SBH01OFFAsSIaspQ=
From:   bingjingc <bingjingc@synology.com>
To:     kuba@kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, jack@suse.cz, bingjingc@synology.com
Subject: [PATCH] parser: Fix kernel-doc markups
Date:   Fri, 29 Jan 2021 13:00:37 +0800
Message-Id: <20210129050037.10722-1-bingjingc@synology.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: BingJing Chang <bingjingc@synology.com>

Fix existing issues at the kernel-doc markups

Signed-off-by: BingJing Chang <bingjingc@synology.com>
---
 lib/parser.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/lib/parser.c b/lib/parser.c
index f5b3e5d..763acd7 100644
--- a/lib/parser.c
+++ b/lib/parser.c
@@ -11,7 +11,7 @@
 #include <linux/string.h>
 
 /**
- * match_one: - Determines if a string matches a simple pattern
+ * match_one - Determines if a string matches a simple pattern
  * @s: the string to examine for presence of the pattern
  * @p: the string containing the pattern
  * @args: array of %MAX_OPT_ARGS &substring_t elements. Used to return match
@@ -89,7 +89,7 @@ static int match_one(char *s, const char *p, substring_t args[])
 }
 
 /**
- * match_token: - Find a token (and optional args) in a string
+ * match_token - Find a token (and optional args) in a string
  * @s: the string to examine for token/argument pairs
  * @table: match_table_t describing the set of allowed option tokens and the
  * arguments that may be associated with them. Must be terminated with a
@@ -114,7 +114,7 @@ int match_token(char *s, const match_table_t table, substring_t args[])
 EXPORT_SYMBOL(match_token);
 
 /**
- * match_number: scan a number in the given base from a substring_t
+ * match_number - scan a number in the given base from a substring_t
  * @s: substring to be scanned
  * @result: resulting integer on success
  * @base: base to use when converting string
@@ -147,7 +147,7 @@ static int match_number(substring_t *s, int *result, int base)
 }
 
 /**
- * match_u64int: scan a number in the given base from a substring_t
+ * match_u64int - scan a number in the given base from a substring_t
  * @s: substring to be scanned
  * @result: resulting u64 on success
  * @base: base to use when converting string
@@ -174,7 +174,7 @@ static int match_u64int(substring_t *s, u64 *result, int base)
 }
 
 /**
- * match_int: - scan a decimal representation of an integer from a substring_t
+ * match_int - scan a decimal representation of an integer from a substring_t
  * @s: substring_t to be scanned
  * @result: resulting integer on success
  *
@@ -189,7 +189,7 @@ int match_int(substring_t *s, int *result)
 EXPORT_SYMBOL(match_int);
 
 /**
- * match_u64: - scan a decimal representation of a u64 from
+ * match_u64 - scan a decimal representation of a u64 from
  *                  a substring_t
  * @s: substring_t to be scanned
  * @result: resulting unsigned long long on success
@@ -206,7 +206,7 @@ int match_u64(substring_t *s, u64 *result)
 EXPORT_SYMBOL(match_u64);
 
 /**
- * match_octal: - scan an octal representation of an integer from a substring_t
+ * match_octal - scan an octal representation of an integer from a substring_t
  * @s: substring_t to be scanned
  * @result: resulting integer on success
  *
@@ -221,7 +221,7 @@ int match_octal(substring_t *s, int *result)
 EXPORT_SYMBOL(match_octal);
 
 /**
- * match_hex: - scan a hex representation of an integer from a substring_t
+ * match_hex - scan a hex representation of an integer from a substring_t
  * @s: substring_t to be scanned
  * @result: resulting integer on success
  *
@@ -236,7 +236,7 @@ int match_hex(substring_t *s, int *result)
 EXPORT_SYMBOL(match_hex);
 
 /**
- * match_wildcard: - parse if a string matches given wildcard pattern
+ * match_wildcard - parse if a string matches given wildcard pattern
  * @pattern: wildcard pattern
  * @str: the string to be parsed
  *
@@ -287,7 +287,7 @@ bool match_wildcard(const char *pattern, const char *str)
 EXPORT_SYMBOL(match_wildcard);
 
 /**
- * match_strlcpy: - Copy the characters from a substring_t to a sized buffer
+ * match_strlcpy - Copy the characters from a substring_t to a sized buffer
  * @dest: where to copy to
  * @src: &substring_t to copy
  * @size: size of destination buffer
@@ -310,7 +310,7 @@ size_t match_strlcpy(char *dest, const substring_t *src, size_t size)
 EXPORT_SYMBOL(match_strlcpy);
 
 /**
- * match_strdup: - allocate a new string with the contents of a substring_t
+ * match_strdup - allocate a new string with the contents of a substring_t
  * @s: &substring_t to copy
  *
  * Description: Allocates and returns a string filled with the contents of
-- 
2.7.4

