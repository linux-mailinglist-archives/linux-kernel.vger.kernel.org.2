Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722993A0992
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 03:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbhFIBqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 21:46:14 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:58959 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbhFIBqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 21:46:13 -0400
Received: (Authenticated sender: n@nfraprado.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 4F9B360005;
        Wed,  9 Jun 2021 01:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nfraprado.net;
        s=gm1; t=1623203058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9uCR7hI5P8LyVwfNKUDWjVrhcofvpCmZ4LJ9PVnGBBo=;
        b=Y17CiFpWE6c504+7KjhtmBoreLuyq0zSC5b/nqjLQligpJHQa408I9/fGMBhLf9gtHqG+e
        Vankfu4OcvlZMSL1ChV90l41Y1M/7uyJIhZ01S6qwvvcNT+exWVXvnXuHYrUKrhYK6HAkq
        F3+QtdNtVXHyJKODu/VuNfC6NynSBo5I741Jm0X/zP2rAIT76R5RwyHSrNFbBOsbbmdiW0
        K6VB2aH9gxMk7wjG7mavYX00cT7wBSNOZ4vN8Kz2Gs5T6nnAWv2/ZGzaGADaCD8CcfguPt
        rR9g2gnoenEjsKej+zabSujtxvsisllMkG6zJB4sHHO4N1eIZThzUyAjKnPVTw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <n@nfraprado.net>
To:     linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        ~lkcamp/patches@lists.sr.ht
Subject: [RFC PATCH 1/2] docs: automarkup.py: Add literal markup of known constants
Date:   Tue,  8 Jun 2021 22:43:07 -0300
Message-Id: <20210609014308.234027-2-n@nfraprado.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210609014308.234027-1-n@nfraprado.net>
References: <20210609014308.234027-1-n@nfraprado.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some known constants that are used throughout the
documentation, like NULL and error codes, and which are better formatted
as literals by Sphinx. Make these words automatically literals.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Nícolas F. R. A. Prado <n@nfraprado.net>
---
 Documentation/sphinx/automarkup.py | 45 ++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/automarkup.py
index acf5473002f3..eb219783d9e3 100644
--- a/Documentation/sphinx/automarkup.py
+++ b/Documentation/sphinx/automarkup.py
@@ -72,6 +72,40 @@ Skipfuncs = [ 'open', 'close', 'read', 'write', 'fcntl', 'mmap',
               'select', 'poll', 'fork', 'execve', 'clone', 'ioctl',
               'socket' ]
 
+#
+# Words that are automatically converted to literals
+#
+Literals = [ 'NULL', 'ULONG_MAX', 'LONG_MAX', 'EPERM', 'ENOENT', 'ESRCH',
+            'EINTR', 'EIO', 'ENXIO', 'E2BIG', 'ENOEXEC', 'EBADF', 'ECHILD',
+            'EAGAIN', 'ENOMEM', 'EACCES', 'EFAULT', 'ENOTBLK', 'EBUSY',
+            'EEXIST', 'EXDEV', 'ENODEV', 'ENOTDIR', 'EISDIR', 'EINVAL',
+            'ENFILE', 'EMFILE', 'ENOTTY', 'ETXTBSY', 'EFBIG', 'ENOSPC',
+            'ESPIPE', 'EROFS', 'EMLINK', 'EPIPE', 'EDOM', 'ERANGE', 'EDEADLK',
+            'ENAMETOOLONG', 'ENOLCK', 'ENOSYS', 'ENOTEMPTY', 'ELOOP',
+            'EWOULDBLOCK', 'ENOMSG', 'EIDRM', 'ECHRNG', 'EL2NSYNC', 'EL3HLT',
+            'EL3RST', 'ELNRNG', 'EUNATCH', 'ENOCSI', 'EL2HLT', 'EBADE', 'EBADR',
+            'EXFULL', 'ENOANO', 'EBADRQC', 'EBADSLT', 'EDEADLOCK', 'EBFONT',
+            'ENOSTR', 'ENODATA', 'ETIME', 'ENOSR', 'ENONET', 'ENOPKG',
+            'EREMOTE', 'ENOLINK', 'EADV', 'ESRMNT', 'ECOMM', 'EPROTO',
+            'EMULTIHOP', 'EDOTDOT', 'EBADMSG', 'EOVERFLOW', 'ENOTUNIQ',
+            'EBADFD', 'EREMCHG', 'ELIBACC', 'ELIBBAD', 'ELIBSCN', 'ELIBMAX',
+            'ELIBEXEC', 'EILSEQ', 'ERESTART', 'ESTRPIPE', 'EUSERS', 'ENOTSOCK',
+            'EDESTADDRREQ', 'EMSGSIZE', 'EPROTOTYPE', 'ENOPROTOOPT',
+            'EPROTONOSUPPORT', 'ESOCKTNOSUPPORT', 'EOPNOTSUPP', 'EPFNOSUPPORT',
+            'EAFNOSUPPORT', 'EADDRINUSE', 'EADDRNOTAVAIL', 'ENETDOWN',
+            'ENETUNREACH', 'ENETRESET', 'ECONNABORTED', 'ECONNRESET', 'ENOBUFS',
+            'EISCONN', 'ENOTCONN', 'ESHUTDOWN', 'ETOOMANYREFS', 'ETIMEDOUT',
+            'ECONNREFUSED', 'EHOSTDOWN', 'EHOSTUNREACH', 'EALREADY',
+            'EINPROGRESS', 'ESTALE', 'EUCLEAN', 'ENOTNAM', 'ENAVAIL', 'EISNAM',
+            'EREMOTEIO', 'EDQUOT', 'ENOMEDIUM', 'EMEDIUMTYPE', 'ECANCELED',
+            'ENOKEY', 'EKEYEXPIRED', 'EKEYREVOKED', 'EKEYREJECTED',
+            'EOWNERDEAD', 'ENOTRECOVERABLE', 'ERFKILL', 'EHWPOISON' ]
+
+#
+# Any of the words in Literals, optionally prefixed with a '-'
+#
+RE_literal = re.compile(r'-?\b(' + str(r'|'.join(Literals)) + r')\b')
+
 c_namespace = ''
 
 def markup_refs(docname, app, node):
@@ -83,14 +117,18 @@ def markup_refs(docname, app, node):
     #
     markup_func_sphinx2 = {RE_doc: markup_doc_ref,
                            RE_function: markup_c_ref,
-                           RE_generic_type: markup_c_ref}
+                           RE_generic_type: markup_c_ref,
+                           RE_literal: markup_literal,
+                           }
 
     markup_func_sphinx3 = {RE_doc: markup_doc_ref,
                            RE_function: markup_func_ref_sphinx3,
                            RE_struct: markup_c_ref,
                            RE_union: markup_c_ref,
                            RE_enum: markup_c_ref,
-                           RE_typedef: markup_c_ref}
+                           RE_typedef: markup_c_ref,
+                           RE_literal: markup_literal,
+                           }
 
     if sphinx.version_info[0] >= 3:
         markup_func = markup_func_sphinx3
@@ -225,6 +263,9 @@ def markup_c_ref(docname, app, match):
 
     return target_text
 
+def markup_literal(docname, app, match):
+    return nodes.literal('', match.group(0))
+
 #
 # Try to replace a documentation reference of the form Documentation/... with a
 # cross reference to that page
-- 
2.32.0

