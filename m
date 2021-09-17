Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7258440F57E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 12:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241567AbhIQKD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 06:03:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343652AbhIQKDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 06:03:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4032B60EE9;
        Fri, 17 Sep 2021 10:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631872953;
        bh=qvyIxgaEqokE4mxvwfdWGcoscYlHq77pc2/n1TEu4KU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IiYRimnuaI5cYe8cCl04LevrtNOQAeufJyBvFPK710QjVEx9xtUdV+t3C+0HgRew9
         rT+ZYlj8BanhO/IfbkRZphVSPz6lnmumI4O/8RsIIyU5AOwyqFGBtbpY0/Yaks+e7T
         lqdCPnS0jjE7AQbO86sOqv+sHhcsRgnIBXnf2LuB4JIVwJaDuonhgI31x/oGycRHL1
         HZCRCXfLcdLKtHCWn+6m1BI8k7l80R8vuZS8B2tOvE/gCO5fDQRM3fTqCoJpthdUXq
         ARpsKZAeoK9hWKTYI7hT8gnuXL33G9OLl4ONiJeLhYEQw8mJ5ADDgA8vwa9iGUsviU
         rNZIlxNnjkBAA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/7] tools/bootconfig: Run test script when build all
Date:   Fri, 17 Sep 2021 19:02:32 +0900
Message-Id: <163187295173.2366983.18295281097397499118.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163187294400.2366983.7393164788107844569.stgit@devnote2>
References: <163187294400.2366983.7393164788107844569.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Run the bootconfig test script when build all target
so that user can notice any issue when build it.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bootconfig/Makefile b/tools/bootconfig/Makefile
index da5975775337..f1eec3ccbe18 100644
--- a/tools/bootconfig/Makefile
+++ b/tools/bootconfig/Makefile
@@ -15,7 +15,7 @@ CFLAGS = -Wall -g -I$(CURDIR)/include
 ALL_TARGETS := bootconfig
 ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
 
-all: $(ALL_PROGRAMS)
+all: $(ALL_PROGRAMS) test
 
 $(OUTPUT)bootconfig: main.c $(LIBSRC)
 	$(CC) $(filter %.c,$^) $(CFLAGS) -o $@

