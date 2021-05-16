Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606B2381F61
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 16:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbhEPO5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 10:57:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234462AbhEPO5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 10:57:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA4C361186;
        Sun, 16 May 2021 14:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621176961;
        bh=eMDGY00Srcwc9Mv3Q7xd4VTBuRrB8CH6Jc58EjqrkKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jWsQMguaWBHeFRkxBLzeVMYu1ghufxsbJDO6Y2DKyVZ+r6xYxxekjgqZemmFmF9vD
         XBKEjXxghKyit6InN6q1tSW4ow/TM0jaXYOT9ZSStLvSXH+02V/1rK7dDtQyfyeQ9C
         6w9RqS4M8pfqX57ahk2WqNU7QmRLiUF4e0ok7U27gGKEXfMupuOTN/LTTJzcVkGTc9
         cCeKYX1EqqQYlQzcYJB5TD6ymeppH+hi5bnEmDquHUx+i+d/0rI+yJsSZf3+v59m6t
         ycA27inD66dERBIo6A2UZTEAfvkwKOo2UzNUum+rdN9NDOzH/UGEuETMKQXOqOOTAZ
         VEXMMLauJpVgg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Devin Moore <devinmoore@google.com>
Subject: [PATCH 4/4] docs: bootconfig: Update for mixing value and subkeys
Date:   Sun, 16 May 2021 23:55:58 +0900
Message-Id: <162117695806.9011.2777026750573406243.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162117692155.9011.16682190750100804269.stgit@devnote2>
References: <162117692155.9011.16682190750100804269.stgit@devnote2>
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
 0 files changed

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index 452b7dcd7f6b..37bdae273b18 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -89,13 +89,33 @@ you can use ``+=`` operator. For example::
 
 In this case, the key ``foo`` has ``bar``, ``baz`` and ``qux``.
 
-However, a sub-key and a value can not co-exist under a parent key.
-For example, following config is NOT allowed.::
+Moreover, sub-keys and a value can co-exist under a parent key.
+For example, following config is allowed.::
 
  foo = value1
- foo.bar = value2 # !ERROR! subkey "bar" and value "value1" can NOT co-exist
- foo.bar := value2 # !ERROR! even with the override operator, this is NOT allowed.
+ foo.bar = value2
+ foo := value3 # This will update foo's value.
 
+Note, since there is no syntax to add raw value in the structured
+key, you have to define it outside of the brace. For example::
+
+ foo.bar = value1
+ foo.bar {
+         baz = value2
+         qux = value3
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
+
+ foo = value2
+ foo.bar = value1
 
 Comments
 --------

