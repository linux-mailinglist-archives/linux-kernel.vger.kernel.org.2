Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6814E40D324
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 08:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbhIPGYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 02:24:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234532AbhIPGYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 02:24:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5279E611CA;
        Thu, 16 Sep 2021 06:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631773394;
        bh=tjYE+w+hVKFuNE7M94ifyu2S6XUIpnaX8UMLFXe0coU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MwxvbaDFsFzJ0WbuMDAhQxGz/QZ32erbRaFMpTAonzvMiZydGTsKs5oL/JGb9gB++
         2efsqfpYklFXhsEVzQICxeLwaa4R3VpphL14ekzIMTZKs/ezdJpXfKXfLlcseRl8iT
         JmAz4N8KNBdOVH4rKiOxW/uBGcJSftOWd8VxjMw9AoLegyAXJIdnjId1BNSWX9o4M4
         /AbiAetqvRmUo+R8Jp8hOjqk/OT6h1HXiWyz3yLXEa7hFPdF70Q/DxAUAnLptJe8r+
         f8ZuVJIkt7JqYBUju9hvSti6nQgzROJ1saFL8n+Pi+WnWOaf1lmNMi/zan62sqvRXd
         JV1cA2GLd6biQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v4 1/4] bootconfig: init: Fix memblock leak in xbc_make_cmdline()
Date:   Thu, 16 Sep 2021 15:23:12 +0900
Message-Id: <163177339181.682366.8713781325929549256.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163177338366.682366.5998343833719057348.stgit@devnote2>
References: <163177338366.682366.5998343833719057348.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free unused memblock in a error case to fix memblock leak
in xbc_make_cmdline().

Fixes: 51887d03aca1 ("bootconfig: init: Allow admin to use bootconfig for kernel command line")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 init/main.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/init/main.c b/init/main.c
index 3f7216934441..0b054fff8e92 100644
--- a/init/main.c
+++ b/init/main.c
@@ -382,6 +382,7 @@ static char * __init xbc_make_cmdline(const char *key)
 	ret = xbc_snprint_cmdline(new_cmdline, len + 1, root);
 	if (ret < 0 || ret > len) {
 		pr_err("Failed to print extra kernel cmdline.\n");
+		memblock_free_ptr(new_cmdline, len + 1);
 		return NULL;
 	}
 

