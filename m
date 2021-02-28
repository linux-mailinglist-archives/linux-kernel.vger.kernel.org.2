Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F104B327383
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 18:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhB1RGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 12:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhB1RGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 12:06:33 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BD8C061786
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 09:05:52 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a22so23776917ejv.9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 09:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fGK1R7e9wY+Kv1i3b3EIJk5Asvw3vI9xL+h7sNNGtMI=;
        b=r9mGeDGSmkvU8TGa2JrHfUirVP8jMk387jR1dLuSkujZE5/3qx+jjuizAYMB/M+1nB
         +9qbqX6u6pGbTfkAq+qAmGlgrgkMknZsq7keLKSJ6r+tErzmR8BzVfWIWukAV4JU4bCD
         Zmtb78eTFt6im/VzIQORa00IMp3drhnPvBbbWE/+v+bZ1C7vuojxkc2L2GBxnZwK6EsK
         /IK7tLJZ/Y+nnYoOcRdwAf8nhdVNhpz9vqBmG0E6hbTdHteaLS30SYgOBJZkzAyyuTaL
         ikEIP1h7TrRLHyi4iK8+u/mEkLg25OxzTr5IoVMZ9R0Uf+cH12nu/2/QqjK3KXfY4Ge0
         rnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fGK1R7e9wY+Kv1i3b3EIJk5Asvw3vI9xL+h7sNNGtMI=;
        b=r+hPNLhdslofw5wK2eD93tADqLLSwpddfNqmnAxHIbiIDtRq0jp5/Zd2zJPhiMq1j1
         4ljG0Ow7n8mkf+GVk6PpK9MvwYZaqEYxUFKfLJUsnW+afE5Gf7TWg5qqHVTw3BIXDfma
         /kHJ0HJAsdyD7Fbr1Pyntn3HqHlaIwkzpSJ+eQmG14QvFMvSVEQVKyqx1+cDPA41Kj1c
         4hi/vIWPrwCnn39U+rwkL89FfZaRFbEvWIl0EUMSyZrMLHWzpOry5pV87AE8gWNlzcAh
         bkVFwKYMjPz4GsbWJ1RB0LhCiBWIzoatY3Ga4vxXgUEMIZOB0RT3WuB/D9/fzNqaJ4En
         PPtg==
X-Gm-Message-State: AOAM531AL+gzfO5aTe5pHBeKK92mvkNJ4lR8GyN9gIXV5H/QOrzHGiLv
        3le6qgP+uCb9L/4g5zfGQw==
X-Google-Smtp-Source: ABdhPJyr9o/9M92Ykiu7oT/ojSgOX067MX7M5/CZk4UXavOCux7nId6hbOih56V4BEgJ9QrAX8ZIbA==
X-Received: by 2002:a17:906:934f:: with SMTP id p15mr12047984ejw.473.1614531951034;
        Sun, 28 Feb 2021 09:05:51 -0800 (PST)
Received: from localhost.localdomain ([46.53.249.223])
        by smtp.gmail.com with ESMTPSA id y20sm11198945edc.84.2021.02.28.09.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 09:05:50 -0800 (PST)
Date:   Sun, 28 Feb 2021 20:05:49 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: [PATCH 11/11] pragma once: conversion script (in Python 2)
Message-ID: <YDvNbbHd2cKXlLme@localhost.localdomain>
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 2bffcdfec69a8d28e9cb2c535724fbba8e12b820 Mon Sep 17 00:00:00 2001
From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Tue, 9 Feb 2021 14:47:34 +0300
Subject: [PATCH 11/11] pragma once: conversion script (in Python 2)

Script accepts list of files to be converted from the command line,
strips include guard if any and inserts "#pragma once" directive in
the beginning.

The following patterns are recognised:

	#ifndef FOO_H		#ifndef FOO_H
	#define FOO_H		#ifndef FOO_H 1

	#endif
	#endif // comment
	#endif /* one line comment */

This is how almost all include guards look like.

Scripts doesn't pretend to be a compiler. For example, comments inside
preprocessor directive aren't recognised because people don't write code
like this:

	# /*
	   * legal C
	   */        def\
	ine FOO /*
		 * no, we don't care
		 */

Trailing multiline comments aren't recognised as well.

Script can cut through SPDX comments:

	/* SPDX-License-Identifier: xxx
	 *	<=== pragma once will be inserted here
	 * Copyright ...
	 */

In other words, the script is simple but not too simple.

It cowardly exits and doesn't do anything as a safety measure in case of
an existing pragma once directive, missing/broken include guard or a bug.
Running it second time shouldn't do anything.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 scripts/pragma-once.py | 159 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)
 create mode 100755 scripts/pragma-once.py

