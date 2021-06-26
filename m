Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1693B4E96
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 15:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFZNII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 09:08:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230035AbhFZNH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 09:07:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5556661C3E;
        Sat, 26 Jun 2021 13:05:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lx807-000Efx-CN; Sat, 26 Jun 2021 09:05:35 -0400
Message-ID: <20210626130535.223682128@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 26 Jun 2021 09:04:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 04/24] docs: bootconfig: Update for mixing value and subkeys
References: <20210626130404.033700863@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Update document for the mixing value and subkeys on a key.

Link: https://lkml.kernel.org/r/162262196510.264090.15044943496205914148.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/admin-guide/bootconfig.rst | 30 ++++++++++++++++++++----
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
-- 
2.30.2
