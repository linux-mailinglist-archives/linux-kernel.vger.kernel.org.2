Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55C640BCC4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 02:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhIOAyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 20:54:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230252AbhIOAye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 20:54:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B0E261184;
        Wed, 15 Sep 2021 00:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631667196;
        bh=tjYE+w+hVKFuNE7M94ifyu2S6XUIpnaX8UMLFXe0coU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lw+x3M5cCMkeL7uU6t+ypFcqKpSGYAIHsSK5xSYO5AqJ9q1cv7It52GQzfMf9s3VR
         HQI0zPcUBg0ByxPU+fYataZ4ThsM2ycGnHjwKFhjMKh0lAUpNzxjUcT2si9zcTa9Rz
         Yo0/l5bhL37/PwA7KAIru4GI0ekzWeO3nYlbGbc435fj8AxickBdntfam1uvGIuNUf
         UaeX4ArMI+ImR0fa6OCVpj2TRAMDkGMj8csPWyYZcTCbLg/3Sq7yFFHvhOQowGIA9R
         NS98VYG+7Wl39xGCdlXM0fUyTxMXrTLFvFTeFNFOp6vBvezNUxqDeSvAdpdhyQLEZE
         liBpiEGhMzaEA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 2/5] bootconfig: init: Fix memblock leak in xbc_make_cmdline()
Date:   Wed, 15 Sep 2021 09:53:14 +0900
Message-Id: <163166719378.510331.1159980452908668023.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163166717752.510331.12843735095061762373.stgit@devnote2>
References: <163166717752.510331.12843735095061762373.stgit@devnote2>
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
 

