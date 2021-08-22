Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7263F3D2F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 04:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhHVDAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 23:00:02 -0400
Received: from smtprelay0057.hostedemail.com ([216.40.44.57]:51078 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231336AbhHVDAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 23:00:01 -0400
Received: from omf15.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id B3024100E7B45;
        Sun, 22 Aug 2021 02:59:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 73693C4178;
        Sun, 22 Aug 2021 02:59:19 +0000 (UTC)
Message-ID: <6abd83d11f1daa3094f82e92843e8279f302e349.camel@perches.com>
Subject: [PATCH] vsprintf and docs: Add X to %ph for upper case output
From:   Joe Perches <joe@perches.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 21 Aug 2021 19:59:17 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 73693C4178
X-Spam-Status: No, score=-0.09
X-Stat-Signature: 6a6a1xazpyuju3t5xqehad5orsxdyjwo
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18KH3X14MR+r7ohb0OTpWvW8asK4ecJwjY=
X-HE-Tag: 1629601159-778388
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uppercase hex output of small char arrays is moderately frequently used.
Add a mechanism to support the %*ph output as uppercase using 'X'.

Signed-off-by: Joe Perches <joe@perches.com>
---
 Documentation/core-api/printk-formats.rst |  7 ++++-
 lib/vsprintf.c                            | 48 ++++++++++++++++++++-----------
 2 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index e08bbe9b0cbf3..01944b0c8adf3 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -285,12 +285,17 @@ Raw buffer as a hex string
 ::
 
 	%*ph	00 01 02  ...  3f
+	%*phX	00 01 02  ...  3F
 	%*phC	00:01:02: ... :3f
+	%*phCX	00:01:02: ... :3F
 	%*phD	00-01-02- ... -3f
+	%*phDX	00-01-02- ... -3F
 	%*phN	000102 ... 3f
+	%*phNX	000102 ... 3F
 
 For printing small buffers (up to 64 bytes long) as a hex string with a
-certain separator. For larger buffers consider using
+certain separator. Typical output is lowercase, formats with X are uppercase.
+For larger buffers consider using
 :c:func:`print_hex_dump`.
 
 MAC/FDDI addresses
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 134216c45980e..6aca95d5a99f0 100644
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
+	bool ucase = false;
 
 	if (spec.field_width == 0)
 		/* nothing to print */
@@ -1156,30 +1159,41 @@ char *hex_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
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
+			ucase = true;
+			break;
+		default:
+			found = false;
+			break;
+		}
+	} while (found);
 
 	if (spec.field_width > 0)
 		len = min_t(int, spec.field_width, 64);
 
 	for (i = 0; i < len; ++i) {
-		if (buf < end)
+		if (buf < end) {
 			*buf = hex_asc_hi(addr[i]);
+			if (ucase)
+				*buf = toupper(*buf);
+		}
 		++buf;
-		if (buf < end)
+		if (buf < end) {
 			*buf = hex_asc_lo(addr[i]);
+			if (ucase)
+				*buf = toupper(*buf);
+		}
 		++buf;
 
 		if (separator && i != len - 1) {


