Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB3740C62A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 15:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbhIONU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 09:20:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229670AbhIONU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 09:20:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7A2D61251;
        Wed, 15 Sep 2021 13:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631711979;
        bh=tjYE+w+hVKFuNE7M94ifyu2S6XUIpnaX8UMLFXe0coU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZDqe1aTewpyN1tOX6hRfENmOnA173xBNFs6FcoacqVZAkQXpAcvWkHaKX8DHxv2Of
         xjwNkN425Ir3TvSrHGGely0P6g/Jm651RKRuyx6KLk8dC0b9TbLVz72VkfMwwQxjKa
         7gws47GEnK9Z4PG74cQi3cpMqgH1seBf8cTKUwoWOLI9/6EqgzmMEko1rK3sTwMZAi
         kNHNZbBB86t523s64ZgrwPYutlSnJiOmvU13LfYOoTDX7KjkvOpKXDc5yWfWF7dKGh
         gQCSD/7/s/IRICnj4RfeShEj4OzkrIOeRsgi4qYmAitcE34L/jhR/B4cxYh3t9+ama
         nh9YDdRRZAsQw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v3 1/3] bootconfig: init: Fix memblock leak in xbc_make_cmdline()
Date:   Wed, 15 Sep 2021 22:19:36 +0900
Message-Id: <163171197599.590070.10960384725563297226.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163171196689.590070.15063104707696447188.stgit@devnote2>
References: <163171196689.590070.15063104707696447188.stgit@devnote2>
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
 