diff --git a/scripts/pragma-once.py b/scripts/pragma-once.py
new file mode 100755
index 000000000000..7c8a274aad28
--- /dev/null
+++ b/scripts/pragma-once.py
@@ -0,0 +1,159 @@
+#!/usr/bin/python2
+# Copyright (c) 2021 Alexey Dobriyan <adobriyan@gmail.com>
+#
+# Permission to use, copy, modify, and distribute this software for any
+# purpose with or without fee is hereby granted, provided that the above
+# copyright notice and this permission notice appear in all copies.
+#
+# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+
+# Change include guard to "#pragma once" directive in place.
+import os
+import re
+import sys
+
+def read_file(filename):
+    with open(filename) as f:
+        return f.read()
+
+def write_file(filename, buf):
+    tmp = '%s.pragma-once' % filename
+    with open(tmp, 'w') as f:
+        f.write(buf)
+    os.rename(tmp, filename)
+
+def ws(c):
+    return c == ' ' or c == '\t' or c == '\n'
+
+re_ifndef = re.compile('#[ \t]*ifndef[ \t]+([A-Za-z_][A-Za-z0-9_]*)\n')
+re_define = re.compile('#[ \t]*define[ \t]+([A-Za-z_][A-Za-z0-9_]*)([ \t]+1)?\n')
+re_endif1 = re.compile('#[ \t]*endif[ \t]*//')
+re_endif2 = re.compile('#[ \t]*endif[ \t]*/\*')
+
+def pragma_once(c):
+    i = 0
+
+    # skip leading whitespace and comments
+    while i < len(c):
+        if ws(c[i]):
+            i += 1
+        elif c[i] == '/' and c[i + 1] == '*':
+            i = c.index('*/', i + 2) + 2
+        elif c[i] == '/' and c[i + 1] == '/':
+            i = c.index('\n', i + 2) + 1
+        else:
+            break;
+
+    # find #ifndef
+    ifndef_start = i
+    match = re_ifndef.match(c, i)
+    guard = match.group(1)
+    i = match.end()
+
+    # find #define
+    match = re_define.match(c, i)
+    if match.group(1) != guard:
+        raise
+    i = match.end()
+
+    while ws(c[i]):
+        i += 1
+
+    define_end = i
+
+    # trim whitespace before #ifndef
+    i = ifndef_start
+    while i > 0 and ws(c[i - 1]):
+        i -= 1
+    if c[i] == '\n':
+        i += 1
+    ifndef_start = i
+
+    #print repr(c[ifndef_start:define_end])
+
+    # find #endif
+    i = c.rindex('\n#endif', i) + 1
+    endif_start = i
+
+    match = None
+    if match is None:
+        match = re_endif1.match(c, i)
+        if match:
+            try:
+                i = c.index('\n', match.end()) + 1
+            except ValueError:
+                i = len(c)
+
+    if match is None:
+        match = re_endif2.match(c, i)
+        if match:
+            try:
+                i = c.index('*/', match.end()) + 2
+            except ValueError:
+                i = len(c)
+
+    if match is None:
+        i = endif_start + len('#endif')
+
+    while i < len(c) and ws(c[i]):
+        i += 1
+    if i != len(c):
+        raise
+
+    endif_end = i
+
+    # trim whitespace before #endif
+    i = endif_start
+    while i > 0 and ws(c[i - 1]):
+        i -= 1
+    if c[i] == '\n':
+        i += 1
+    endif_start = i
+
+    #print repr(c[endif_start:endif_end])
+
+    if define_end > endif_start:
+        raise
+
+    spdx_end = None
+    pragma_once = '#pragma once\n'
+    cut_comment = False
+    if c.startswith('/* SPDX'):
+        spdx_end = c.index('\n') + 1
+        if not (c[spdx_end - 3] == '*' and c[spdx_end - 2] == '/'):
+            cut_comment = True
+    elif c.startswith('// SPDX') or c.startswith('//SPDX'):
+        spdx_end = c.index('\n') + 1
+
+    if spdx_end is None:
+        l = [pragma_once, c[0:ifndef_start]]
+    elif cut_comment:
+        l = [c[0:spdx_end - 1], ' */\n', pragma_once, '/*\n', c[spdx_end:ifndef_start]]
+    else:
+        l = [c[0:spdx_end], pragma_once, c[spdx_end:ifndef_start]]
+
+    l.append(c[define_end:endif_start])
+    l.append(c[endif_end:])
+    return ''.join(l)
+
+def main():
+    for filename in sys.argv[1:]:
+        s = ''
+        try:
+            buf = read_file(filename)
+            if buf.find('#pragma once') == -1:
+                write_file(filename, pragma_once(buf))
+            else:
+                s = 'skip '
+        except:
+            pass
+        print '#pragma once: %s%s' % (s, filename)
+
+if __name__ == '__main__':
+    main()
-- 
2.29.2

