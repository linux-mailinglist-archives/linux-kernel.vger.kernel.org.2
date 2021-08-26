Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAA43F8E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 20:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243379AbhHZSoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 14:44:02 -0400
Received: from smtprelay0174.hostedemail.com ([216.40.44.174]:38202 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243288AbhHZSoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 14:44:01 -0400
Received: from omf02.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id DC885100E894C;
        Thu, 26 Aug 2021 18:43:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id A1BD71D42F8;
        Thu, 26 Aug 2021 18:43:11 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] vsprintf/Documentation: Add X to %*ph extension to output upper case hex
Date:   Thu, 26 Aug 2021 11:43:01 -0700
Message-Id: <bc33e306a9064dfbf1180a35f9bfa587c6502eca.1630003183.git.joe@perches.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1630003183.git.joe@perches.com>
References: <cover.1630003183.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=5.10
X-Stat-Signature: xma4geogintafk4fq5999pib9fb915sa
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: A1BD71D42F8
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+We4XWtKcgRIaH66WbuAlHEKemFDnH12Y=
X-HE-Tag: 1630003391-142208
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few sysfs output uses of hex arrays are uppercase and are nominally ABI.

Add a mechanism to the existing vsprintf %*ph hex output extension to
support upper case hex output.

Signed-off-by: Joe Perches <joe@perches.com>
---
 Documentation/core-api/printk-formats.rst |  6 ++++
 lib/vsprintf.c                            | 42 ++++++++++++++---------
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index e08bbe9b0cbf3..ca750274992e6 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -284,10 +284,16 @@ Raw buffer as a hex string
 
 ::
 
+	The preferred output is lowercase
 	%*ph	00 01 02  ...  3f
 	%*phC	00:01:02: ... :3f
 	%*phD	00-01-02- ... -3f
 	%*phN	000102 ... 3f
+	Formats with X are uppercase, used for backwards compatibility
+	%*phX	00 01 02  ...  3F
+	%*phCX	00:01:02: ... :3F
+	%*phDX	00-01-02- ... -3F
+	%*phNX	000102 ... 3F
 
 For printing small buffers (up to 64 bytes long) as a hex string with a
 certain separator. For larger buffers consider using
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 134216c45980e..5c22a07bbe3a7 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1147,7 +1147,10 @@ char *hex_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 {
 	int i, len = 1;		/* if we pass '%ph[CDN]', field width remains
 				   negative value, fallback to the default */
-	char separator;
+	char separator = ' ';
+	int count = 1;
+	bool found = true;
+	char locase = 0x20;	/* ASCII OR'd for lower case see: number() */
 
 	if (spec.field_width == 0)
 		/* nothing to print */
@@ -1156,30 +1159,35 @@ char *hex_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 	if (check_pointer(&buf, end, addr, spec))
 		return buf;
 
-	switch (fmt[1]) {
-	case 'C':
-		separator = ':';
-		break;
-	case 'D':
-		separator = '-';
-		break;
-	case 'N':
-		separator = 0;
-		break;
-	default:
-		separator = ' ';
-		break;
-	}
+	do {
+		switch (fmt[count++]) {
+		case 'C':
+			separator = ':';
+			break;
+		case 'D':
+			separator = '-';
+			break;
+		case 'N':
+			separator = 0;
+			break;
+		case 'X':
+			locase = 0;
+			break;
+		default:
+			found = false;
+			break;
+		}
+	} while (found);
 
 	if (spec.field_width > 0)
 		len = min_t(int, spec.field_width, 64);
 
 	for (i = 0; i < len; ++i) {
 		if (buf < end)
-			*buf = hex_asc_hi(addr[i]);
+			*buf = hex_asc_upper_hi(addr[i]) | locase;
 		++buf;
 		if (buf < end)
-			*buf = hex_asc_lo(addr[i]);
+			*buf = hex_asc_upper_lo(addr[i]) | locase;
 		++buf;
 
 		if (separator && i != len - 1) {
-- 
2.30.0

