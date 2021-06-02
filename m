Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B473983FA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhFBIVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 04:21:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230516AbhFBIVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:21:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E825613C1;
        Wed,  2 Jun 2021 08:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622621969;
        bh=xQC7WGE+155P8uQ6aYYnmapY86KbOycguF9S3ZNJuXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uqfn2oHHDXbiMtfSPDtQEFF1yQS8RGxjzvT6jnms4mJ7NyoX0dUGPz4bcHsp+AIXp
         AI0NeHqMyDu4Ja4sggHz4qZsIKNgYhwFX5rymhmP18IXM3MPAUmse7i0FuNI1E9W37
         t8mTPR6eI3XffvCSndTo0+0UGPODw1dqOqtKS/nrEy1K5/z3ti9mD8fqlqfASqknAj
         3Y+oVoAYUXGvhCyaqhDxyJQaN+w5Gz6YoEL3n01PwQ5N2Va+q4lj6x8A4xRjTMbCFg
         RGJXyGL5j0hnnRIKdBZwhMB2cLAKDYp4GpfaQiiYZbQuU7AQikggYG7UfeF4uB4ddZ
         KcCEllnpMoFgA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Devin Moore <devinmoore@google.com>
Subject: [PATCH v4 5/6] docs: bootconfig: Update for mixing value and subkeys
Date:   Wed,  2 Jun 2021 17:19:25 +0900
Message-Id: <162262196510.264090.15044943496205914148.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162262192121.264090.6540508908529705156.stgit@devnote2>
References: <162262192121.264090.6540508908529705156.stgit@devnote2>
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

