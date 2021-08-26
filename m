Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C7A3F8436
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 11:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240894AbhHZJNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 05:13:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240568AbhHZJNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 05:13:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E6E1610C9;
        Thu, 26 Aug 2021 09:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629969143;
        bh=uDYKss5H51+qlIxfwS1FoAJZats7oowU7sDnItkFnkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+Dd0uchzkhttjR2fUYqF873FDaPGvREczo8WfLlhIj9+AMkkYd59L9t5sqNKUllR
         Z+opvWlq5I8niffvM4jJSCYpkPS7BDFULoSYJsIwOzsjLm6eUgJdDnrrJjSfLOCbpR
         IuYfFSeYYS2ye33ZK9BY8LOYB1aq6wAKxUpYH6zPmS9jltgXEE5DnAJSHDtjdW23iO
         urlf5VXah4PJsqzjlSAYyrs2KoQCM1chOl/z1TDeEwW4bWrcdKlW40auTe8i+H8c0E
         ueCXJLC55xEuHdUqmsUKgEtXt99ET+LgEt6iCpuXDx/QaWf1kQRcrVm6/fAeJCjjWV
         fP6k6YD4NXd9A==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 3/3] docs: bootconfig: Add how to use bootconfig for kernel parameters
Date:   Thu, 26 Aug 2021 18:12:21 +0900
Message-Id: <162996914170.236535.439632993302650531.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162996911932.236535.7533708592332223449.stgit@devnote2>
References: <162996911932.236535.7533708592332223449.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a section to describe how to use the bootconfig for
specifying kernel and init parameters. This is an important
section because it is the reason why this document is under
the admin-guide.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/admin-guide/bootconfig.rst |   39 +++++++++++++++++++++++++++++-
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
 

