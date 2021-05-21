Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A01738BF74
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 08:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbhEUGg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 02:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232783AbhEUGgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 02:36:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 889C1613B6;
        Fri, 21 May 2021 06:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621578903;
        bh=xQC7WGE+155P8uQ6aYYnmapY86KbOycguF9S3ZNJuXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bG12sn1D2spk5297gnqioSYItOsEBnDHdUkKEB8/oeCLYwSFW4uMWxt2gA7P/Pg2s
         MBSQcSYFneN8KNUQyyAVg7mGPerSXW5VucAZyF5ECIfxtW+YkK7YRuMKshz0jvAVNV
         MTrYwdY1QBBKaU3yp+YoAXxQjnWlaZM3Fn5ASTEpaxmHAgxBTG7/p6+56JN5yUFQCM
         3+69Icv/9aIAjpk33FLzDwk2hQejYYaj1subqFMvB/oHyc/EIKJjtx9g3K+RuBNhw5
         eP4mCs2VHNB9iShFb5Go9s7Y+cESwCRslxdE3m2XrjGphMdv7hiTCRuMj6RHz80FdP
         NJldnsnYi7ssA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Devin Moore <devinmoore@google.com>
Subject: [PATCH v2 4/4] docs: bootconfig: Update for mixing value and subkeys
Date:   Fri, 21 May 2021 15:35:00 +0900
Message-Id: <162157890064.78209.16783417415944826941.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162157886618.78209.11141970623539574861.stgit@devnote2>
References: <162157886618.78209.11141970623539574861.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update document for the mixing value and subkeys on a key.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v2:
  - Update an example of mixing value and subkeys.
---
 Documentation/admin-guide/bootconfig.rst |   30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index 452b7dcd7f6b..6a79f2e59396 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -89,13 +89,35 @@ you can use ``+=`` operator. For example::
 
 In this case, the key ``foo`` has ``bar``, ``baz`` and ``qux``.
 
-However, a sub-key and a value can not co-exist under a parent key.
-For example, following config is NOT allowed.::
+Moreover, sub-keys and a value can coexist under a parent key.
+For example, following config is allowed.::
 
  foo = value1
- foo.bar = value2 # !ERROR! subkey "bar" and value "value1" can NOT co-exist
- foo.bar := value2 # !ERROR! even with the override operator, this is NOT allowed.
+ foo.bar = value2
+ foo := value3 # This will update foo's value.
+
+Note, since there is no syntax to put a raw value directly under a
+structured key, you have to define it outside of the brace. For example::
+
+ foo {
+     bar = value1
+     bar {
+         baz = value2
+         qux = value3
+     }
+ }
+
+Also, the order of the value node under a key is fixed. If there
+are a value and subkeys, the value is always the first child node
+of the key. Thus if user specifies subkeys first, e.g.::
+
+ foo.bar = value1
+ foo = value2
+
+In the program (and /proc/bootconfig), it will be shown as below::
 
+ foo = value2
+ foo.bar = value1
 
 Comments
 --------

