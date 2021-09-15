Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A6440BCC5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 02:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhIOAyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 20:54:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230252AbhIOAyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 20:54:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D4326103B;
        Wed, 15 Sep 2021 00:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631667205;
        bh=3BaNmCZTv0c11pAEto4TWOw5JJNkPY3QPpJT3D6yH7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g86IkxSDnxmpvSl4SA0OUao7b8oHAidoBLVipURaY0Z4Rd7VYJtOr1qJL/mdzZs9y
         /AccSRLvdl+E/Kjge7FrrCJll/UKEcW9GfeZuS1pkNuZdhea/mOziyPTxO/PeWhPJS
         mW3PdRm+YqY4myc6V99F0gc1LDCrlqXf5uuH/JR9JLaTT4JGFzHzMutlxz7nLhsGVj
         mi0zeUChV8oLVCXg5WlWhvmQxhDsjOsHqy5K4v959knj2NG1mypYAreuLjT0WlnpYG
         Z1OH0Egy9hFqR1E0xUoyVMg1JWbg4Tz1aLA8r8+21cgTk22fy9V1J3jjKTrKhhoyeE
         eWDzRRdceiyVg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 3/5] bootconfig: init: Fix memblock leak in setup_boot_config()
Date:   Wed, 15 Sep 2021 09:53:21 +0900
Message-Id: <163166720179.510331.2971582309563797048.stgit@devnote2>
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
in setup_boot_config().

Fixes: 7684b8582c24 ("bootconfig: Load boot config from the tail of initrd")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 init/main.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/init/main.c b/init/main.c
index 0b054fff8e92..4f059fde1df0 100644
--- a/init/main.c
+++ b/init/main.c
@@ -459,6 +459,7 @@ static void __init setup_boot_config(void)
 		else
 			pr_err("Failed to parse bootconfig: %s at %d.\n",
 				msg, pos);
+		memblock_free_ptr(copy, size + 1);
 	} else {
 		pr_info("Load bootconfig: %d bytes %d nodes\n", size, ret);
 		/* keys starting with "kernel." are passed via cmdline */

