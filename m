Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C458443CB37
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 15:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242301AbhJ0N47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 09:56:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237482AbhJ0N45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 09:56:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C30C60E74;
        Wed, 27 Oct 2021 13:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635342872;
        bh=JZgb1PnqFozZoT5EnBGi/iPn+NC4Wq7XkdyiQcf5HLI=;
        h=From:To:Cc:Subject:Date:From;
        b=P1AR5rQO3YK+Wz0votLrusTNx4R9of3JUCVJv3V4TZuDMz4m0Y5t1TjB/Sazo6jXm
         r4hikDPi07pqXTWm9OhVgJheuf1iu43p3wPfXYfVJfOO1F5sugDM88E+HNQns0ntRg
         uc0YYzOHjf5chIm/yqo9Oassu7kGubA9w9HxrpkXYdCYo3jddeX1l8oxta0fSvtfcD
         6xIQ3IIfYmIgWFSslxTGj2gPPYTNYx3OmL1TwBcxq9YMKNsmdIFEW4LzYo+hOzy/Kz
         k3mYWVCxlj7TuwlFI0YrMIStwbtwI8UorEMdwgdFtz/TSrzGlZ3uIq9g8NyYlHR96z
         LpS+luN+RUWQg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bootconfig: Fix to initialize 'ret' local variable
Date:   Wed, 27 Oct 2021 22:54:28 +0900
Message-Id: <163534286875.793799.13298849524607405594.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix xbc_parse_tree() to initialize the 'ret' local variable
before referring in the loop.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Andrew Morton <akpm@linux-foundation.org>
Fixes: f3668cde8562 ("bootconfig: Split parse-tree part from xbc_init")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 lib/bootconfig.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index a10ab25f6fcc..70e0d52ffd24 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -836,7 +836,7 @@ static int __init xbc_verify_tree(void)
 static int __init xbc_parse_tree(void)
 {
 	char *p, *q;
-	int ret, c;
+	int ret = 0, c;
 
 	last_parent = NULL;
 	p = xbc_data;

