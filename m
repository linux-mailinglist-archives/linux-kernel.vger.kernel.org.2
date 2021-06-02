Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960D0398117
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 08:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhFBG1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 02:27:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231285AbhFBG0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 02:26:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D25160FDC;
        Wed,  2 Jun 2021 06:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622615111;
        bh=eMDGY00Srcwc9Mv3Q7xd4VTBuRrB8CH6Jc58EjqrkKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=URoAVkVnoiMQCTtI8p5lwYftSwz55U1gcEMPMxPExpodfp4lKLV6ylL9k/AeEDu36
         dPErEFpLAiZMlMDoTj6E5WPZGrjFXkwogItB72hWo8QUdVgcXrVyWl/uyHkqa7fva9
         eKob1UkBs9C6BVBi7lCA5k/N6fYpCtcuPtAn34YUGNnFHrIwbEdrEuugMZ/9QIBn16
         WMdAFJLA621eEJs+IcXlootut3euhbAzzbmrknOhq7YWVjiIdB8jmVMzPbP500xlKc
         gfXjTFRbEFT+dmjtpdGC/5O3TAnnzKdV8hWNwGDIREKihItxaJC2sRkbkVUaXIhze7
         ez+Eeh9JQuBOQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Devin Moore <devinmoore@google.com>
Subject: [PATCH v3 5/6] docs: bootconfig: Update for mixing value and subkeys
Date:   Wed,  2 Jun 2021 15:25:08 +0900
Message-Id: <162261510788.255316.168529766501617432.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162261506232.255316.12147562546699211199.stgit@devnote2>
References: <162261506232.255316.12147562546699211199.stgit@devnote2>
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

