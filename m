Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902FD40BCC6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 02:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhIOAyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 20:54:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232064AbhIOAyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 20:54:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C72D761165;
        Wed, 15 Sep 2021 00:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631667213;
        bh=z+Rz9mifdit69o+uIbSikKcuPTSNShUmHrawtlDV4WI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GDzsdNsTDeveoDIbcZEYLKzJtN/0PoJtqtdsyBL0M8chUFYMumXnG5+nM2QgwDAhX
         uuVRNmUA/SbTPOOrDx1175Hx9PRJDNCzHrC/gvRNX8lvbs/ct0VCwbSS63EIybHUju
         TJGz5l79xcqMg8a2uTf8O+4hYqd8vTT5vQwPmXGuuQygQCdFuv39/W0q1wjkKv0a5o
         ojmJ6IJYf5u6gQrvUUb4aCbvh7Q7StuRlw5rk22DUoAiO44ruDzlkKKB+lnIVjFlhu
         Wn8KUcc0Cbh0DzymItHLsKaUiXdP6E1/THe3KynYMzzYBogMTtxgrh/XHPcOLilUe0
         rpqFVbaz1REuw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 4/5] bootconfig: Free copied bootconfig data after boot
Date:   Wed, 15 Sep 2021 09:53:30 +0900
Message-Id: <163166721027.510331.6820619440348067061.stgit@devnote2>
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

Free copied bootconfig data after booting kernel because that
data will not be used anymore.

commit 40caa127f3c7 ("init: bootconfig: Remove all bootconfig
data when the init memory is removed") freed the bootconfig
xbc_node array after booting kernel, but forgot to free the
bootconfig data itself. This fixes that to free the bootconfig
data too.

Fixes: 40caa127f3c7 ("init: bootconfig: Remove all bootconfig data when the init memory is removed")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v2:
  - Split memblock leak fix because it fixes another commit.
  - Use memblock_free_ptr()
---
 init/main.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/init/main.c b/init/main.c
index 4f059fde1df0..0148152652e9 100644
--- a/init/main.c
+++ b/init/main.c
@@ -319,6 +319,8 @@ static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
 #ifdef CONFIG_BOOT_CONFIG
 
 static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
+static void *init_xbc_data_copy __initdata;
+static phys_addr_t init_xbc_data_size __initdata;
 
 #define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
 
@@ -466,12 +468,17 @@ static void __init setup_boot_config(void)
 		extra_command_line = xbc_make_cmdline("kernel");
 		/* Also, "init." keys are init arguments */
 		extra_init_args = xbc_make_cmdline("init");
+		init_xbc_data_copy = copy;
+		init_xbc_data_size = size + 1;
 	}
 	return;
 }
 
 static void __init exit_boot_config(void)
 {
+	if (!init_xbc_data_copy)
+		return;
+	memblock_free_ptr(init_xbc_data_copy, init_xbc_data_size);
 	xbc_destroy_all();
 }
 

