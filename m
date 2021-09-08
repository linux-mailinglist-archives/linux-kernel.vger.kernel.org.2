Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06497403FBF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 21:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352482AbhIHTVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 15:21:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350585AbhIHTVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 15:21:33 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D8FF61181;
        Wed,  8 Sep 2021 19:20:25 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mO36w-0014ZW-D7; Wed, 08 Sep 2021 15:19:54 -0400
Message-ID: <20210908191954.240146988@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Sep 2021 15:18:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [for-next][PATCH 06/12] docs: bootconfig: Add how to use bootconfig for kernel parameters
References: <20210908191851.381347939@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add a section to describe how to use the bootconfig for
specifying kernel and init parameters. This is an important
section because it is the reason why this document is under
the admin-guide.

Link: https://lkml.kernel.org/r/163077086399.222577.5881779375643977991.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/admin-guide/bootconfig.rst | 39 +++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index 6a79f2e59396..a1860fc0ca88 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -178,7 +178,7 @@ update the boot loader and the kernel image itself as long as the boot
 loader passes the correct initrd file size. If by any chance, the boot
 loader passes a longer size, the kernel fails to find the bootconfig data.
 
-To do this operation, Linux kernel provides "bootconfig" command under
+To do this operation, Linux kernel provides ``bootconfig`` command under
 tools/bootconfig, which allows admin to apply or delete the config file
 to/from initrd image. You can build it by the following command::
 
@@ -196,6 +196,43 @@ To remove the config from the image, you can use -d option as below::
 Then add "bootconfig" on the normal kernel command line to tell the
 kernel to look for the bootconfig at the end of the initrd file.
 
+
+Kernel parameters via Boot Config
+=================================
+
+In addition to the kernel command line, the boot config can be used for
+passing the kernel parameters. All the key-value pairs under ``kernel``
+key will be passed to kernel cmdline directly. Moreover, the key-value
+pairs under ``init`` will be passed to init process via the cmdline.
+The parameters are concatinated with user-given kernel cmdline string
+as the following order, so that the command line parameter can override
+bootconfig parameters (this depends on how the subsystem handles parameters
+but in general, earlier parameter will be overwritten by later one.)::
+
+ [bootconfig params][cmdline params] -- [bootconfig init params][cmdline init params]
+
+Here is an example of the bootconfig file for kernel/init parameters.::
+
+ kernel {
+   root = 01234567-89ab-cdef-0123-456789abcd
+ }
+ init {
+  splash
+ }
+
+This will be copied into the kernel cmdline string as the following::
+
+ root="01234567-89ab-cdef-0123-456789abcd" -- splash
+
+If user gives some other command line like,::
+
+ ro bootconfig -- quiet
+
+The final kernel cmdline will be the following::
+
+ root="01234567-89ab-cdef-0123-456789abcd" ro bootconfig -- splash quiet
+
+
 Config File Limitation
 ======================
 
-- 
2.32.0
